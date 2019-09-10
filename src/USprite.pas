unit USprite;

interface

uses
  Vcl.Graphics,
  UGlobal;

type
  TSprite = class
  private
    FPosX: Integer;
    FPosY: Integer;
    FIcon: TBitmap;
  public
    constructor Create(APosX, APosY: Integer); virtual;
    destructor Destroy; override;
  public
    property Icon: TBitmap read FIcon;
    property PosX: Integer read FPosX write FPosX;
    property PosY: Integer read FPosY write FPosY;
  end;

  TTownSprite = class(TSprite)
  public
    constructor Create(APosX, APosY: Integer); override;
  end;

  TLandTraderSprite = class(TSprite)
  public
    constructor Create(APosX, APosY: Integer); override;
  end;

  TSeaTraderSprite = class(TSprite)
  public
    constructor Create(APosX, APosY: Integer); override;
  end;

implementation

uses
  System.Types;

{ TSprite }

constructor TSprite.Create(APosX, APosY: Integer);
begin
  FIcon := TBitmap.Create;
  FPosX := APosX;
  FPosY := APosY;

  FIcon.TransparentColor := clWhite;
  FIcon.Transparent := True;
  FIcon.Canvas.Brush.Color := clWhite;

  FIcon.SetSize(SPRITE_SIZE,SPRITE_SIZE);
end;

destructor TSprite.Destroy;
begin
  FIcon.Free;
  inherited;
end;

{ TTownSprite }

constructor TTownSprite.Create(APosX, APosY: Integer);
begin
  inherited;

  FIcon.Canvas.Brush.Color := clRed;
  FICon.Canvas.Ellipse(0,0,SPRITE_SIZE, SPRITE_SIZE);
end;

{ TTraderSprite }

constructor TLandTraderSprite.Create(APosX, APosY: Integer);
var
  l_Distance: Integer;
begin
  inherited;

  l_Distance := SPRITE_SIZE div 4;

  FIcon.Canvas.Brush.Color := clOlive;
  FICon.Canvas.Rectangle(l_Distance, l_Distance, l_Distance*3, l_Distance*3);
end;

{ TSeaTraderSprite }

constructor TSeaTraderSprite.Create(APosX, APosY: Integer);
var
  Points: array of TPoint;
begin
  inherited;

  SetLength(Points, 3);
  Points[0] := Point(0, SPRITE_SIZE);
  Points[1] := Point(SPRITE_SIZE div 2, 0);
  Points[2] := Point(SPRITE_SIZE, SPRITE_SIZE);

  FIcon.Canvas.Pen.Width := 2;
  FIcon.Canvas.Pen.Color := clRed;
  FIcon.Canvas.Brush.Color := clYellow;
  FIcon.Canvas.Polygon(Points);
end;

end.
