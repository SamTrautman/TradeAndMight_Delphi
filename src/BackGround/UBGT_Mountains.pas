unit UBGT_Mountains;

interface

uses
  Vcl.Graphics,
  UBGT_Base;

type
  TBGT_Mountains = class(TBGT_Base)
  protected
    function GetBackGroundColor: TColor; override;
    function GetBackGroundType: TBackGroundType; override;
    function GetCanPassBySea: Boolean; override;
    function GetCanPassByLand: Boolean; override;
  end;

implementation

{ TBGT_Mountains }

function TBGT_Mountains.GetBackGroundColor: TColor;
begin
  Result := clGray;
end;

function TBGT_Mountains.GetBackGroundType: TBackGroundType;
begin
  Result := BGT_Mountains;
end;

function TBGT_Mountains.GetCanPassByLand: Boolean;
begin
  Result := False;
end;

function TBGT_Mountains.GetCanPassBySea: Boolean;
begin
  Result := False;
end;

end.
