object FrameWorldBuilder: TFrameWorldBuilder
  Left = 0
  Top = 0
  Width = 778
  Height = 552
  TabOrder = 0
  object ImgWorld: TImage
    Left = 212
    Top = 0
    Width = 566
    Height = 552
    Align = alClient
    OnMouseDown = ImgWorldMouseDown
    ExplicitLeft = 224
    ExplicitWidth = 554
  end
  object splitSidePanelImage: TSplitter
    Left = 209
    Top = 0
    Height = 552
    ExplicitLeft = 208
    ExplicitTop = 248
    ExplicitHeight = 100
  end
  object pcSidePanel: TPageControl
    Left = 0
    Top = 0
    Width = 209
    Height = 552
    ActivePage = tsTesting
    Align = alLeft
    MultiLine = True
    TabOrder = 0
    TabPosition = tpLeft
    object tsCreateWorld: TTabSheet
      Caption = 'Create World'
      object txtSizeX: TLabeledEdit
        Left = 3
        Top = 16
        Width = 169
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'Size X'
        TabOrder = 0
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
        TabOrder = 1
        Text = '25'
      end
      object btnCreateWorld: TButton
        Left = 3
        Top = 86
        Width = 169
        Height = 25
        Caption = 'Create World'
        TabOrder = 2
        OnClick = btnCreateWorldClick
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
    object tsEditTerrain: TTabSheet
      Caption = 'Edit Terrain'
      ImageIndex = 1
      object rgTerrainTiles: TRadioGroup
        Left = 0
        Top = 0
        Width = 181
        Height = 89
        Align = alTop
        Caption = 'Terrain'
        ItemIndex = 0
        Items.Strings = (
          'Water'
          'Land'
          'Mountain')
        TabOrder = 0
      end
    end
    object tsEditObjects: TTabSheet
      Caption = 'Edit Objects'
      ImageIndex = 2
      object rgObjekte: TRadioGroup
        Left = 0
        Top = 0
        Width = 181
        Height = 41
        Align = alTop
        Caption = 'Objekte'
        ItemIndex = 0
        Items.Strings = (
          'Town')
        TabOrder = 0
      end
    end
    object tsView: TTabSheet
      Caption = 'View'
      ImageIndex = 3
      object rgSpriteSize: TRadioGroup
        Left = 0
        Top = 0
        Width = 181
        Height = 89
        Align = alTop
        Caption = 'Sprite Size'
        ItemIndex = 0
        Items.Strings = (
          '16x16 Pixel'
          '32x32 Pixel'
          '64x64 Pixel')
        TabOrder = 0
        OnClick = rgSpriteSizeClick
      end
    end
    object tsTesting: TTabSheet
      Caption = 'Testing'
      ImageIndex = 4
      object btnRunTurn: TButton
        Left = 3
        Top = 3
        Width = 166
        Height = 25
        Caption = 'Run Turn'
        TabOrder = 0
        OnClick = btnRunTurnClick
      end
    end
  end
  object SaveDialogMap: TSaveDialog
    Left = 56
    Top = 500
  end
  object OpenDialogMap: TOpenDialog
    Left = 128
    Top = 500
  end
end
