program TradeAndMight;

uses
  Vcl.Forms,
  UFrmMain in '..\user\UFrmMain.pas' {FrmMain},
  UWorldMap in '..\src\UWorldMap.pas',
  USprite in '..\src\USprite.pas',
  UGlobal in '..\src\UGlobal.pas',
  UBGT_Water in '..\src\BackGround\UBGT_Water.pas',
  UBGT_Land in '..\src\BackGround\UBGT_Land.pas',
  UBGT_Mountains in '..\src\BackGround\UBGT_Mountains.pas',
  UBGT_Town in '..\src\BackGround\UBGT_Town.pas',
  UBGT_Base in '..\src\BackGround\UBGT_Base.pas',
  UBackGroundFactory in '..\src\BackGround\UBackGroundFactory.pas',
  UWorld in '..\src\UWorld.pas',
  UBaseTerrainTile in '..\src\Terrain\UBaseTerrainTile.pas',
  UWaterTerrainTile in '..\src\Terrain\UWaterTerrainTile.pas',
  ULandTerrainTile in '..\src\Terrain\ULandTerrainTile.pas',
  UMountainTerrainTile in '..\src\Terrain\UMountainTerrainTile.pas',
  UFrameWorldBuilder in '..\user\UFrameWorldBuilder.pas' {FrameWorldBuilder: TFrame},
  UBaseTerrainObject in '..\src\TerrainObject\UBaseTerrainObject.pas',
  UTownTerrainObject in '..\src\TerrainObject\UTownTerrainObject.pas',
  UFrmNewTown in '..\user\UFrmNewTown.pas' {FrmNewTown};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmNewTown, FrmNewTown);
  Application.Run;
end.
