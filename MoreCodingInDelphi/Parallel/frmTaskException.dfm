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
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 250
    Height = 25
    Caption = 'Exception Raised but Nothing happens!'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 264
    Top = 8
    Width = 363
    Height = 283
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object Button2: TButton
    Left = 8
    Top = 39
    Width = 250
    Height = 25
    Caption = 'try...finally block get ugly error'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 70
    Width = 250
    Height = 25
    Caption = 'AcquireExceptionObject'
    TabOrder = 3
    OnClick = Button3Click
  end
end
