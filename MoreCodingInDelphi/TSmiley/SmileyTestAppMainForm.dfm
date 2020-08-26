object SmileyTestForm: TSmileyTestForm
  Left = 633
  Top = 456
  Caption = 'Smiley Test Application'
  ClientHeight = 238
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  ShowHint = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 65
    Top = 64
    Width = 210
    Height = 49
    AutoSize = False
    WordWrap = True
  end
  object Label2: TLabel
    Left = 8
    Top = 64
    Width = 52
    Height = 13
    Caption = 'Long Hint: '
  end
  object Button1: TButton
    Left = 90
    Top = 192
    Width = 185
    Height = 25
    Caption = 'Create a TSmiley'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 90
    Top = 161
    Width = 185
    Height = 25
    Caption = 'Increment'
    Enabled = False
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 90
    Top = 130
    Width = 185
    Height = 25
    Caption = 'Choose Click Mood'
    Enabled = False
    TabOrder = 2
    OnClick = Button3Click
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 40
    Height = 40
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 3
  end
  object ApplicationEvents1: TApplicationEvents
    OnHint = ApplicationEvents1Hint
    Left = 24
    Top = 152
  end
end
