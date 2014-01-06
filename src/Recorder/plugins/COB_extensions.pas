unit COB_extensions;

interface
uses
  PluginEngine, SynCommons, TA_MemoryLocations;

// -----------------------------------------------------------------------------

const
  State_COB_extensions : boolean = true;
  
function GetPlugin : TPluginData;

// -----------------------------------------------------------------------------

Procedure OnInstallCobExtensions;
Procedure OnUninstallCobExtensions;

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
 HEALTH_VAL = 76;
 CLOAKED = 77;
 UNITX = 81;
 UNITY = 82;
 UNITZ = 83;

 { SET }
 WEAPON1 = 78;
 WEAPON2 = 79;
 WEAPON3 = 80;
 KILLME = 85;

 UPGRADEABLE = 200;

 NAME = 140;        //string
 UNITNAME	= 141;    //string
 DESCRIPTION = 142; //string
 CATEGORY	= 143;    //string
 SOUNDCTGR = 144;   //string

 MOVEMENTCLASS = 149;

 MAXHEALTH = 150;
 HEALTIME = 151;

 MAXSPEED = 152;
 ACCELERATION = 153;
 BRAKERATE = 154;
 TURNRATE = 155;
 CRUISEALT = 156;
 MANEUVERLEASH = 157;
 ATTACKRUNLEN = 158;
 MAXSLOPE = 159;
 MAXWATERSLOPE = 160;
 WATERLINE = 161;

 TRANSPORTSIZE = 162;
 TRANSPORTCAP = 163;

 BANKSCALE = 164;
 KAMIKAZEDIST = 165;
 DAMAGEMODIFIER = 166;

 WORKERTIME = 167;
 BUILDDIST = 168;

 SIGHTDIST  = 169;
 RADARDIST = 170;
 SONARDIST = 171;
 MINCLOAKDIST = 172;
 RADARDISTJAM = 173;
 SONARDISTJAM = 174;

 MAKESMETAL = 175;
 FENERGYMAKE = 176; 	//Multiply (when setting) or divide by 100 after getting
 FMETALMAKE = 177;
 FENERGYUSE = 178;
 FMETALUSE = 179;
 FENERGYSTOR = 180;
 FMETALSTOR = 181;
 FWINDGENERATOR = 182;
 FTIDALGENERATOR = 183;
 FCLOAKCOST = 184;
 FCLOAKCOSTMOVE = 185;  //end multiply

 UNIT_TEMPLATE = 190;
 
 CUSTOM_LOW = MIN_ID;
 CUSTOM_HIGH = UPGRADEABLE;

// -----------------------------------------------------------------------------

var
  CustomUnitInfosArray: TUnitInfos;
  CustomUnitInfos: TDynArray;
  CustomUnitInfosCount: Integer;

// -----------------------------------------------------------------------------

Procedure COB_Extensions_Handling;
Procedure COB_ExtensionsSetters_Handling;

implementation
uses
  idplay,
  TA_NetworkingMessages,
  INI_Options;

Procedure OnInstallCobExtensions;
begin
  CustomUnitInfos.Init(TypeInfo(TUnitInfos),CustomUnitInfosArray, @CustomUnitInfosCount);
  CustomUnitInfos.Capacity:= 5000;
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
      result := TAUnit.getCloak(pointer(unitPtr));
      end;
    UNIT_IS_ON_THIS_COMP:
      begin
      result := TAUnit.isOnThisComp(pointer(unitPtr));
      end;
    UNITX:
      begin
      result:= TAUnit.getUnitX(pointer(unitPtr)) div 163840;
      end;
    UNITY:
      begin
      result:= TAUnit.getUnitY(pointer(unitPtr)) div 163840;
      end;
    UNITZ:
      begin
      result:= TAUnit.getUnitZ(pointer(unitPtr)) div 163840;
      end;
    MOVEMENTCLASS..FCLOAKCOSTMOVE : // 149 - 185
      begin
      result:= TAUnit.getUnitInfoField(pointer(unitPtr), index, nil);
      end;
    end;
  end;
end;

procedure CustomSetters( index: longword; unitPtr : longword;
                        arg1: longword); stdcall;
begin
if ((index >= CUSTOM_LOW) and (index <= CUSTOM_HIGH)) then
begin
  if TAUnit.isOnThisComp(pointer(unitPtr)) <> 0 then
  begin
    case index of
      HEALTH_VAL       : TAUnit.setHealth(pointer(unitPtr), arg1);
      CLOAKED          : TAUnit.setCloak(pointer(unitPtr), arg1);
      WEAPON1..WEAPON3 :
        begin
        if TAUnit.setWeapon(pointer(unitPtr), index, Word(arg1), iniSettings.weaponidpatch) then
          globalDplay.SendCobEventMessage(TANM_Rec2Rec_UnitWeapon, @unitPtr, @index, nil, @arg1, nil);
        end;
      UNITX :
        begin
        TAUnit.setUnitX(pointer(unitPtr), arg1);
        end;
      UNITY :
        begin
        TAUnit.setUnitY(pointer(unitPtr), arg1);
        end;
      UNITZ :
        begin
        TAUnit.setUnitZ(pointer(unitPtr), arg1);
        end;
      KILLME :
        begin
        //TAUnit.Kill(pointer(unitPtr), Byte(arg1));
        end;
      UNIT_TEMPLATE :
        begin
       // TAUnit.setTemplate(pointer(unitPtr), arg1);
       //   globalDplay.SendCobEventMessage(TANM_Rec2Rec_UnitTemplate, @unitPtr, nil, nil, nil);
        end;
      UPGRADEABLE :
        begin
        if TAUnit.setUpgradeable(pointer(unitPtr), arg1, nil) <> 0 then
          globalDplay.SendCobEventMessage(TANM_Rec2Rec_UnitUpgradeable, @unitPtr, nil, @arg1, nil, nil);
        end;
      MOVEMENTCLASS..FCLOAKCOSTMOVE : // 149 - 185
        begin
        if TAUnit.setUnitInfoField(pointer(unitPtr), index, arg1, nil) <> 0 then
          globalDplay.SendCobEventMessage(TANM_Rec2Rec_UnitEditTemplate, @unitPtr, @arg1, nil, nil, @index);
        end;
    end;
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
