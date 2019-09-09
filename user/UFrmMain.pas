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
    procedure btnCreateWorldClick(Sender: TObject);
    procedure btnSaveWorldClick(Sender: TObject);
    procedure btnLoadWorldClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImgWorldMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FWorldMap: TWorldMap;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FrmMain: TFrmMain;

implementation

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

procedure TFrmMain.ImgWorldMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FWorldMap.CreateBackGroundTile(X, Y, rgTiles.ItemIndex);
  ImgWorld.Picture.Graphic := FWorldMap.WorldMap;
end;

end.
