object FrmNewTown: TFrmNewTown
  Left = 0
  Top = 0
  Caption = 'New Town'
  ClientHeight = 179
  ClientWidth = 203
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object txtTownName: TLabeledEdit
    Left = 16
    Top = 24
    Width = 177
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Name'
    TabOrder = 0
  end
  object btnBack: TButton
    Left = 16
    Top = 139
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 1
  end
  object btnSave: TButton
    Left = 118
    Top = 139
    Width = 75
    Height = 25
    Caption = 'Speichern'
    ModalResult = 1
    TabOrder = 2
  end
  object txtGrain: TLabeledEdit
    Left = 16
    Top = 64
    Width = 57
    Height = 21
    EditLabel.Width = 25
    EditLabel.Height = 13
    EditLabel.Caption = 'Grain'
    TabOrder = 3
    Text = '0'
  end
  object txtBeer: TLabeledEdit
    Left = 16
    Top = 104
    Width = 57
    Height = 21
    EditLabel.Width = 22
    EditLabel.Height = 13
    EditLabel.Caption = 'Beer'
    TabOrder = 4
    Text = '0'
  end
end
