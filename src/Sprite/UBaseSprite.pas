unit UBaseSprite;

interface

type
  TBaseSprite = class
  protected
    FCurrentPosX: Integer;
    FCurrentPosY: Integer;
    FTargetPosX: Integer;
    FTargetPosY: Integer;
  public
    procedure DoAction; virtual; abstract;
  public
    constructor Create(APosX, APosY: Integer);
  public
    property CurrentPosX: Integer read FCurrentPosX;
    property CurrentPosY: Integer read FCurrentPosY;
    property TargetPosX: Integer read FTargetPosX;
    property TargetPosY: Integer read FTargetPosY;
  end;

implementation

{ TBaseSprite }

constructor TBaseSprite.Create(APosX, APosY: Integer);
begin
  FCurrentPosX := APosX;
  FCurrentPosY := APosY;
  FTargetPosX := APosX;
  FTargetPosY := APosY;
end;

end.
