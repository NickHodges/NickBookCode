object StartTaskDemoForm: TStartTaskDemoForm
  Left = 0
  Top = 0
  Caption = 'Start Task Demo'
  ClientHeight = 313
  ClientWidth = 664
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    664
    313)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 17
    Top = 10
    Width = 177
    Height = 27
    Caption = 'Create Task'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 17
    Top = 278
    Width = 177
    Height = 27
    Caption = 'Execute Task'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 211
    Top = 10
    Width = 445
    Height = 295
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
  end
end
