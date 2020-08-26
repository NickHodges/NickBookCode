object UndoExampleForm: TUndoExampleForm
  Left = 0
  Top = 0
  Caption = 'Undo Command Demo'
  ClientHeight = 305
  ClientWidth = 633
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 0
    Top = 41
    Width = 633
    Height = 264
    Align = alClient
    OnMouseUp = PaintBox1MouseUp
    OnPaint = PaintBox1Paint
    ExplicitLeft = 296
    ExplicitTop = 80
    ExplicitWidth = 307
    ExplicitHeight = 178
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 633
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 296
      Top = 14
      Width = 31
      Height = 13
      Caption = 'Label1'
    end
    object btnUndo: TButton
      Left = 16
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Undo'
      TabOrder = 0
      OnClick = btnUndoClick
    end
    object btnClear: TButton
      Left = 97
      Top = 10
      Width = 75
      Height = 24
      Caption = 'Clear'
      TabOrder = 1
      OnClick = btnClearClick
    end
  end
end
