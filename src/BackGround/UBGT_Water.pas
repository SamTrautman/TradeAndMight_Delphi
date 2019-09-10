unit UBGT_Water;

interface

uses
  Vcl.Graphics,
  UBGT_Base;

type
  TBGT_Water = class(TBGT_Base)
  protected
    function GetBackGroundColor: TColor; override;
    function GetBackGroundType: TBackGroundType; override;
    function GetCanPassBySea: Boolean; override;
    function GetCanPassByLand: Boolean; override;
  end;

implementation

{ TBGT_Water }

function TBGT_Water.GetBackGroundColor: TColor;
begin
  Result := clBlue;
end;

function TBGT_Water.GetBackGroundType: TBackGroundType;
begin
  Result := BGT_Water;
end;

function TBGT_Water.GetCanPassByLand: Boolean;
begin
  Result := False;
end;

function TBGT_Water.GetCanPassBySea: Boolean;
begin
  Result := True;
end;

end.
