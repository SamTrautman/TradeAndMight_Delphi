unit UWaterTerrainTile;

interface

uses
  UBaseTerrainTile;

type
  TWaterTerrainTile = class(TBaseTerrainTile)
  protected
    function GetTerrainType: TTerrainType; override;
    function GetCanPassByLand: Boolean; override;
    function GetCanPassBySea: Boolean; override;
  end;

implementation

{ TWaterTerrainTile }

function TWaterTerrainTile.GetCanPassByLand: Boolean;
begin
  Result := False;
end;

function TWaterTerrainTile.GetCanPassBySea: Boolean;
begin
  Result := True;
end;

function TWaterTerrainTile.GetTerrainType: TTerrainType;
begin
  Result := TT_Water;
end;

end.
