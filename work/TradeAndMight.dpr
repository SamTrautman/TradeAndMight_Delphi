program TradeAndMight;

uses
  Vcl.Forms,
  UFrmMain in '..\user\UFrmMain.pas' {FrmMain},
  UGlobal in '..\src\UGlobal.pas',
  UWorld in '..\src\UWorld.pas',
  UBaseTerrainTile in '..\src\Terrain\UBaseTerrainTile.pas',
  UWaterTerrainTile in '..\src\Terrain\UWaterTerrainTile.pas',
  ULandTerrainTile in '..\src\Terrain\ULandTerrainTile.pas',
  UMountainTerrainTile in '..\src\Terrain\UMountainTerrainTile.pas',
  UFrameWorldBuilder in '..\user\UFrameWorldBuilder.pas' {FrameWorldBuilder: TFrame},
  UBaseTerrainObject in '..\src\TerrainObject\UBaseTerrainObject.pas',
  UTownTerrainObject in '..\src\TerrainObject\UTownTerrainObject.pas',
  UFrmNewTown in '..\user\UFrmNewTown.pas' {FrmNewTown},
  UBaseSprite in '..\src\Sprite\UBaseSprite.pas',
  USeaTrader in '..\src\Sprite\USeaTrader.pas',
  UStock in '..\src\UStock.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmNewTown, FrmNewTown);
  Application.Run;
end.
