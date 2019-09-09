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

end.
