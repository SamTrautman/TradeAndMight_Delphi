unit UWorldMap;

interface

uses
  System.Generics.Collections,
  Vcl.Graphics,
  USprite, UBGT_Base;

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
  private
    procedure ReDrawMap;
    procedure ReDrawField(X, Y: Integer);
  public
    procedure CreateNewWorld(ASizeX, ASizeY: Integer);
    procedure SaveToFile(AFileName: String);
    procedure LoadFromFile(AFileName: String);
    procedure CreateBackGroundTile(PosX, PosY, ABGType: Integer);
  public
    constructor Create;
    destructor Destroy; override;
  public
    property WorldMap: TBitmap read FWorldMap;
  end;

implementation

uses
  System.JSON, System.Classes, System.SysUtils,
  UBackGroundFactory,
  UGlobal;

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
begin
  FWorldMap.Free;

  for l_WorldMapTiles in FWorldMapTiles do
  begin
    for l_WorldMapTile in l_WorldMapTiles do
    begin
      l_WorldMapTile.Free;
    end;
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

procedure TWorldMap.ReDrawField(X, Y: Integer);
begin
  FWorldMap.Canvas.Draw(X * SPRITE_SIZE,Y * SPRITE_SIZE,FWorldMapTiles[Y][X].FBackGroundSprite.Icon);
end;

procedure TWorldMap.ReDrawMap;
var
  Y: Integer;
  X: Integer;
begin
  for Y := 0 to FSizeY -1 do
  begin
    for X := 0 to FSizeX -1 do
    begin
      ReDrawField(X, Y);
    end;
  end;
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
