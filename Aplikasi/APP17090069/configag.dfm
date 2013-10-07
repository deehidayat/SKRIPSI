object FrmConfigAG: TFrmConfigAG
  Left = 0
  Top = 0
  AutoSize = True
  BorderStyle = bsDialog
  Caption = 'Konfigurasi'
  ClientHeight = 377
  ClientWidth = 357
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sGroupBox1: TsGroupBox
    Left = 0
    Top = 89
    Width = 357
    Height = 169
    Align = alTop
    Caption = 'Aturan '
    TabOrder = 0
    SkinData.SkinSection = 'GROUPBOX'
    object aturan1: TsCheckBox
      Left = 16
      Top = 24
      Width = 62
      Height = 20
      Caption = 'Aturan 1'
      TabOrder = 0
      OnClick = aturan1Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object aturan2: TsCheckBox
      Left = 16
      Top = 50
      Width = 62
      Height = 20
      Caption = 'Aturan 2'
      TabOrder = 1
      OnClick = aturan2Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object aturan3: TsCheckBox
      Left = 16
      Top = 76
      Width = 62
      Height = 20
      Caption = 'Aturan 3'
      TabOrder = 2
      OnClick = aturan3Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object aturan4: TsCheckBox
      Left = 16
      Top = 102
      Width = 62
      Height = 20
      Caption = 'Aturan 4'
      TabOrder = 3
      OnClick = aturan4Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object aturan5: TsCheckBox
      Left = 16
      Top = 128
      Width = 62
      Height = 20
      Caption = 'Aturan 5'
      TabOrder = 4
      OnClick = aturan5Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object aturan10: TsCheckBox
      Left = 172
      Top = 128
      Width = 68
      Height = 20
      Caption = 'Aturan 10'
      TabOrder = 5
      OnClick = aturan10Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object aturan9: TsCheckBox
      Left = 172
      Top = 102
      Width = 62
      Height = 20
      Caption = 'Aturan 9'
      TabOrder = 6
      OnClick = aturan9Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object aturan8: TsCheckBox
      Left = 172
      Top = 76
      Width = 62
      Height = 20
      Caption = 'Aturan 8'
      TabOrder = 7
      OnClick = aturan8Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object aturan7: TsCheckBox
      Left = 172
      Top = 50
      Width = 62
      Height = 20
      Caption = 'Aturan 7'
      TabOrder = 8
      OnClick = aturan7Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object aturan6: TsCheckBox
      Left = 172
      Top = 24
      Width = 62
      Height = 20
      Caption = 'Aturan 6'
      TabOrder = 9
      OnClick = aturan6Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
  end
  object sGroupBox2: TsGroupBox
    Left = 0
    Top = 258
    Width = 357
    Height = 87
    Align = alTop
    Caption = 'Laporan '
    TabOrder = 1
    SkinData.SkinSection = 'GROUPBOX'
    object laporan1: TsCheckBox
      Left = 16
      Top = 24
      Width = 93
      Height = 20
      Caption = 'Laporan Utama'
      TabOrder = 0
      OnClick = laporan1Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object laporan2: TsCheckBox
      Left = 16
      Top = 50
      Width = 81
      Height = 20
      Caption = 'Laporan Hari'
      TabOrder = 1
      OnClick = laporan2Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object laporan3: TsCheckBox
      Left = 172
      Top = 24
      Width = 92
      Height = 20
      Caption = 'Laporan Dosen'
      TabOrder = 2
      OnClick = laporan3Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object laporan4: TsCheckBox
      Left = 172
      Top = 50
      Width = 87
      Height = 20
      Caption = 'Laporan Kelas'
      TabOrder = 3
      OnClick = laporan4Click
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
  end
  object sBitBtn1: TsBitBtn
    Left = 0
    Top = 345
    Width = 357
    Height = 32
    Align = alTop
    Caption = 'OK'
    Default = True
    DoubleBuffered = True
    ModalResult = 1
    ParentDoubleBuffered = False
    TabOrder = 2
    SkinData.SkinSection = 'BUTTON'
  end
  object sGroupBox3: TsGroupBox
    Left = 0
    Top = 0
    Width = 357
    Height = 89
    Align = alTop
    Caption = 'Parameter Genetik '
    TabOrder = 3
    SkinData.SkinSection = 'GROUPBOX'
    object sLabel3: TsLabel
      Left = 13
      Top = 27
      Width = 72
      Height = 13
      SkinSection = 'LABEL'
      Caption = 'Target Fitness '
    end
    object sLabel4: TsLabel
      Left = 13
      Top = 54
      Width = 58
      Height = 13
      SkinSection = 'LABEL'
      Caption = 'Max. Iterasi'
    end
    object EdTgFitness: TsEdit
      Left = 90
      Top = 24
      Width = 51
      Height = 21
      Color = 16380653
      NumbersOnly = True
      TabOrder = 0
      Text = '0'
      OnChange = EdTgFitnessChange
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
    object EdMaxIterasi: TsEdit
      Left = 90
      Top = 51
      Width = 51
      Height = 21
      Color = 16380653
      NumbersOnly = True
      TabOrder = 1
      Text = '0'
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
    object Panel1: TPanel
      Left = 157
      Top = 17
      Width = 194
      Height = 59
      TabOrder = 2
      object sLabel1: TsLabel
        Left = 12
        Top = 9
        Width = 100
        Height = 13
        SkinSection = 'LABEL'
        Caption = 'Prob. Crossover (%)'
      end
      object sLabel2: TsLabel
        Left = 12
        Top = 36
        Width = 82
        Height = 13
        SkinSection = 'LABEL'
        Caption = 'Prob. Mutasi (%)'
      end
      object EdPbCross: TsEdit
        Left = 118
        Top = 6
        Width = 51
        Height = 21
        Color = 16380653
        NumbersOnly = True
        TabOrder = 0
        Text = '0'
        OnChange = EdPbCrossChange
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
      object sUpDown1: TsUpDown
        Left = 169
        Top = 6
        Width = 16
        Height = 21
        Associate = EdPbCross
        TabOrder = 1
      end
      object EdPbMutasi: TsEdit
        Left = 118
        Top = 33
        Width = 51
        Height = 21
        Color = 16380653
        NumbersOnly = True
        TabOrder = 2
        Text = '0'
        OnChange = EdPbMutasiChange
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
      object sUpDown2: TsUpDown
        Left = 169
        Top = 33
        Width = 16
        Height = 21
        Associate = EdPbMutasi
        TabOrder = 3
      end
    end
  end
end
