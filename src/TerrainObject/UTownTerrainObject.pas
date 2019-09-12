unit UTownTerrainObject;

interface

uses
  UBaseTerrainObject, UStock;

type
  TTownTerrainObject = class(TBaseTerrainObject)
  private
    FTownName: string;
    FCurrentStock: TStock;
    FProduction: TStock;
    FConsumption: TStock;
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure SetProduction(AStockItem: TStockItem; AAmount: Integer);
    procedure SetConsumption(AStockItem: TStockItem; AAmount: Integer);
  public
    property TownName: string read FTownName write FTownName;
    property CurrentStock: TStock read FCurrentStock;
    property Production: TStock read FProduction;
    property Consumption: TStock read FConsumption;
  end;

implementation

{ TTownTerrainObject }

constructor TTownTerrainObject.Create;
begin
  FProduction := TStock.Create(1000);
  FConsumption := TStock.Create(1000);
  FCurrentStock := TStock.Create(1000);
end;

destructor TTownTerrainObject.Destroy;
begin
  FProduction.Free;
  FConsumption.Free;
  FCurrentStock.Free;
  inherited;
end;

procedure TTownTerrainObject.SetConsumption(AStockItem: TStockItem;
  AAmount: Integer);
var
  l_CurrentAmount: Integer;
begin
  FConsumption.RemoveItem(AStockItem, 0 - FConsumption.GetQuantity(AStockItem));
  FConsumption.AddItem(AStockItem, AAmount);
end;

procedure TTownTerrainObject.SetProduction(AStockItem: TStockItem;
  AAmount: Integer);
var
  l_CurrentAmount: Integer;
begin
  FProduction.RemoveItem(AStockItem, 0 - FProduction.GetQuantity(AStockItem));
  FProduction.AddItem(AStockItem, AAmount);
end;

end.
