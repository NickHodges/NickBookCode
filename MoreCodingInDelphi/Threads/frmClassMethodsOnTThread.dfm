object Form50: TForm50
  Left = 0
  Top = 0
  Caption = 'TThread Class Methods Demo'
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
    Width = 185
    Height = 25
    Caption = 'CreateAnonymousThread'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 216
    Top = 8
    Width = 411
    Height = 283
    TabOrder = 1
  end
  object Button2: TButton
    Left = 8
    Top = 39
    Width = 185
    Height = 25
    Caption = 'Synchronize'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 70
    Width = 185
    Height = 25
    Caption = 'Queue'
    TabOrder = 3
    OnClick = Button3Click
  end
end
