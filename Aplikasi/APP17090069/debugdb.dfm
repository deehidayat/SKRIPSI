object FrmDebugDB: TFrmDebugDB
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'FrmDebugDB'
  ClientHeight = 224
  ClientWidth = 304
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sGroupBox1: TsGroupBox
    Left = 24
    Top = 21
    Width = 249
    Height = 195
    Caption = 'Konfigurasi Database '
    TabOrder = 0
    SkinData.SkinSection = 'GROUPBOX'
    object Label1: TsLabel
      Left = 24
      Top = 24
      Width = 60
      Height = 13
      AutoSize = False
      Caption = 'Nama DB'
    end
    object sLabel1: TsLabel
      Left = 24
      Top = 51
      Width = 60
      Height = 13
      AutoSize = False
      Caption = 'Host'
    end
    object sLabel2: TsLabel
      Left = 24
      Top = 78
      Width = 60
      Height = 13
      AutoSize = False
      Caption = 'User'
    end
    object sLabel3: TsLabel
      Left = 24
      Top = 105
      Width = 60
      Height = 13
      AutoSize = False
      Caption = 'Password'
    end
    object SpeedButton1: TsSpeedButton
      Left = 90
      Top = 153
      Width = 111
      Height = 24
      Caption = 'Connect'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FF0066CF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF0268D11477DD0E76E0FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0066CE318DEA
        3D9AF9056CD60C70D60B6FD70167CF0167CFFF00FFFF00FFFF00FFFF00FF11EE
        EDFF00FFFF00FFFF00FFFF00FF056AD11A7ADD2281E43C99F72D8EF02286EC0E
        74DB0269D1FF00FFFF00FF11EFE8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0366CF3F99F4409BF83797F72488EC0167CF1580EB076FE800542DFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF066BD32988E8439FFA2E8FF10167CF1B
        83EB137CF6006591036C0A04771BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF066BD33C98F60167CF1F83E91C83F90165A005700F169124056F080060
        00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF066BD30167CF2285E8288BFB02
        65B5046D161B9B2E0C7E1A006000036904FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF1173DA3091FB066AC1036A211EA031138A25006000108621046F
        09FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0463C4036C2F21
        A736199834006000148E2911872108750FFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF0B79091FA33F0060001A993418942F1086210978
        11006300FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF12FAF8FF00FFFF00FF00
        63010876111085210E821D0C7E1905710A10841F056E09FF00FFFF00FFFF00FF
        FF00FF11EEEDFF00FFFF00FFFF00FFFF00FF0062000061000064000065000061
        001DA13C108520006400FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF006100056F0A026903FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF006100006100FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = SpeedButton1Click
      SkinData.SkinSection = 'SPEEDBUTTON'
    end
    object sLabel4: TsLabel
      Left = 24
      Top = 129
      Width = 60
      Height = 13
      AutoSize = False
      Caption = 'Protocol'
    end
    object Edit1: TsEdit
      Left = 90
      Top = 21
      Width = 111
      Height = 21
      TabOrder = 0
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object Edit2: TsEdit
      Left = 90
      Top = 48
      Width = 111
      Height = 21
      TabOrder = 1
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object Edit3: TsEdit
      Left = 90
      Top = 75
      Width = 111
      Height = 21
      TabOrder = 2
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object Edit4: TsEdit
      Left = 90
      Top = 102
      Width = 111
      Height = 21
      PasswordChar = '*'
      TabOrder = 3
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object ComboBox1: TsComboBox
      Left = 90
      Top = 126
      Width = 111
      Height = 21
      Alignment = taLeftJustify
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      SkinData.SkinSection = 'COMBOBOX'
      Style = csDropDownList
      ItemIndex = -1
      TabOrder = 4
      Items.Strings = (
        'mysql'
        'mysql-4.1'
        'mysql-5'
        'sqlite'
        'sqlite-3')
    end
  end
end
