object StrideDemoForm: TStrideDemoForm
  Left = 0
  Top = 0
  Caption = 'Stride Demo Form'
  ClientHeight = 340
  ClientWidth = 535
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 200
    Top = 16
    Width = 300
    Height = 300
  end
  object Label1: TLabel
    Left = 8
    Top = 45
    Width = 86
    Height = 13
    Caption = 'Number of Strides'
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 177
    Height = 25
    Caption = 'Paint Parallel Squares'
    TabOrder = 0
    OnClick = Button1Click
  end
  object SpinEdit1: TSpinEdit
    Left = 8
    Top = 64
    Width = 121
    Height = 22
    MaxValue = 100
    MinValue = 1
    TabOrder = 1
    Value = 10
  end
end
