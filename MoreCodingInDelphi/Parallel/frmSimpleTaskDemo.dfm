object SimpleTaskForm: TSimpleTaskForm
  Left = 0
  Top = 0
  Caption = 'Simple Task Demo'
  ClientHeight = 286
  ClientWidth = 575
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    575
    286)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 24
    Top = 23
    Width = 185
    Height = 25
    Caption = 'No Task'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 24
    Top = 54
    Width = 185
    Height = 25
    Caption = 'Use a Task'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 248
    Top = 25
    Width = 309
    Height = 243
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
  end
end
