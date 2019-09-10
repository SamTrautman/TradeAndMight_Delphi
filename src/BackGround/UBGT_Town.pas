unit UBGT_Town;

interface

uses
  Vcl.Graphics,
  UBGT_Base;

type
  TBGT_Town = class(TBGT_Base)
  protected
    function GetBackGroundColor: TColor; override;
    function GetBackGroundType: TBackGroundType; override;
    function GetCanPassBySea: Boolean; override;
    function GetCanPassByLand: Boolean; override;
  end;

implementation

{ TBGT_Town }

function TBGT_Town.GetBackGroundColor: TColor;
begin
  Result := clRed;
end;

function TBGT_Town.GetBackGroundType: TBackGroundType;
begin
  Result := BGT_Town;
end;

function TBGT_Town.GetCanPassByLand: Boolean;
begin
  Result := True;
end;

function TBGT_Town.GetCanPassBySea: Boolean;
begin
  Result := True;
end;

end.
