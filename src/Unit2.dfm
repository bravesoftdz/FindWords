object frmsummary: Tfrmsummary
  Left = 498
  Top = 111
  Width = 256
  Height = 616
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Summary of moves'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Courier New'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 18
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 241
    Height = 572
    Align = alLeft
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'TXT'
    Filter = 'Text files|*.TXT'
    Left = 40
    Top = 132
  end
  object MainMenu1: TMainMenu
    Left = 52
    Top = 72
    object Save1: TMenuItem
      Caption = 'Save'
      OnClick = Save1Click
    end
  end
end
