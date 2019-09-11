unit UWorld;

interface

uses
  System.Generics.Collections,
  UBaseTerrainTile, UTownTerrainObject;

type
  TWorld = class(TObject)
  private
    FSizeX: Integer;
    FSizeY: Integer;
    FTerrainTiles: TArray<TArray<TBaseTerrainTile>>;
    FTowns: TObjectList<TTownTerrainObject>;
  private
    procedure BuildTerrainArray;
    procedure DestroyOldWorld;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure CreateNewWorld(ASizeX, ASizeY: Integer);
    procedure EditTerrain(X, Y: Integer; ATerrainType: TTerrainType);
    procedure AddTown(X, Y: Integer; ATownName: String);
    procedure RemoveTown(X, Y: Integer);
  public
    property SizeX: Integer read FSizeX;
    property SizeY: Integer read FSizeY;
    property TerrainTiles: TArray<TArray<TBaseTerrainTile>> read FTerrainTiles;
    property Towns: TObjectList<TTownTerrainObject> read FTowns;
  end;

var
  TheWorld: TWorld;

implementation

uses
  UWaterTerrainTile, ULandTerrainTile, UMountainTerrainTile;

{ TWorld }

procedure TWorld.AddTown(X, Y: Integer; ATownName: String);
var
  I: Integer;
begin
  I := FTowns.Add(TTownTerrainObject.Create(X, Y));
  FTowns[I].TownName := ATownName;
end;

procedure TWorld.BuildTerrainArray;

  function BuildInnerArray: TArray<TBaseTerrainTile>;
  begin
    SetLength(Result, FSizeY);
  end;

  procedure FillTerrainArray;
  var
     X: Integer;
     Y: Integer;
  begin
    for X := 0 to FSizeX - 1 do
    begin
      for Y := 0 to FSizeY - 1 do
        FTerrainTiles[X][Y] := TWaterTerrainTile.Create;
    end;
  end;
var
  X: Integer;
begin
  SetLength(FTerrainTiles, FSizeX);

  for X := 0 to Length(FTerrainTiles) - 1 do
  begin
    FTerrainTiles[X] := BuildInnerArray;
  end;

  FillTerrainArray;
end;

constructor TWorld.Create;
begin
  FTowns := TObjectList<TTownTerrainObject>.Create;
  FTowns.OwnsObjects := True;
end;

procedure TWorld.CreateNewWorld(ASizeX, ASizeY: Integer);
begin
  DestroyOldWorld;

  FSizeX := ASizeX;
  FSizeY := ASizeY;

  BuildTerrainArray;
end;

destructor TWorld.Destroy;
begin
  FTowns.Free;
  inherited;
end;

procedure TWorld.DestroyOldWorld;
var
  X: Integer;
  Y: Integer;
  l_Town: TTownTerrainObject;
begin
  for X := 0 to FSizeX - 1 do
  begin
    for Y := 0 to FSizeY - 1 do
      FTerrainTiles[X][Y].Free;
  end;

  for l_Town in FTowns do
    FTowns.Remove(l_Town);
end;

procedure TWorld.EditTerrain(X, Y: Integer; ATerrainType: TTerrainType);
begin
  FTerrainTiles[X][Y].Free;

  if ATerrainType = TT_Water then
    FTerrainTiles[X][Y] := TWaterTerrainTile.Create
  else if ATerrainType = TT_Land then
    FTerrainTiles[X][Y] := TLandTerrainTile.Create
  else if ATerrainType = TT_Mountain then
    FTerrainTiles[X][Y] := TMountainTerrainTile.Create;
end;

procedure TWorld.RemoveTown(X, Y: Integer);
var
  l_Town: TTownTerrainObject;
begin
  for l_Town in FTowns do
  begin
    if (l_Town.PosX = X) AND (l_Town.PosY = Y) then
    begin
      FTowns.Remove(l_Town);
    end;
  end;
end;

Initialization
begin
  TheWorld := TWorld.Create;
end;

finalization
begin
  TheWorld.Free;
end;

end.
