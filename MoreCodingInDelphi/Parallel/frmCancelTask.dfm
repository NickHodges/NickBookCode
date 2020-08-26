object Form62: TForm62
  Left = 0
  Top = 0
  Caption = '-'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 177
    Height = 25
    Caption = 'Start Long Task'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 200
    Top = 16
    Width = 417
    Height = 273
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object Button2: TButton
    Left = 110
    Top = 39
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = Button2Click
  end
end
