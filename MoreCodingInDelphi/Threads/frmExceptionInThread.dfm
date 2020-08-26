object Form52: TForm52
  Left = 0
  Top = 0
  Caption = 'Form52'
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
  object Memo1: TMemo
    Left = 216
    Top = 8
    Width = 411
    Height = 283
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 202
    Height = 25
    Caption = 'Create Exception-raising Thread'
    TabOrder = 1
    OnClick = Button1Click
  end
end
