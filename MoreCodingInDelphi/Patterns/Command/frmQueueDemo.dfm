object Form49: TForm49
  Left = 0
  Top = 0
  Caption = 'Command Queue Demo'
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
  object Label1: TLabel
    Left = 8
    Top = 66
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 217
    Height = 25
    Caption = 'Pull item from queue'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 248
    Top = 10
    Width = 379
    Height = 281
    TabOrder = 1
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 24
    Top = 248
  end
end
