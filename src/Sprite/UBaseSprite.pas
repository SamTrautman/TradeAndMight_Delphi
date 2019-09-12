unit UBaseSprite;

interface

uses
  System.Generics.Collections,
  UTownTerrainObject;

type
  TBaseSprite = class
  protected
    FTowns: TList<TTownTerrainObject>;
    FCurrentPosX: Integer;
    FCurrentPosY: Integer;
    FTargetPosX: Integer;
    FTargetPosY: Integer;
  public
    procedure DoAction; virtual; abstract;
  public
    constructor Create(APosX, APosY: Integer; ATownList: TList<TTownTerrainObject>);
  public
    property Towns: TList<TTownTerrainObject> read FTowns write FTowns;
    property CurrentPosX: Integer read FCurrentPosX;
    property CurrentPosY: Integer read FCurrentPosY;
    property TargetPosX: Integer read FTargetPosX;
    property TargetPosY: Integer read FTargetPosY;
  end;

implementation

{ TBaseSprite }

constructor TBaseSprite.Create(APosX, APosY: Integer; ATownList: TList<TTownTerrainObject>);
begin
  FTowns := ATownList;

  FCurrentPosX := APosX;
  FCurrentPosY := APosY;
  FTargetPosX := APosX;
  FTargetPosY := APosY;
end;

end.
