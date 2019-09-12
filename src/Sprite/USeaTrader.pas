unit USeaTrader;

interface

uses
  UBaseSprite;

type
  TSeaTrader = class(TBaseSprite)
  private
    procedure ChoseNewTarget;
  public
    procedure DoAction; override;
  end;

implementation

{ TSeaTrader }

procedure TSeaTrader.ChoseNewTarget;
begin
  Randomize;

  FTargetPosX := Random(25);
  FTargetPosY := Random(25);
end;

procedure TSeaTrader.DoAction;
begin
  inherited;
  if (CurrentPosX = TargetPosX) AND (CurrentPosY = TargetPosY) then
    ChoseNewTarget;

  if TargetPosX > CurrentPosX then
    FCurrentPosX := FCurrentPosX + 1
  else if TargetPosX < FCurrentPosX then
    FCurrentPosX := CurrentPosX - 1
  else if TargetPosY > FCurrentPosY then
    FCurrentPosY := CurrentPosY + 1
  else if TargetPosY < CurrentPosY then
    FCurrentPosY := FCurrentPosY - 1;
end;

end.
