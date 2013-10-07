object FrmSplashScreen: TFrmSplashScreen
  Left = 636
  Top = 250
  AutoSize = True
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 270
  ClientWidth = 540
  Color = clLime
  TransparentColor = True
  TransparentColorValue = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 540
    Height = 270
    AutoSize = True
    Center = True
    Proportional = True
    Transparent = True
  end
  object LblMessage: TsLabel
    Left = 0
    Top = 234
    Width = 540
    Height = 36
    Align = alBottom
    Alignment = taRightJustify
    Color = clRed
    ParentColor = False
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 14603725
    Font.Height = -32
    Font.Name = 'MV Boli'
    Font.Style = [fsBold]
    ExplicitLeft = 523
    ExplicitWidth = 17
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 247
    Top = 40
  end
end
