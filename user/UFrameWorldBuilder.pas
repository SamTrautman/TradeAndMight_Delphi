unit UFrameWorldBuilder;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFrameWorldBuilder = class(TFrame)
    ImgWorld: TImage;
    pcSidePanel: TPageControl;
    tsCreateWorld: TTabSheet;
    splitSidePanelImage: TSplitter;
    txtSizeX: TLabeledEdit;
    txtSizeY: TLabeledEdit;
    btnCreateWorld: TButton;
    btnSaveWorld: TButton;
    btnLoadWorld: TButton;
    tsEditTerrain: TTabSheet;
    tsEditObjects: TTabSheet;
    tsView: TTabSheet;
    rgTerrainTiles: TRadioGroup;
    rgObjekte: TRadioGroup;
    rgSpriteSize: TRadioGroup;
    SaveDialogMap: TSaveDialog;
    OpenDialogMap: TOpenDialog;
    procedure btnCreateWorldClick(Sender: TObject);
    procedure ImgWorldMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure rgSpriteSizeClick(Sender: TObject);
    procedure btnSaveWorldClick(Sender: TObject);
    procedure btnLoadWorldClick(Sender: TObject);
  private
    FSpriteSize: Integer;
  private
    procedure DrawTerrainTile(X, Y: Integer);
    procedure DrawTown(X, Y: Integer);
    procedure ReRenderWorld;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.dfm}

uses
  System.JSON,
  UWorld, UBaseTerrainTile, UTownTerrainObject, UGlobal, UFrmNewTown;

procedure TFrameWorldBuilder.btnCreateWorldClick(Sender: TObject);
begin
  TheWorld.CreateNewWorld(StrToInt(txtSizeX.Text), StrToInt(txtSizeY.Text));
  ReRenderWorld;
end;

procedure TFrameWorldBuilder.btnLoadWorldClick(Sender: TObject);
var
  l_ImportStream: TStringStream;
  l_ImportJSON: TJSONValue;

  l_YArray: TJSONArray;
  l_XArray: TJSONArray;
  l_TownArray: TJSONArray;
  l_FieldValue: Integer;

  Y: Integer;
  X: Integer;

  l_TownX: Integer;
  l_TownY: Integer;
  l_TownName: String;

  l_SizeX: Integer;
  l_SizeY: Integer;
  I: Integer;
begin
  l_ImportJSON := TJSONObject.Create;
  try
    if OpenDialogMap.Execute then
    begin
      l_ImportStream := TStringStream.Create;
      try
        l_ImportStream.LoadFromFile(OpenDialogMap.FileName);
        l_ImportJSON := TJSONObject.ParseJSONValue(l_ImportStream.DataString);
      finally
        l_ImportStream.Free;
      end;

      l_SizeX := StrToInt(l_ImportJSON.GetValue<TJSONObject>('MapSize').GetValue<string>('SizeX'));
      l_SizeY := StrToInt(l_ImportJSON.GetValue<TJSONObject>('MapSize').GetValue<string>('SizeY'));

      TheWorld.CreateNewWorld(l_SizeX, l_SizeY);

      l_XArray := l_ImportJSON.GetValue<TJSONArray>('MapData');

      for X := 0 to l_XArray.Count - 1 do
      begin
        l_YArray := l_XArray.Items[X].GetValue<TJSONArray>;

        for Y := 0 to l_YArray.Count - 1 do
        begin
          l_FieldValue := StrToInt(l_YArray.Items[Y].GetValue<TJSONObject>.GetValue<String>('TType'));
          TheWorld.EditTerrain(X, Y, TTerrainType(l_FieldValue));
        end;
      end;

      l_TownArray := l_ImportJSON.GetValue<TJSONArray>('Towns');

      for I := 0 to l_TownArray.Count -1 do
      begin
        l_TownX := StrToInt(l_TownArray.Items[I].GetValue<TJSONObject>.GetValue<string>('PosX'));
        l_TownY := StrToInt(l_TownArray.Items[I].GetValue<TJSONObject>.GetValue<string>('PosY'));
        l_TownName := l_TownArray.Items[I].GetValue<TJSONObject>.GetValue<string>('TownName');

        TheWorld.AddTown(l_TownX, l_TownY, l_TownName);
      end;
    end;
  finally
    l_ImportJSON.Free;
  end;

  ReRenderWorld;
end;

procedure TFrameWorldBuilder.btnSaveWorldClick(Sender: TObject);

  function ExportTile(ARowNumber, AColumnNumber: Integer): TJSonObject;
  begin
    Result := TJSONObject.Create;
    Result.AddPair('TType', IntToStr(Ord(TheWorld.TerrainTiles[ARowNumber][AColumnNumber].TerrainType)));
  end;

  function ExportRow(ARowNumber: Integer): TJSONArray;
  var
    I: Integer;
  begin
    Result := TJSONArray.Create;

    for I := 0 to TheWorld.SizeX -1 do
    begin
      Result.Add(ExportTile(ARowNumber, I));
    end;
  end;

  function CreateMapData: TJSONArray;
  var
    I: Integer;
  begin
    Result := TJSONArray.Create;

    for I := 0 to TheWorld.SizeY -1 do
    begin
      Result.Add(ExportRow(I));
    end;
  end;

  function CreateTownObject(p_Town: TTownTerrainObject): TJSONObject;
  begin
    Result := TJSONObject.Create;
    Result.AddPair('TownName', p_Town.TownName);
    Result.AddPair('PosX', IntToStr(p_Town.PosX));
    Result.AddPair('PosY', IntToStr(p_Town.PosY));
  end;

  function CreateTownsData: TJSONArray;
  var
    l_Town: TTownTerrainObject;
  begin
    Result := TJSONArray.Create;

    for l_Town in TheWorld.Towns do
    begin
      Result.Add(CreateTownObject(l_Town));
    end;
  end;

var
  l_ExportStream: TStringStream;
  l_ExportJSON: TJSONObject;
  l_MapSize: TJSONObject;
begin
  if SaveDialogMap.Execute then
  begin
    l_ExportJSON := TJSONObject.Create;
    try
      l_MapSize := TJSONObject.Create;
      l_MapSize.AddPair('SizeX', IntToStr(TheWorld.SizeX));
      l_MapSize.AddPair('SizeY', IntToStr(TheWorld.SizeY));

      l_ExportJSON.AddPair('MapSize', l_MapSize);
      l_ExportJSON.AddPair('MapData', CreateMapData);
      l_ExportJSON.AddPair('Towns', CreateTownsData);

      l_ExportStream := TStringStream.Create;
      try
        l_ExportStream.WriteString(l_ExportJSON.ToString);
        l_ExportStream.SaveToFile(SaveDialogMap.FileName);
      finally
        l_ExportStream.Free;
      end;
    finally
      l_ExportJSON.Free;
    end;
  end;
end;

constructor TFrameWorldBuilder.Create(AOwner: TComponent);
begin
  inherited;
  FSpriteSize := 16;

  pcSidePanel.ActivePage := tsCreateWorld;
end;

procedure TFrameWorldBuilder.DrawTerrainTile(X, Y: Integer);
var
  l_Bitmap: TBitmap;
begin
  l_Bitmap := TBitmap.Create;
  try
    l_Bitmap.Canvas.Brush.Color := clFuchsia;
    l_Bitmap.SetSize(FSpriteSize, FSpriteSize);

    if TheWorld.TerrainTiles[X, Y].TerrainType = TT_Water then
      l_Bitmap.Canvas.Brush.Color := clBlue
    else if TheWorld.TerrainTiles[X, Y].TerrainType = TT_Land then
      l_Bitmap.Canvas.Brush.Color := clGreen
    else if TheWorld.TerrainTiles[X, Y].TerrainType = TT_Mountain then
      l_Bitmap.Canvas.Brush.Color := clGray;

    l_Bitmap.Canvas.Pen.Color := clBtnFace;
    l_Bitmap.Canvas.Rectangle(0, 0, FSpriteSize, FSpriteSize);

    ImgWorld.Canvas.Draw(X * FSpriteSize,Y * FSpriteSize,l_Bitmap);
  finally
    l_Bitmap.Free;
  end;
end;

procedure TFrameWorldBuilder.DrawTown(X, Y: Integer);
var
  l_Bitmap: TBitmap;
begin
  l_Bitmap := TBitmap.Create;
  try
    l_Bitmap.Canvas.Brush.Color := clFuchsia;
    l_Bitmap.TransparentColor := clFuchsia;
    l_Bitmap.Transparent := True;

    l_Bitmap.SetSize(FSpriteSize, FSpriteSize);

    l_Bitmap.Canvas.Brush.Color := clRed;
    l_Bitmap.Canvas.Pen.Color := clBtnFace;
    l_Bitmap.Canvas.Rectangle(2, 2, FSpriteSize -2, FSpriteSize - 2);

    ImgWorld.Canvas.Draw(X * FSpriteSize, Y * FSpriteSize,l_Bitmap);
  finally
    l_Bitmap.Free;
  end;
end;

procedure TFrameWorldBuilder.ImgWorldMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  function IsWithInBounds: Boolean;
  begin
    Result :=
      (X > 0) AND
      (Y > 0) AND
      ((X div FSpriteSize ) <= (TheWorld.SizeX -1)) AND
      ((Y div FSpriteSize) <= (TheWorld.SizeY -1));
  end;

begin
  if IsWithInBounds then
  begin
    if pcSidePanel.ActivePage = tsEditTerrain then
    begin
      if rgTerrainTiles.ItemIndex = Ord(TT_Water) then
        TheWorld.EditTerrain(X div FSpriteSize, Y div FSpriteSize, TT_Water)
      else if rgTerrainTiles.ItemIndex = Ord(TT_Land) then
        TheWorld.EditTerrain(X div FSpriteSize, Y div FSpriteSize, TT_Land)
      else if rgTerrainTiles.ItemIndex = Ord(TT_Mountain) then
        TheWorld.EditTerrain(X div FSpriteSize, Y div FSpriteSize, TT_Mountain);
    end
    else if pcSidePanel.ActivePage = tsEditObjects then
    begin
      if rgObjekte.ItemIndex = 0 then
      begin
        if Button = mbLeft then
        begin
          if FrmNewTown.ShowModal = mrok then
          begin
            TheWorld.AddTown(X div FSpriteSize, Y div FSpriteSize, FrmNewTown.txtTownName.Text);
          end;
        end
        else if Button = mbRight then
          TheWorld.RemoveTown(X div FSpriteSize, Y div FSpriteSize);
      end;
    end;

    ReRenderWorld;
  end;
end;

procedure TFrameWorldBuilder.ReRenderWorld;
var
  X: Integer;
  Y: Integer;
  l_Town: TTownTerrainObject;
begin
  ImgWorld.Picture := NIL;

  for X := 0 to TheWorld.SizeX - 1 do
  begin
    for Y := 0 to TheWorld.SizeY - 1 do
    begin
      DrawTerrainTile(X, Y);
    end;
  end;

  for l_Town in TheWorld.Towns do
  begin
    DrawTown(l_Town.PosX, l_Town.PosY);
  end;
end;

procedure TFrameWorldBuilder.rgSpriteSizeClick(Sender: TObject);
begin
  if rgSpriteSize.ItemIndex = 0 then
    FSpriteSize := 16
  else if rgSpriteSize.ItemIndex = 1 then
    FSpriteSize := 32
  else if rgSpriteSize.ItemIndex = 2 then
    FSpriteSize := 64;

  ReRenderWorld;
end;

end.
