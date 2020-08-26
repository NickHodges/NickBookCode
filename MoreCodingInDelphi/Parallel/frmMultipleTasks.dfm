object MultipleTasksDemoForm: TMultipleTasksDemoForm
  Left = 0
  Top = 0
  Caption = 'Multiple Tasks Demo'
  ClientHeight = 415
  ClientWidth = 690
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    690
    415)
  PixelsPerInch = 96
  TextHeight = 13
  object Button3: TButton
    Left = 42
    Top = 25
    Width = 185
    Height = 26
    Caption = 'Run Three Tasks'
    TabOrder = 0
    OnClick = Button3Click
  end
  object Memo1: TMemo
    Left = 259
    Top = 25
    Width = 423
    Height = 382
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    ExplicitHeight = 389
  end
  object Button4: TButton
    Left = 34
    Top = 314
    Width = 184
    Height = 26
    Caption = 'Wait For All Tasks'
    TabOrder = 2
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 34
    Top = 346
    Width = 184
    Height = 27
    Caption = 'Wait For Any Task'
    TabOrder = 3
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 34
    Top = 378
    Width = 184
    Height = 27
    Caption = 'Wait For The First Two'
    TabOrder = 4
    OnClick = Button6Click
  end
end
