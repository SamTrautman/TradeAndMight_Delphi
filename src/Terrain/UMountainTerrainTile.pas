unit UMountainTerrainTile;

interface

uses
  UBaseTerrainTile;

type
  TMountainTerrainTile = class(TBaseTerrainTile)
  protected
    function GetTerrainType: TTerrainType; override;
    function GetCanPassByLand: Boolean; override;
    function GetCanPassBySea: Boolean; override;
  end;

implementation

{ TMountainTerrainTile }

function TMountainTerrainTile.GetCanPassByLand: Boolean;
begin
  Result := False;
end;

function TMountainTerrainTile.GetCanPassBySea: Boolean;
begin
  Result := False;
end;

function TMountainTerrainTile.GetTerrainType: TTerrainType;
begin
  Result := TT_Mountain;
end;

end.
