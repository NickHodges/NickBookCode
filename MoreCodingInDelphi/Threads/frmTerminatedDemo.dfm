object Form49: TForm49
  Left = 0
  Top = 0
  Caption = 'Terminate Thread'
  ClientHeight = 119
  ClientWidth = 281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 168
    Top = 51
    Width = 60
    Height = 25
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 16
    Top = 25
    Width = 105
    Height = 25
    Caption = 'Start Thread'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 16
    Top = 56
    Width = 105
    Height = 25
    Caption = 'Terminate Thread'
    TabOrder = 1
    OnClick = Button2Click
  end
end
