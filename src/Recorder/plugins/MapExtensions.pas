unit MapExtensions;

interface
uses
  Windows, SysUtils, Classes, PluginEngine, IniFiles;

// -----------------------------------------------------------------------------

type
  TMemStreamIniFile = class(TMemIniFile)
  public
     procedure LoadFromStream(Stream: TStream);
  end;

const
  State_MapExtensions: Boolean = True;

function GetPlugin : TPluginData;

// -----------------------------------------------------------------------------

Procedure OnInstallMapExtensions;
Procedure OnUninstallMapExtensions;

// -----------------------------------------------------------------------------

procedure SwapTNT(Idx: Byte);

implementation
uses
  UnitInfoExpand,
  ExtensionsMem,
  TA_MemoryConstants,
  TA_MemoryStructures,
  TA_MemoryLocations,
  TA_MemPlayers,
  TA_MemUnits,
  TA_FunctionsU;

procedure InitMapMissions; stdcall;
var
  MapOTAFile : PMapOTAFile;
  COBFilePath : String;
  TDFFilePath : String;
  TDFFileSize : Integer;
  p_TDFFile : Pointer;
  TDFFile : array of byte;
  msTDF : TMemoryStream;
  TDFIni : TMemStreamIniFile;
  AiDifficulty : Integer;
  GameType : Integer;
  SectionKeys: TStringList;
  i: Integer;
begin
  MouseLock := False;
  CameraFadeLevel := 0;

  MapOTAFile := TAData.MainStruct.p_MapOTAFile;
  COBFilePath := ChangeFileExt(MapOTAFile.sTNTFile, '.cob');
  if HAPIFILE_GetFileLength(PAnsiChar(COBFilePath)) > 0 then
  begin
    TDFFilePath := ChangeFileExt(MapOTAFile.sTNTFile, '.tdf');
    TDFFileSize := HAPIFILE_GetFileLength(PAnsiChar(TDFFilePath));
    if TDFFileSize > 0 then
    begin
      p_TDFFile := LoadHPITerainFile(PAnsiChar(TDFFilePath));
      TDFIni := TMemStreamIniFile.Create('');
      try
        msTDF := TMemoryStream.Create;
        try
          SetLength(TDFFile, TDFFileSize);
          CopyMemory(TDFFile, p_TDFFile, TDFFileSize);
          msTDF.Write(TDFFile[0], TDFFileSize);
          msTDF.Position := 0;
          TDFIni.LoadFromStream(msTDF);
          if TDFIni.SectionExists('sounds') then
          begin
            MapMissionsSounds := TStringList.Create;
            TDFIni.ReadSection('sounds', MapMissionsSounds);
          end;
          if TDFIni.SectionExists('features') then
          begin
            MapMissionsFeatures := TStringList.Create;
            TDFIni.ReadSection('features', MapMissionsFeatures);
          end;
          if TDFIni.SectionExists('unitsmissions') then
          begin
            MapMissionsUnitsInitialMissions := TStringList.Create;
            TDFIni.ReadSection('unitsmissions', MapMissionsUnitsInitialMissions);
          end;
          if TDFIni.SectionExists('textmessages') then
          begin
            MapMissionsTextMessages := TStringList.Create;
            SectionKeys := TStringList.Create;
            try
              TDFIni.ReadSection('textmessages', SectionKeys);
              for i := 0 to SectionKeys.Count - 1 do
              begin
                MapMissionsTextMessages.Add(TDFIni.ReadString('textmessages', SectionKeys[i], ''));
              end;
            finally
              SectionKeys.Free;
            end;
          end;
        finally
          msTDF.Free;
        end;
      finally
        TDFIni.Free;
      end;
    end;

    FreeUnitMem(@MapMissionsUnit);

    MapMissionsUnit.nUnitInfoID := 1;
    //MapMissionsUnit.p_UNITINFO := TAMem.UnitInfoId2Ptr(0);

    MapMissionsUnit.p_Owner := TAPlayer.GetPlayerByIndex(TAData.LocalPlayerID);
    //if UNITS_AllocateUnit(@MapMissionsUnit, 0, 0, 0, 1) then
    //begin
      MapMissionsUnitInfo := PUnitInfo(TAMem.UnitInfoId2Ptr(MapMissionsUnit.nUnitInfoID))^;
      MapMissionsUnitInfo.pCOBScript := COBEngine_LoadScriptFromFile(PAnsiChar(COBFilePath));
      MapMissionsUnit.p_UNITINFO := @MapMissionsUnitInfo;
      UNITS_CreateModelScripts(@MapMissionsUnit);
      GameType := Ord(TAData.GameingType);
      if GameType <> 0 then
      begin
        AiDifficulty := Ord(TAData.AIDifficulty);
        TAUnit.CobStartScript(@MapMissionsUnit, 'MapMission',
          @GameType, @AiDifficulty, nil, nil, True);
      end;
      MapMissionsUnit.lUnitInGameIndex := MapMissionsUnit.lUnitInGameIndex or $0000FFFF;
    //end;
  end;
end;

procedure LoadingMapSchema;
asm
  pushAD
  call InitMapMissions
  popAD
  mov     ecx, [TADynMemStructPtr]
  //call LoadCampaign_UniqueUnits
  push $00497B50
  call PatchNJump
end;

procedure RunMapMissionScript;
label
  GoBack;
asm
  lea     esi, MapMissionsUnit
  push    esi
  mov     ecx, [esi+TUnitStruct.p_UnitScriptsData]
  test    ecx, ecx
  jz      GoBack
  push    1
  call    COBEngine_DoScriptsNow
GoBack :
  pop     esi
  mov     ecx, [TADynMemStructPtr]
  push $0048B02E
  call PatchNJump
end;

procedure CheckMouseForLock;
label
  NoNewMouseEvent,
  DiscardMouseEvent;
asm
  jz      NoNewMouseEvent
  mov     eax, MouseLock
  test    eax, eax
  jnz     DiscardMouseEvent
  push $004B5E3B
  call PatchNJump
NoNewMouseEvent :
  push $004B5F5F
  call PatchNJump
DiscardMouseEvent :
  push $004B5F56
  call PatchNJump
end;

procedure SolarEnergy;
label
  UseSolarEnergy,
  EnergyUse;
asm
  pushAD
  push    17
  push    esi
  call    GetUnitInfoProperty
  test    eax, eax
  jz      EnergyUse
UseSolarEnergy:
  // pop EnergyUse value
  fstp    st(0)
  fld     ExtraMapOTATags.SolarStrength
  mov     ecx, [esi+TUnitStruct.p_UNITINFO]
  movzx   eax, word ptr [ecx+TUnitInfo.nCategory]
  mov     ecx, type TUnitInfoCustomFieldsRec
  mov     edx, [UnitInfoCustomFields]
  imul    eax, ecx
  fld     qword ptr [edx+eax+TUnitInfoCustomFieldsRec.SolarGenerator]
  fmul    st(0), st(1)
  // new value must be in st(0)
  fstp    st(1)
  popAD
  mov     eax, [esi+TUnitStruct.p_Owner]
  push $00401431
  call PatchNJump
EnergyUse:
  popAD
  mov     eax, [esi+TUnitStruct.p_Owner]
  push $0040142F
  call PatchNJump
end;

procedure LoadOTATags(TDFHandle: Cardinal); stdcall;
begin
  ExtraMapOTATags.SolarStrength := TdfFile_GetFloat(0, 0, TDFHandle, 0.0, PAnsiChar('SolarStrength'));
end;

procedure LoadOTATagsHook;
asm
  pushAD
  push    ecx
  call    LoadOTATags
  popAD
  push    0
  push    0                // double
  push    $00504BF0        // "tidalstrength"
  push $0043655F
  call PatchNJump
end;

{ TMemStreamIniFile }

procedure TMemStreamIniFile.LoadFromStream(Stream: TStream);
var
  List : TStringList;
begin
  List := TStringList.Create;
  try
    List.LoadFromStream(Stream);
    SetStrings(List);
  finally
    List.Free;
  end;
end;

procedure SwapTNT(Idx: Byte);
var
  sCurrentTNTPath : String;
  lpFileName : PAnsiChar;
  TNTFile : PTNTHeaderStruct;
  TNTMemStruct : PTNTMemStruct;
  PTR_TILE_SET, PTR_TILE_MAP, PTR_HEIGHT_MAP, PTR_MINIMAP : Pointer;
  p_TileSet, p_TileMap, p_PlotMemory : Pointer;
  TileMapSize, PlotSize : Cardinal;
  CurrentPlotPos : Integer;
  GridPlot : PPlotGrid;
  CurrHeightMap : Cardinal;
  GafFrame : TGAFFrame;
  offp : Cardinal;
  i : integer;
  p_Unit : PUnitStruct;
  PlotGrid : PPlotGrid;
  x, z : Integer;
  AtLava : Boolean;
begin
  sCurrentTNTPath := PMapOTAFile(TAData.MainStruct.p_MapOTAFile).sTNTFile;
  lpFileName := PAnsiChar(ChangeFileExt(sCurrentTNTPath, IntToStr(Idx) + '.TNT'));
  TNTFile := LoadTNTFile(lpFileName);

  TNTMemStruct := @TAData.MainStruct.TNTMemStruct;
  CopyMemory(@PMapOTAFile(TAData.MainStruct.p_MapOTAFile).sTNTFile,
             lpFileName, Length(lpFileName));

  // tileset pixels data
  PTR_TILE_SET := Pointer(Cardinal(TNTFile) + TNTFile.p_TileSet);
  p_TileSet := MEM_Alloc((TNTFile.lTilesCount shl 10) + 8);
  PCardinal(p_TileSet)^ := TNTFile.lTilesCount;
  PCardinal(Cardinal(p_TileSet) + 4)^ := Cardinal(Pointer(Cardinal(p_TileSet) + 8));
  CopyMemory(Pointer(Cardinal(p_TileSet) + 8), PTR_TILE_SET, 4 * ((TNTFile.lTilesCount shl 10) shr 2));

  // tileset map
  TileMapSize := 2 * TNTMemStruct.lMapWidth div 32 * TNTMemStruct.lMapHeight div 32;
  p_TileMap := MEM_Alloc(TileMapSize);
  PTR_TILE_MAP := Pointer(Cardinal(TNTFile) + TNTFile.p_TileMap);
  CopyMemory(p_TileMap, PTR_TILE_MAP, TileMapSize);

  // plot data
  PlotSize := TNTMemStruct.lTilesetMapSizeX * TNTMemStruct.lTilesetMapSizeY;
  p_PlotMemory := MEM_Alloc(SizeOf(TPlotGrid) * PlotSize);
  CopyMemory(p_PlotMemory, TNTMemStruct.p_PlotMemory, SizeOf(TPlotGrid) * PlotSize);

  PTR_HEIGHT_MAP := Pointer(Cardinal(TNTFile) + TNTFile.p_HeightMap);
  GridPlot := PPlotGrid(p_PlotMemory);
  CurrHeightMap := Cardinal(PTR_HEIGHT_MAP);
  if PlotSize > 0 then
  begin
    CurrentPlotPos := PlotSize;
    repeat
      GridPlot.bHeight := PByte(CurrHeightMap)^;
      //GridPlot.nFeatureDefIndex := $FFFF;
      //if ( PWord(CurrHeightMap + 1)^ = $FFFC ) then
      //  PlaceFeatureOnMap(GridPlot, $FFFC, nil, nil, 10);
      GridPlot := Pointer(Cardinal(GridPlot) + SizeOf(TPlotGrid));
      Inc(CurrHeightMap, 4);
      Dec(CurrentPlotPos);
    until CurrentPlotPos <= 0;
  end;
  TNTMemStruct.p_TileSet := p_TileSet;
  TNTMemStruct.p_TileMap := p_TileMap;
  TNTMemStruct.p_PlotMemory := p_PlotMemory;
  LoadMap_AverageHeightMap;
  LoadMap_PLOT3;

  // reconstruct minimap
  PTR_MINIMAP := Pointer(Cardinal(TNTFile) + TNTFile.p_Minimap);
  GafFrame.Width := PCardinal(PTR_MINIMAP)^;
  GafFrame.Height := PCardinal(Pointer(Cardinal(PTR_MINIMAP) + 4))^;
  GafFrame.Left := 0;
  GafFrame.Top := 0;
  GafFrame.Background := 0;
  GafFrame.Compressed := 0;
  GafFrame.SubFrames := 0;
  GafFrame.IsCompressed := 0;
  GafFrame.PtrFrameData := nil;
  GafFrame.PtrFrameBits := Pointer(Pointer(Cardinal(PTR_MINIMAP) + 8));
  GafFrame.Bits2_Ptr := nil;
  TNTMemStruct.p_TedGeneratedPic := CompositeBuffer(PAnsiChar('TED GENERATED PIC'),
                                                    GafFrame.Width,
                                                    GafFrame.Height);
  CompositeBuf2_OFFSCREEN(@offp, TNTMemStruct.p_TedGeneratedPic);
  CopyGafToContext(@offp, @GafFrame, 0, 0);
  InitRadar;

  if (TAData.UnitsArray_p <> nil) then
  begin
    for i := 1 to TAData.MaxUnitsID do
    begin
      p_Unit := TAUnit.Id2Ptr(i);
      AtLava := False;
      if p_Unit <> nil then
        if p_Unit.nUnitInfoID <> 0 then
        begin
          for z := 0 to p_Unit.nFootPrintZ do
          begin
            for x := 0 to p_Unit.nFootPrintX do
            begin
              PlotGrid := GetGridPosPLOT(p_Unit.nGridPosX + x, p_Unit.nGridPosZ + z);
              if PlotGrid <> nil then
              begin
                //if GetPosHeight(@p_Unit.Position) = 0 then
                  if PlotGrid.nFeatureDefIndex = $FFFD then
                  begin
                    AtLava := True;
                    Break;
                  end;
              end;
            end;
            if AtLava then
              Break;
          end;
          if AtLava then
            if (p_Unit.lUnitStateMask and 3) <> 2 then
              if (TAData.MainStruct.p_MapOTAFile.lIsLavaMap <> 0) then
                TAUnit.Kill(p_Unit, 1)
              else
                TAUnit.Kill(p_Unit, 0);
        end;
    end;
  end;
  //LoadFeatures;
  //LoadFeatureAnimData(TNTFile);
  //LoadMetalSpots;
  FreeMemory(TNTFile);
end;

procedure DrawFade(p_Offscreen: Pointer); stdcall;
begin
  if CameraFadeLevel <> 0 then
    DrawTransparentBox(p_Offscreen, nil, CameraFadeLevel - 31);
end;

procedure ScreenFadeControl;
asm
  lea     ecx, [esp+224h-$1F0]
  push    ecx
  call    DrawFade
  lea     ecx, [esp+224h-$1F0]
  push    ecx
  push $0046A2E7
  call PatchNJump
end;

Procedure OnInstallMapExtensions;
begin
end;

Procedure OnUninstallMapExtensions;
begin
end;

function GetPlugin : TPluginData;
begin
  if IsTAVersion31 and State_MapExtensions then
  begin
    Result := TPluginData.Create( False,
                                  '',
                                  State_MapExtensions,
                                  @OnInstallMapExtensions,
                                  @OnUnInstallMapExtensions );

    Result.MakeRelativeJmp( State_MapExtensions,
                            'Init map script',
                            @LoadingMapSchema,
                            $00497B4A, 0 );

    Result.MakeRelativeJmp( State_MapExtensions,
                            'Keep running map script (no more "sleep" freeze)',
                            @RunMapMissionScript,
                            $0048B028, 0 );

    Result.MakeRelativeJmp( State_MapExtensions,
                            'Locking mouse functionality',
                            @CheckMouseForLock,
                            $004B5E35, 1 );
    
    Result.MakeRelativeJmp( State_MapExtensions,
                            '',
                            @SolarEnergy,
                            $00401429, 1 );

    Result.MakeRelativeJmp( State_MapExtensions,
                            '',
                            @LoadOTATagsHook,
                            $00436556, 4 );

    Result.MakeRelativeJmp( State_MapExtensions,
                            'Control game screen fade level',
                            @ScreenFadeControl,
                            $0046A2E2, 0 );
    {
    // do not release TDF Features vector after loading the list
    // this allows to place features on map that weren't loaded with the map data
    FillMemory(@Replacement[0], 5, $90);
    Result.MakeReplacement(State_MapExtensions,
                           '',
                           $004918DE,
                           Replacement );
    }
  end else
    Result := nil;
end;

end.