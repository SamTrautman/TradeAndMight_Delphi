object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Trade & Might'
  ClientHeight = 573
  ClientWidth = 753
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ImgWorld: TImage
    Left = 185
    Top = 41
    Width = 568
    Height = 491
    Align = alClient
    OnMouseDown = ImgWorldMouseDown
    ExplicitLeft = 312
    ExplicitTop = 152
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object pnlStatus: TPanel
    Left = 0
    Top = 532
    Width = 753
    Height = 41
    Align = alBottom
    TabOrder = 0
  end
  object pnlSideBar: TPanel
    Left = 0
    Top = 41
    Width = 185
    Height = 491
    Align = alLeft
    TabOrder = 1
    object pgcMenu: TPageControl
      Left = 1
      Top = 1
      Width = 183
      Height = 489
      ActivePage = tsEditMap
      Align = alClient
      TabOrder = 0
      object tsNewWorld: TTabSheet
        Caption = 'New World'
        object btnCreateWorld: TButton
          Left = 3
          Top = 86
          Width = 169
          Height = 25
          Caption = 'Create World'
          TabOrder = 0
          OnClick = btnCreateWorldClick
        end
        object txtSizeX: TLabeledEdit
          Left = 3
          Top = 16
          Width = 169
          Height = 21
          EditLabel.Width = 28
          EditLabel.Height = 13
          EditLabel.Caption = 'Size X'
          TabOrder = 1
          Text = '25'
        end
        object txtSizeY: TLabeledEdit
          Left = 3
          Top = 59
          Width = 169
          Height = 21
          EditLabel.Width = 28
          EditLabel.Height = 13
          EditLabel.Caption = 'Size Y'
          TabOrder = 2
          Text = '25'
        end
        object btnSaveWorld: TButton
          Left = 3
          Top = 117
          Width = 169
          Height = 25
          Caption = 'Save World'
          TabOrder = 3
          OnClick = btnSaveWorldClick
        end
        object btnLoadWorld: TButton
          Left = 3
          Top = 148
          Width = 169
          Height = 25
          Caption = 'Load World'
          TabOrder = 4
          OnClick = btnLoadWorldClick
        end
      end
      object tsEditMap: TTabSheet
        Caption = 'Edit Map'
        ImageIndex = 1
        object rgTiles: TRadioGroup
          Left = 0
          Top = 0
          Width = 175
          Height = 105
          Align = alTop
          Caption = 'Tiles'
          ItemIndex = 0
          Items.Strings = (
            'Water'
            'Land'
            'Mountains'
            'Town')
          TabOrder = 0
        end
      end
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 753
    Height = 41
    Align = alTop
    TabOrder = 2
  end
  object DlgSaveWorldMap: TSaveDialog
    Filter = 'worldmap'
    Left = 40
    Top = 480
  end
  object DlgOpenWorldMap: TOpenDialog
    Filter = 'worldmap'
    Left = 37
    Top = 426
  end
end
