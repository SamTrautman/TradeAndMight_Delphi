unit UBGT_Base;

interface

uses
  Vcl.Graphics;

type
  TBackGroundType = (BGT_Water, BGT_Land, BGT_Mountains, BGT_Town);

  TBGT_Base = class
  private
    FIcon: TBitmap;
  private
    procedure DrawIcon;
  protected
    function GetBackGroundType: TBackGroundType; virtual; abstract;
    function GetBackGroundColor: TColor; virtual; abstract;
  public
    constructor Create;
    destructor Destroy; override;
  public
    property Icon: TBitmap read FIcon;
    property BGType: TBackGroundType read GetBackGroundType;
  end;

implementation

uses
  UGlobal;

{ TBGT_Base }

constructor TBGT_Base.Create;
begin
  FIcon := TBitmap.Create;
  DrawIcon;
end;

destructor TBGT_Base.Destroy;
begin
  FIcon.Free;
  inherited;
end;

procedure TBGT_Base.DrawIcon;
begin
  FIcon.Canvas.Brush.Color := clFuchsia;
  FIcon.SetSize(SPRITE_SIZE,SPRITE_SIZE);

  FIcon.Canvas.Brush.Color := GetBackGroundColor;
  FIcon.Canvas.Pen.Color := clBtnFace;
  FIcon.Canvas.Rectangle(0, 0, SPRITE_SIZE, SPRITE_SIZE);
end;

end.
