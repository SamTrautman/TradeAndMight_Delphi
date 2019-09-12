unit UFrmNewTown;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmNewTown = class(TForm)
    txtTownName: TLabeledEdit;
    btnBack: TButton;
    btnSave: TButton;
    txtGrain: TLabeledEdit;
    txtBeer: TLabeledEdit;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FrmNewTown: TFrmNewTown;

implementation

{$R *.dfm}

end.
