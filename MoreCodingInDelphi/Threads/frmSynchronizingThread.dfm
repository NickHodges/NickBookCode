object Form51: TForm51
  Left = 0
  Top = 0
  Caption = 'Thread Synchronization Demo'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = Button2Click
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 169
    Height = 25
    Caption = 'Protect with Critical Section'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 200
    Top = 8
    Width = 427
    Height = 283
    TabOrder = 1
  end
  object Button2: TButton
    Left = 8
    Top = 266
    Width = 169
    Height = 25
    Caption = 'Terminate Threads'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 39
    Width = 169
    Height = 25
    Caption = 'Protect with TMonitor'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 132
    Width = 169
    Height = 25
    Caption = 'No Protection'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 8
    Top = 70
    Width = 169
    Height = 25
    Caption = 'Protect with TMutex'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 8
    Top = 101
    Width = 169
    Height = 25
    Caption = 'Protect with TSpinLock'
    TabOrder = 6
    OnClick = Button6Click
  end
end
