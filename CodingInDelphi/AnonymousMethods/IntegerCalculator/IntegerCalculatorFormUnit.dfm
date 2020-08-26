object IntegerCalculatorForm: TIntegerCalculatorForm
  Left = 0
  Top = 0
  Caption = 'IntegerCalculatorForm'
  ClientHeight = 406
  ClientWidth = 750
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    750
    406)
  PixelsPerInch = 96
  TextHeight = 13
  object LeftOperandLabel: TLabel
    Left = 8
    Top = 11
    Width = 66
    Height = 13
    Caption = '&Left operand:'
    FocusControl = LeftOperandSpinEdit
  end
  object RightOperandLabel: TLabel
    Left = 8
    Top = 39
    Width = 72
    Height = 13
    Caption = '&Right operand:'
    FocusControl = RightOperandSpinEdit
  end
  object OperatorsRadioGroup: TRadioGroup
    Left = 8
    Top = 64
    Width = 185
    Height = 213
    Anchors = [akLeft, akTop, akBottom]
    Caption = 'OperatorsRadioGroup'
    TabOrder = 2
  end
  object AddOperatorsButton: TButton
    Left = 8
    Top = 283
    Width = 185
    Height = 25
    Action = AddOperatorsAction
    Anchors = [akLeft, akBottom]
    TabOrder = 3
  end
  object LogMemo: TMemo
    Left = 199
    Top = 8
    Width = 546
    Height = 393
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clBtnFace
    Lines.Strings = (
      'LogMemo')
    ReadOnly = True
    TabOrder = 7
  end
  object ShowAnimalLocomotionsButton: TButton
    Left = 8
    Top = 376
    Width = 185
    Height = 25
    Action = PerformOperationAction
    Anchors = [akLeft, akBottom]
    TabOrder = 6
  end
  object LeftOperandSpinEdit: TSpinEdit
    Left = 80
    Top = 8
    Width = 113
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 8
  end
  object RightOperandSpinEdit: TSpinEdit
    Left = 80
    Top = 36
    Width = 113
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 0
    Value = 4
  end
  object Button1: TButton
    Left = 8
    Top = 314
    Width = 185
    Height = 25
    Action = AddDivisionOperatorsAction
    Anchors = [akLeft, akBottom]
    TabOrder = 4
  end
  object Button2: TButton
    Left = 8
    Top = 345
    Width = 185
    Height = 25
    Action = AddPowerOperatorAction
    Anchors = [akLeft, akBottom]
    TabOrder = 5
  end
  object ActionManager: TActionManager
    Left = 232
    Top = 352
    StyleName = 'Platform Default'
    object AddOperatorsAction: TAction
      Caption = 'AddOperatorsAction'
      OnExecute = AddOperatorsActionExecute
    end
    object PerformOperationAction: TAction
      Caption = 'PerformOperationAction'
      OnExecute = PerformOperationActionExecute
      OnUpdate = PerformOperationActionUpdate
    end
    object AddDivisionOperatorsAction: TAction
      Caption = 'AddDivisionOperatorsAction'
      OnExecute = AddDivisionOperatorsActionExecute
      OnUpdate = AddDivisionOperatorsActionUpdate
    end
    object AddPowerOperatorAction: TAction
      Caption = 'AddPowerOperatorAction'
      OnExecute = AddPowerOperatorActionExecute
      OnUpdate = AddPowerOperatorActionUpdate
    end
  end
end
