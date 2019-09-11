unit UBaseTerrainTile;

interface

type
  TTerrainType = (TT_Water, TT_Land, TT_Mountain);

  TBaseTerrainTile = class
  protected
    function GetTerrainType: TTerrainType; virtual; abstract;
    function GetCanPassByLand: Boolean; virtual; abstract;
    function GetCanPassBySea: Boolean; virtual; abstract;
  public
    property TerrainType: TTerrainType read GetTerrainType;
    property CanPassByLand: Boolean read GetCanPassByLand;
    property CanPassBySea: Boolean read GetCanPassBySea;
  end;

implementation

end.
