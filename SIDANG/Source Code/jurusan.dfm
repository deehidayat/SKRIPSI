object FrmJurusan: TFrmJurusan
  Left = 0
  Top = 0
  Caption = 'Jurusan'
  ClientHeight = 407
  ClientWidth = 518
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inline FrmDML: TFrmDML
    Left = 0
    Top = 65
    Width = 518
    Height = 342
    Align = alClient
    TabOrder = 1
    ExplicitTop = 65
    ExplicitWidth = 518
    ExplicitHeight = 342
    inherited Panel1: TsPanel
      Width = 518
      ExplicitWidth = 518
      inherited BtnSearch: TsSpeedButton
        Left = 407
        ExplicitLeft = 407
      end
      inherited sLabel1: TsLabel
        Left = 483
        ExplicitLeft = 483
      end
      inherited sLabel2: TsLabel
        Left = 501
        ExplicitLeft = 501
      end
      inherited sLabel3: TsLabel
        Left = 493
        ExplicitLeft = 493
      end
      inherited EdtSearch: TsEdit
        Left = 328
        Width = 72
        Height = 21
        ExplicitLeft = 328
        ExplicitWidth = 72
        ExplicitHeight = 21
      end
    end
    inherited DBGrid: TsDBGrid
      Width = 518
      Height = 311
      Columns = <
        item
          Expanded = False
          FieldName = 'jid'
          Width = -1
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'kode'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jurusan'
          Width = 200
          Visible = True
        end>
    end
    inherited DSource: TDataSource
      DataSet = FrmDataModul.TblJurusan
      Left = 269
      Top = 91
    end
    inherited ImageListDML: TImageList
      Bitmap = {
        494C01010B001400140010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
        0000000000003600000028000000400000003000000001002000000000000030
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000007A7A7A00000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000004D5C7300000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000F5CA9900F6D1A100F5CB9900F3C18B00F2C08800F3C38E00000000000000
        00000000000000000000000000000000000000000000A1A1A100797979000000
        0000000000000000000079797900B1B1B100AFAFAF00A0A0A000999999009393
        930095959500797979000000000000000000000000002B92FF000E67C9000000
        000000000000000000000E90C90059C1E90055C0E9003CB5E50031B0E20028AB
        E0002AADE1000E90C90000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000000FCF0
        CC00FEF6D500FCE6BE00F6D5A600FCC69600FFC49500FDD6AE00FFE2BF00FEE2
        BA00F4C5900000000000000000000000000000000000ABABAB00A0A0A0008888
        88000000000079797900B4B4B400BFBFBF00B6B6B600A3A3A3009B9B9B009292
        920090909000969696007979790000000000000000003DA9FF002A92FF005E68
        7F00000000000E90C90058CEF20072CCEF0063C6EB0041B7E60033B2E30026AA
        E00024A7DE002CADE2000E90C900000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000000FEFB
        DD00FEF9D800FCE4BB00F0D6A700BBC888009CBD6F0043A7360072BA5E00EFF6
        D400FDEECC00F2BF890000000000000000000000000000000000000000009C9C
        9C00767676007A7A7A00AAAAAA00BFBFBF00BFBFBF00B7B7B700AAAAAA009C9C
        9C0098989800969696007979790000000000000000000000000000000000238E
        FF0025629D00257EA500899AA100BAA7A300AAABB20063C9EE004AC1EB0034B5
        E6002EB1E3002CAFE2000E90C900000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000F1B87F00F6D0
        A100FDF4D100FDEBC500FCDBB30044AB3800009402000E9A0F0010970B0057B6
        4E00FEF5DB00F4C28C000000000000000000000000000000000000000000ABAB
        AB00CAB8CA00B6B6B600E5E5E500ECECEC00E8E8E800AEAEAE00B2B2B200A2A2
        A2009E9E9E009A9A9A0079797900000000000000000000000000000000003DA9
        FF00B7A8C000BDA38900F6F0C600FFFFCF00FAF4CA008B9CA90057C9EF003BBC
        EA0035B7E70030B2E5000E90C900000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000F2BD8700F1BA
        8100F3C18A00F8D5A600FFE1BE0047AD3A000088000084CD8500FFF4EF0063B5
        5200B6C07900FDC08D0000000000000000000000000000000000000000009696
        9600C2ABC200D5D5D500EBEBEB00F3F3F300FAFAFA00FDFDFD00AEAEAE00AEAE
        AE00AAAAAA00A3A3A30079797900000000000000000000000000000000006984
        9300D1949400F6D79E00FFFECB00FFFFE000FFFFF300FFFFFA00AA968A004DCB
        F20047C6EF003EBDEA000E90C900000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000F5C49200F5C7
        9600F4C39000F4BE8900FCC5960093C47B005CB95C0089CB8300FFFFFF00F7FE
        FC00CBCA9200F6BC85000000000000000000000000000000000000000000AFAF
        AF00D0D0D000CDCDCD00EAEAEA00F5F5F500FDFDFD00F3F3F300CECECE00B4B4
        B400B0B0B000A9A9A9007979790000000000000000000000000000000000B880
        7E00E7CA9F00F2C78F00FFFBC900FFFFE500FFFFFB00FFFFE000D5CBAB0056D1
        F60050CEF30045C4EE000E90C900000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000F9D0A800FBD2
        AD00FAD0A900FACEA600F6CDA100D0DFB800FFFFFF00E2F2DF0071C26E0066C0
        6600C8CB9200FAC18E000000000000000000000000000000000000000000AFAF
        AF00D4D4D400B9B9B900CECECE00EDEDED00EEEEEE00EEEEEE00D3D3D300BEBE
        BE00BBBBBB00B3B3B3007979790000000000000000000000000000000000B880
        7E00EDD0A400EAA96A00F3CB9100FFFFD100FFFFD300FFFFD300DDD4B10066DE
        FB0060DAFA0055D0F4000E90C900000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000F8D4A800FDDEBF00FDDE
        BE00FDDBBB00FDDBBB00FFDEC50078BB610098D49800E7F5E6003EAD3B00008A
        00009AC17600FFCCA600F2BE8700000000000000000000000000000000009696
        9600C4BBC400DCDCDC00CACACA00DDDDDD00E6E6E600ECECEC00CFCFCF00C1C1
        C100BFBFBF00B8B8B80079797900000000000000000000000000000000006984
        9300D5A79500F6DAAF00F0C48A00F8E5AF00FCF4C100FFFFCF00E6C99F006AE2
        FE0068E0FC005CD7F7000E90C900000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000F8D4A800FFEFD100FEEA
        CB00FEE9C900FEE7C800FFE7C900E2E2BE00169A14002BA12900089708000092
        000090C47800FFD9BC00F2BE8700000000000000000000000000000000000000
        000000000000D8D8D800E9E9E900D7D7D700DADADA00B5B5B500CDCDCD00C1C1
        C100C1C1C100BFBFBF0079797900000000000000000000000000000000000000
        000000000000D9CAC000FEF4C900FCDE9E00FCE2A500AB9999008BE2F7006BE2
        FE006BE2FE0067DEFC000E90C900000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FBE5BD00FFFCDF00FFF7
        D800FFF6D600FFF4D500FFF3D200FFF5DC00C5DFAD0042AB3B0043AE3B00AFD7
        9E00C5DCAA00FFE7C900F5C79300000000000000000000000000000000000000
        0000000000007C7C7C00AAAAAA00C6C6C600C4C4C400DEDEDE00D0D0D000C1C1
        C100C1C1C100BFBFBF0079797900000000000000000000000000000000000000
        0000000000003A738E00A1908800D3B29C00CAA99E00AFEAFC008BE7FE006BE2
        FE006BE2FE0068E0FC000E90C900000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FDF3D100FFFFE100FFFC
        DD00FFFDDE00FFFCDD00FFFCDE00FFFDDE00FFFFE800FFFFF000FFFFED00FFFF
        E700FFFAE000FFF7D700F6CE9D00000000000000000000000000000000000000
        00000000000079797900C7C7C700EAEAEA00EBEBEB00E0E0E000D0D0D000C1C1
        C100C1C1C100BFBFBF0079797900000000000000000000000000000000000000
        0000000000000E90C90078E3FC00C9F0FF00CCF0FF00B0EDFF008CE7FE006BE2
        FE006BE2FE0068E0FC000E90C900000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FEF7D700FFFFE500FFFF
        E200FFFFE200FFFFE300FFFEE000FEF8D800FAE3B600F7CE9500F7CF9700F9E1
        B600FEF5D200FFFFE500F6D5A700000000000000000000000000000000000000
        00000000000079797900C7C7C700EFEFEF00EFEFEF00E0E0E000D0D0D000C4C4
        C400C5C5C500C0C0C00079797900000000000000000000000000000000000000
        0000000000000E90C90079E5FC00D7F7FF00D5F4FF00B0EEFF008CE9FE0070E6
        FF0072E7FF0069E1FC000E90C900000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000F7D8AB00FAE6C000FAE5
        BE00F9E1B900F8DAAE00F6CD9800F3BE8000F0B16A00F0B06700F0B37000F4BE
        8800FBCE9E00FDDDB400FBCEA000000000000000000000000000000000000000
        000000000000797979008D8D8D00B0B0B000BBBBBB00C3C3C300C0C0C000ABAB
        AB009E9E9E008A8A8A0079797900000000000000000000000000000000000000
        0000000000000E90C90025A4D4005CBFE2006DC9EA007AD1F00074D1EF004EC2
        E70039B7E20020A3D5000E90C900000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000F1B66F00F3BD8200F9CB
        9B00FBCD9F00FBCB9B00FBCB9B00000000000000000000000000000000000000
        00000000000079797900CCCCCC00E7E7E700E0E0E000D2D2D200CCCCCC00C7C7
        C700C8C8C800AEAEAE0079797900000000000000000000000000000000000000
        0000000000000E90C9008CD8F200C2F7FF00B1F3FF0090EBFF0082EAFF0077EA
        FF0078EDFF004ECBEF000E90C900000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000000FBCE
        9F00FBCE9F00FBCE9F0000000000000000000000000000000000000000000000
        0000000000000000000000000000777777007A7A7A007D7D7D007D7D7D007B7B
        7B00787878000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000C8FC9000F92CA001295CB001295CB001092
        CA000D8FC7000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000955A1000857A6000557AA000655A7000954A0000954A0000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000955A1000857A6000557AA000655A7000954A0000954A0000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000872
        DD000362C300006CDB000877E700117DEA000877E7000069DD00005DC7000654
        A5000654A5000000000000000000000000000000000000000000000000000872
        DD000362C300006CDB000877E700117DEA000877E7000069DD00005DC7000654
        A5000654A5000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000000000000F6BC9000872
        DD003E99F50091C4F900D6E9FD00EEF7FF00E4F1FF00B0D4FB0059A5F5000570
        E500035AB7000B509500000000000000000000000000000000000F6BC9000872
        DD003E99F50091C4F900D6E9FD00EEF7FF00E4F1FF00B0D4FB0059A5F5000570
        E500035AB7000B50950000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        9A0000009A000000000000000000000000000000000000000000000000000000
        9A0000009A00000000000000000000000000000000001278E000127CE80070B4
        F900F6FAFE00FFFFFF00EEF6FD00D3E6FB00E2EEFD00FFFFFF00FFFFFF00AED2
        FA000E78ED00025AB6000653A20000000000000000001278E000127CE80070B4
        F900F6FAFE00FFFFFF00EEF6FD00D3E6FB00E2EEFD00FFFFFF00FFFFFF00AED2
        FA000E78ED00025AB6000653A200000000000000000000000000000000000000
        00000000000021A3350000660000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000009A001645
        FF001444FF0000009A000000000000000000000000000000000000009A000030
        FF000030FF0000009A000000000000000000000000001278E0006DB2F900FEFE
        FF00F4F9FE0077B6F6003391F000B5D5F9001B7FEA004693EE00C9E0FA00FFFF
        FF00B0D5FA000970E6000653A20000000000000000001278E0006DB2F900FEFE
        FF00E9F3FD001E7FF0000D73ED001474EB00066BE9000C6FE80089B9F400E6F0
        FD00B0D5FA000970E6000653A200000000000000000000000000000000000000
        00000066000012A9200028B04000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000009A001A4B
        FF001746FF000E30E40000009A00000000000000000000009A000129EF00002E
        FF000030FF0000009A0000000000000000000B70D5003695F400E8F3FE00FFFF
        FF004FA3F6001F88F200D4E7FC00FFFFFF00489BEF000065E6000E74E800C9E1
        FA00FFFFFF0058A5F500005EC7000858AB000B70D5003695F400E8F3FE00FFFF
        FF0089BAF4008FC0F9002A86F1001075EE001275EC001E79EC0084B5F40089BA
        F400FFFFFF0058A5F500005EC7000858AB000000000000000000000000001F99
        31002EC04A001FB5340019AF2B0025AE3C000066000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        9A001A40EF001948FF001848FF0000009A0000009A00002FFF00002EFF000324
        E50000009A00000000000000000000000000137AE30071B5FB00FFFFFF00B2D7
        FC00469FF700DEEEFD00FDFEFE00E0EEFD00A1CCF8000173E900006AE7004294
        ED00FFFFFF00B3D7FB00016BDE000858AB00137AE30071B5FB00FFFFFF00B2D7
        FC00278CF90092C4FB00DAEAFD00318BF300388DF200D7E8FC0087B8F5000D71
        EA00E6F0FD00B3D7FB00016BDE000858AB000000000000000000006600003FCE
        630037C8570025A63B000066000014AC250024AD3A0000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000009A001E4EFF001B4AFF000E38F6000431FD00002EFF000030FF000000
        9A00000000000000000000000000000000001F85EC00A2CFFD00FFFFFF0071B7
        FD00ACD4FD00FAFCFF0066AFF8003F9AF500E2EFFD002D8EF0000075EB000575
        E900E2EEFC00E6F3FF000E7BE900065AB0001F85EC00A2CFFD00FFFFFF00419E
        FD003495FB00298DF90092C5FB00E6F1FE00E5F1FD0088BCF7001075EE000B70
        EB00B4D2F800E6F3FF000E7BE900065AB000000000000066000059E2890050DB
        7B0036BC5500000000000000000000660000148D210021AB3600006600000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000009A001B45F5001342FF000F3EFF000830F00000009A000000
        0000000000000000000000000000000000002F8FF100B7DAFD00FFFFFF006BB4
        FF003C9DFE004FA5FB001D8AF8001484F500A0CDFB0084BDF800067AEF000374
        EB00D4E8FB00F0F8FF001A82EC00055CB5002F8FF100B7DAFD00FFFFFF00419F
        FF003196FE003094FC00469EFC00F1F8FE00F1F8FE003892F500187DF1001378
        EF009FC9F700F0F8FF001A82EC00055CB500000000000066000031B04D003ABF
        5B00006600000000000000000000000000000000000018AE290020AA34000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000009A001F4DFC001A48FF001544FF00143CF00000009A000000
        0000000000000000000000000000000000003693F000B8DAFE00FFFFFF008EC6
        FF002391FF002E95FE002B93FC00218CF9002D92F7009ACAFB001D86F2001D86
        F000F3F8FE00D9EBFE00117DE900095CB2003693F000B8DAFE00FFFFFF0059AC
        FF003499FF0055A9FE00E8F3FF0085BFFD0083BDFC00E7F2FE004498F6001A7F
        F200D3E6FC00D9EBFE00117DE900095CB2000000000000000000000000000000
        00000000000000000000000000000000000000000000000000000066000014AB
        2400006600000000000000000000000000000000000000000000000000000000
        000000009A003160FF002B5AFF002047F1001F46F100204FFF001F4FFF000000
        9A00000000000000000000000000000000002689ED00AFD6FD00FFFFFF00E1F0
        FF003499FF002F96FF003399FF002E94FD00218CF90050A4F900419BF7007DBB
        F800FFFFFF0099C9FA000773E1000958AB002689ED00AFD6FD00FFFFFF00C3E1
        FF004AA4FF00EDF6FF0081C0FF003296FE002E93FC007BBAFD00EBF5FE0059A5
        F800E9F3FE0099C9FA000773E1000958AB000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000066
        0000118D1D000000000000000000000000000000000000000000000000000000
        9A00325EF7003361FF003365FF0000009A0000009A002656FF002251FF001840
        EF0000009A00000000000000000000000000000000003994F000F1F8FF00FFFF
        FF00ADD6FF003499FF002592FF002893FF00238FFC001788FA006FB4FA00F4FA
        FF00F5FAFE0049A0F700076ACE0000000000000000003994F000F1F8FF00FBFD
        FF0078BBFF0061AFFF003499FF003499FF003398FF003095FD0068B0FC00F4FA
        FF00F5FAFE0049A0F700076ACE00000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000006600000066000000000000000000000000000000009A004172
        FF003E6DFF002A4CE40000009A00000000000000000000009A001D40E4002452
        FF002353FF0000009A000000000000000000000000003994F000CDE6FF00F6FA
        FF00FFFFFF00E0EFFF008DC6FF006EB6FE0079BBFF00B6DAFE00FFFFFF00FFFF
        FF0078B9F900137BE600076ACE0000000000000000003994F000CDE6FF00F6FA
        FF00FBFDFF00C1DFFF0058ABFF0043A0FF0049A3FF0084C1FE00FBFDFF00FFFF
        FF0078B9F900137BE600076ACE00000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000009A004576
        FF004475FF0000009A000000000000000000000000000000000000009A00295A
        FF002758FF0000009A000000000000000000000000000000000064ACF600D4EA
        FF00F9FCFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7F3FE0077B8
        FA001D85ED000D6DD0000000000000000000000000000000000064ACF600D4EA
        FF00F9FCFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7F3FE0077B8
        FA001D85ED000D6DD00000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        9A0000009A000000000000000000000000000000000000000000000000000000
        9A0000009A00000000000000000000000000000000000000000000000000459A
        F000A7D2FC00D8ECFF00E2F1FF00E4F1FE00D1E7FE009DCDFD004DA2F700177F
        E800177FE800000000000000000000000000000000000000000000000000459A
        F000A7D2FC00D8ECFF00E2F1FF00E4F1FE00D1E7FE009DCDFD004DA2F700177F
        E800177FE8000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000003B94F00061ABF60065ADF700489EF4002286EC00127AE4000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000003B94F00061ABF60065ADF700489EF4002286EC00127AE4000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000072000000720000006B000000660000006500000065000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000072000000720000006B000000660000006500000065000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000072000000720000006B000000660000006500000065000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000955A1000857A6000557AA000655A7000954A0000954A0000000
        0000000000000000000000000000000000000000000000000000000000000001
        B7000001B700050DAC00393EB000585AB2005657AB002E2F900000006F000000
        6900000069000000000000000000000000000000000000000000000000000001
        B7000001B700050DAC00393EB000585AB2005657AB002E2F900000006F000000
        6900000069000000000000000000000000000000000000000000000000000001
        B7000001B700050DAC00393EB000585AB2005657AB002E2F900000006F000000
        6900000069000000000000000000000000000000000000000000000000000872
        DD000362C300006CDB000877E700117DEA000877E7000069DD00005DC7000654
        A5000654A50000000000000000000000000000000000000000000016CE000915
        C6006C74D900CED1F200FFFFFF00FFFFFF00FFFFFF00FFFFFF00C1C2DF005A5A
        9F000101690000007D00000000000000000000000000000000000016CE000915
        C6006C74D900CED1F200FFFFFF00FFFFFF00FFFFFF00FFFFFF00C1C2DF005A5A
        9F000101690000007D00000000000000000000000000000000000016CE000915
        C6006C74D900CED1F200FFFFFF00FFFFFF00FFFFFF00FFFFFF00C1C2DF005A5A
        9F000101690000007D00000000000000000000000000000000000F6BC9000872
        DD003E99F50091C4F900D6E9FD00EEF7FF00E4F1FF00B0D4FB0059A5F5000570
        E500035AB7000B5095000000000000000000000000000018DF000A1DD300A8B0
        ED00FFFFFF00FFFFFF00BDBEE9008C8CD1008D8DD000CACAEA00FFFFFF00FFFF
        FF008C8CBD00010169000000720000000000000000000018DF000A1DD300A8B0
        ED00FFFFFF00FFFFFF00BDBEE9008C8CD1008D8DD000CACAEA00FFFFFF00FFFF
        FF008C8CBD00010169000000720000000000000000000018DF000A1DD300A8B0
        ED00FFFFFF00FFFFFF00BDBEE9008C8CD1008D8DD000CACAEA00FFFFFF00FFFF
        FF008C8CBD00010169000000720000000000000000001278E000127CE80070B4
        F900F6FAFE00FFFFFF00EEF6FD00D3E6FB00E2EEFD00FFFFFF00FFFFFF00AED2
        FA000E78ED00025AB6000653A20000000000000000000018DF00919DEF00FFFF
        FF00E6E8F9004F53CE000002AB0000009D0000009500000097005F5FBE00F0F0
        FA00FFFFFF006565A6000000720000000000000000000018DF00919DEF00FFFF
        FF00E6E8F9005054CE000B0DAF00242AC2001C1EB200000097005F5FBE00F0F0
        FA00FFFFFF006565A6000000720000000000000000000018DF00919DEF00FFFF
        FF00E6E8F9004F53CE000002AB00161DBE001A1CB100000097005F5FBE00F0F0
        FA00FFFFFF006565A6000000720000000000000000001278E0006DB2F900FEFE
        FF00E9F3FD001E7FF0000D73ED001474EB00066BE9000C6FE80089B9F400E6F0
        FD00B0D5FA000970E6000653A20000000000001EF1002743E700FBFBFF00F7F8
        FD003B4BDA000000C000161DBE00B0B4E700A3A5E0000A0CA00000008F005252
        B900FFFFFF00D9D9E9000B0B7F0000007A00001EF1002743E700FBFBFF00F7F8
        FD003C4BD9001617C4003438C3001214B000171BB100090B9F002323A1005E5E
        BE00FFFFFF00D9D9E9000B0B7F0000007A00001EF1002743E700FBFBFF00F7F8
        FD003B4BDA000000C000161DBE001619B4000B0CA100090B9F0000008F005252
        B900FFFFFF00D9D9E9000B0B7F0000007A000B70D5003695F400E8F3FE00FFFF
        FF002185F5006CADF700D0E4FC00E3EFFD00D1E4FB0062A2F2000469E80089BA
        F400FFFFFF0058A5F500005EC7000858AB00001EF1007287F600FFFFFF0091A1
        F400000DDA00000BD000161DCB00F1F4FE00DEE1F6000508A90000009A000000
        9300ACACDD00FFFFFF005353AF0000007A00001EF1007287F600FFFFFF0091A1
        F4000A15D7000E12B900191DB6001114AE002C30BB001D20B20010119A002323
        A300ADADDD00FFFFFF005353AF0000007A00001EF1007287F600FFFFFF0091A1
        F400000DDA00000BD000161DCB001D1EAE000C0DA0000609A70000009A000000
        9300ACACDD00FFFFFF005353AF0000007A00137AE30071B5FB00FFFFFF00B2D7
        FC00278CF900F1F7FE006CAEF7002C88F2006DACF500EFF6FE004F97F1000D71
        EA00E6F0FD00B3D7FB00016BDE000858AB000023F800A8B8FC00FFFFFF004060
        F6001734EC00A0AEF200BABEF100F8F9FE00F3F4FB00B6B8E9009799DC000D0E
        A2005A5BBF00FFFFFF008487D600000079000023F800A8B8FC00FFFFFF004060
        F6008794F200FDFDFE00F3F4FB00F2F2FA00F2F3FA00FFFFFF00FFFFFF001214
        A7006061C200FFFFFF008487D600000079000023F800A8B8FC00FFFFFF004060
        F6001734EC00F8F9FE00F8F9FE00F8F9FE00F3F4FB00F3F4FB00F3F4FB000D0E
        A2005A5BBF00FFFFFF008487D600000079001F85EC00A2CFFD00FFFFFF00419E
        FD00C6E1FE008BC1FC002A8DF7001F84F5001A7FF30088BCF700C1DBFB000B70
        EB00B4D2F800E6F3FF000E7BE900065AB0000E3EFE00C5CFFE00FFFFFF003259
        FE002649F900FAFCFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EBECF9001519
        B1004A4FC100FFFFFF009094D9000000A2000E3EFE00C5CFFE00FFFFFF003259
        FE00294AF800A7B0F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00262DD5001320
        CB008186D600FFFFFF009094D9000000A2000E3EFE00C5CFFE00FFFFFF003259
        FE002649F900C5CFFD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EBECF9001519
        B1004A4FC100FFFFFF009094D9000000A2002F8FF100B7DAFD00FFFFFF00419F
        FF00D9ECFF0068B1FD002B90FB007BB9FB002186F6002C8BF50061A6F5001378
        EF009FC9F700F0F8FF001A82EC00055CB5003C63FF00C4D0FF00FFFFFF005979
        FF00052EFF00375CFB00586DF400F0F3FE00E3E6FA004D5ADE003446D2000004
        B700757CD600FFFFFF00797DD5000000A8003C63FF00C4D0FF00FFFFFF005979
        FF00052EFF00173DFD00C3C9F800FFFFFF00FFFFFF001D2DDC000B1ED900303C
        D6008C92DE00FEFEFF00797DD5000000A8003C63FF00C4D0FF00FFFFFF005979
        FF00052EFF00123AFE00122EEB000D24E2000719D9000F17D1000004B7000004
        B700757CD600FFFFFF00797DD5000000A8003693F000B8DAFE00FFFFFF0059AC
        FF00AAD4FF00B7DBFF003095FD00FFFFFF00C5E0FD0051A1F9001F84F4001A7F
        F200D3E6FC00D9EBFE00117DE900095CB200103EFF00B6C5FF00FFFFFF00C7D2
        FF00032CFF000020FF001739FB00F3F6FF00E1E5FA00071FDC000007CE000C1C
        CB00D9DCF500FDFDFE00313CC8000000A800103EFF00B6C5FF00FFFFFF00C7D2
        FF00032CFF000020FF002C48FE00C4CBFA00374AE7001A2CDE001D29D900222E
        D100D3D6F400FDFDFE00313CC8000000A800103EFF00B6C5FF00FFFFFF00C7D2
        FF00032CFF000020FF000829FE001630EB000119E2000517D9000A11D0000C1C
        CB00D9DCF500FDFDFE00313CC8000000A8002689ED00AFD6FD00FFFFFF00C3E1
        FF0048A3FF00D9ECFF00E1F0FF00FFFFFF00FFFFFF00FFFFFF007EBAFB00449A
        F700E9F3FE0099C9FA000773E1000958AB00000000008DA4FF00FFFFFF00FFFF
        FF008AA0FF000027FF00002CFF00466AFF004163F800001DE900061CDF00A1AC
        F100FFFFFF00B4BAED000007BB0000000000000000008DA4FF00FFFFFF00FFFF
        FF008AA0FF000027FF00012CFF000424FF001C3EFB00001DE900061CDF009EA9
        F100FFFFFF00B4BAED000007BB0000000000000000008DA4FF00FFFFFF00FFFF
        FF008AA0FF000027FF00012CFF000424FF001C3EFB00001DE900061CDF00A1AC
        F100FFFFFF00B4BAED000007BB0000000000000000003994F000F1F8FF00FBFD
        FF0078BBFF003499FF003499FF00FFFFFF00F4F9FF009CCCFE003E9AFB00F4FA
        FF00F5FAFE0049A0F700076ACE000000000000000000718DFF00DAE1FF00FFFF
        FF00FFFFFF00B1C0FF003B5DFF001538FF001739FE004966F800C0CAFA00FFFF
        FF00EDEFFC003041D3000007BB000000000000000000718DFF00DAE1FF00FFFF
        FF00FFFFFF00B1C0FF003B5DFF001538FF001739FE004966F800C0CAFA00FFFF
        FF00EDEFFC003041D3000007BB000000000000000000718DFF00DAE1FF00FFFF
        FF00FFFFFF00B1C0FF003B5DFF001538FF001739FE004966F800C0CAFA00FFFF
        FF00EDEFFC003041D3000007BB0000000000000000003994F000CDE6FF00F6FA
        FF00FBFDFF00C1DFFF0058ABFF00C6E2FF0049A3FF0084C1FE00FBFDFF00FFFF
        FF0078B9F900137BE600076ACE0000000000000000000000000088A0FF00E6EB
        FF00FFFFFF00FFFFFF00FDFDFF00E2E9FF00E4EBFF00FFFFFF00FFFFFF00DBE0
        FA003D50E000000BCC000000000000000000000000000000000088A0FF00E6EB
        FF00FFFFFF00FFFFFF00FDFDFF00E2E9FF00E4EBFF00FFFFFF00FFFFFF00DBE0
        FA003D50E000000BCC000000000000000000000000000000000088A0FF00E6EB
        FF00FFFFFF00FFFFFF00FDFDFF00E2E9FF00E4EBFF00FFFFFF00FFFFFF00DBE0
        FA003D50E000000BCC000000000000000000000000000000000064ACF600D4EA
        FF00F9FCFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7F3FE0077B8
        FA001D85ED000D6DD00000000000000000000000000000000000000000008AA1
        FF00BAC7FE00E8ECFF00FFFFFF00FFFFFF00FFFFFF00E4E9FE00889BF6001738
        E600000BCC000000000000000000000000000000000000000000000000008AA1
        FF00BAC7FE00E8ECFF00FFFFFF00FFFFFF00FFFFFF00E4E9FE00889BF6001738
        E600000BCC000000000000000000000000000000000000000000000000008AA1
        FF00BAC7FE00E8ECFF00FFFFFF00FFFFFF00FFFFFF00E4E9FE00889BF6001738
        E600000BCC00000000000000000000000000000000000000000000000000459A
        F000A7D2FC00D8ECFF00E2F1FF00E4F1FE00D1E7FE009DCDFD004DA2F700177F
        E800177FE8000000000000000000000000000000000000000000000000000000
        0000000000008AA0FF008AA3FF0090A6FF007993FE004A6BF9001A40EF000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000008AA0FF008AA3FF0090A6FF007993FE004A6BF9001A40EF000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000008AA0FF008AA3FF0090A6FF007993FE004A6BF9001A40EF000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000003B94F00061ABF60065ADF700489EF4002286EC00127AE4000000
        000000000000000000000000000000000000424D3E000000000000003E000000
        2800000040000000300000000100010000000000800100000000000000000000
        000000000000000000000000FFFFFF00FFFFBFFFBFFF0000F03F9C039C030000
        E007880188010000E003E001E0010000C003E001E0010000C003E001E0010000
        C003E001E0010000C003E001E00100008001E001E00100008001F801F8010000
        8001F801F80100008001F801F80100008001F801F80100008001F801F8010000
        FF81F801F8010000FFE3FE07FE070000F81FF81FFFFFFFFFE007E007FFFFFFFF
        C003C003FFFFE7E780018001F9FFC3C380018001F1FFC18300000000E07FE007
        00000000C07FF00F00000000861FF81F00000000879FF81F00000000FFC7F00F
        00000000FFE7E00780018001FFF9C18380018001FFFFC3C3C003C003FFFFE7E7
        E007E007FFFFFFFFF81FF81FFFFFFFFFF81FF81FF81FF81FE007E007E007E007
        C003C003C003C003800180018001800180018001800180010000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000080018001800180018001800180018001C003C003C003C003
        E007E007E007E007F81FF81FF81FF81F00000000000000000000000000000000
        000000000000}
    end
  end
  object Panel1: TsPanel
    Left = 0
    Top = 0
    Width = 518
    Height = 65
    Margins.Left = 0
    Margins.Right = 0
    Align = alTop
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object Label2: TsLabel
      Left = 140
      Top = 5
      Width = 81
      Height = 16
      Alignment = taRightJustify
      BiDiMode = bdRightToLeft
      Caption = 'Nama Jurusan'
      ParentBiDiMode = False
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 14603725
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object Label1: TsLabel
      Left = 11
      Top = 2
      Width = 76
      Height = 16
      BiDiMode = bdRightToLeft
      Caption = 'Kode Jurusan'
      ParentBiDiMode = False
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 14603725
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object DBEdit2: TsDBEdit
      Left = 140
      Top = 24
      Width = 220
      Height = 24
      Color = 16380653
      DataField = 'jurusan'
      DataSource = FrmDML.DSource
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
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
    object DBEdit1: TsDBEdit
      Left = 11
      Top = 24
      Width = 116
      Height = 24
      Hint = 'DDDD'
      Color = 16380653
      DataField = 'kode'
      DataSource = FrmDML.DSource
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
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
  end
end
