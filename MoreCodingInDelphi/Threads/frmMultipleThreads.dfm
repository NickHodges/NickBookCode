object Form53: TForm53
  Left = 0
  Top = 0
  Caption = 'Multiple Threads Demo'
  ClientHeight = 382
  ClientWidth = 826
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
    Left = 144
    Top = 8
    Width = 209
    Height = 366
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 359
    Top = 8
    Width = 226
    Height = 366
    TabOrder = 1
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 130
    Height = 25
    Caption = 'Launch Threads'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Memo3: TMemo
    Left = 591
    Top = 8
    Width = 226
    Height = 366
    TabOrder = 3
  end
end
