object FileDisplayerForm: TFileDisplayerForm
  Left = 0
  Top = 0
  Caption = 'File Viewer'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Constraints.MinHeight = 480
  Constraints.MinWidth = 640
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    624
    441)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 100
    Width = 109
    Height = 13
    Caption = 'Extensions Supported:'
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 122
    Height = 73
    Caption = 'Get and Display File'
    TabOrder = 0
    WordWrap = True
    OnClick = Button1Click
  end
  object Panel1: TPanel
    Left = 152
    Top = 0
    Width = 472
    Height = 441
    Align = alRight
    Anchors = [akLeft, akTop, akRight, akBottom]
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    TabOrder = 1
  end
  object Button2: TButton
    Left = 8
    Top = 401
    Width = 122
    Height = 32
    Anchors = [akLeft, akBottom]
    Caption = 'Close'
    TabOrder = 2
    OnClick = Button2Click
  end
  object ListBox1: TListBox
    Left = 8
    Top = 119
    Width = 121
    Height = 276
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    TabOrder = 3
  end
end
