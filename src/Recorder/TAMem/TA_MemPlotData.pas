unit TA_MemPlotData;

interface
uses
  TA_MemoryStructures, TA_MemoryLocations, TA_MemUnits;

type
  TAMap = class
  public
    class procedure SetCameraToUnit(p_Unit: PUnitStruct);
    class function PlaceFeatureOnMap(FeatureName: String;
      Position: TPosition; Turn: TTurn) : Boolean;
    class procedure RemoveMapFeature(X, Z: Integer; Method: Boolean);
    class function PositionInLOS(Player: PPlayerStruct; Position: PPosition) : Boolean;
  end;

implementation
uses
  TA_FunctionsU;

// -----------------------------------------------------------------------------
// TAMap
// -----------------------------------------------------------------------------

class procedure TAMap.SetCameraToUnit(p_Unit: PUnitStruct);
begin
  TAData.MainStruct.pCameraToUnit := p_Unit;
end;

class function TAMap.PlaceFeatureOnMap(FeatureName: String;
  Position: TPosition; Turn: TTurn): Boolean;
var
  FeatureId: SmallInt;
  GridPlot: PPlotGrid;
  X, Z: Word;
begin
  Result := False;
  FeatureId := FeatureName2ID(PAnsiChar(FeatureName));

  if FeatureId = -1 then
    FeatureId := LoadFeature(PAnsiChar(FeatureName));

  if FeatureId <> -1 then
  begin
    TAMem.Position2Grid(Position, X, Z);
    GridPlot := GetGridPosPLOT(X, Z);
    Result := (SpawnFeatureOnMap(GridPlot, FeatureId, @Position, @Turn, 10) <> nil);
  end;
end;

class procedure TAMap.RemoveMapFeature(X, Z: Integer;
  Method: Boolean);
var
  GridPlot : PPlotGrid;
begin
  GridPlot := GetGridPosPLOT(X div 16, Z div 16);
  FEATURES_Destroy(GridPlot, Method);
end;

class function TAMap.PositionInLOS(Player: PPlayerStruct;
  Position: PPosition): Boolean;
var
  X, Z: Integer;
  Pos : Cardinal;
begin
  Result := False;
  if PositionInPlayerMapped(Player, Position) then
  begin
    X := SHiWord(Position.X) div 32;
    Z := (SHiWord(Position.Z) - (SHiWord(Position.Y) div 2)) div 32;
    if (X < Player.lLOS_Width) and
       (Z < Player.lLOS_Height) then
    begin
      Pos := Z * Player.lLOS_Width + X;
      Result := PByte(Cardinal(Player.LOS_MEMORY) + Pos)^ <> 0;
    end;
  end;
end;

end.