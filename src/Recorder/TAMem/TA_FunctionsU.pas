unit TA_FunctionsU;

interface
uses
  TA_MemoryStructures, DPlay;

const
  access = 1;

type
  GetTAProgramStructHandler = function : Pointer; register;
var
  GetTAProgramStruct : GetTAProgramStructHandler = GetTAProgramStructHandler($004B6220);

type
  GetGameingTypeHandler = function(a1, a2, a3: Cardinal): Cardinal; register;
var
  GetGameingType : GetGameingTypeHandler = GetGameingTypeHandler($00435100);

type
  Game_SetLOSStateHandler = function (flags : integer) : integer; stdcall;
var
  // called by to setup the LOS tables
  Game_SetLOSState : Game_SetLOSStateHandler = Game_SetLOSStateHandler($004816A0);

type
  TA_UpdateLOSHandler = function (FillFeatureMap_b: LongWord): LongWord; stdcall;
var
  // called to update LOS
  TA_UpdateLOS : TA_UpdateLOSHandler = TA_UpdateLOSHandler($004816A0);

type
  ScrollViewHandler = function (X, Y: Cardinal; Smooth: LongBool): Cardinal; stdcall;
var
  ScrollView : ScrollViewHandler = ScrollViewHandler($0041C4C0);

type
  Mouse_SetDrawMouseHandler = function (Draw: Boolean): Integer; stdcall;
var
  Mouse_SetDrawMouse : Mouse_SetDrawMouseHandler = Mouse_SetDrawMouseHandler($004C22D0);

type
  DrawOptionsTabHandler = function (p_Offscreen: Pointer): Cardinal; stdcall;
var
  DrawOptionsTab : DrawOptionsTabHandler = DrawOptionsTabHandler($0045FFB0);

type
  SetGammaHandler = function (fGamma: Single): Integer; stdcall;
var
  SetGamma : SetGammaHandler = SetGammaHandler($004BA590);

type
  FreeObjectStateHandler = function ( ObjectState: Pointer ): Integer; stdcall;
var
  FreeObjectState : FreeObjectStateHandler = FreeObjectStateHandler($0045AAA0);

type
  FreeMoveClassHandler = function ( a1: pointer; a2: pointer; MoveClass: Pointer ): Integer; register;
var
  FreeMoveClass : FreeMoveClassHandler = FreeMoveClassHandler($0043DD10);

type
  FreeUnitScriptDataHandler = function ( uneax, unedx: Pointer;
                                         ScriptData: Pointer; a2: Byte ): Pointer; register;
var
  FreeUnitScriptData : FreeUnitScriptDataHandler = FreeUnitScriptDataHandler($00485E30);

// turret weap aiming
type
  sub_49D910Handler = function ( a1 : LongInt; a2 : LongInt; a3 : LongInt;
                                 a9 : LongInt; a8 : LongInt; a7 : LongInt;
                                 a6 : LongInt; a5 : LongInt; a4 : LongInt) : LongInt; register;
var
  sub_49D910 : sub_49D910Handler = sub_49D910Handler($49D910);

type
  GetUnit_BuildWeaponProgressHandler = function ( p_Unit: Pointer ): Cardinal; stdcall;
var
  GetUnit_BuildWeaponProgress : GetUnit_BuildWeaponProgressHandler = GetUnit_BuildWeaponProgressHandler($439D20);

type
  UnitExplosionHandler = procedure ( p_Unit: Pointer; destructas: Cardinal ); stdcall;
var
  UnitExplosion: UnitExplosionHandler = UnitExplosionHandler($0049B000);

type
  TestHeal_Handler = function ( ResPercentage: Pointer;
                                Amount: Single ): Integer; stdcall;
var
  TestHeal: TestHeal_Handler = TestHeal_Handler($00401180);

type
  UNITS_SetStateMaskHandler = function ( uneax, unedx: Pointer;
                                        p_Unit: Pointer;
                                        ScriptIdx: Integer;
                                        NewState: Integer ): Cardinal; register;
var
  UNITS_SetStateMask: UNITS_SetStateMaskHandler = UNITS_SetStateMaskHandler($0048B090);

type
  Trajectory3Handler = function ( Attackerp_Unit: Pointer;
                                  Position1: PPosition;
                                  Position2: PPosition;
                                  WhichWeapon: Word ): Integer; stdcall;
var
  Trajectory3 : Trajectory3Handler = Trajectory3Handler($0049AA80);

type
  UnitAutoAim_CheckUnitWeaponHandler = function ( Attackerp_Unit: Pointer;
                                                  Targetp_Unit: Pointer;
                                                  WhichWeapon: Word ): Byte; stdcall;
var
  UnitAutoAim_CheckUnitWeapon : UnitAutoAim_CheckUnitWeaponHandler = UnitAutoAim_CheckUnitWeaponHandler($0049ABB0);

type
  TranslateStringHandler = function ( const Str: PAnsiChar ): PAnsiChar; stdcall;
var
  TranslateString : TranslateStringHandler = TranslateStringHandler($004C5740);

type
  _strcmpiHandler = function( const Str1: PAnsiChar; const Str2: PAnsiChar ): Integer; cdecl;
var
  _strcmpi : _strcmpiHandler = _strcmpiHandler($004F8A70);

type
  TA_AttachDetachUnitHandler = procedure ( Transportedp_Unit : Pointer;
                                           Transporterp_Unit : Pointer;
                                           Piece : ShortInt;
                                           Unknown : Byte ); stdcall;
var
  TA_AttachDetachUnit : TA_AttachDetachUnitHandler = TA_AttachDetachUnitHandler($0048AAC0);

type
  TerminateProcess_WithWarningHandler = procedure(TerminateMessage: PAnsiChar); stdcall;
var
  TerminateProcess_WithWarning : TerminateProcess_WithWarningHandler = TerminateProcess_WithWarningHandler($004B6290);

// used by TA to load terrain TNT file (sets also terrain load progress)
// but can be also used to allocate, load HPI file into memory and retrieve pointer to it
type
  LoadHPITerainFileHandler = function (FilePath: PAnsiChar): Pointer; stdcall;
var
  LoadHPITerainFile : LoadHPITerainFileHandler = LoadHPITerainFileHandler($00429660);

type
  GetTA_ScreenWidthHandler = function : Integer; cdecl;
var
  GetTA_ScreenWidth : GetTA_ScreenWidthHandler = GetTA_ScreenWidthHandler($004B6700);

type
  CorrecLinetPositionHandler = function( p_Offscreen: Pointer;
                                         x1: Pointer;
                                         y1: Pointer;
                                         x2: Pointer;
                                         y2: Pointer): LongInt; stdcall;
var
  CorrecLinetPosition : CorrecLinetPositionHandler = CorrecLinetPositionHandler($004BEA20);

type
  GetFontTypeHandler = function: Pointer; stdcall;
var
  GetFontType : GetFontTypeHandler = GetFontTypeHandler($004C1440);

type
  GetFontBackgroundColorHandler = function: Cardinal; stdcall;
var
  GetFontBackgroundColor : GetFontBackgroundColorHandler = GetFontBackgroundColorHandler($004C13F0);

type
  SetFontColorHandler = procedure(Color: Integer; FontAlpha: Integer); stdcall;
var
  SetFontColor : SetFontColorHandler = SetFontColorHandler($004C13A0);

type
  SetFontTypeHandler = procedure(p_FontHandle: Pointer); stdcall;
var
  SetFontType : SetFontTypeHandler = SetFontTypeHandler($004C1420);

type
  GetFontCharWidthHandler = function: Integer; stdcall;
var
  GetFontCharWidth : GetFontCharWidthHandler = GetFontCharWidthHandler($004C1450);

type
  Msg_ReminderHandler = function(Msg_Str: PAnsiChar; Msg_Type: Word) : Integer; stdcall;
var
  Msg_Reminder : Msg_ReminderHandler = Msg_ReminderHandler($046BC70);

type
  //Access 1 = no cheats, 3 = cheats
  InterpretCommandHandler = procedure ( Command : PChar; access : Longint); stdcall;
var
  // called by GUI to process player commands
  InterpretCommand : InterpretCommandHandler = InterpretCommandHandler($417B50);
  procedure InterpretInternalCommand(CommandText: string);

type
  //Access 1 = no cheats, 3 = cheats
  DoInterpretCommandHandler = procedure ( var Command : PChar; access : Longint); stdcall;
var
  // called by GUI+engine to process all commands
  DoInterpretCommand : DoInterpretCommandHandler = DoInterpretCommandHandler($4B7900);

type
  // a1 = 0, a2 = 0, a3 = 0
  // result = current amount of maps
  IterateMapsHandler = function ( a1: Longint; a2: Longint; a3: Longint): Longint; stdcall;
var
  IterateMaps : IterateMapsHandler = IterateMapsHandler($434BF0);

type
  LoadCampaign_UniqueUnitsHandler = procedure(); cdecl;
var
  LoadCampaign_UniqueUnits : LoadCampaign_UniqueUnitsHandler = LoadCampaign_UniqueUnitsHandler($00488310);

type
  Campaign_ParseUnitInitialMissionHandler = function( p_Unit: PUnitStruct;
                                                      Missions: PAnsiChar;
                                                      UniqueNameArray: Pointer): Pointer; stdcall;
var
  Campaign_ParseUnitInitialMission :
    Campaign_ParseUnitInitialMissionHandler = Campaign_ParseUnitInitialMissionHandler($00487BF0);

type
  PLAYERS_Index2DPlayIDHandler = function ( PlayerIndex: Word ): Integer; stdcall;
var
  PLAYERS_Index2DPlayID : PLAYERS_Index2DPlayIDHandler = PLAYERS_Index2DPlayIDHandler($0044FFD0);

type
  UNITINFO_Name2IDHandler = function ( const UnitName: PAnsiChar ): Word; stdcall;
var
  UNITINFO_Name2ID : UNITINFO_Name2IDHandler = UNITINFO_Name2IDHandler($00488B10);

type
  FindSpot_CategorysAryHandler = function ( const CategoryName: String ): Integer; stdcall;
var
  FindSpot_CategorysAry : FindSpot_CategorysAryHandler = FindSpot_CategorysAryHandler($00488C50);

// providing Player will also check is grid spot in player LOS
// just like unmapped terrain build spot check works
type
  TestGridSpotHandler = function ( BuildUnit : Pointer;
                                    Pos : Integer;
                                    unk : Word; //unk=zero
                                    Player : Pointer
                                    ): Integer; stdcall;
var
  TestGridSpot : TestGridSpotHandler = TestGridSpotHandler($0047D2E0);

type
  TestGridSpotAIHandler = function ( UnitInfo : Pointer;
                                    GridPos : Cardinal
                                    ): Integer; stdcall;
var
  TestGridSpotAI : TestGridSpotAIHandler = TestGridSpotAIHandler($0047D820);

type //fill TAdynmem->MouseMapPosX & TAdynmem->MouseMapPosY first
	TestBuildSpotHandler = procedure (); stdcall;
var
  TestBuildSpot : TestBuildSpotHandler = TestBuildSpotHandler($004197D0);

type
  CanAttachAtGridSpotHandler = function ( UnitInfo: PUnitInfo;
                                          UnitID: Word;
                                          GridPos: Integer;
                                          State: Integer): Boolean; stdcall;
var
  CanAttachAtGridSpot : CanAttachAtGridSpotHandler = CanAttachAtGridSpotHandler($0047DB70);

type
  CanCloseOrOpenYardHandler = function ( p_Unit: Pointer; NewState: Integer): Boolean; stdcall;
var
  CanCloseOrOpenYard : CanCloseOrOpenYardHandler = CanCloseOrOpenYardHandler($0047D970);

type
  GetPiecePositionHandler = function(var PositionOut: TPosition;
                                     p_Unit: PUnitStruct;
                                     PieceIdx: Integer): PPosition; stdcall;
var
  GetPiecePosition : GetPiecePositionHandler = GetPiecePositionHandler($0043E060);

type
  GetUnitPiecePositionHandler = procedure(var PositionOut: TPosition;
                                          p_Unit: PUnitStruct;
                                          PieceIdx: Integer); stdcall;
var
  GetUnitPiecePosition : GetUnitPiecePositionHandler = GetUnitPiecePositionHandler($0043DEF0);

type // buffer should be at least 50 characters long
  GetContextHandler = function ( ptr : PChar ) : Longint; Stdcall;
var
  GetContext : GetContextHandler = GetContextHandler($4C5E70);

Type // +los cheat
  TextCommand_LOSHandler = procedure ; stdcall;
var
  TextCommand_LOS : TextCommand_LOSHandler = TextCommand_LOSHandler($416D50);

Type
  rand2Handler = function: Integer; cdecl;
var
  rand2 : rand2Handler = rand2Handler($004E4870);

Type
  TA_Atan2Handler = function(y, x : Integer): Integer; cdecl;
var
  TA_Atan2 : TA_Atan2Handler = TA_Atan2Handler($004B715A);

Type
  TurnXLookupHandler = function(a1: Word; a2: Integer): Integer; stdcall;
var
  TurnXLookup : TurnXLookupHandler = TurnXLookupHandler($004B70EF);

Type
  TurnZLookupHandler = function(a1: Word; a2: Integer): Integer; stdcall;
var
  TurnZLookup : TurnZLookupHandler = TurnZLookupHandler($004B7123);

Type
  LoadTNTFileHandler = function(lpFileName: PAnsiChar): PTNTHeaderStruct; stdcall;
var
  LoadTNTFile : LoadTNTFileHandler = LoadTNTFileHandler($00429660);

Type
  LoadGameData_MainHandler = procedure(); stdcall;
var
  LoadGameData_Main : LoadGameData_MainHandler = LoadGameData_MainHandler($004917D0);

type
  CopyGafToContextHandler = function( p_Offscreen: Pointer;
                                      GafFrame: Pointer;
                                      Off_X, Off_Y: Integer ): Pointer; stdcall;
var
  CopyGafToContext : CopyGafToContextHandler = CopyGafToContextHandler($004B7F90);

type
  AlphaCompsteBuf2OFFScreenHandler = function(p_Offscreen: Pointer; GafFrame: Pointer; Off_X, Off_Y: Integer): Pointer; stdcall;
var
  AlphaCompsteBuf2OFFScreen : AlphaCompsteBuf2OFFScreenHandler = AlphaCompsteBuf2OFFScreenHandler($004B8500);

type
  InitRadarHandler = function(): Integer; cdecl;
var
  InitRadar : InitRadarHandler = InitRadarHandler($4669B0);

type
  CompositeBufferHandler = function(Description: PAnsiChar; Width: Integer; Height: Integer): Pointer; stdcall;
var
  CompositeBuffer : CompositeBufferHandler = CompositeBufferHandler($4B8DA0);

type
  CompositeBuf2_OFFSCREENHandler = function(p_Offscreen: Pointer; CompositeBuf_ptr : Pointer): Pointer; stdcall;
var
  CompositeBuf2_OFFSCREEN : CompositeBuf2_OFFSCREENHandler = CompositeBuf2_OFFSCREENHandler($004B8A80);

type
  DeselectAllUnitsHandler = function: LongBool; cdecl;
var
  DeselectAllUnits : DeselectAllUnitsHandler = DeselectAllUnitsHandler($0048BD00);

type
  UpdateIngameGUIHandler = function(unk : Integer): Integer; stdcall;
var
  UpdateIngameGUI : UpdateIngameGUIHandler = UpdateIngameGUIHandler($00491D70);

type
  ApplySelectUnitMenuHandler = function: Integer; cdecl;
var
  ApplySelectUnitMenu : ApplySelectUnitMenuHandler = ApplySelectUnitMenuHandler($00495860);

//////////////////////////////////////////////////////////////////////////////////////////
// Chat messages and text commands
//////////////////////////////////////////////////////////////////////////////////////////

type //TextType - 0 = chat, 1 = popup
  ShowReminderMsgHandler = function(Text: PAnsiChar; TextType: Word): Integer; stdcall;
var
  ShowReminderMsg : ShowReminderMsgHandler = ShowReminderMsgHandler($0046BC70);
  procedure SendTextLocal(Text: string);

type
  ShowChatMessageHandler = procedure(Player: PPlayerStruct; Text: PAnsiChar;
    Priority: Longint; ToPlayerName: PAnsiChar); stdcall;
var
  ShowChatMessage : ShowChatMessageHandler = ShowChatMessageHandler($00463E50);

type
  NewChatTextHandler = procedure(Source: PAnsiChar; Access: Byte;
    Priority: Word; FromPlayerIdx: Byte); stdcall;
var
  NewChatText : NewChatTextHandler = NewChatTextHandler($00463CA0);

type
  ClearChatHandler = procedure; stdcall;
var
  ClearChat : ClearChatHandler = ClearChatHandler($00463C80);

//////////////////////////////////////////////////////////////////////////////////////////
// Map data
//////////////////////////////////////////////////////////////////////////////////////////

type
  LoadMapHandler = function (un1, un2: Pointer;
    MapOTA: PMapOTAFile; MapName: PAnsiChar): Integer; register;
var
  LoadMap : LoadMapHandler = LoadMapHandler($00435A20);

type
  sub_435D30Handler = function (un1, un2: Pointer;
    MapOTA: PMapOTAFile; a1: Integer): Integer; register;
var
  sub_435D30 : sub_435D30Handler = sub_435D30Handler($00435D30);

type
  CalculateOTACRCHandler = function (un1, un2: Pointer; MapOTA: PMapOTAFile): Cardinal; register;
var
  CalculateOTACRC : CalculateOTACRCHandler = CalculateOTACRCHandler($004373A0);

type
  UpdateViewMapHandler = procedure; cdecl;
var
  UpdateViewMap : UpdateViewMapHandler = UpdateViewMapHandler($00444A20);

type
  GetPosHeightHandler = function (pPosition : Pointer): Integer; stdcall;
var
  GetPosHeight : GetPosHeightHandler = GetPosHeightHandler($00485070);

type
  UnitInPlayerLOSHandler = function (PlayerPtr : Pointer; p_Unit : Pointer): Integer; stdcall;
var
  UnitInPlayerLOS : UnitInPlayerLOSHandler = UnitInPlayerLOSHandler($00465AC0);

type
  PositionInPlayerMappedHandler = function (PlayerPtr : Pointer; Position : PPosition): LongBool; stdcall;
var
  PositionInPlayerMapped : PositionInPlayerMappedHandler = PositionInPlayerMappedHandler($00408090);

type
  LoadMap_AverageHeightMapHandler = function: Word; cdecl;
var
  LoadMap_AverageHeightMap : LoadMap_AverageHeightMapHandler = LoadMap_AverageHeightMapHandler($483370);

type
  LoadMap_PLOT3Handler = function(): Pointer; cdecl;
var
  LoadMap_PLOT3 : LoadMap_PLOT3Handler = LoadMap_PLOT3Handler($4833B0);

type
  GetUnitAtMouseHandler = function: Cardinal; stdcall;
var
  GetUnitAtMouse : GetUnitAtMouseHandler = GetUnitAtMouseHandler($0048CD80);

type
  IsPositionInRectHandler = function(Rect: PtagRECT; x, y : Integer): LongBool; cdecl;
var
  IsPositionInRect : IsPositionInRectHandler = IsPositionInRectHandler($004B6720);

type
  Position2GridPlotWreckHandler = function(Position: PPosition): PPlotGrid; stdcall;
var
  Position2GridPlotWreck : Position2GridPlotWreckHandler = Position2GridPlotWreckHandler($004815F0);

type
  Position2GridPlotHandler = function(Position: PPosition): PPlotGrid; stdcall;
var
  Position2GridPlot : Position2GridPlotHandler = Position2GridPlotHandler($004815A0);

type
  GetTPositionHandler = function ( X, Z: Integer; out Position: TPosition ): Pointer; stdcall;
var
  GetTPosition : GetTPositionHandler = GetTPositionHandler($00484B50);

type
  GetGridPosPLOTHandler = function ( X, Z: Integer ): Pointer; stdcall;
var
  GetGridPosPLOT : GetGridPosPLOTHandler = GetGridPosPLOTHandler($00481550);

type
  GetFeatureTypeFromOrderHandler = function( p_Pos: PPosition;
                                             p_Order: PUnitOrder;
                                             p_FeatureSize: Pointer ): Word; stdcall;
var
  GetFeatureTypeFromOrder : GetFeatureTypeFromOrderHandler = GetFeatureTypeFromOrderHandler($00421DA0);

type
  GetGridPosFeatureHandler = function (PlotGrid: PPlotGrid): SmallInt; stdcall;
var
  GetGridPosFeature : GetGridPosFeatureHandler = GetGridPosFeatureHandler($00421E60);

type
  FeatureName2IDHandler = function ( FeatureName: PAnsiChar ): SmallInt; stdcall;
var
  FeatureName2ID : FeatureName2IDHandler = FeatureName2IDHandler($00422DD0);

// get feature type ID from name and load into definitions if not listed yet
type
  FeatureNameNotListed2IDHandler = function ( FeatureName: PAnsiChar ): SmallInt; stdcall;
var
  FeatureNameNotListed2ID : FeatureNameNotListed2IDHandler = FeatureNameNotListed2IDHandler($00422E40);

type
  LoadFeatureHandler = function ( FeatureName: PAnsiChar ): SmallInt; stdcall;
var
  LoadFeature : LoadFeatureHandler = LoadFeatureHandler($004224B0);

type
  ReleaseFeature_TdfVectorHandler = procedure(); register;
var
  ReleaseFeature_TdfVector : ReleaseFeature_TdfVectorHandler = ReleaseFeature_TdfVectorHandler($4223E0);

type
  SpawnFeatureOnMapHandler = function ( GridPosPLOT: PPlotGrid;
                                        CorpseIdx: SmallInt;
                                        Position: PPosition;
                                        Volume: PTurn;
                                        PlayerId: Byte ): Pointer; stdcall;
var
  SpawnFeatureOnMap : SpawnFeatureOnMapHandler = SpawnFeatureOnMapHandler($00423C50);

type
  FEATURES_Destroy_3DHandler = procedure ( X: Integer; Z: Integer; bReclamateOrDie: LongBool ); stdcall;
var
  FEATURES_Destroy_3D : FEATURES_Destroy_3DHandler = FEATURES_Destroy_3DHandler($00423550);

type
  FEATURES_DestroyHandler = procedure ( GridPlot: PPlotGrid; bMethod: Boolean ); stdcall;
var
  FEATURES_Destroy : FEATURES_DestroyHandler = FEATURES_DestroyHandler($004246B0);

type
  FEATURES_StartBurnHandler = procedure ( X: Integer; Z: Integer; bFromNetworkPacket: LongBool ); stdcall;
var
  FEATURES_StartBurn : FEATURES_StartBurnHandler = FEATURES_StartBurnHandler($004233A0);

type
  FEATURES_TakeWeaponDamageHandler = procedure( p_lotGrid: PPlotGrid;
                                                X: Integer;
                                                Y: Integer;
                                                p_Weapon: PWeaponDef ); stdcall;
var
  FEATURES_TakeWeaponDamage : FEATURES_TakeWeaponDamageHandler = FEATURES_TakeWeaponDamageHandler($004244B0);

//////////////////////////////////////////////////////////////////////////////////////////
// Weapons and projectiles
//////////////////////////////////////////////////////////////////////////////////////////

type
  WEAPONS_Name2PtrHandler = function ( const WeaponName: PAnsiChar ): Pointer; stdcall;
var
  WEAPONS_Name2Ptr : WEAPONS_Name2PtrHandler = WEAPONS_Name2PtrHandler($0049E5B0);

type
  PROJECTILES_FireMapWeapHandler = function ( WeaponTypePtr: Pointer;
                                              StartPosition: PPosition;
                                              TargetPosition: PPosition;
                                              bBroadcast: LongBool): LongBool; stdcall;
var
  PROJECTILES_FireMapWeap: PROJECTILES_FireMapWeapHandler = PROJECTILES_FireMapWeapHandler($49DF10);

type
  WEAPONS_ProjectileDamageHandler = procedure( p_WeaponProjectile: PWeaponProjectile;
                                               p_TargetUnit: PUnitStruct ); stdcall;
var
  WEAPONS_ProjectileDamage : WEAPONS_ProjectileDamageHandler = WEAPONS_ProjectileDamageHandler($00499EB0);

type
  fire_callbackHandler = function ( Attacker_p_Unit: Pointer;
                                    Weapon_Target_ID: Pointer;
                                    Victim_p_Unit: Pointer;
                                    Position_Target: Pointer ): Cardinal; stdcall;
var
  fire_callback1: fire_callbackHandler = fire_callbackHandler($0049DB70);
  fire_callback2: fire_callbackHandler = fire_callbackHandler($0049DD60);
  fire_callback3: fire_callbackHandler = fire_callbackHandler($0049D9C0);

type
  fire_callback0Handler = function ( Attacker_p_Unit: Pointer;
                                     Weapon_Target_ID: Pointer;
                                     Victim_p_Unit: Pointer;
                                     Position_Target: Pointer ): Cardinal; cdecl;
var
  fire_callback0 : fire_callback0Handler = fire_callback0Handler($0049D580);

type
  UNITS_FireProjectile_0_3Handler = function ( p_UnitWeapon: PUnitWeapon;
                                               p_AttackerUnit: PUnitStruct;
                                               p_Position_Start: PPosition;
                                               p_Position_Target: PPosition;
                                               p_TargetUnit: PUnitStruct ): LongBool; stdcall;
var
  UNITS_FireProjectile_0_3 : UNITS_FireProjectile_0_3Handler = UNITS_FireProjectile_0_3Handler($0049C9C0);

type
  UNITS_FireProjectile_1Handler = function ( p_UnitWeapon: PUnitWeapon;
                                             p_AttackerUnit: PUnitStruct;
                                             p_Position_Start: PPosition;
                                             p_Position_Target: PPosition;
                                             p_TargetUnit: PUnitStruct;
                                             p_Interceptor: PWeaponProjectile ): LongBool; stdcall;
var
  UNITS_FireProjectile_1 : UNITS_FireProjectile_1Handler = UNITS_FireProjectile_1Handler($0049CC20);

type
  UNITS_FireProjectile_0Handler = function ( p_UnitWeapon: PUnitWeapon;
                                             p_AttackerUnit: PUnitStruct;
                                             p_Position_Start: PPosition;
                                             p_Position_Target: PPosition;
                                             p_TargetUnit: PUnitStruct ): LongBool; stdcall;
var
  UNITS_FireProjectile_0 : UNITS_FireProjectile_0Handler = UNITS_FireProjectile_0Handler($0049CDE0);

type
  InitProjectileHandler = procedure ( p_WeaponProjectile: PWeaponProjectile;
                                      p_WeaponDef: PWeaponDef;
                                      p_Position_Start: PPosition;
                                      p_Position_Target: PPosition;
                                      FireTime: Integer;
                                      p_AttackerUnit: PUnitStruct ); stdcall;
var
  InitProjectile : InitProjectileHandler = InitProjectileHandler($0049C740);

//////////////////////////////////////////////////////////////////////////////////////////
// Units Orders
//////////////////////////////////////////////////////////////////////////////////////////

type
  GetPrepareOrderNameHandler = function ( a1: Cardinal; DestStr: Pointer; UnitOrder: Cardinal): PAnsiChar; stdcall;
var
  GetPrepareOrderName: GetPrepareOrderNameHandler = GetPrepareOrderNameHandler($0049FED0);

type
  ScriptAction_Name2IndexHandler = procedure ( uneax, unedx: Pointer;
                                               RtnIndex: PByte;
                                               ActionName: PAnsiChar ); register;
var
  ScriptAction_Name2Index: ScriptAction_Name2IndexHandler = ScriptAction_Name2IndexHandler($00438760);

type
  ScriptAction_Index2HandlerHandler = function ( uneax, unedx: Pointer;
                                                 RtnIndex: PByte ): Pointer; register;
var
  ScriptAction_Index2Handler: ScriptAction_Index2HandlerHandler = ScriptAction_Index2HandlerHandler($00438830);

type
  ScriptAction_Type2IndexHandler = procedure ( p_RtnIndex_ptr: Pointer;
                                               Action_ID: Byte;
                                               p_OrderUnit: PUnitStruct;
                                               p_TargetUnit: PUnitStruct;
                                               p_Position: PPosition ); stdcall;
var
  ScriptAction_Type2Index: ScriptAction_Type2IndexHandler = ScriptAction_Type2IndexHandler($0043F0E0);

type
  MOUSE_EVENT_2UnitOrderHandler = function ( CurtMouseEvent_ptr: Pointer; ActionType: Cardinal;
                                             ActionIndex: Cardinal; Position_DWORD_p: Cardinal;
                                             lPar1: Cardinal; lPar2: Cardinal): Cardinal; stdcall;
var
  MOUSE_EVENT_2UnitOrder: MOUSE_EVENT_2UnitOrderHandler = MOUSE_EVENT_2UnitOrderHandler($0048CF30);

type
  Order2UnitHandler = function ( ScriptIndex: Cardinal;
                                 ShiftKey: Cardinal;
                                 pp_Unit: Pointer;
                                 pTargetp_Unit: Pointer;
                                 Position: PPosition;
                                 lPar1: Cardinal;
                                 lPar2: Cardinal ): Cardinal; stdcall;
var
  Order2Unit: Order2UnitHandler = Order2UnitHandler($0043AFC0);

type
  SubOrder2UnitHandler = function ( ScriptIndex: Cardinal;
                                    ShiftKey: Cardinal;
                                    pp_Unit: Pointer;
                                    pTargetp_Unit: Pointer;
                                    Position: PPosition;
                                    lPar1: Cardinal;
                                    lPar2: Cardinal ): Cardinal; stdcall;
var
  SubOrder2Unit: SubOrder2UnitHandler = SubOrder2UnitHandler($0043ADC0);

type
  ORDERS_NewSubBuildOrderHandler = function ( OrderType: Cardinal;
                                              BuilderPtr: PUnitStruct;
                                              UnitInfoID: Cardinal;
                                              QueueAmount: Integer): PUnitOrder; stdcall;
var
  ORDERS_NewSubBuildOrder: ORDERS_NewSubBuildOrderHandler = ORDERS_NewSubBuildOrderHandler($0043B0B0);

type
  UnitSubBuildClickHandler = procedure( UnitInfoName: PAnsiChar;
                                        BuilderPtr: PUnitStruct;
                                        QueueAmount: Integer ); stdcall;
var
  UnitSubBuildClick: UnitSubBuildClickHandler = UnitSubBuildClickHandler($00419B00);

type
  ORDERS_RemoveAllBuildQueuesHandler = procedure ( p_Unit: PUnitStruct; Unk: LongBool); stdcall;
var
  ORDERS_RemoveAllBuildQueues: ORDERS_RemoveAllBuildQueuesHandler = ORDERS_RemoveAllBuildQueuesHandler($00439EB0);

type
  GetUnitFirstOrderTargatHandler = function ( p_Unit: Pointer ): Cardinal; stdcall;
var
  GetUnitFirstOrderTargat: GetUnitFirstOrderTargatHandler = GetUnitFirstOrderTargatHandler($439DD0);

type
  ORDERS_CreateObjectHandler = function ( uneax, unedx: Cardinal;
                                          p_Memory: Pointer;
                                          Flags: Cardinal;
                                          lPar2: Cardinal;
                                          lPar1: Cardinal;
                                          TargetPosition: PPosition;
                                          TargetUnit: PUnitStruct;
                                          ActionType: Cardinal ): PUnitOrder; register;
var
  ORDERS_CreateObject: ORDERS_CreateObjectHandler = ORDERS_CreateObjectHandler($0043A0C0);

type
  ORDERS_QueueOrderHandler = procedure ( p_Unit: PUnitStruct;
    Order1: PUnitOrder; Order2: PUnitOrder ); stdcall;
var
  ORDERS_QueueOrder: ORDERS_QueueOrderHandler = ORDERS_QueueOrderHandler($0043AC60);

type
  ORDERS_CancelOrderHandler = procedure(eax, edx: Cardinal; p_UnitOrder: PUnitOrder); register;
var
  ORDERS_CancelOrder: ORDERS_CancelOrderHandler = ORDERS_CancelOrderHandler($0043A1F0);

type
  ORDERS_MovementRelatedHandler = procedure( eax, edx: Cardinal;
                                             p_UnitOrder: PUnitOrder;
                                             Dist: Integer;
                                             p_Position: PPosition ); register;
var
  ORDERS_MovementRelated: ORDERS_MovementRelatedHandler = ORDERS_MovementRelatedHandler($00438930);

type
  ORDERS_ChaseUnitToBeRepairedHandler = function( p_Builder: PUnitStruct;
                                                  p_TargetUnit: PUnitStruct;
                                                  TestedStateMask: Cardinal ): LongBool; stdcall;
var
  ORDERS_ChaseUnitToBeRepaired: ORDERS_ChaseUnitToBeRepairedHandler = ORDERS_ChaseUnitToBeRepairedHandler($0043B400);

type
  ORDERS_DelayCallbackHandler = procedure( eax, edx: Cardinal;
                                           p_UnitOrder: PUnitOrder;
                                           Delay: Integer ); register;
var
  ORDERS_DelayCallback: ORDERS_DelayCallbackHandler = ORDERS_DelayCallbackHandler($00439E80);

type
  ORDERS_RecoverMainOrderHandler = procedure( p_Unit: PUnitStruct;
                                              p_UnitOrder: PUnitOrder ); stdcall;
var
  ORDERS_RecoverMainOrder: ORDERS_RecoverMainOrderHandler = ORDERS_RecoverMainOrderHandler($0043A020);


type
  ORDERS_BackupMainOrderHandler = procedure( eax, edx: Cardinal;
                                             p_UnitOrder: PUnitOrder;
                                             p_OrderCallBack: Pointer ); register;
var
  ORDERS_BackupMainOrder: ORDERS_BackupMainOrderHandler = ORDERS_BackupMainOrderHandler($004388D0);

type
  ORDERS_PushOrderHandler = procedure( p_Unit: PUnitStruct;
                                       p_UnitOrder: PUnitOrder ); stdcall;
var
  ORDERS_PushOrder: ORDERS_PushOrderHandler = ORDERS_PushOrderHandler($0043ACB0);


//////////////////////////////////////////////////////////////////////////////////////////
// Units
//////////////////////////////////////////////////////////////////////////////////////////

type
  UNITS_CreateHandler = function ( OwnerIndex : Cardinal;
                                   UnitInfoId: Cardinal;
                                   PosX_: Cardinal;
                                   PosZ_: Cardinal;
                                   PosY_: Cardinal;
                                   FullHp: Cardinal;
                                   UnitStateMask: Cardinal;
                                   UnitId: Cardinal) : Pointer; stdcall; // 0 if UnitId is unknown (?)
var
  UNITS_Create : UNITS_CreateHandler = UNITS_CreateHandler($00485F50);

type
  UNITS_CreateModelScriptsHandler = function (p_Unit : Pointer) : Pointer; stdcall;
var
  UNITS_CreateModelScripts : UNITS_CreateModelScriptsHandler = UNITS_CreateModelScriptsHandler($00485D40);

type
  UNITS_CreateMoveClassHandler = function ( p_Unit: Pointer ): Pointer; stdcall;
var
  UNITS_CreateMoveClass : UNITS_CreateMoveClassHandler = UNITS_CreateMoveClassHandler($00485E50);

type
  UNITS_FixYPosHandler = procedure(p_Unit: PUnitStruct); stdcall;
var
  UNITS_FixYPos : UNITS_FixYPosHandler = UNITS_FixYPosHandler($0048A870);

type
  UNITS_FixYPosOtherTypeHandler = procedure(p_Unit: PUnitStruct); stdcall;
var
  UNITS_FixYPosOtherType : UNITS_FixYPosOtherTypeHandler = UNITS_FixYPosOtherTypeHandler($0048A490);

type
  UNITS_NewUnitPositionHandler = function (p_Unit: Pointer;
                                           NewX, NewY, NewZ: Integer;
                                           State: Cardinal): Cardinal; stdcall;
var
  UNITS_NewUnitPosition : UNITS_NewUnitPositionHandler = UNITS_NewUnitPositionHandler($0048A9F0);

type
  UNITS_SetMetalExtractionRatioHandler = procedure ( p_Unit: Pointer ); stdcall;
var
  UNITS_SetMetalExtractionRatio : UNITS_SetMetalExtractionRatioHandler = UNITS_SetMetalExtractionRatioHandler($00437840);

type
  UNITS_StartWeaponsScriptsHandler = procedure ( p_Unit: Pointer ); stdcall;
var
  UNITS_StartWeaponsScripts : UNITS_StartWeaponsScriptsHandler = UNITS_StartWeaponsScriptsHandler($0049E070);

type
  UNITS_QueryWeaponPositionHandler = procedure( p_Unit: PUnitStruct;
                                                out OutPosition: TPosition;
                                                cWeapIdx: Byte;
                                                PieceIdx: Integer ); stdcall;
var
  UNITS_QueryWeaponPosition : UNITS_QueryWeaponPositionHandler = UNITS_QueryWeaponPositionHandler($0043E240);

type
  UNITS_CallAimScriptsHandler = procedure( p_Unit: PUnitStruct;
                                           out OutPosition: TPosition;
                                           cWeapIdx: Byte ); stdcall;
var
  UNITS_CallAimScripts : UNITS_CallAimScriptsHandler = UNITS_CallAimScriptsHandler($0043E2E0);

type
  UNITS_AllocateUnitHandler = function ( p_Unit : Pointer;
                                         PosX: Integer;
                                         PosY: Integer;
                                         PosZ: Integer;
                                         FullHp: Integer ): LongBool; stdcall;
var
  UNITS_AllocateUnit: UNITS_AllocateUnitHandler = UNITS_AllocateUnitHandler($00485A40);

type
  UNITS_AllocateMovementClassHandler = function ( p_Unit: Pointer): Pointer; stdcall;
var
  UNITS_AllocateMovementClass: UNITS_AllocateMovementClassHandler = UNITS_AllocateMovementClassHandler($00485E50);

type
  UNITS_RebuildLOSHandler = procedure(p_Unit: PUnitStruct); stdcall;
var
  UNITS_RebuildLOS : UNITS_RebuildLOSHandler = UNITS_RebuildLOSHandler($00482AC0);

type
  UNITS_RebuildFootPrintHandler = function (p_Unit: Pointer): Cardinal; stdcall;
var
  UNITS_RebuildFootPrint : UNITS_RebuildFootPrintHandler = UNITS_RebuildFootPrintHandler($0047CC30);

type
  UNITS_GiveUnitHandler = procedure ( p_Unit : Pointer;
                                      PlayerStruct : PPlayerStruct;
                                      Packet : Pointer); stdcall;
var
  UNITS_GiveUnit : UNITS_GiveUnitHandler = UNITS_GiveUnitHandler($00488570);

type
  // 0 : found in unit "recreate" proc
  // 3 : typical kill
  // 8 : TA finalization, kill all proc etc.
  UNITS_KillUnitHandler = procedure ( p_Unit: Pointer; a2: Cardinal ); stdcall;
var
  UNITS_KillUnit : UNITS_KillUnitHandler = UNITS_KillUnitHandler($004864B0);

type
  UNITS_MakeDamageHandler = procedure ( p_AttackerUnit: PUnitStruct;
                                        p_TargetUnit: PUnitStruct;
                                        Amount: Integer;
                                        DamageType: Cardinal;
                                        Angle: Word ); stdcall;
var
  UNITS_MakeDamage: UNITS_MakeDamageHandler = UNITS_MakeDamageHandler($00489BB0);

type
  UNITS_HealUnitHandler = function ( Healerp_Unit: Pointer;
                                     Healedp_Unit: Pointer;
                                     Amount: Single ): Integer; stdcall;
var
  UNITS_HealUnit: UNITS_HealUnitHandler = UNITS_HealUnitHandler($0041BD10);

type
  // GroupNr -1 when received unit death packet
  UNITS_SetHotKeyGroupHandler = procedure ( p_Unit: Pointer; GroupNr: Integer ); stdcall;
var
  UNITS_SetHotKeyGroup : UNITS_SetHotKeyGroupHandler = UNITS_SetHotKeyGroupHandler($00480250);

type
  UnitStateProbeHandler = function (OffscreenPtr: Cardinal): Integer; stdcall;
var
  UnitStateProbe: UnitStateProbeHandler = UnitStateProbeHandler($00467E50);

type
  UnitBuilderProbeHandler = function (OffscreenPtr: Cardinal): Integer; stdcall;
var
  UnitBuilderProbe: UnitBuilderProbeHandler = UnitBuilderProbeHandler($004685A0);

type
  Send_UnitBuildFinishedHandler = function ( p_Unit: Pointer; Unit2Ptr: Pointer ): Integer; stdcall;
var
  Send_UnitBuildFinished : Send_UnitBuildFinishedHandler = Send_UnitBuildFinishedHandler($004560C0);

type
  Send_UnitDeathHandler = function ( p_Unit: Pointer; a2: Integer ): Integer; stdcall;
var
  Send_UnitDeath : Send_UnitDeathHandler = Send_UnitDeathHandler($004864B0);

type
  FreeUnitOrdersHandler = procedure ( p_Unit: Pointer ); stdcall;
var
  FreeUnitOrders : FreeUnitOrdersHandler = FreeUnitOrdersHandler($00489740);

type
  AutoAimHandler = procedure(p_Unit: PUnitStruct); stdcall;
var
  AutoAim : AutoAimHandler = AutoAimHandler($0049E1A0);

type
  CallbackForUnitsInDistanceHandler = procedure( p_Position: PPosition;
                                                 Distance: Integer;
                                                 UnitSearchCallbackRec: PUnitSearchCallbackRec ); stdcall;
var
  CallbackForUnitsInDistance: CallbackForUnitsInDistanceHandler = CallbackForUnitsInDistanceHandler($0047E890);

type
  SearchForReclamateFeaturesHandler = function( p_Position: PPosition;
                                                Distance: Integer;
                                                p_FoundPosition: PPosition;
                                                p_OutFeatureEnergy: PSingle;
                                                p_Unk: PPosition;
                                                p_Unk2: PSingle ): LongBool; stdcall;
var
  SearchForReclamateFeatures: SearchForReclamateFeaturesHandler = SearchForReclamateFeaturesHandler($0047EA40);

//////////////////////////////////////////////////////////////////////////////////////////
// Network and multiplayer games related stuff
//////////////////////////////////////////////////////////////////////////////////////////

Type
  HAPINET_guaranteepacketsHandler = function(NewState: Integer): Integer; stdcall;
var
  HAPINET_guaranteepackets : HAPINET_guaranteepacketsHandler = HAPINET_guaranteepacketsHandler($004C9790);

Type
  HAPI_BroadcastMessageHandler = function(FromPID: TDPID;
    p_Buffer: Pointer; BufferSize: Cardinal): LongBool; stdcall;
var
  HAPI_BroadcastMessage : HAPI_BroadcastMessageHandler = HAPI_BroadcastMessageHandler($00451DF0);

Type
  HAPI_SendMessageHandler = function(FromPID: TDPID;
    ToPID: TDPID; p_Buffer: Pointer; BufferSize: Cardinal): LongBool; stdcall;
var
  HAPI_SendMessage : HAPI_SendMessageHandler = HAPI_SendMessageHandler($00451BC0);

type
  DirectID2PlayerAryHandler = function ( a1: LongInt ): Byte; stdcall;
var
  DirectID2PlayerAry : DirectID2PlayerAryHandler = DirectID2PlayerAryHandler($44FE40);

type
  GetLocalPlayerDPIDHandler = function: TDPID; cdecl;
var
  GetLocalPlayerDPID : GetLocalPlayerDPIDHandler = GetLocalPlayerDPIDHandler($0044FDB0);

type
  GetSharedPlayerDPIDHandler = function: TDPID; cdecl;
var
  GetSharedPlayerDPID : GetSharedPlayerDPIDHandler = GetSharedPlayerDPIDHandler($00450030);

type
  IsLocalPlayerHostHandler = function: LongBool; cdecl;
var
  IsLocalPlayerHost : IsLocalPlayerHostHandler = IsLocalPlayerHostHandler($00457A50);

type
  UpdateGameInfoHandler = function: LongBool; cdecl;
var
  UpdateGameInfo : UpdateGameInfoHandler = UpdateGameInfoHandler($00451180);

type
  Send_PacketPlayerInfoHandler = procedure; cdecl;
var
  Send_PacketPlayerInfo : Send_PacketPlayerInfoHandler = Send_PacketPlayerInfoHandler($00450F90);

//////////////////////////////////////////////////////////////////////////////////////////
// Ingame reporter
//////////////////////////////////////////////////////////////////////////////////////////

type
  REPORTER_PlayerInfoHandler = function ( InfoType: Integer ): Integer; stdcall;
var
  REPORTER_PlayerInfo : REPORTER_PlayerInfoHandler = REPORTER_PlayerInfoHandler($00450F90);

//////////////////////////////////////////////////////////////////////////////////////////
// COB Engine
//////////////////////////////////////////////////////////////////////////////////////////

type
  COBEngine_LoadScriptFromFileHandler = function (FilePath : PAnsiChar) : Pointer; stdcall;
var
  COBEngine_LoadScriptFromFile : COBEngine_LoadScriptFromFileHandler = COBEngine_LoadScriptFromFileHandler($004B2450);

type
  COBEngine_StartScriptHandler = procedure(a1: Cardinal;
                                           a2: Cardinal;
                                           UnitScriptsData_p: Pointer;
                                           lArg4: Integer;
                                           lArg3: Integer;
                                           lArg2: Integer;
                                           lArg1: Integer;
                                           lArgsCount: Cardinal;
                                           Guaranteed: LongBool;
                                           p_Callback: Pointer;
                                           const Name: PAnsiChar); register;
var
  COBEngine_StartScript: COBEngine_StartScriptHandler = COBEngine_StartScriptHandler($004B0A70);

type
  COBEngine_QueryScriptHandler = function(a1: Cardinal;
                                          a2: Cardinal;
                                          UnitScriptsData_p: Pointer;
                                          lArg4: PInteger;
                                          lArg3: PInteger;
                                          lArg2: PInteger;
                                          lArg1: PInteger;
                                          const Name: PAnsiChar): LongInt; register;
var
  COBEngine_QueryScript: COBEngine_QueryScriptHandler = COBEngine_QueryScriptHandler($004B0BC0);

type
  COBEngine_DoScriptsNowHandler = function(COBData_p: Pointer): Integer; stdcall;
var
  COBEngine_DoScriptsNow : COBEngine_DoScriptsNowHandler = COBEngine_DoScriptsNowHandler($004B0D60);

//////////////////////////////////////////////////////////////////////////////////////////
// GFX
//////////////////////////////////////////////////////////////////////////////////////////

type
  DrawGameScreenHandler = procedure (DrawUnits: Integer; BlitScreen: Integer); stdcall;
var
  DrawGameScreen : DrawGameScreenHandler = DrawGameScreenHandler($00468CF0);

type
  DrawHealthBarsHandler = procedure( p_Offscreen: Pointer;
                                     p_Unit: PUnitStruct;
                                     PosX: Integer;
                                     PosY: Integer ); stdcall;
var
  DrawHealthBars : DrawHealthBarsHandler = DrawHealthBarsHandler($0046A430);

type
  DrawUnitHandler = procedure( p_Offscreen: Pointer;
                               p_Unit: PUnitStruct ); stdcall;
var
  DrawUnit : DrawUnitHandler = DrawUnitHandler($0045AC20);

type
  DrawUnitSelectBoxRectHandler = procedure( p_Offscreen: Pointer;
                                            p_Unit: PUnitStruct ); stdcall;
var
  DrawUnitSelectBoxRect : DrawUnitSelectBoxRectHandler = DrawUnitSelectBoxRectHandler($0046A530);

type
  DrawBarHandler = procedure( p_Offscreen: Pointer;
                              p_TagRect: PtagRECT;
                              ColorOffset: Byte ); stdcall;
var
  DrawBar : DrawBarHandler = DrawBarHandler($004BF6F0);

type
  DrawTranspRectangleHandler = procedure( p_Offscreen: Pointer;
                                          Position: Pointer;
                                          ColorOffset: Byte ); stdcall;
var
  DrawTranspRectangle : DrawTranspRectangleHandler = DrawTranspRectangleHandler($004BF8C0);

type
  DrawPointHandler = procedure( p_Offscreen: Pointer;
                                X, Y : Integer;
                                ColorOffset: Byte ); stdcall;
var
  DrawPoint : DrawPointHandler = DrawPointHandler($004BEE60);

type
  DrawUnk1Handler = procedure( p_Offscreen: Pointer;
                               Position: Pointer;
                               ColorOffset: Byte ); stdcall;
var
  DrawUnk1 : DrawUnk1Handler = DrawUnk1Handler($004BFD60);

type
  DrawLineHandler = procedure( p_Offscreen: Pointer;
                               X, Y, X2, Y2: Integer;
                               ColorOffset: Byte ); stdcall;
var
  DrawLine : DrawLineHandler = DrawLineHandler($004BE950);

type
  DrawLightHandler = procedure( p_Offscreen: Pointer;
                                X, Y, X2, Y2: Integer;
                                ColorOffset: Byte ); stdcall;
var
  DrawLight : DrawLightHandler = DrawLightHandler($004BEC70);

type
  DrawAlphaHandler = procedure( p_Offscreen: Pointer;
                                X, Y, X2, Y2: Integer;
                                ColorOffset: Byte ); stdcall;
var
  DrawAlpha : DrawAlphaHandler = DrawAlphaHandler($004BED70);

type
  DrawLine2Handler = procedure( p_Offscreen: Pointer;
                                x1, y1, x2, y2: Integer;
                                Color: Byte ); stdcall;
var
  DrawLine2 : DrawLine2Handler = DrawLine2Handler($004CC7AB);

type
  DrawCircleHandler = procedure( p_Offscreen: Pointer;
                                 CenterX, CenterY, Radius : Integer;
                                 ColorOffset: Byte ); stdcall;
var
  DrawCircle : DrawCircleHandler = DrawCircleHandler($004C0070);

type
  DrawDotteCircleHandler = procedure( p_Offscreen: Pointer;
                                      CenterX, CenterY, Radius: Integer;
                                      ColorOffset: Integer;
                                      Spacing: Word;
                                      Dotte_b: Integer); stdcall;
var
  DrawDotteCircle : DrawDotteCircleHandler = DrawDotteCircleHandler($004C01A0);

type
  DrawRangeCircleHandler = procedure( p_Offscreen: Pointer;
                                      CirclePointer: Cardinal;
                                      Position: PPosition;
                                      Radius : Integer;
                                      ColorOffset: Integer;
                                      Text: PAnsiChar;
                                      Priority: Integer ); stdcall;
var
  DrawRangeCircle : DrawRangeCircleHandler = DrawRangeCircleHandler($00438EA0);

type
  DrawProgressBarHandler = procedure( p_Offscreen: Pointer;
                                      Position: Pointer;
                                      BarPosition: Integer ); stdcall;
var
  DrawProgressBar : DrawProgressBarHandler = DrawProgressBarHandler($00468310);

type
  DrawTransparentBoxHandler = procedure( p_Offscreen: Pointer;
                                         Position: PtagRECT;
                                         Transp: Integer ); stdcall;
var
  DrawTransparentBox : DrawTransparentBoxHandler = DrawTransparentBoxHandler($004BF4D0);

type
  DrawTextCustomFontHandler = procedure( p_Offscreen: Pointer;
                                         const Str: PAnsiChar;
                                         Left: Integer;
                                         Top: Integer;
                                         MaxWidth: Integer ); stdcall;
var
  DrawTextCustomFont: DrawTextCustomFontHandler = DrawTextCustomFontHandler($004C14F0);

type
  DrawTextHandler = procedure( p_Offscreen: Pointer;
                               const Str: PAnsiChar;
                               Left: Integer;
                               Top: Integer;
                               MaxLen: Integer;
                               Background: Integer); stdcall;
var
  DrawText : DrawTextHandler = DrawTextHandler($004A50E0);

type
  DrawText_ThinHandler = procedure( p_Offscreen: Pointer;
                                    const Str: PAnsiChar;
                                    Left: Integer;
                                    Top: Integer;
                                    MaxLen: Integer;
                                    a6: Integer;
                                    Background: Integer); stdcall;
var
  DrawText_Thin : DrawText_ThinHandler = DrawText_ThinHandler($004A51D0);

type
  SetFONTLENGTH_ptrHandler = function (NewFontLength: Cardinal) : LongInt; stdcall;
var
  SetFONTLENGTH_ptr : SetFONTLENGTH_ptrHandler = SetFONTLENGTH_ptrHandler($004C1420);

type
  GAF_Name2SequenceHandler = function (GafStruct: Pointer; SequenceName: PAnsiChar): PGAFSequence; stdcall;
var
  GAF_Name2Sequence : GAF_Name2SequenceHandler = GAF_Name2SequenceHandler($004B8D40);

type
  GAF_SequenceIndex2FrameHandler = function (p_GAFSequence: PGAFSequence; Index: Integer): PGAFFrame; stdcall;
var
  GAF_SequenceIndex2Frame : GAF_SequenceIndex2FrameHandler = GAF_SequenceIndex2FrameHandler($004B7F30);

type
  GAF_OpenAnimsFileHandler = function (FileName: PAnsiChar): Pointer; stdcall;
var
  GAF_OpenAnimsFile : GAF_OpenAnimsFileHandler = GAF_OpenAnimsFileHandler($00429700);

type
  GAF_DrawTransformedHandler = function (p_Offscreen: Pointer; GafSequence: Pointer; Position: PGAFFrameTransform; Pos2: PGAFFrameTransform) : Pointer; stdcall;
var
  GAF_DrawTransformed : GAF_DrawTransformedHandler = GAF_DrawTransformedHandler($004C7580);

type
  ShowExplodeGafHandler = procedure( Position: PPosition;
                                     p_GAFAnim: PGAFSequence;
                                     AddGlow: Integer;
                                     AddSmoke: Integer ); stdcall;
var
  ShowExplodeGaf : ShowExplodeGafHandler = ShowExplodeGafHandler($00420A30);

type
  sub_4B8B30Handler = procedure(p_Exp: Pointer; p_GAFAnim: Pointer; StartingFrame: LongInt); stdcall;
var
  sub_4B8B30 : sub_4B8B30Handler = sub_4B8B30Handler($4B8B30);

type
  EmitSfx_SmokeInfiniteHandler = function (Position: PPosition; nPrior: Integer) : Byte; stdcall;
var
  EmitSfx_SmokeInfinite : EmitSfx_SmokeInfiniteHandler = EmitSfx_SmokeInfiniteHandler($00472C50);

type
  EmitSfx_BlackSmokeHandler = function (Position: PPosition; nPrior: Integer) : Byte; stdcall;
var
  EmitSfx_BlackSmoke : EmitSfx_BlackSmokeHandler = EmitSfx_BlackSmokeHandler($004728F0);

type
  EmitSfx_GraySmokeHandler = function (Position: PPosition; nPrior: Integer) : Byte; stdcall;
var
  EmitSfx_GraySmoke : EmitSfx_GraySmokeHandler = EmitSfx_GraySmokeHandler($00472810);

type
  EmitSfx_NanoParticlesHandler = function (p_PosStart: PPosition; p_PosTarget: PNanolathePos; nPrior: Word) : Cardinal; stdcall;
var
  EmitSfx_NanoParticles : EmitSfx_NanoParticlesHandler = EmitSfx_NanoParticlesHandler($004720D0);

type
  EmitSfx_NanoParticlesReverseHandler = function (p_PosTarget: PNanolathePos; p_PosStart: PPosition; nPrior: Word) : Cardinal; stdcall;
var
  EmitSfx_NanoParticlesReverse : EmitSfx_NanoParticlesReverseHandler = EmitSfx_NanoParticlesReverseHandler($00472200);

type
  EmitSfx_TeleportHandler = function (p_PosStart, p_PosTarget: PPosition; lSize: Integer; nPrior: Word) : Cardinal; stdcall;
var
  EmitSfx_Teleport : EmitSfx_TeleportHandler = EmitSfx_TeleportHandler($00471FD0);

type
  EmitSfx_BubblesHandler = function (p_PosStart, p_PosTarget: PPosition; lSize: Integer; nPrior: Word) : Cardinal; stdcall;
var
  EmitSfx_Bubbles : EmitSfx_BubblesHandler = EmitSfx_BubblesHandler($00472530);

type
  EmitSfx_Unk5Handler = function (p_PosStart: PPosition; nPrior: Word) : Cardinal; stdcall;
var
  EmitSfx_Unk5 : EmitSfx_Unk5Handler = EmitSfx_Unk5Handler($00472AB0);

//////////////////////////////////////////////////////////////////////////////////////////
// SFX - Sounds
//////////////////////////////////////////////////////////////////////////////////////////

type
  PlaySound_UnitSpeechHandler = function (p_Unit : PUnitStruct;
    speechtype: Cardinal; speechtext: PAnsiChar) : byte; stdcall;
var
  PlaySound_UnitSpeech : PlaySound_UnitSpeechHandler = PlaySound_UnitSpeechHandler($0047F780);

type
  PlaySound_2D_NameHandler = function (SoundName: PAnsiChar; Broadcast: Integer) : Integer; stdcall;
var
  PlaySound_2D_Name : PlaySound_2D_NameHandler =  PlaySound_2D_NameHandler($0047F1A0);

type
  PlaySound_2D_IDHandler = function (SoundNum: Cardinal; Broadcast: Integer) : Integer; stdcall;
var
  PlaySound_2D_ID : PlaySound_2D_IDHandler =  PlaySound_2D_IDHandler($0047F0C0);

type
  PlaySound_3D_NameHandler = function (SoundName: PAnsiChar;
    GridPosition: Pointer; Broadcast: Integer) : Integer; stdcall;
var
  PlaySound_3D_Name : PlaySound_3D_NameHandler =  PlaySound_3D_NameHandler($0047F610);

type
  PlaySound_3D_IDHandler = function (SoundNum: Cardinal;
    Position: Pointer; Broadcast: Integer) : Integer; stdcall;
var
  PlaySound_3D_ID : PlaySound_3D_IDHandler =  PlaySound_3D_IDHandler($0047F300);

//////////////////////////////////////////////////////////////////////////////////////////
// GUI - menus
//////////////////////////////////////////////////////////////////////////////////////////

type
  GUIGADGET_GetStatusHandler = function(pTAUI: Pointer; Name: PAnsiChar): Integer; stdcall;
var
  GUIGADGET_GetStatus : GUIGADGET_GetStatusHandler = GUIGADGET_GetStatusHandler($004A0F60);

type
  GUIGADGET_SetStatusHandler = function(pTAUI: Pointer;
    Name: PAnsiChar; NewVal: Integer): Integer; stdcall;
var
  GUIGADGET_SetStatus : GUIGADGET_SetStatusHandler = GUIGADGET_SetStatusHandler($004A1080);

type
  GUIGADGET_GetActiveHandler = function(pTAUI: Pointer; Name: PAnsiChar): Integer; stdcall;
var
  GUIGADGET_GetActive : GUIGADGET_GetActiveHandler = GUIGADGET_GetActiveHandler($004A04F0);

type
  GUIGADGET_SetActiveHandler = function(pTAUI: Pointer;
    Name: PAnsiChar; NewVal: Integer): Integer; stdcall;
var
  GUIGADGET_SetActive : GUIGADGET_SetActiveHandler = GUIGADGET_SetActiveHandler($004A0570);

type
  GUIGADGET_SetTextHandler = function(pTAUI: Pointer;
    Name: PAnsiChar; NewStr: PAnsiChar; Length: Integer): Integer; stdcall;
var
  GUIGADGET_SetText : GUIGADGET_SetTextHandler = GUIGADGET_SetTextHandler($004A0BF0);

type
  GUIGADGET_SetGrayedOutHandler = function(pTAUI: Pointer;
    Name: PAnsiChar; NewVal: Integer): Integer; stdcall;
var
  GUIGADGET_SetGrayedOut : GUIGADGET_SetGrayedOutHandler = GUIGADGET_SetGrayedOutHandler($004A1450);

type
  GUIGADGET_WasPressedHandler = function(pTAUI: Pointer; Name: PAnsiChar): LongBool; stdcall;
var
  GUIGADGET_WasPressed : GUIGADGET_WasPressedHandler = GUIGADGET_WasPressedHandler($0049FD60);

type
  GUICONTROL_IsOnTopHandler = function(pTAUI: Pointer; const Name: PAnsiChar): LongBool; stdcall;
var
  GUICONTROL_IsOnTop : GUICONTROL_IsOnTopHandler = GUICONTROL_IsOnTopHandler($004AB060);

type
  GetStrExtentHandler = function(Str: PAnsiChar): Integer; stdcall;
var
  GetStrExtent : GetStrExtentHandler = GetStrExtentHandler($004A5030);

type
  GetCustomFontCharWidthHandler = function: Integer; stdcall;
var
  GetCustomFontCharWidth : GetCustomFontCharWidthHandler = GetCustomFontCharWidthHandler($004C1450);

type
  GetCustomFontStrExtentHandler = function(FontHandle: Pointer; Str: PAnsiChar): Integer; stdcall;
var
  GetCustomFontStrExtent : GetCustomFontStrExtentHandler = GetCustomFontStrExtentHandler($004C1480);

//////////////////////////////////////////////////////////////////////////////////////////
// Engine registry and INI options
//////////////////////////////////////////////////////////////////////////////////////////

type
  REGISTRY_ReadIntegerHandler = function(const lpSubKey: PAnsiChar;
    const lpValueName: PAnsiChar; Buffer: Pointer): Integer; stdcall;
var
  REGISTRY_ReadInteger : REGISTRY_ReadIntegerHandler = REGISTRY_ReadIntegerHandler($004B69D0);

type
  REGISTRY_WriteIntegerHandler = function(const lpSubKey: PAnsiChar;
    const lpValueName: PAnsiChar; Data: Integer): Integer; stdcall;
var
  REGISTRY_WriteInteger : REGISTRY_WriteIntegerHandler = REGISTRY_WriteIntegerHandler($004B6A50);

type
  REGISTRY_SaveSettingsHandler = procedure; cdecl;
var
  REGISTRY_SaveSettings : REGISTRY_SaveSettingsHandler = REGISTRY_SaveSettingsHandler($00430F00);

//////////////////////////////////////////////////////////////////////////////////////////
// Memory
//////////////////////////////////////////////////////////////////////////////////////////

type
  MEM_AllocHandler = function(Size: Cardinal): Pointer; cdecl;
var
  MEM_Alloc : MEM_AllocHandler = MEM_AllocHandler($004B4F10);

type
  MEM_ReAllocHandler = function(Memory: Pointer; NewSize: Cardinal): Pointer; cdecl;
var
  MEM_ReAlloc : MEM_ReAllocHandler = MEM_ReAllocHandler($004D8580);

type
  MEM_FreeHandler = procedure(Memory: Pointer); cdecl;
var
  MEM_Free : MEM_FreeHandler = MEM_FreeHandler($004D85A0);

type
  MEM_Free_PointerHandler = procedure(Memory: Pointer); cdecl;
var
  MEM_Free_Pointer : MEM_Free_PointerHandler = MEM_Free_PointerHandler($004D8670);

type
  MEM_Free_PPointerHandler = procedure(Memory: Pointer); cdecl;
var
  MEM_Free_PPointer : MEM_Free_PPointerHandler = MEM_Free_PPointerHandler($004B4F20);

Type
  MEM_AllowReadWriteHandler = function(Address : Cardinal): Integer; cdecl;
var
  MEM_AllowReadWrite : MEM_AllowReadWriteHandler = MEM_AllowReadWriteHandler($004D8780);

Type
  MEM_SetReadOnlyHandler = function(Address : Cardinal): Integer; cdecl;
var
  MEM_SetReadOnly : MEM_SetReadOnlyHandler = MEM_SetReadOnlyHandler($004D8710);

//////////////////////////////////////////////////////////////////////////////////////////
// HPI, HAPIBANK and TDF files
//////////////////////////////////////////////////////////////////////////////////////////

type
  HAPIFILE_GetFileLengthHandler = function(FilePath: PAnsiChar): Integer; stdcall;
var
  HAPIFILE_GetFileLength : HAPIFILE_GetFileLengthHandler = HAPIFILE_GetFileLengthHandler($004BBC40);

Type
  HAPIFILE_FindFirstHandler = function(lpFileName: PAnsiChar;
    finddata_ptr: Pointer; SearchType: Integer; TryNext: Integer): Integer; stdcall;
var
  HAPIFILE_FindFirst : HAPIFILE_FindFirstHandler = HAPIFILE_FindFirstHandler($004BC4B0);

Type
  HAPIFILE_FindNextHandler = function(SearchHandle: Integer;
    finddata_ptr: Pointer): Integer; stdcall;
var
  HAPIFILE_FindNext : HAPIFILE_FindNextHandler = HAPIFILE_FindNextHandler($004BC640);

Type
  HAPIFILE_FindCloseHandler = function(SearchHandle: Integer): Integer; stdcall;
var
  HAPIFILE_FindClose : HAPIFILE_FindCloseHandler = HAPIFILE_FindCloseHandler($004BC8D0);

Type
  HAPIFILE_ReadFileHandler = function(FilePath: PAnsiChar; StartOffset: Integer): Pointer; stdcall;
var
  HAPIFILE_ReadFile : HAPIFILE_ReadFileHandler = HAPIFILE_ReadFileHandler($004BBE50);

Type
  GetLocalizedFilePathHandler = procedure( Buffer: Pointer;
                                           FileDir: PAnsiChar;
                                           FileName: PAnsiChar;
                                           FileExt: PAnsiChar ); stdcall;
var
  GetLocalizedFilePath : GetLocalizedFilePathHandler = GetLocalizedFilePathHandler($004290F0);

Type
  Open3DOFileHandler = function(FileName: PAnsiChar): Pointer; stdcall;
var
  Open3DOFile : Open3DOFileHandler = Open3DOFileHandler($004CB560);

Type
  Parse3DOFileHandler = procedure(p_3DO: Pointer); stdcall;
var
  Parse3DOFile : Parse3DOFileHandler = Parse3DOFileHandler($004CB590);

Type
  TextureMatch3DOHandler = procedure(p_3DO: Pointer; ModelName: PAnsiChar); stdcall;
var
  TextureMatch3DO : TextureMatch3DOHandler = TextureMatch3DOHandler($0042A140);

Type
  HAPIFILE_InsertToArrayHandler = function(Filename: PAnsiChar;
    Priority: Integer): Integer; stdcall;
var
  HAPIFILE_InsertToArray : HAPIFILE_InsertToArrayHandler = HAPIFILE_InsertToArrayHandler($004BE0B0);

type
  HAPIBANK_OpenAccountHandler = function ( Eax: Pointer; Edx: Pointer;
                                           HAPIBANK: Pointer;
                                           const AccountName: PAnsiChar ): LongBool; register;
var
  HAPIBANK_OpenAccount : HAPIBANK_OpenAccountHandler = HAPIBANK_OpenAccountHandler($004B4560);

type
  HAPIBANK_WriteIntegerHandler = function ( Eax: Pointer; Edx: Pointer;
                                            HAPIBANK: Pointer;
                                            Value: Integer;
                                            const Description: PAnsiChar ): LongBool; register;
var
  HAPIBANK_WriteInteger : HAPIBANK_WriteIntegerHandler = HAPIBANK_WriteIntegerHandler($004B4630);

type
  HAPIBANK_ReadIntegerHandler = function ( Eax: Pointer; Edx: Pointer;
                                           HAPIBANK: Pointer;
                                           DefaultVal: Integer;
                                           const Description: PAnsiChar ): Integer; register;
var
  HAPIBANK_ReadInteger : HAPIBANK_ReadIntegerHandler = HAPIBANK_ReadIntegerHandler($004B4800);

type
  HAPIBANK_WriteStringHandler = function ( Eax: Pointer; Edx: Pointer;
                                           HAPIBANK: Pointer;
                                           Description: PAnsiChar;
                                           Value: PAnsiChar ): LongBool; register;
var
  HAPIBANK_WriteString : HAPIBANK_WriteStringHandler = HAPIBANK_WriteStringHandler($004B4750);

type
  HAPIBANK_WriteBinDataHandler = function ( Eax: Pointer; Edx: Pointer;
                                            HAPIBANK: Pointer;
                                            WriteSize: Cardinal;
                                            Data: Pointer ): Cardinal; register;
var
  HAPIBANK_WriteBinData : HAPIBANK_WriteBinDataHandler = HAPIBANK_WriteBinDataHandler($004B4CF0);

type
  HAPIBANK_ReadBinDataHandler = function ( Eax: Pointer; Edx: Pointer;
                                           HAPIBANK: Pointer;
                                           ReadSize: Cardinal;
                                           Dest: Pointer ): Cardinal; register;
var
  HAPIBANK_ReadBinData : HAPIBANK_ReadBinDataHandler = HAPIBANK_ReadBinDataHandler($004B4C80);

type
  HAPIBANK_GetItemSizeHandler = function ( Eax: Pointer; Edx: Pointer;
                                           HAPIBANK: Pointer ): Integer; register;
var
  HAPIBANK_GetItemSize : HAPIBANK_GetItemSizeHandler = HAPIBANK_GetItemSizeHandler($004B4BF0);

type
  HAPIBANK_AccessSafeDepositHandler = function ( Eax: Pointer; Edx: Pointer;
                                                 HAPIBANK: Pointer;
                                                 Description: PAnsiChar ): LongBool; register;
var
  HAPIBANK_AccessSafeDeposit :
    HAPIBANK_AccessSafeDepositHandler = HAPIBANK_AccessSafeDepositHandler($004B4BA0);

type
  HAPIBANK_SeekInHexHandler = function ( Eax: Pointer; Edx: Pointer;
                                         HAPIBANK: Pointer;
                                         Position: Integer ): Integer; register;
var
  HAPIBANK_SeekInHex : HAPIBANK_SeekInHexHandler = HAPIBANK_SeekInHexHandler($004B4C10);

// warning: this also jumps into section if exists
type
  TdfFile_SectionExistsHandler = function ( Eax : Cardinal;
                                            Edx : Cardinal;
                                            Ecx : Cardinal;
                                            SectionName : PAnsiChar): Boolean; register;
var
  TdfFile_SectionExists : TdfFile_SectionExistsHandler = TdfFile_SectionExistsHandler($004C3410);

type
  TdfFile_GetIntHandler = function ( Eax : Cardinal;
                                     Edx : Cardinal;
                                     Ecx : Cardinal;
                                     DefaultNumber : LongInt;
                                     TagName : PAnsiChar): Integer; register;
var
  TdfFile_GetInt : TdfFile_GetIntHandler = TdfFile_GetIntHandler($004C46C0);

type
  TdfFile_GetStrHandler = function ( Eax : Cardinal;
                                     Edx : Cardinal;
                                     Ecx : Cardinal;
                                     Default : Pointer;
                                     BufLen : Integer;
                                     Name : Pointer;
                                     ReceiveBuf : Pointer): Integer; register;
var
  TdfFile_GetStr : TdfFile_GetStrHandler = TdfFile_GetStrHandler($004C48C0);

type
  TdfFile_GetFloatHandler = function ( Eax : Cardinal;
                                       Edx : Cardinal;
                                       Ecx : Cardinal;
                                       DefaultNumber : Double;
                                       TagName : PAnsiChar): Double; register;
var
  TdfFile_GetFloat : TdfFile_GetFloatHandler = TdfFile_GetFloatHandler($004C4760);

type
  TdfFile_GetRootHandler = function ( Eax : Cardinal;
                                      Edx : Cardinal;
                                      TDFhandle : Cardinal): Cardinal; register;
var
  TdfFile_GetRoot : TdfFile_GetRootHandler = TdfFile_GetRootHandler($004C3E20);

type
  TdfFile_SetRootHandler = procedure ( Eax : Cardinal;
                                       Edx : Cardinal;
                                       TDFhandle : Cardinal;
                                       NewRoot: Cardinal); register;
var
  TdfFile_SetRoot : TdfFile_SetRootHandler = TdfFile_SetRootHandler($004C3E30);

Type
  SetCurrentDirectoryToTAPathHandler = function: Boolean; cdecl;
var
  SetCurrentDirectoryToTAPath : SetCurrentDirectoryToTAPathHandler = SetCurrentDirectoryToTAPathHandler($0049F540);

//////////////////////////////////////////////////////////////////////////////////////////
/// Not used.
//////////////////////////////////////////////////////////////////////////////////////////

type
  InitPlayerStructHandler = function(PlayerPtr: PPlayerStruct): Pointer; stdcall;
var
  InitPlayerStruct : InitPlayerStructHandler = InitPlayerStructHandler($00464700);

//////////////////////////////////////////////////////////////////////////////////////////

function SHiWord(A: Integer): SmallInt; overload;
function SHiWord(A: Cardinal): SmallInt; overload;

implementation

procedure InterpretInternalCommand(CommandText: string);
begin
  InterpretCommand(PChar(CommandText),access);
end;

procedure SendTextLocal(Text: string);
begin
  ShowReminderMsg(PAnsiChar(Text), 0);
end;

function SHiWord(A: Cardinal): SmallInt; overload;
begin
  Result := SmallInt(A div 65536);
end;

function SHiWord(A: Integer): SmallInt; overload;
begin
  Result := SmallInt(Cardinal(A) div 65536);
end;

end.