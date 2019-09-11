unit UFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  UWorldMap, UFrameWorldBuilder;

type
  TFrmMain = class(TForm)
    pnlStatus: TPanel;
    pnlTop: TPanel;
    FrameWorldBuilder: TFrameWorldBuilder;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

end.
