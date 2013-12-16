unit COB_extensions;

interface
uses
  PluginEngine;

// -----------------------------------------------------------------------------

const
  State_COB_extensions : boolean = true;
  
function GetPlugin : TPluginData;

// -----------------------------------------------------------------------------

Procedure OnInstallCobExtensions;
Procedure OnUninstallCobExtensions;

// -----------------------------------------------------------------------------
const
 { GET }
 // gets kills * 100
 VETERAN_LEVEL = 32;
 // returns the lowest valid unit ID number
 MIN_ID = 69;
 // returns the highest valid unit ID number
 MAX_ID = 70;
 // returns ID of current unit
 MY_ID = 71;
 // returns team of unit given with parameter
 UNIT_TEAM = 72;
 // basically BUILD_PERCENT_LEFT, but comes with a unit parameter
 UNIT_BUILD_PERCENT_LEFT = 73;
 // is unit given with parameter allied to the unit of the current COB script. 1=allied, 0=not allied
 UNIT_ALLIED = 74;
 // indicates if the 1st parameter(a unit ID) is local to this computer
 UNIT_IS_ON_THIS_COMP = 75;

 { GET/SET }
 // health value
 HEALTH_VAL = 76;
 // cloack mode
 CLOAKED = 77;
 
 CUSTOM_LOW = MIN_ID;
 CUSTOM_HIGH = CLOAKED;
// -----------------------------------------------------------------------------

Procedure COB_Extensions_Handling;
Procedure COB_ExtensionsSetters_Handling;

function CustomGetters( index : longword;
                        unitPtr : longword;
                        arg1, arg2, arg3, arg4 : longword) : longword; stdcall;

procedure CustomSetters( index: longword; unitPtr : longword;
                        arg1: longword); stdcall;

implementation
uses
  TADemoConsts,
  TA_MemoryLocations;

Procedure OnInstallCobExtensions;
begin
end; 

Procedure OnUninstallCobExtensions;
begin
end;

function GetPlugin : TPluginData;
begin
if IsTAVersion31 and State_COB_extensions then
  begin

  result := TPluginData.create( State_COB_extensions,
                                'COB Extensions',
                                State_COB_extensions,
                                @OnInstallCobExtensions, @OnUnInstallCobExtensions );

  result.MakeRelativeJmp( State_COB_extensions,
                          'COB Extensions handler',
                          @COB_Extensions_Handling,
                          $480770,
                          $1 );

  result.MakeRelativeJmp( State_COB_extensions,
                          'COB Extensions Setters handler',
                          @COB_ExtensionsSetters_Handling,
                          $480B20,
                          $1 );


  end
else
  result := nil;
end;

function CustomGetters( index : longword;
                        unitPtr : longword;
                        arg1, arg2, arg3, arg4 : longword) : longword; stdcall;
var
  playerPtr, Unit2Ptr : pointer;
  playerIndex : longword;
  TAPlayerType : TTAPlayerType;
begin
result := 0;

if (index = VETERAN_LEVEL) or ((index >= CUSTOM_LOW) and (index <= CUSTOM_HIGH)) then
  begin
  case index of
    MIN_ID : result := 1;
    MAX_ID :
      begin
      if TAData.IsAlteredUnitLimit then
        result := TAData.ActualUnitLimit * MAXPLAYERCOUNT
      else
        result := TAData.MaxUnitLimit * MAXPLAYERCOUNT;
      end;
    MY_ID :
      begin
      result := ( (unitPtr - TAData.UnitsPtr ) div UnitStructSize );
      end;
    UNIT_TEAM :
      begin
      Unit2Ptr := TAMem.GetUnitPtr(arg1);
      result := TAUnit.GetOwnerIndex(Unit2Ptr);
      end;
    UNIT_ALLIED :
      begin
      playerPtr := TAUnit.GetOwnerPtr(pointer(unitPtr));
      Unit2Ptr := TAMem.GetUnitPtr(arg1);
      playerIndex := TAUnit.GetOwnerIndex(Unit2Ptr);
      result := BoolValues[TAPlayer.GetAlliedState(playerPtr,playerIndex)]
      end;
    VETERAN_LEVEL :
      begin
      result := TAUnit.getKills(pointer(unitPtr))*100;
      end;
    HEALTH_VAL :
      begin
      result := TAUnit.getHealth(pointer(unitPtr));
      end;
    CLOAKED :
      begin
        if TAUnit.getCloak(pointer(unitPtr)) then
          Result:= 1
        else
          Result:= 0;
      end;
    UNIT_IS_ON_THIS_COMP:
      begin
      Unit2Ptr := TAMem.GetUnitPtr(arg1);
      playerPtr := TAUnit.GetOwnerPtr(pointer(Unit2Ptr));
      TAPlayerType := TAPlayer.PlayerType(playerPtr);
       case TAPlayerType of
           Player_LocalHuman:
                             result := 1;
           Player_LocalAI:
                          result := 1;
       end;
      end;
    end;
  end;
end;

procedure CustomSetters( index: longword; unitPtr : longword;
                        arg1: longword); stdcall;
begin
  if ((index >= CUSTOM_LOW) and (index <= CUSTOM_HIGH)) then
  begin
    case index of
      HEALTH_VAL :
        begin
          TAUnit.setHealth(pointer(unitPtr), arg1);
        end;
      CLOAKED :
        begin
          TAUnit.setCloak(pointer(unitPtr), arg1);
        end;
      {SUNITX :
        begin
          TAUnit.setUnitX(pointer(unitPtr), arg1);
        end;
      SUNITY :
        begin
          TAUnit.setUnitY(pointer(unitPtr), arg1);
        end; }
    end;
  end;
end;

Procedure COB_Extensions_Handling;
// arg_4 
// arg_8
// arg_C
// arg_10

label
  DefaultCase,
  DoReturn,
  GeneralCaseGetter;
asm
  // function prolog
  mov     eax, [ecx+540h]
  mov     ecx, [esp+4]//[esp+arg_0]
  sub     esp, 24h
  push    esi
  // start of case statement
  mov     esi, [eax+0Ch];
  mov     esi, [eax+0Ch]
  lea     eax, [ecx-1]    // switch 20 cases

  cmp     eax, 13h
  ja      DefaultCase
  jmp     ds:$480AC4[eax*4] // switch jump
  // should not get here
  int 3 

DefaultCase:

  inc eax;
  cmp eax, UNIT_BUILD_PERCENT_LEFT
  jnz GeneralCaseGetter

  mov ecx,[TADynmemStructPtr]
  mov esi,[esp+28h+$8]
  imul esi, UnitStructSize
  mov eax, [ecx+TAdynmemStruct_Units]
  add esi, eax

  cmp esi, eax
  jb DoReturn

  mov eax, [ecx+TAdynmemStruct_Units_EndMarker]
  cmp esi, eax
  jae DoReturn  

  push $480A44
  Call PatchNJump;

GeneralCaseGetter:
  mov ecx, [esp+28h+$14] // arg_14
  push ecx;
  mov ecx, [esp+2ch+$10] // arg_10
  push ecx;
  mov ecx, [esp+30h+$C] // arg_C
  push ecx;
  mov ecx, [esp+34h+$8] // arg_8
  push ecx;
  push esi;             // unitPtr
  push eax;             // index
  // todo : fix this mess up
  call CustomGetters;

DoReturn:
  pop esi;
  add esp, 24h;
  ret 14h;  
end;

Procedure COB_ExtensionsSetters_Handling;

label
  DefaultCase,
  DoReturn,
  GeneralCaseSetter;
asm
  // function prolog
  mov     eax, [ecx+540h]
  mov     ecx, [esp+4]//[esp+arg_0]
  push    esi
  // start of case statement
  mov     esi, [eax+0Ch];
  mov     esi, [eax+0Ch]
  lea     eax, [ecx-1]    // switch 20 cases
  cmp     eax, 13h
  ja      DefaultCase

  xor edx, edx
  mov dl, ds:$480C18[eax]
  jmp     ds:$480BFC[edx*4] // switch jump
  // should not get here
  int 3
  
DefaultCase:
  inc eax;
  cmp eax, UNIT_BUILD_PERCENT_LEFT
  jnz GeneralCaseSetter

  mov ecx,[TADynmemStructPtr]
  mov esi,[esp+28h+$8]
  imul esi, UnitStructSize
  mov eax, [ecx+TAdynmemStruct_Units]
  add esi, eax

  cmp esi, eax
  jb DoReturn

  mov eax, [ecx+TAdynmemStruct_Units_EndMarker]
  cmp esi, eax
  jae DoReturn  

  push $480BF1
  Call PatchNJump;

GeneralCaseSetter:
  mov ecx, [esp+4h+$8] // value to be set
  push ecx;
  push esi;             // unitPtr
  push eax;             // index
  call CustomSetters;

DoReturn:
  pop esi;
  ret 8h;
end;

end.
