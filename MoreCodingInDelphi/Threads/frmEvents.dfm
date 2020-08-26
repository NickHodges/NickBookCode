object Form61: TForm61
  Left = 0
  Top = 0
  Caption = 'Form61'
  ClientHeight = 299
  ClientWidth = 635
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
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 153
    Height = 25
    Caption = 'Start Threads'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 184
    Top = 16
    Width = 441
    Height = 265
    TabOrder = 1
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 24
    Top = 48
  end
end
