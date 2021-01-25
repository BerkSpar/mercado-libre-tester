object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 313
  ClientWidth = 639
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblCategoryId: TLabel
    Left = 8
    Top = 14
    Width = 59
    Height = 13
    Caption = 'Category ID'
  end
  object edtCategoryId: TEdit
    Left = 8
    Top = 29
    Width = 105
    Height = 21
    TabOrder = 0
    Text = 'MLB1055'
  end
  object btnGetAttributes: TButton
    Left = 119
    Top = 14
    Width = 82
    Height = 36
    Caption = 'Get Attributes'
    TabOrder = 1
    OnClick = btnGetAttributesClick
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 64
    Width = 625
    Height = 241
    ColCount = 4
    DefaultColWidth = 150
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 2
  end
end
