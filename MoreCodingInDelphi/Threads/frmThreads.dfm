object ThreadsDemoForm: TThreadsDemoForm
  Left = 0
  Top = 0
  Caption = 'Threads Demo'
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
    Left = 192
    Top = 8
    Width = 417
    Height = 283
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 169
    Height = 25
    Caption = 'Run Simple Thread'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 39
    Width = 169
    Height = 25
    Caption = 'Create Suspended'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 70
    Width = 169
    Height = 25
    Caption = 'Start MemoMessage Thread'
    TabOrder = 3
    OnClick = Button3Click
  end
end
