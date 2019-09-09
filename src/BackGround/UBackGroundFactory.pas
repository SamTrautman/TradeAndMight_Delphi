unit UBackGroundFactory;

interface

uses
  UBGT_Base;

function CreateBackGroundTile(ABGT_Type: TBackGroundType): TBGT_Base;

implementation

uses
  UBGT_Water, UBGT_Land, UBGT_Mountains, UBGT_Town;

type
  TBackGroundFactory = class
  public
    function CreateBackGroundTile(ABGT_Type: TBackGroundType): TBGT_Base;
  end;

var
  FBackGroundFactory: TBackGroundFactory;

function CreateBackGroundTile(ABGT_Type: TBackGroundType): TBGT_Base;
begin
  Result := FBackGroundFactory.CreateBackGroundTile(ABGT_Type);
end;

{ TBackGroundFactory }

function TBackGroundFactory.CreateBackGroundTile(
  ABGT_Type: TBackGroundType): TBGT_Base;
begin
  if ABGT_Type = BGT_Water then
    Result := TBGT_Water.Create
  else if ABGT_Type = BGT_Land then
    Result := TBGT_Land.Create
  else if ABGT_Type = BGT_Mountains then
    Result := TBGT_Mountains.Create
  else if ABGT_Type = BGT_Town then
    Result := TBGT_Town.Create
  else
    Result := TBGT_Water.Create;
end;

initialization
begin
  FBackGroundFactory := TBackGroundFactory.Create;
end;

finalization
begin
  FBackGroundFactory.Free;
end;

end.
