object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Trade & Might'
  ClientHeight = 673
  ClientWidth = 837
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlStatus: TPanel
    Left = 0
    Top = 632
    Width = 837
    Height = 41
    Align = alBottom
    TabOrder = 0
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 837
    Height = 41
    Align = alTop
    TabOrder = 1
  end
  inline FrameWorldBuilder: TFrameWorldBuilder
    Left = 0
    Top = 41
    Width = 837
    Height = 591
    Align = alClient
    TabOrder = 2
    ExplicitTop = 41
    ExplicitWidth = 837
    ExplicitHeight = 591
    inherited ImgWorld: TImage
      Width = 625
      Height = 591
      ExplicitWidth = 625
      ExplicitHeight = 591
    end
    inherited splitSidePanelImage: TSplitter
      Height = 591
      ExplicitHeight = 591
    end
    inherited pcSidePanel: TPageControl
      Height = 591
      ExplicitHeight = 591
      inherited tsCreateWorld: TTabSheet
        ExplicitHeight = 583
      end
    end
  end
end
