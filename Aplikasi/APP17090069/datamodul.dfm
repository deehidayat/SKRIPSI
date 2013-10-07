object FrmDataModul: TFrmDataModul
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 411
  Width = 471
  object DB: TZConnection
    Protocol = 'sqlite-3'
    HostName = 'localhost'
    Database = 'libs\bsc.db'
    User = 'root'
    Connected = True
    Left = 64
    Top = 32
  end
  object TblJurusan: TZTable
    Connection = DB
    SortedFields = 'jurusan'
    BeforeDelete = TblJurusanBeforeDelete
    TableName = 'jurusan'
    IndexFieldNames = 'jurusan Asc'
    Left = 264
    Top = 80
    object TblJurusanjid: TIntegerField
      FieldName = 'jid'
      Visible = False
    end
    object TblJurusankode: TWideStringField
      DisplayLabel = 'Kode Jurusan'
      DisplayWidth = 10
      FieldName = 'kode'
      Required = True
      Size = 10
    end
    object TblJurusanjurusan: TWideStringField
      DisplayLabel = 'Nama Jurusan'
      DisplayWidth = 50
      FieldName = 'jurusan'
      Required = True
      Size = 255
    end
  end
  object TblMatapelajaran: TZTable
    Connection = DB
    SortedFields = 'kode;matapelajaran;'
    BeforeDelete = TblMatapelajaranBeforeDelete
    TableName = 'matapelajaran'
    IndexFieldNames = 'kode Asc;matapelajaran Asc; Asc'
    Left = 408
    Top = 80
    object TblMatapelajaranmpid: TIntegerField
      FieldName = 'mpid'
      Visible = False
    end
    object TblMatapelajarankode: TWideStringField
      DisplayLabel = 'Kode'
      DisplayWidth = 10
      FieldName = 'kode'
      Required = True
      Size = 10
    end
    object TblMatapelajaranmatapelajaran: TWideStringField
      DisplayLabel = 'Mata Pelajaran'
      DisplayWidth = 50
      FieldName = 'matapelajaran'
      Required = True
      Size = 255
    end
  end
  object TblPengajar: TZTable
    Connection = DB
    SortedFields = 'pengajar'
    BeforeDelete = TblPengajarBeforeDelete
    TableName = 'pengajar'
    IndexFieldNames = 'pengajar Asc'
    Left = 336
    Top = 80
    object TblPengajarpid: TIntegerField
      FieldName = 'pid'
      Visible = False
    end
    object TblPengajarkode: TWideStringField
      DisplayLabel = 'Kode Pengajar'
      DisplayWidth = 10
      FieldName = 'kode'
      Required = True
      Size = 10
    end
    object TblPengajarpengajar: TWideStringField
      DisplayLabel = 'Nama Pengajar'
      DisplayWidth = 50
      FieldName = 'pengajar'
      Required = True
      Size = 255
    end
  end
  object TblRuangan: TZTable
    Connection = DB
    SortedFields = 'ruangan'
    TableName = 'ruangan'
    IndexFieldNames = 'ruangan Asc'
    Left = 16
    Top = 336
    object TblRuanganrid: TIntegerField
      FieldName = 'rid'
      Visible = False
    end
    object TblRuanganruangan: TWideStringField
      DisplayLabel = 'Ruangan'
      DisplayWidth = 50
      FieldName = 'ruangan'
      Required = True
      Size = 255
    end
    object TblRuangantingkat_1: TSmallintField
      DisplayLabel = 'Tingkat X'
      FieldName = 'tingkat_1'
    end
    object TblRuangantingkat_2: TSmallintField
      DisplayLabel = 'Tingkat XI'
      FieldName = 'tingkat_2'
    end
    object TblRuangantingkat_3: TSmallintField
      DisplayLabel = 'Tingkat XII'
      FieldName = 'tingkat_3'
    end
    object TblRuanganenabled: TSmallintField
      DisplayLabel = 'Aktif'
      FieldName = 'enabled'
    end
  end
  object TblKegiatan: TZTable
    Connection = DB
    SortedFields = 'tingkatid;jid;kelasid;pid;'
    TableName = 'kegiatan'
    IndexFieldNames = 'tingkatid Asc;jid Asc;kelasid Asc;pid Asc; Asc'
    Left = 360
    Top = 144
    object TblKegiatankid: TIntegerField
      FieldName = 'kid'
      Visible = False
    end
    object TblKegiatantingkatid: TIntegerField
      FieldName = 'tingkatid'
      Required = True
    end
    object TblKegiatanjid: TIntegerField
      DisplayLabel = 'Jurusan'
      DisplayWidth = 200
      FieldName = 'jid'
      LookupDataSet = TblJurusan
      LookupKeyFields = 'jid'
      LookupResultField = 'jurusan'
      Required = True
    end
    object TblKegiatankelasid: TIntegerField
      DisplayLabel = 'Kelas'
      FieldName = 'kelasid'
    end
    object TblKegiatanmpid: TIntegerField
      DisplayLabel = 'Mata Pelajaran'
      DisplayWidth = 200
      FieldName = 'mpid'
      Required = True
    end
    object TblKegiatanpid: TIntegerField
      DisplayLabel = 'Pengajar'
      DisplayWidth = 200
      FieldName = 'pid'
      Required = True
    end
    object TblKegiatanjam: TIntegerField
      DisplayLabel = 'Jam'
      FieldName = 'jam'
      Required = True
    end
  end
  object ZQuery1: TZQuery
    Connection = DB
    Params = <>
    Left = 56
    Top = 80
  end
  object TblPengajarAturan: TZTable
    Connection = DB
    SortedFields = 'pid;hariid;jamid;'
    TableName = 'pengajar_aturan'
    MasterFields = 'pid'
    MasterSource = DSPengajar
    LinkedFields = 'pid'
    IndexFieldNames = 'pid Asc;hariid Asc;jamid Asc; Asc'
    Left = 208
    Top = 176
    object TblPengajarAturanpaid: TIntegerField
      FieldName = 'paid'
    end
    object TblPengajarAturanpid: TIntegerField
      DisplayLabel = 'Pengajar'
      FieldName = 'pid'
      Required = True
    end
    object TblPengajarAturanhariid: TIntegerField
      DisplayLabel = 'Hari'
      FieldName = 'hariid'
      Required = True
    end
    object TblPengajarAturanjamid: TIntegerField
      DisplayLabel = 'Jam'
      FieldName = 'jamid'
      Required = True
    end
  end
  object DSPengajar: TDataSource
    DataSet = TblPengajar
    Left = 160
    Top = 176
  end
  object TblHari: TZTable
    Connection = DB
    SortedFields = 'hariid'
    ReadOnly = True
    TableName = 'hari'
    IndexFieldNames = 'hariid Asc'
    Left = 72
    Top = 336
    object TblHarihid: TIntegerField
      DisplayWidth = 5
      FieldName = 'hariid'
    end
    object TblHarihari: TWideStringField
      DisplayLabel = 'Hari'
      DisplayWidth = 15
      FieldName = 'hari'
      Size = 30
    end
  end
  object TblJam: TZTable
    Connection = DB
    SortedFields = 'jamid'
    ReadOnly = True
    TableName = 'jam'
    IndexFieldNames = 'jamid Asc'
    Left = 128
    Top = 336
    object TblJamjid: TIntegerField
      FieldName = 'jamid'
    end
    object TblJamjam: TWideStringField
      DisplayLabel = 'Jam'
      DisplayWidth = 10
      FieldName = 'jam'
      Size = 30
    end
    object TblJamistirahat: TSmallintField
      DisplayLabel = 'Istirahat'
      FieldName = 'istirahat'
      Required = True
    end
    object TblJamjumat: TSmallintField
      DisplayLabel = 'Jum'#39'at'
      DisplayWidth = 10
      FieldName = 'jumat'
      Required = True
    end
  end
  object TblKelas: TZTable
    Connection = DB
    SortedFields = 'kelasid'
    ReadOnly = True
    TableName = 'kelas'
    IndexFieldNames = 'kelasid Asc'
    Left = 184
    Top = 336
    object TblKelaskelasid: TIntegerField
      FieldName = 'kelasid'
    end
    object TblKelaskelas: TWideStringField
      FieldName = 'kelas'
      Size = 10
    end
  end
  object TblTingkat: TZTable
    Connection = DB
    SortedFields = 'tingkatid'
    ReadOnly = True
    TableName = 'tingkat'
    IndexFieldNames = 'tingkatid Asc'
    Left = 240
    Top = 336
    object TblTingkattingkatid: TIntegerField
      FieldName = 'tingkatid'
    end
    object TblTingkattingkat: TWideStringField
      DisplayLabel = 'Tingkat'
      FieldName = 'tingkat'
      Required = True
    end
  end
end
