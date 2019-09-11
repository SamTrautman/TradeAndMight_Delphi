unit UBaseTerrainObject;

interface

type
  TBaseTerrainObject = class
  private
    FPosX: Integer;
    FPosY: Integer;
  public
    property PosX: Integer read FPosX write FPosX;
    property PosY: Integer read FPosY write FPosY;
  public
    constructor Create(APosX, APosY: Integer);
  end;

implementation

{ TBaseTerrainObject }

constructor TBaseTerrainObject.Create(APosX, APosY: Integer);
begin
  FPosX := APosX;
  FPosY := APosY;
end;

end.
