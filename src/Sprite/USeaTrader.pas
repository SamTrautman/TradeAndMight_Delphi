unit USeaTrader;

interface

uses
  System.Generics.Collections,
  UTownTerrainObject,
  UBaseSprite, UStock;

type
  TSeaTrader = class(TBaseSprite)
  private
    FCurrentStock: TStock;
  private
    procedure ChooseNewTarget;
    procedure Trade;
  public
    procedure DoAction; override;
  public
    destructor Destroy; override;
    constructor Create(APosX, APosY: Integer; ATownList: TList<UTownTerrainObject.TTownTerrainObject>); override;
  end;

implementation

{ TSeaTrader }

procedure TSeaTrader.ChooseNewTarget;
var
  l_TownIndex: Integer;
begin
  Randomize;

  l_TownIndex := Random(FTowns.Count -1);

  FTargetPosX := FTowns.Items[l_TownIndex].PosX;
  FTargetPosY := FTowns.Items[l_TownIndex].PosY;
end;

constructor TSeaTrader.Create(APosX, APosY: Integer;
  ATownList: TList<UTownTerrainObject.TTownTerrainObject>);
begin
  inherited;
  FCurrentStock := TStock.Create(10);
end;

destructor TSeaTrader.Destroy;
begin
  FCurrentStock.Free;
  inherited;
end;

procedure TSeaTrader.DoAction;
begin
  inherited;
  if (CurrentPosX = TargetPosX) AND (CurrentPosY = TargetPosY) then
    Trade;

  if TargetPosX > CurrentPosX then
    FCurrentPosX := FCurrentPosX + 1
  else if TargetPosX < FCurrentPosX then
    FCurrentPosX := CurrentPosX - 1
  else if TargetPosY > FCurrentPosY then
    FCurrentPosY := CurrentPosY + 1
  else if TargetPosY < CurrentPosY then
    FCurrentPosY := FCurrentPosY - 1;

  if (CurrentPosX = TargetPosX) AND (CurrentPosY = TargetPosY) then
    ChooseNewTarget;
end;

procedure TSeaTrader.Trade;
begin
  //
end;

end.
