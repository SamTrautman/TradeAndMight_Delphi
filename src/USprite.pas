unit USprite;

interface

uses
  Vcl.Graphics;

type
  TSprite = class
  private
    FIcon: TBitmap;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  public
    property Icon: TBitmap read FIcon;
  end;

  TTownSprite = class(TSprite)
  public
    constructor Create; override;
  end;

  TTraderSprite = class(TSprite)
  public
    constructor Create; override;
  end;

implementation

uses
  UGlobal;

{ TSprite }

constructor TSprite.Create;
begin
  FIcon := TBitmap.Create;

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

constructor TTownSprite.Create;
begin
  inherited;

  FIcon.Canvas.Brush.Color := clRed;
  FICon.Canvas.Ellipse(0,0,SPRITE_SIZE, SPRITE_SIZE);
end;

{ TTraderSprite }

constructor TTraderSprite.Create;
var
  l_Distance: Integer;
begin
  inherited;

  l_Distance := SPRITE_SIZE div 4;

  FIcon.Canvas.Brush.Color := clYellow;
  FICon.Canvas.Rectangle(l_Distance, l_Distance, l_Distance*3, l_Distance*3);
end;

end.
