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

end.
