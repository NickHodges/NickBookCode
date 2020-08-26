object AnimalForm: TAnimalForm
  Left = 0
  Top = 0
  Caption = 'AnimalForm'
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
  object AnimalTypeRadioGroup: TRadioGroup
    Left = 8
    Top = 8
    Width = 185
    Height = 331
    Anchors = [akLeft, akTop, akBottom]
    Caption = 'AnimalTypeRadioGroup'
    TabOrder = 0
  end
  object FillAnimalTypesButton: TButton
    Left = 8
    Top = 345
    Width = 185
    Height = 25
    Action = FillAnimalTypesAction
    Anchors = [akLeft, akBottom]
    TabOrder = 1
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
    TabOrder = 3
  end
  object ShowAnimalLocomotionsButton: TButton
    Left = 8
    Top = 376
    Width = 185
    Height = 25
    Action = ShowAnimalLocomotionsAction
    Anchors = [akLeft, akBottom]
    TabOrder = 2
  end
  object ActionManager: TActionManager
    Left = 224
    Top = 352
    StyleName = 'Platform Default'
    object FillAnimalTypesAction: TAction
      Caption = 'FillAnimalTypesAction'
      OnExecute = FillAnimalTypesActionExecute
    end
    object ShowAnimalLocomotionsAction: TAction
      Caption = 'ShowAnimalLocomotionsAction'
      OnExecute = ShowAnimalLocomotionsActionExecute
      OnUpdate = ShowAnimalLocomotionsActionUpdate
    end
  end
end
