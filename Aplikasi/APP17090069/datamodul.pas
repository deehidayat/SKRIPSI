unit datamodul;

interface

uses
  SysUtils, Classes, WideStrings, DB, SqlExpr, ZConnection, ZAbstractRODataset,
  ZAbstractDataset, ZAbstractTable, ZDataset;

type
  TFrmDataModul = class(TDataModule)
    DB: TZConnection;
    TblJurusan: TZTable;
    TblMatapelajaran: TZTable;
    TblPengajar: TZTable;
    TblRuangan: TZTable;
    TblJurusanjid: TIntegerField;
    TblJurusankode: TWideStringField;
    TblJurusanjurusan: TWideStringField;
    TblRuanganrid: TIntegerField;
    TblRuanganruangan: TWideStringField;
    TblRuanganenabled: TSmallintField;
    TblMatapelajaranmpid: TIntegerField;
    TblMatapelajarankode: TWideStringField;
    TblMatapelajaranmatapelajaran: TWideStringField;
    TblPengajarpid: TIntegerField;
    TblPengajarkode: TWideStringField;
    TblPengajarpengajar: TWideStringField;
    TblKegiatan: TZTable;
    TblKegiatankid: TIntegerField;
    TblKegiatanjam: TIntegerField;
    TblKegiatanjid: TIntegerField;
    TblKegiatanpid: TIntegerField;
    TblKegiatanmpid: TIntegerField;
    ZQuery1: TZQuery;
    TblPengajarAturan: TZTable;
    DSPengajar: TDataSource;
    TblHari: TZTable;
    TblJam: TZTable;
    TblKelas: TZTable;
    TblHarihid: TIntegerField;
    TblHarihari: TWideStringField;
    TblJamjid: TIntegerField;
    TblJamjam: TWideStringField;
    TblJamistirahat: TSmallintField;
    TblJamjumat: TSmallintField;
    TblKelaskelas: TWideStringField;
    TblKelaskelasid: TIntegerField;
    TblKegiatankelasid: TIntegerField;
    TblPengajarAturanpaid: TIntegerField;
    TblPengajarAturanpid: TIntegerField;
    TblPengajarAturanhariid: TIntegerField;
    TblPengajarAturanjamid: TIntegerField;
    TblTingkat: TZTable;
    TblTingkattingkatid: TIntegerField;
    TblTingkattingkat: TWideStringField;
    TblKegiatantingkatid: TIntegerField;
    TblRuangantingkat_1: TSmallintField;
    TblRuangantingkat_2: TSmallintField;
    TblRuangantingkat_3: TSmallintField;
    procedure TblJurusanBeforeDelete(DataSet: TDataSet);
    procedure TblPengajarBeforeDelete(DataSet: TDataSet);
    procedure TblMatapelajaranBeforeDelete(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDataModul: TFrmDataModul;

implementation

{$R *.dfm}

procedure TFrmDataModul.DataModuleCreate(Sender: TObject);
begin
  DB.Connected := False;
end;

procedure TFrmDataModul.TblJurusanBeforeDelete(DataSet: TDataSet);
begin
  with DataSet do begin
    if TblKegiatan.Locate('jid',FieldByName('jid').Value,[loCaseInsensitive]) then begin
        ZQuery1.Active := False;
        ZQuery1.SQL.Text := 'delete from kegiatan where jid=:jid';
        ZQuery1.Params.ParamByName('jid').Value := FieldByName('jid').Value;
        ZQuery1.ExecSQL;
        ZQuery1.Active := False;
        TblKegiatan.Refresh;
    end;
  end;
end;

procedure TFrmDataModul.TblMatapelajaranBeforeDelete(DataSet: TDataSet);
begin
  with DataSet do begin
    if TblKegiatan.Locate('mpid',FieldByName('mpid').Value,[loCaseInsensitive]) then begin
        ZQuery1.Active := False;
        ZQuery1.SQL.Text := 'delete from kegiatan where mpid=:mpid';
        ZQuery1.Params.ParamByName('mpid').Value := FieldByName('mpid').Value;
        ZQuery1.ExecSQL;
        ZQuery1.Active := False;
        TblKegiatan.Refresh;
    end;
  end;
end;

procedure TFrmDataModul.TblPengajarBeforeDelete(DataSet: TDataSet);
begin
  with DataSet do begin
    if TblKegiatan.Locate('pid',FieldByName('pid').Value,[loCaseInsensitive]) then begin
        ZQuery1.Active := False;
        ZQuery1.SQL.Text := 'delete from kegiatan where pid=:pid';
        ZQuery1.Params.ParamByName('pid').Value := FieldByName('pid').Value;
        ZQuery1.ExecSQL;
        ZQuery1.Active := False;
        ZQuery1.SQL.Text := 'delete from pengajar_aturan where pid=:pid';
        ZQuery1.Params.ParamByName('pid').Value := FieldByName('pid').Value;
        ZQuery1.ExecSQL;
        ZQuery1.Active := False;
        TblKegiatan.Refresh;
        TblPengajarAturan.Refresh;
    end;
  end;
end;

end.
