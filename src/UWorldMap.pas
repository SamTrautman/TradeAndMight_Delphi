unit UWorldMap;

interface

uses
  System.Generics.Collections,
  Vcl.Graphics,
  UGlobal, USprite, UBGT_Base;

type
  TWorldMapTile = class
  private
    FBackGroundSprite: TBGT_Base;
    FSprites: TList<TSprite>;
  public
    constructor Create(ABGType: TBackGroundType);
    destructor Destroy; override;
  end;

  TWorldMapTiles = TArray<TWorldMapTile>;

  TWorldMap = class
  private
    FWorldMap: TBitmap;
    FSizeX: Integer;
    FSizeY: Integer;
    FWorldMapTiles: TArray<TWorldMapTiles>;
    FSprites: TList<TSprite>;
  private
    procedure ReDrawMap;
    procedure ReDrawField(X, Y: Integer);
    procedure ReDrawSprite(p_Sprite: TSprite);
  public
    procedure CreateNewWorld(ASizeX, ASizeY: Integer);
    procedure SaveToFile(AFileName: String);
    procedure LoadFromFile(AFileName: String);
    procedure CreateBackGroundTile(PosX, PosY, ABGType: Integer);
    procedure MoveSprite(p_Sprite: Integer; p_Direction: TDirection);
  public
    constructor Create;
    destructor Destroy; override;
  public
    property WorldMap: TBitmap read FWorldMap;
  end;

implementation

uses
  System.JSON, System.Classes, System.SysUtils, System.Math,
  UBackGroundFactory;

{ TWorldMap }

procedure TWorldMap.CreateBackGroundTile(PosX, PosY, ABGType: Integer);
var
  X: Integer;
  Y: Integer;
begin
  X := PosX div SPRITE_SIZE;
  Y := PosY div SPRITE_SIZE;

  FWorldMapTiles[Y][X].FBackGroundSprite.Free;
  FWorldMapTiles[Y][X].FBackGroundSprite := UBackGroundFactory.CreateBackGroundTile(TBackGroundType(ABGType));

  ReDrawMap;
end;

procedure TWorldMap.CreateNewWorld(ASizeX, ASizeY: Integer);
var
  Y: Integer;
  X: Integer;
begin
  FSizeX := ASizeX;
  FSizeY := ASizeY;

  FSprites.Add(TLandTraderSprite.Create(0, 0));
  FSprites.Add(TSeaTraderSprite.Create(0, 0));

  FWorldMap.SetSize(FSizeX * SPRITE_SIZE, FSizeY * SPRITE_SIZE);

  SetLength(FWorldMapTiles, FSizeY);

  for Y := 0 to FSizeY - 1 do
  begin
    SetLength(FWorldMapTiles[Y], FSizeX);

    for X := 0 to FSizeX - 1 do
    begin
      FWorldMapTiles[Y][X] := TWorldMapTile.Create(BGT_Water);
    end;
  end;

  ReDrawMap;
end;

destructor TWorldMap.Destroy;
var
  l_WorldMapTiles: TWorldMapTiles;
  l_WorldMapTile: TWorldMapTile;
  l_Sprite: TSprite;
begin
  FWorldMap.Free;

  for l_WorldMapTiles in FWorldMapTiles do
  begin
    for l_WorldMapTile in l_WorldMapTiles do
    begin
      l_WorldMapTile.Free;
    end;
  end;

  for l_Sprite in FSprites do
  begin
    l_Sprite.Free;
  end;

  inherited;
end;

procedure TWorldMap.LoadFromFile(AFileName: String);
var
  l_ImportStream: TStringStream;
  l_ImportJSON: TJSONValue;

  l_YArray: TJSONArray;
  l_XArray: TJSONArray;
  l_FieldObj: TJSONObject;
  l_FieldValue: Integer;

  Y: Integer;
  X: Integer;
begin
  FSprites.Add(TLandTraderSprite.Create(0, 0));
  FSprites.Add(TSeaTraderSprite.Create(0, 0));

  l_ImportJSON := TJSONObject.Create;
  try
    l_ImportStream := TStringStream.Create;
    try
      l_ImportStream.LoadFromFile(AFileName);
      l_ImportJSON := TJSONObject.ParseJSONValue(l_ImportStream.DataString);
    finally
      l_ImportStream.Free;
    end;

    FSizeX := StrToInt(l_ImportJSON.GetValue<TJSONObject>('MapSize').GetValue<string>('SizeX'));
    FSizeY := StrToInt(l_ImportJSON.GetValue<TJSONObject>('MapSize').GetValue<string>('SizeY'));

    FWorldMap.SetSize(FSizeX * SPRITE_SIZE, FSizeY * SPRITE_SIZE);

    SetLength(FWorldMapTiles, FSizeY);

    l_YArray := l_ImportJSON.GetValue<TJSONArray>('MapData');

    for Y := 0 to l_YArray.Count - 1 do
    begin
      SetLength(FWorldMapTiles[Y], FSizeX);

      l_XArray := l_YArray.Items[Y].GetValue<TJSONArray>;

      for X := 0 to l_XArray.Count - 1 do
      begin
        l_FieldValue := StrToInt(l_XArray.Items[X].GetValue<TJSONObject>.GetValue<String>('BGType'));
        FWorldMapTiles[Y][X] := TWorldMapTile.Create(TBackGroundType(l_FieldValue));
      end;
    end;
  finally
    l_ImportJSON.Free;
  end;

  ReDrawMap;
end;

procedure TWorldMap.MoveSprite(p_Sprite: Integer; p_Direction: TDirection);
begin
  if p_Direction = DIR_LEFT then
    FSprites[p_Sprite].PosX := Max(FSprites[p_Sprite].PosX -1, 0)
  else if p_Direction = DIR_UP then
    FSprites[p_Sprite].PosY := Max(FSprites[p_Sprite].PosY -1, 0)
  else if p_Direction = DIR_RIGHT then
    FSprites[p_Sprite].PosX := Min(FSprites[p_Sprite].PosX +1, FSizeX -1)
  else if p_Direction = DIR_DOWN then
    FSprites[p_Sprite].PosY := Min(FSprites[p_Sprite].PosY +1, FSizeY -1);

  ReDrawMap;
end;

procedure TWorldMap.ReDrawField(X, Y: Integer);
begin
  FWorldMap.Canvas.Draw(X * SPRITE_SIZE,Y * SPRITE_SIZE,FWorldMapTiles[Y][X].FBackGroundSprite.Icon);
end;

procedure TWorldMap.ReDrawMap;
var
  Y: Integer;
  X: Integer;
  l_Sprite: TSprite;
begin
  for Y := 0 to FSizeY -1 do
  begin
    for X := 0 to FSizeX -1 do
    begin
      ReDrawField(X, Y);
    end;
  end;

  for l_Sprite in FSprites do
  begin
    ReDrawSprite(l_Sprite);
  end;
end;

procedure TWorldMap.ReDrawSprite(p_Sprite: TSprite);
begin
  FWorldMap.Canvas.Draw(p_Sprite.PosX * SPRITE_SIZE, p_Sprite.PosY * SPRITE_SIZE, p_Sprite.Icon);
end;

procedure TWorldMap.SaveToFile(AFileName: String);

  function ExportTile(ARowNumber, AColumnNumber: Integer): TJSonObject;
  begin
    Result := TJSONObject.Create;
    Result.AddPair('BGType', IntToStr(Ord(FWorldMapTiles[ARowNumber][AColumnNumber].FBackGroundSprite.BGType)));
  end;

  function ExportRow(ARowNumber: Integer): TJSONArray;
  var
    I: Integer;
  begin
    Result := TJSONArray.Create;

    for I := 0 to FSizeX -1 do
    begin
      Result.Add(ExportTile(ARowNumber, I));
    end;
  end;

  function CreateMapData: TJSONArray;
  var
    I: Integer;
  begin
    Result := TJSONArray.Create;

    for I := 0 to FSizeY -1 do
    begin
      Result.Add(ExportRow(I));
    end;
  end;

var
  l_ExportStream: TStringStream;
  l_ExportJSON: TJSONObject;
  l_MapSize: TJSONObject;
begin
  l_ExportJSON := TJSONObject.Create;
  try
    l_MapSize := TJSONObject.Create;
    l_MapSize.AddPair('SizeX', IntToStr(FSizeX));
    l_MapSize.AddPair('SizeY', IntToStr(FSizeY));

    l_ExportJSON.AddPair('MapSize', l_MapSize);
    l_ExportJSON.AddPair('MapData', CreateMapData());

    l_ExportStream := TStringStream.Create;
    try
      l_ExportStream.WriteString(l_ExportJSON.ToString);
      l_ExportStream.SaveToFile(AFileName);
    finally
      l_ExportStream.Free;
    end;
  finally
    l_ExportJSON.Free;
  end;
end;

{ TWorldMap }

constructor TWorldMap.Create;
begin
  FWorldMap := TBitmap.Create;
  FSprites := TList<TSprite>.Create;
end;

{ TWorldMapTile }

constructor TWorldMapTile.Create(ABGType: TBackGroundType);
begin
  FBackGroundSprite := CreateBackGroundTile(ABGType);
  FSprites := TList<TSprite>.Create;
end;

destructor TWorldMapTile.Destroy;
var
  l_Sprite: TSprite;
begin
  FBackGroundSprite.Free;

  for l_Sprite in FSprites do
  begin
    l_Sprite.Free;
  end;

  inherited;
end;

end.
