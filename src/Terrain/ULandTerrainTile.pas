unit ULandTerrainTile;

interface

uses
  UBaseTerrainTile;

type
  TLandTerrainTile = class(TBaseTerrainTile)
  protected
    function GetTerrainType: TTerrainType; override;
    function GetCanPassByLand: Boolean; override;
    function GetCanPassBySea: Boolean; override;
  end;

implementation

{ TLandTerrainTile }

function TLandTerrainTile.GetCanPassByLand: Boolean;
begin
  Result := True;
end;

function TLandTerrainTile.GetCanPassBySea: Boolean;
begin
  Result := False;
end;

function TLandTerrainTile.GetTerrainType: TTerrainType;
begin
  Result := TT_Land;
end;

end.
