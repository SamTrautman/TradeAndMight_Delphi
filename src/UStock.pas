unit UStock;

interface

uses
  System.Generics.Collections;

type
  TStockItem = (SI_Grain, SI_Beer);

  TStock = class
  private
    FSize: Integer;
    FFreeSpace: Integer;
    FItems: TDictionary<TStockItem, Integer>;
  public
    function AddItem(AItem: TStockItem; AAmount: Integer): Boolean;
    function RemoveItem(AItem: TStockItem; AAmount: Integer): Boolean;
    function GetQuantity(AItem: TStockItem): Integer;
  public
    constructor Create(ASize: Integer);
    destructor Destroy; override;
  public
    property Size: Integer read FSize;
    property FreeSpace: Integer read FFreeSpace;
  end;

implementation

{ TStock }

function TStock.AddItem(AItem: TStockItem; AAmount: Integer): Boolean;
var
  l_CurrentStock: Integer;
begin
  if (AAmount <= FFreeSpace) AND FItems.TryGetValue(AItem, l_CurrentStock) then
  begin
    FFreeSpace := FFreeSpace - AAmount;
    FItems.AddOrSetValue(AItem, l_CurrentStock + AAmount);

    Result := True;
  end
  else
    Result := False;
end;

constructor TStock.Create(ASize: Integer);
var
  I: TStockItem;
begin
  FSize := ASize;
  FFreeSpace := ASize;

  FItems := TDictionary<TStockItem, Integer>.Create;

  for I := low(TStockItem) to High(TStockItem) do
    FItems.Add(I, 0);
end;

destructor TStock.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TStock.GetQuantity(AItem: TStockItem): Integer;
var
  l_Result: Integer;
begin
  if NOT FItems.TryGetValue(AItem, l_Result) then
    l_Result := 0;

  Result := l_Result;
end;

function TStock.RemoveItem(AItem: TStockItem; AAmount: Integer): Boolean;
var
  l_CurrentStock: Integer;
begin
  if FItems.TryGetValue(AItem, l_CurrentStock) AND (AAmount <= l_CurrentStock) then
  begin
    FFreeSpace := FFreeSpace + AAmount;
    FItems.AddOrSetValue(AItem, l_CurrentStock - AAmount);

    Result := True;
  end
  else
    Result := False;
end;

end.
