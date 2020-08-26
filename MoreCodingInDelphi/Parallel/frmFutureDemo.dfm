object FuturesDemoForm: TFuturesDemoForm
  Left = 0
  Top = 0
  Caption = 'Futures Demo'
  ClientHeight = 333
  ClientWidth = 638
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    638
    333)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 248
    Top = 8
    Width = 382
    Height = 317
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
  end
  object Button1: TButton
    Left = 16
    Top = 16
    Width = 193
    Height = 25
    Caption = 'Start Futures Running'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 16
    Top = 300
    Width = 193
    Height = 25
    Caption = 'Wait for All Futures to Finish'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 16
    Top = 144
    Width = 193
    Height = 25
    Caption = 'Wait for Any Future to Finish'
    TabOrder = 3
    OnClick = Button3Click
  end
end
