unit UFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  UWorldMap;

type
  TFrmMain = class(TForm)
    pnlStatus: TPanel;
    pnlSideBar: TPanel;
    pnlTop: TPanel;
    ImgWorld: TImage;
    pgcMenu: TPageControl;
    tsNewWorld: TTabSheet;
    tsEditMap: TTabSheet;
    btnCreateWorld: TButton;
    txtSizeX: TLabeledEdit;
    txtSizeY: TLabeledEdit;
    btnSaveWorld: TButton;
    btnLoadWorld: TButton;
    DlgSaveWorldMap: TSaveDialog;
    DlgOpenWorldMap: TOpenDialog;
    rgTiles: TRadioGroup;
    TabSheet1: TTabSheet;
    rgMove: TRadioGroup;
    procedure btnCreateWorldClick(Sender: TObject);
    procedure btnSaveWorldClick(Sender: TObject);
    procedure btnLoadWorldClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImgWorldMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FWorldMap: TWorldMap;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  UGlobal;

{$R *.dfm}

procedure TFrmMain.btnCreateWorldClick(Sender: TObject);
begin
  FWorldMap.CreateNewWorld(StrToInt(txtSizeX.Text), StrToInt(txtSizeY.Text));
  ImgWorld.Picture.Graphic := FWorldMap.WorldMap;
end;

procedure TFrmMain.btnLoadWorldClick(Sender: TObject);
begin
  if DlgOpenWorldMap.Execute then
    FWorldMap.LoadFromFile(DlgOpenWorldMap.FileName);
  ImgWorld.Picture.Graphic := FWorldMap.WorldMap;
end;

procedure TFrmMain.btnSaveWorldClick(Sender: TObject);
begin
  if DlgSaveWorldMap.Execute then
    FWorldMap.SaveToFile(DlgSaveWorldMap.FileName);
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FWorldMap := TWorldMap.Create;
end;

procedure TFrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_NUMPAD4 then
    FWorldMap.MoveSprite(rgMove.ItemIndex, DIR_LEFT)
  else if key = VK_NUMPAD8 then
    FWorldMap.MoveSprite(rgMove.ItemIndex, DIR_UP)
  else if key = VK_NUMPAD6 then
    FWorldMap.MoveSprite(rgMove.ItemIndex, DIR_RIGHT)
  else if key = VK_NUMPAD2 then
    FWorldMap.MoveSprite(rgMove.ItemIndex, DIR_DOWN);

  ImgWorld.Picture.Graphic := FWorldMap.WorldMap;
end;

procedure TFrmMain.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  if key = VK_LEFT then
//    FWorldMap.MoveSprite(rgMove.ItemIndex, DIR_LEFT)
//  else if key = VK_UP then
//    FWorldMap.MoveSprite(rgMove.ItemIndex, DIR_UP)
//  else if key = VK_RIGHT then
//    FWorldMap.MoveSprite(rgMove.ItemIndex, DIR_RIGHT)
//  else if key = VK_DOWN then
//    FWorldMap.MoveSprite(rgMove.ItemIndex, DIR_DOWN);
end;

procedure TFrmMain.ImgWorldMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FWorldMap.CreateBackGroundTile(X, Y, rgTiles.ItemIndex);
  ImgWorld.Picture.Graphic := FWorldMap.WorldMap;
end;

end.
