unit UTownTerrainObject;

interface

uses
  UBaseTerrainObject;

type
  TTownTerrainObject = class(TBaseTerrainObject)
  private
    FTownName: string;
  public
    property TownName: string read FTownName write FTownName;
  end;

implementation

end.
