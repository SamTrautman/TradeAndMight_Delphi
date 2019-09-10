unit UBGT_Land;

interface

uses
  Vcl.Graphics,
  UBGT_Base;

type
  TBGT_Land = class(TBGT_Base)
  protected
    function GetBackGroundColor: TColor; override;
    function GetBackGroundType: TBackGroundType; override;
    function GetCanPassBySea: Boolean; override;
    function GetCanPassByLand: Boolean; override;
  end;

implementation

{ TBGT_Land }

function TBGT_Land.GetBackGroundColor: TColor;
begin
  Result := clGreen;
end;

function TBGT_Land.GetBackGroundType: TBackGroundType;
begin
  Result := BGT_Land;
end;

function TBGT_Land.GetCanPassByLand: Boolean;
begin
  Result := True;
end;

function TBGT_Land.GetCanPassBySea: Boolean;
begin
  Result := False;
end;

end.
