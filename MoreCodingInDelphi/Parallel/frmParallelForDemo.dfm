object ParallelForDemoForm: TParallelForDemoForm
  Left = 0
  Top = 0
  Caption = 'Parallel For Demo'
  ClientHeight = 346
  ClientWidth = 604
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    604
    346)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 225
    Top = 17
    Width = 369
    Height = 321
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 14
    Width = 210
    Height = 27
    Caption = 'Count from 1 to 10'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 47
    Width = 210
    Height = 27
    Caption = 'Primes Below 100,000'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 112
    Width = 210
    Height = 26
    Caption = 'Takes a long time -- Press Cancel'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 92
    Top = 144
    Width = 126
    Height = 26
    Caption = 'Cancel with Stop'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button6: TButton
    Left = 8
    Top = 79
    Width = 210
    Height = 27
    Caption = 'Responsive Parallel For Loop'
    TabOrder = 5
    OnClick = Button6Click
  end
end
