unit penjadwalan;

interface

uses
  PARENT, SESSION, MODULE, OKegiatan, ORuangan, OAturanPengajar, XMLLog,
  uLkJSON, Math, Windows, Messages, SysUtils, Variants,
  Classes, Graphics, Controls, Forms, Dialogs, Buttons, ActnList,
  PlatformDefaultStyleActnCtrls, ActnMan, Grids, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset,
  DBGrids, ExtCtrls, StdCtrls, DBCtrls, DBCGrids, ComCtrls, acProgressBar,
  sStatusBar, sDBLookupListBox, sGroupBox, sEdit, sMemo, sSpeedButton, sLabel,
  sPanel, acDBGrid, ZAbstractTable, ImgList, Menus, acAlphaImageList, sButton,
  ToolWin, sToolBar, sComboBox, ActnPopup;

// const
// KodeFields: array [0 .. 2] of String = ('id_jurusan', 'semester', 'kelas');

type
  TFrmPenjadwalan = class(TFormDee)
    GenerateAG: TAction;
    DSKegiatanQuery: TDataSource;
    DBGrid1: TsDBGrid;
    Panel1: TsPanel;
    StringGrid2: TStringGrid;
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    CreateReport: TAction;
    TblKegiatanQuery: TZQuery;
    Timer2: TTimer;
    StartRegenerasi: TAction;
    StopRegenerasi: TAction;
    StatusBar1: TsStatusBar;
    ProgressBar: TsProgressBar;
    ActionList: TActionList;
    Panel3: TsPanel;
    Label1: TsLabel;
    LblRuang: TsLabel;
    Label2: TsLabel;
    LblHari: TsLabel;
    Label3: TsLabel;
    LblJam: TsLabel;
    Label9: TsLabel;
    LblKelasKuliah: TsLabel;
    Panel2: TsPanel;
    ImgControl: TsAlphaImageList;
    SpeedButton1: TsSpeedButton;
    SpeedButton3: TsSpeedButton;
    SpeedButton2: TsSpeedButton;
    SpeedButton4: TsSpeedButton;
    TblDosenMengajar: TZQuery;
    TblKelasDiajar: TZQuery;
    ZQueryAturan: TZQuery;
    TblKegiatanQuerykid: TIntegerField;
    TblKegiatanQuerytingkatid: TIntegerField;
    TblKegiatanQuerytingkat: TWideStringField;
    TblKegiatanQuerykelasid: TIntegerField;
    TblKegiatanQuerykelas: TWideStringField;
    TblKegiatanQueryjid: TIntegerField;
    TblKegiatanQuerykode_jurusan: TWideStringField;
    TblKegiatanQueryjurusan: TWideStringField;
    TblKegiatanQuerypid: TIntegerField;
    TblKegiatanQuerykode_pengajar: TWideStringField;
    TblKegiatanQuerypengajar: TWideStringField;
    TblKegiatanQuerympid: TIntegerField;
    TblKegiatanQuerykode_matapelajaran: TWideStringField;
    TblKegiatanQuerymatapelajaran: TWideStringField;
    TblKegiatanQueryjam: TIntegerField;
    sPanel1: TsPanel;
    ComboBox1: TsComboBox;
    ComboBox2: TsComboBox;
    ComboBox3: TsComboBox;
    TblKelasDiajartingkat: TWideStringField;
    TblKelasDiajarkode_jurusan: TWideStringField;
    TblKelasDiajarjurusan: TWideStringField;
    TblKelasDiajarkelas: TWideStringField;
    TblKelasDiajartingkatid: TIntegerField;
    TblKelasDiajarkelasid: TIntegerField;
    TblKelasDiajarjid: TIntegerField;
    DBGrid2: TDBGrid;
    DataSource1: TDataSource;
    ZQuery: TZQuery;
    SpeedButton5: TsSpeedButton;
    SetupConfig: TAction;
    InitAG: TAction;
    EdTgFitness: TsEdit;
    sLabel3: TsLabel;
    sLabel1: TsLabel;
    procedure GenerateAGExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure CreateReportExecute(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure StartRegenerasiExecute(Sender: TObject);
    procedure StopRegenerasiExecute(Sender: TObject);
    procedure DSKegiatanQueryDataChange(Sender: TObject; Field: TField);
    procedure DSGrupDataChange(Sender: TObject; Field: TField);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure ComboBox1Change(Sender: TObject);
    procedure SetupConfigExecute(Sender: TObject);
    procedure InitAGExecute(Sender: TObject);
    procedure ComboBox1Enter(Sender: TObject);

    procedure Panel2Click(Sender: TObject);
  private
    { Private declarations }
    IIterasi: Integer;
    function GetIterasi: Integer;
    procedure SetIterasi(I: Integer);
    procedure SetStatus(value: String);
    property Iterasi: Integer read GetIterasi write SetIterasi;

    procedure Kontrol(Aktif: Boolean);

    function ParseKode(kode: String; DataSet: TDataSet): String;
    procedure BuatLaporan(var Sheet: Variant; Json: TlkJSONobject);
    procedure BuatLaporan2(var Sheet: Variant; Json: TlkJSONobject);

    procedure ShowKromosomToGrid;
    procedure ClearGrid;

    // property TimeStr: String read GetTimer write SetTimer;
  public
    { Public declarations }
    property Status: string write SetStatus;
  end;

type
  TString = class(TObject)
  private
    fStr: String;
  public
    constructor Create(const AStr: String);
    property Str: String read fStr write fStr;
  end;

var
  FrmPenjadwalan: TFrmPenjadwalan;
  AG: TAGenetika;
  Dt, Mt, Jm: Integer;
  IsGenerated: Boolean = false;
  LogProses: IXMLLogType;
  TimeStr: string;
  aHari, aJam: Tarray<string>;
  aRuang: Tarray<TRuangan>;

implementation

uses ComObj, datamodul, index, DML, configag, about;
{$R *.dfm}

constructor TString.Create(const AStr: String);
begin
  inherited Create;
  fStr := AStr;
end;

procedure FreeObjects(const strings: TStrings);
var
  idx: Integer;
begin
  for idx := 0 to Pred(strings.Count) do
  begin
    strings.Objects[idx].Free;
    strings.Objects[idx] := nil;
  end;
end;

procedure TandaiCellTabrak(var Sheet: Variant; Baris, Kolom: Integer);
begin
  Sheet.Cells[Baris, Kolom].Font.Color := clRed;
  Sheet.Cells[Baris, Kolom].Font.Bold := True;
  Sheet.Cells[Baris, Kolom].Font.Italic := True;
end;

function AddLeadingZeroes(const aNumber, Length: Integer): string;
begin
  Result := SysUtils.Format('%.*d', [Length, aNumber]);
end;

procedure TFrmPenjadwalan.SetStatus(value: String);
begin
  Application.ProcessMessages;
  StatusBar1.Panels[0].Text := value;
end;

procedure TFrmPenjadwalan.SetupConfigExecute(Sender: TObject);
begin
  FrmConfigAG.ShowModal;
end;

procedure TFrmPenjadwalan.ShowKromosomToGrid;
var
  I, NoKromosom: Integer;
begin
  ClearGrid;
  for NoKromosom := 1 to POPULATION_SIZE do
  begin
    for I := 0 to AG.JUMLAHGEN - 1 do
      StringGrid1.Cells[I + 1, NoKromosom] := AG.AmbilKromosom(NoKromosom, I);
    StringGrid2.Cells[0, NoKromosom] := IntToStr(AG.AmbilFitness(NoKromosom));
  end;
end;

procedure TFrmPenjadwalan.SetIterasi(I: Integer);
begin
  Application.ProcessMessages;
  IIterasi := I;
  if I > 0 then
    Status := 'Regenerasi Kromosom...(' + TimeStr + ')';
  ProgressBar.Position := I;
end;

function TFrmPenjadwalan.GetIterasi;
begin
  Result := IIterasi;
end;

procedure TFrmPenjadwalan.InitAGExecute(Sender: TObject);
var
  I: Integer;
begin
  with ZQuery do
  begin
    Active := false;
    SQL.Text := 'select * from ruangan where enabled=:enabled ';

    if ComboBox1.ItemIndex = 1 then
    begin
      SQL.Text := SQL.Text + 'and tingkat_1=1';
    end
    else if ComboBox1.ItemIndex = 2 then
    begin
      SQL.Text := SQL.Text + 'and tingkat_2=1';
    end
    else if ComboBox1.ItemIndex = 3 then
    begin
      SQL.Text := SQL.Text + 'and tingkat_3=1';
    end;

    ParamByName('enabled').AsInteger := 1;
    Open;
    SetLength(aRuang, RecordCount);
    for I := 0 to RecordCount - 1 do
    begin
      RecNo := I + 1;
      aRuang[I] := TRuangan.Create;
      aRuang[I].id := I;
      aRuang[I].ruangan := FieldByName('ruangan').AsString;
      aRuang[I].tingkat_1 := FieldByName('tingkat_1').AsInteger = 1;
      aRuang[I].tingkat_2 := FieldByName('tingkat_2').AsInteger = 1;
      aRuang[I].tingkat_3 := FieldByName('tingkat_3').AsInteger = 1;
    end;
  end;

  if Assigned(AG) then
  begin
    // AG.Destroy;
    FreeAndNil(AG);
  end;

  // FrmPenjadwalan.Log.Lines.Add(Format('Hari: %d, Ruang: %d, Jam: %d',[Length(NamaHari),Length(NamaRuang),Length(NamaJam)]));
  AG := TAGenetika.Create(aHari, aJam, aRuang);
  aRuang := nil;

  LblRuang.Caption := IntToStr(AG.JUMLAHRUANG);
  LblHari.Caption := IntToStr(AG.JUMLAHHARI);
  LblJam.Caption := IntToStr(AG.JUMLAHJAM);

  StringGrid1.ColCount := AG.JUMLAHGEN + 1;
  StringGrid1.RowCount := POPULATION_SIZE + 1;
  StringGrid1.FixedCols := 1;
  StringGrid1.FixedRows := 1;
  for I := 0 to AG.JUMLAHGEN - 1 do
    StringGrid1.Cells[I + 1, 0] := IntToStr(I + 1);

  StringGrid2.ColCount := 1;
  StringGrid2.RowCount := POPULATION_SIZE + 1;
  StringGrid2.FixedRows := 1;
  StringGrid2.Cells[0, 0] := 'F';

  SetLength(AG.Kegiatan, TblKegiatanQuery.RecordCount);
  TblKegiatanQuery.First;
  for I := 0 to TblKegiatanQuery.RecordCount - 1 do
  begin
    AG.Kegiatan[I] := TKegiatan.Create;
    AG.Kegiatan[I].id := TblKegiatanQuery.FieldByName(KEY_FIELD).AsString;
    AG.Kegiatan[I].tingkat := TblKegiatanQuery.FieldByName('tingkatid')
      .AsInteger;
    AG.Kegiatan[I].jurusan := TblKegiatanQuery.FieldByName('jid').AsInteger;
    AG.Kegiatan[I].kelas := TblKegiatanQuery.FieldByName('kelasid').AsInteger;
    AG.Kegiatan[I].matapelajaran := TblKegiatanQuery.FieldByName('mpid')
      .AsInteger;
    AG.Kegiatan[I].pengajar := TblKegiatanQuery.FieldByName('pid').AsInteger;
    AG.Kegiatan[I].jam := TblKegiatanQuery.FieldByName('jam').AsInteger;
    TblKegiatanQuery.Next;
  end;

  with ZQuery do
  begin
    Active := false;
    SQL.Text := 'select * from pengajar_aturan';
    Open;
    SetLength(AG.AturanPengajar, RecordCount);
    for I := 0 to RecordCount - 1 do
    begin
      RecNo := I + 1;
      AG.AturanPengajar[I] := TAturanPEngajar.Create;
      AG.AturanPengajar[I].pengajar := FieldByName('pid').AsInteger;
      AG.AturanPengajar[I].hari := FieldByName('hariid').AsInteger;
      AG.AturanPengajar[I].jam := FieldByName('jamid').AsInteger;
    end;
  end;

  ClearGrid;
end;

procedure TFrmPenjadwalan.Kontrol(Aktif: Boolean);
begin
end;

procedure TFrmPenjadwalan.DSGrupDataChange(Sender: TObject; Field: TField);
begin
  if IsGenerated then
  begin
    GenerateAG.Enabled := True;
    StartRegenerasi.Enabled := false;
    StopRegenerasi.Enabled := false;
    CreateReport.Enabled := false;
    IsGenerated := false;
    ClearGrid;
  end;
end;

procedure TFrmPenjadwalan.DSKegiatanQueryDataChange
  (Sender: TObject; Field: TField);
begin
  LblKelasKuliah.Caption := IntToStr(TblKegiatanQuery.RecordCount);
end;

procedure TFrmPenjadwalan.FormActivate(Sender: TObject);
begin
  if (TblKegiatanQuery.Active = True) then
    TblKegiatanQuery.Refresh;
  // TblGrup.Refresh;
end;

procedure TFrmPenjadwalan.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmPenjadwalan := nil;
  FreeObjects(ComboBox1.Items);
  FreeObjects(ComboBox2.Items);
  FreeObjects(ComboBox3.Items);
  if Assigned(AG) then
    AG.Destroy;
  // FreeAndNil(AG);
end;

procedure TFrmPenjadwalan.FormCreate(Sender: TObject);
var
  ProgressBarStyle: Integer;
  I: Integer;
begin
  if FrmDataModul.DB.Connected = false then
    Exit;

  // enable status bar 2nd Panel custom drawing
  StatusBar1.Panels[1].Style := psOwnerDraw;
  // place the progress bar into the status bar
  ProgressBar.PARENT := StatusBar1;
  // remove progress bar border
  ProgressBarStyle := GetWindowLong(ProgressBar.Handle, GWL_EXSTYLE);
  ProgressBarStyle := ProgressBarStyle - WS_EX_STATICEDGE;
  SetWindowLong(ProgressBar.Handle, GWL_EXSTYLE, ProgressBarStyle);

  ComboBox1.Items.Clear;
  ComboBox1.Items.Add('-All-');
  with FrmDataModul.TblTingkat do
    for I := 1 to RecordCount do
    begin
      RecNo := I;
      ComboBox1.Items.AddObject(FieldByName('tingkat').AsString, TString.Create
          (FieldByName('tingkatid').AsString));
    end;
  ComboBox1.ItemIndex := 0;

  ComboBox2.Items.Clear;
  ComboBox2.Items.Add('-All-');
  with FrmDataModul.TblJurusan do
    for I := 1 to RecordCount do
    begin
      RecNo := I;
      ComboBox2.Items.AddObject(FieldByName('kode').AsString, TString.Create
          (FieldByName('jid').AsString));
    end;
  ComboBox2.ItemIndex := 0;

  ComboBox3.Items.Clear;
  ComboBox3.Items.Add('-All-');
  with FrmDataModul.TblKelas do
    for I := 1 to RecordCount do
    begin
      RecNo := I;
      ComboBox3.Items.AddObject(FieldByName('kelas').AsString, TString.Create
          (FieldByName('kelasid').AsString));
    end;
  ComboBox3.ItemIndex := 0;

  if POPULATION_SIZE <= 10 then
    Panel1.Height := StringGrid1.DefaultRowHeight * POPULATION_SIZE +
      Panel2.Height + Panel3.Height + 80
  else
    Panel1.Height := StringGrid1.DefaultRowHeight * 10 + Panel2.Height +
      Panel3.Height + 80;

  StringGrid2.DefaultRowHeight := StringGrid1.DefaultRowHeight;
  StringGrid2.DefaultRowHeight := StringGrid1.DefaultRowHeight;
  StringGrid2.Width := StringGrid1.DefaultRowHeight + 5;

  TblKegiatanQuery.Active := True;
  DBGrid1.OnDrawColumnCell := DrawColumnCellOnSelect;
  DBGrid1.OnTitleClick := DBGridTitleClick;
  // DBGrid1.Visible := DEBUG_MODE;
  StartRegenerasi.Enabled := false;
  CreateReport.Enabled := false;
  // SetupConfig.Enabled := False;
  SpeedButton4.Visible := false;

  with FrmDataModul do
  begin
    SetLength(aHari, TblHari.RecordCount);
    for I := 0 to TblHari.RecordCount - 1 do
    begin
      TblHari.RecNo := I + 1;
      aHari[I] := TblHari.FieldByName('hari').AsString;
    end;

    SetLength(aJam, TblJam.RecordCount);
    for I := 0 to TblJam.RecordCount - 1 do
    begin
      TblJam.RecNo := I + 1;
      aJam[I] := TblJam.FieldByName('jam').AsString;
    end;
  end;

end;

procedure TFrmPenjadwalan.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  if Panel = StatusBar1.Panels[1] then
    with ProgressBar do
    begin
      Top := Rect.Top;
      Left := Rect.Left;
      Width := Rect.Right - Rect.Left - 10;
      Height := Rect.Bottom - Rect.Top;
    end;
end;

procedure TFrmPenjadwalan.ClearGrid;
var
  NoKromosom: Integer;
begin
  for NoKromosom := 1 to POPULATION_SIZE do
  begin
    StringGrid1.Rows[NoKromosom].Clear;
    StringGrid1.Cells[0, NoKromosom] := IntToStr(NoKromosom);
    StringGrid2.Rows[NoKromosom].Clear;
  end;
end;

procedure TFrmPenjadwalan.ComboBox1Change(Sender: TObject);
var
  Query: string;
  tingkat, jurusan, kelas: string;
begin
  // ShowMessage(TString(ComboBox1.Items.Objects[ComboBox1.ItemIndex]).Str);
  if ComboBox1.ItemIndex > 0 then
    tingkat := TString(ComboBox1.Items.Objects[ComboBox1.ItemIndex]).Str;
  if ComboBox2.ItemIndex > 0 then
    jurusan := TString(ComboBox2.Items.Objects[ComboBox2.ItemIndex]).Str;
  if ComboBox3.ItemIndex > 0 then
    kelas := TString(ComboBox3.Items.Objects[ComboBox3.ItemIndex]).Str;
  TblKegiatanQuery.Filtered := false;
  TblKelasDiajar.Filtered := false;

  Query := '';
  if tingkat <> '' then
  begin
    if Query <> '' then
      Query := Query + ' and ';
    Query := Query + 'tingkatid=' + tingkat;
  end;

  if jurusan <> '' then
  begin
    if Query <> '' then
      Query := Query + ' and ';
    Query := Query + 'jid=' + jurusan;
  end;

  if kelas <> '' then
  begin
    if Query <> '' then
      Query := Query + ' and ';
    Query := Query + 'kelasid=' + kelas;
  end;

  TblKegiatanQuery.Filter := Query;
  TblKelasDiajar.Filter := Query;

  TblKegiatanQuery.Filtered := True;
  TblKelasDiajar.Filtered := True;
  TblKegiatanQuery.First;
end;

procedure TFrmPenjadwalan.ComboBox1Enter(Sender: TObject);
begin

  // SendMessage(ComboBox1.handle, CB_SHOWDROPDOWN, Integer(True), 0);
end;

procedure TFrmPenjadwalan.GenerateAGExecute(Sender: TObject);
begin
  if (IsGenerated) and (MessageDLG('Hapus Data Sebelumnya ??', MTConfirmation,
      [MBYes, MBNo], 0) = MRNo) then
    Exit;

  InitAG.Execute;
  GenerateAG.Enabled := false;
  StartRegenerasi.Enabled := false;
  StopRegenerasi.Enabled := false;
  CreateReport.Enabled := false;
  SetupConfig.Enabled := false;
  // Log.Clear;
  // Log2.Clear;

  Status := 'Membuat Populasi Baru..';
  AG.BangkitkanPopulasi();
  ShowKromosomToGrid;

  Iterasi := 0;
  Dt := 0;
  Mt := 0;
  Jm := 0;
  TimeStr := '00:00:00';

  GenerateAG.Enabled := True;
  StartRegenerasi.Enabled := True;
  StopRegenerasi.Enabled := True;
  CreateReport.Enabled := True;
  SetupConfig.Enabled := True;

  Status := '';
  IsGenerated := True;
end;

procedure TFrmPenjadwalan.StringGrid1SelectCell
  (Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  // if ARow = 1 then
  Status := Format('Hari:%s Ruang:%s Jam:%s', [AG.Alelle[ACol - 1].hari,
    AG.Alelle[ACol - 1].Ruang, AG.Alelle[ACol - 1].jam]);
  TblKegiatanQuery.Locate(KEY_FIELD, StringGrid1.Cells[ACol, ARow], [])
end;

procedure TFrmPenjadwalan.Timer1Timer(Sender: TObject);
begin
  if (Dt mod 60) = 0 then
  begin
    Mt := Mt + (Dt div 60);
    Dt := 0;
  end
  else
  begin
    Mt := Mt + (Dt div 60);
    Dt := Dt mod 60;
  end;
  TimeStr := AddLeadingZeroes(Jm, 2) + ':' + AddLeadingZeroes(Mt, 2)
    + ':' + AddLeadingZeroes(Dt, 2);
  Dt := Dt + 1;
end;

procedure TFrmPenjadwalan.StartRegenerasiExecute(Sender: TObject);
begin
  CreateReport.Enabled := false;
  GenerateAG.Enabled := false;
  SetupConfig.Enabled := false;

  // if (Iterasi = 0) then
  // begin
  AG.PbCross := PB_CROSS; // StrToFloat(EdPbCO.Text);
  AG.PbMutasi := PB_MUTASI; // StrToFloat(EdPbMutasi.Text);
  AG.TgFitness := TGT_FITNESS;
  // end;

  ProgressBar.Min := 0;
  ProgressBar.Max := MAX_ITERASI;
  {
    if (Iterasi = 0) then
    begin
    // if MessageDLG('CreateLog',MTConfirmation,[MBYes,MBNo],0)=MRYes then
    LogProses := DEE_LOG.Insert(0);
    LogProses.Datetime := DateTimeToStr(Now);
    LogProses.Fawal := AG.AmbilFitness(1);
    LogProses.Hari := AG.JUMLAHHARI;
    LogProses.Ruang := AG.JUMLAHRUANG;
    LogProses.Jam := AG.JUMLAHJAM;
    LogProses.Kelas := AG.JUMLAHKELAS;
    end;
    }
  Timer1.Enabled := True;
  Timer2.Enabled := True;
  // GBSummary.Enabled := false;
  Status := 'Proses Regenerasi Kromosom...';
  ProgressBar.Visible := True;

  // SpeedButton3.Action := StopRegenerasi;
  SpeedButton4.Visible := True;
  SpeedButton3.Visible := false;

  FrmIndex.ActionList1.State := asSuspended;
  EdTgFitness.Enabled := false;
end;

procedure TFrmPenjadwalan.StopRegenerasiExecute(Sender: TObject);
begin
  Timer1.Enabled := false;
  Timer2.Enabled := false;
  Status := '';
  ProgressBar.Visible := false;

  CreateReport.Enabled := True;
  GenerateAG.Enabled := True;
  SetupConfig.Enabled := True;

  // SpeedButton3.Action := StartRegenerasi;
  SpeedButton4.Visible := false;
  SpeedButton3.Visible := True;

  FrmIndex.ActionList1.State := asNormal;
  EdTgFitness.Enabled := True;
end;

procedure TFrmPenjadwalan.Timer2Timer(Sender: TObject);
var
  x, y: Integer;
begin

  Randomize;

  // x := Random(100);
  // if (x <= AG.PbCross) then
  // if True then
  // begin
  Iterasi := Iterasi + 1;
  AG.CrossOver;
  ShowKromosomToGrid;
  if AG.AmbilFitness(1) <= AG.TgFitness then
  begin
    StopRegenerasi.Execute;
    {
      LogProses.Iterasi := Iterasi;
      LogProses.Fakhir := AG.AmbilFitness(1);
      LogProses.Time := TimeStr;
      DEE_LOG.OwnerDocument.SaveToFile(BASE_PATH + LOG_FILE);
      }
    // AG.UrutSolusi;
    if AG.AmbilFitness(1) <= AG.TgFitness then
    begin
      ShowMessage('  PROSES BERHENTI' + #10#13 + '  -----------------------' +
          #10#13 + '     Nilai Fitness : ' + IntToStr(AG.AmbilFitness(1))
          + #10#13 + '     Iterasi Ke- ' + IntToStr(Iterasi)
          + #10#13 + '     Waktu : ' + TimeStr);
      Exit;
    end
    else
    begin
      StartRegenerasi.Execute;
    end;
  end
  else
  begin
    AG.Mutasi;
    ShowKromosomToGrid;
    if AG.AmbilFitness(1) <= AG.TgFitness then
    begin
      StopRegenerasi.Execute;
      {
        LogProses.Iterasi := Iterasi;
        LogProses.Fakhir := AG.AmbilFitness(1);
        LogProses.Time := TimeStr;
        DEE_LOG.OwnerDocument.SaveToFile(BASE_PATH + LOG_FILE);
        }
      // AG.UrutSolusi;
      if AG.AmbilFitness(1) <= AG.TgFitness then
      begin
        ShowMessage('  PROSES BERHENTI' + #10#13 +
            '  -----------------------' + #10#13 + '     Nilai Fitness : ' +
            IntToStr(AG.AmbilFitness(1)) + #10#13 + '     Iterasi Ke- ' +
            IntToStr(Iterasi) + #10#13 + '     Waktu : ' + TimeStr);
        Exit;
      end
      else
      begin
        StartRegenerasi.Execute;
      end;
    end;
  end;
  // end;

  {
    y := Random(100);
    if (y <= AG.PbMutasi) then
    begin
    AG.Mutasi;
    ShowKromosomToGrid;
    if AG.AmbilFitness(1) <= AG.TgFitness then
    begin
    StopRegenerasi.Execute;
    //    LogProses.Iterasi := Iterasi;
    //    LogProses.Fakhir := AG.AmbilFitness(1);
    //    LogProses.Time := TimeStr;
    //    DEE_LOG.OwnerDocument.SaveToFile(BASE_PATH + LOG_FILE);
    ShowMessage('  PROSES BERHENTI' + #10#13 + '  -----------------------' +
    #10#13 + '     Nilai Fitness : ' + IntToStr(AG.AmbilFitness(1))
    + #10#13 + '     Iterasi Ke- ' + IntToStr(Iterasi)
    + #10#13 + '     Waktu : ' + TimeStr);
    Exit;
    end;
    end;
    }

  if (Iterasi >= MAX_ITERASI) then
  begin
    StopRegenerasi.Execute;
    if MessageDLG('Tambah Batas ?', MTConfirmation, [MBYes, MBNo], 0)
      = MRYes then
    begin
      MAX_ITERASI := MAX_ITERASI + 1000;
      StartRegenerasi.Execute;
    end
    else
    begin
      {
        LogProses.Iterasi := Iterasi;
        LogProses.Fakhir := AG.AmbilFitness(1);
        LogProses.Time := TimeStr;
        DEE_LOG.OwnerDocument.SaveToFile(BASE_PATH + LOG_FILE);
        }
      ShowKromosomToGrid;
      ShowMessage('  PROSES BERHENTI' + #10#13 + '  -----------------------' +
          #10#13 + '     Nilai Fitness : ' + IntToStr(AG.AmbilFitness(1))
          + #10#13 + '     Iterasi Ke- ' + IntToStr(Iterasi)
          + #10#13 + '     Waktu : ' + TimeStr);
    end;
  end;

end;

procedure TFrmPenjadwalan.Panel2Click(Sender: TObject);
begin
  FrmAbout.ShowModal;
end;

function TFrmPenjadwalan.ParseKode(kode: String; DataSet: TDataSet): String;
var
  I: Integer;
begin
  for I := 0 to DataSet.FieldCount - 1 do
  begin
    kode := StringReplace(kode, '%' + DataSet.Fields[I].FieldName + '%',
      DataSet.Fields[I].AsString, [rfReplaceAll, rfIgnoreCase]);
  end;
  Result := kode;
end;

function recrusiveChar(I: Integer): string;
var
  x: Integer;
begin
  if (I >= 1) and (I <= 26) then
  begin
    Result := Char(65 + I - 1);
  end
  else
  begin
    x := I div 26;
    // ShowMessage(IntToStr(x));
    if x <= 26 then
      Result := Chr(65 + x - 1) + recrusiveChar(I mod 26);
  end;
end;

// ============================================================================
procedure TFrmPenjadwalan.BuatLaporan2(var Sheet: Variant; Json: TlkJSONobject);
var
  J, I, Baris, No: Integer;
  KdKelas, aValue, headerKode: String;
  IsAdaKuliah: Boolean;
  Gen, c, d, k, JumKelas, JumError: Integer;
  CellRange: array [1 .. 3] of String;
  oRange: Variant;
  AtrnTbrk: String;
  x, y: Integer;
  // Kegiatan : TKegiatan;
begin

  if (TblKelasDiajar.Active = false) then
    TblKelasDiajar.Active := True;

  Status := Json.Field['excel'].Field['status'].value;
  Sheet.Name := Json.Field['excel'].Field['sheetname'].value;
  Baris := 1;

  CellRange[1] := recrusiveChar(1);
  CellRange[2] := recrusiveChar(1 + 2);
  CellRange[3] := recrusiveChar(1 + 2 + (TblKelasDiajar.RecordCount * 2));

  with ProgressBar do
  begin
    Min := 0;
    Max := AG.JUMLAHGEN - 1;
    Position := 0;
  end;
  // Header Sheet
  for c := 0 to Json.Field['judul'].Count - 1 do
  begin
    oRange := Sheet.Range[CellRange[1] + IntToStr(Baris) + ':' + CellRange[3]
      + IntToStr(Baris)];
    oRange.Merge;
    oRange.HorizontalAlignment := 3;
    oRange.Font.size := 11;
    oRange.Font.Bold := True;
    oRange.Font.Color := clBlue;
    Sheet.Cells[Baris, 1] := Json.Field['judul'].Child[c].value;
    Inc(Baris);
  end;

  Baris := Baris + 2;

  with TblKelasDiajar, AG do
  begin
    // Header Tabel
    Sheet.Cells[Baris, 1] := 'Hari';
    Sheet.Columns[1].ColumnWidth := 5;
    Sheet.Columns[1].HorizontalAlignment := 3;
    Sheet.Cells[Baris, 2] := '---';
    Sheet.Columns[2].ColumnWidth := 3;
    Sheet.Columns[2].HorizontalAlignment := 3;
    Sheet.Cells[Baris, 3] := 'Waktu';
    Sheet.Columns[3].ColumnWidth := 15;
    Sheet.Columns[3].HorizontalAlignment := 3;
    for I := 0 to RecordCount - 1 do
    begin
      RecNo := I + 1;
      Sheet.Cells[Baris, 4 + (I * 2)] := ParseKode(KODE_KELAS, TblKelasDiajar);
      Sheet.Cells[Baris, 5 + (I * 2)] := 'Ruangan';
      Sheet.Columns[4 + (I * 2)].ColumnWidth := 15;
      Sheet.Columns[5 + (I * 2)].ColumnWidth := 8;
      Sheet.Columns[5 + (I * 2)].HorizontalAlignment := 3;
    end;
    Sheet.Rows[Baris].RowHeight := 30;
    oRange := Sheet.Range[CellRange[1] + IntToStr(Baris) + ':' + CellRange[3]
      + IntToStr(Baris)];
    oRange.Font.Bold := True;
    oRange.Font.size := 12;
    oRange.Interior.Color := clWebTomato;
    oRange.VerticalAlignment := 2;
    oRange.Borders.Weight := xlThin;
    oRange.Borders[xlEdgeBottom].Weight := xlThick;
    Inc(Baris);
    // Nama Hari dan Nama Jam
    // Sheet.Cells[Baris,4].View.FreezePanes;
    oRange := Sheet.Range[CellRange[1] + IntToStr(Baris) + ':' + CellRange[3]
      + IntToStr(Baris + (JUMLAHHARI * JUMLAHJAM - 1))];
    oRange.Font.size := 10;
    oRange.VerticalAlignment := 2;
    oRange.Borders.Weight := xlThin;
    for I := 0 to JUMLAHHARI - 1 do
    begin
      J := I * JUMLAHJAM;
      Sheet.Cells[Baris + J, 1] := NamaHari[I];
      for k := 0 to JUMLAHJAM - 1 do
      begin
        Sheet.Cells[Baris + J + k, 2] := IntToStr(k + 1);
        Sheet.Cells[Baris + J + k, 3] := NamaJam[k] + '-' + NamaJam[k + 1];
        if (k = 4) or (k = 8) or (k = 13) then
          Sheet.Range[CellRange[1] + IntToStr(Baris + J + k)
            + ':' + CellRange[3] + IntToStr(Baris + J + k)].Interior.Color :=
            clWebDarkOrange;
        if (I = 4) and ((k = 7) or (k = 8)) then
          Sheet.Range[CellRange[1] + IntToStr(Baris + J + k)
            + ':' + CellRange[3] + IntToStr(Baris + J + k)].Interior.Color :=
            clWebLightGreen;
      end;
      oRange := Sheet.Range[CellRange[1] + IntToStr(Baris + J)
        + ':' + CellRange[1] + IntToStr(Baris + J + JUMLAHJAM - 1)];
      oRange.Merge;
      oRange.Font.size := 14;
      oRange.Orientation := -90;

      oRange := Sheet.Range[CellRange[1] + IntToStr(Baris + J)
        + ':' + CellRange[2] + IntToStr(Baris + J + JUMLAHJAM - 1)];
      oRange.Font.size := 12;
      oRange.Font.Bold := True;
      oRange.HorizontalAlignment := 3;

      oRange := Sheet.Range[CellRange[1] + IntToStr(Baris + J)
        + ':' + CellRange[3] + IntToStr(Baris + J + JUMLAHJAM - 1)];
      oRange.Borders[xlEdgeBottom].Weight := xlThick;

    end;
  end;

  // Isi Jadwal
  with TblKegiatanQuery, AG do
  begin
    JumError := 0;
    for I := 0 to JUMLAHGEN - 1 do
    begin
      if Kromosom[1][I] <> '0' then
      begin
        KdKelas := Kromosom[1][I];
        Locate(KEY_FIELD, KdKelas, []);
        // Kegiatan := AmbilKegiatan(KdKelas);
        TblKelasDiajar.First;
        while not(TblKelasDiajar.Eof) and
          (ParseKode(KODE_KELAS, TblKegiatanQuery) <> ParseKode(KODE_KELAS,
            TblKelasDiajar)) do
        begin
          TblKelasDiajar.Next;
        end;
        if not(TblKelasDiajar.Eof) then
        begin
          y := Baris + (Alelle[I].KodeHari * JUMLAHJAM) + Alelle[I].KodeJam;
          Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)].value :=
            Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)]
            .value + FieldByName('kode_matapelajaran')
            .AsString + '-' + FieldByName('kode_pengajar').AsString;
          Sheet.Cells[y, 5 + ((TblKelasDiajar.RecNo - 1) * 2)].value :=
            Sheet.Cells[y, 5 + ((TblKelasDiajar.RecNo - 1) * 2)].value + Alelle
            [I].Ruang;

          // Tandai Jadwal Yang Bentrok
          AtrnTbrk := '';

          // Waktu Over
          for k := 0 to JumFitAturan[1] - 1 do
          begin
            Gen := k + 1;
            if (MatTabrak[Gen] = KdKelas) or (MatTabrak1[Gen] = KdKelas) then
            begin
              if DEBUG_MODE then
                Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)].value :=
                  Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)]
                  .value + ',1';

              TandaiCellTabrak(Sheet, y, 4 + ((TblKelasDiajar.RecNo - 1) * 2));
              TandaiCellTabrak(Sheet, y, 5 + ((TblKelasDiajar.RecNo - 1) * 2));
              Inc(JumError);
              Break;
            end;
          end;

          // Kelas Tabrakan
          for k := 0 to JumFitAturan[2] - 1 do
          begin
            Gen := k + 1 + JumFitAturan[1];
            if (MatTabrak[Gen] = KdKelas) or (MatTabrak1[Gen] = KdKelas) then
            begin
              if DEBUG_MODE then
                Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)].value :=
                  Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)]
                  .value + ',2';

              TandaiCellTabrak(Sheet, y, 4 + ((TblKelasDiajar.RecNo - 1) * 2));
              TandaiCellTabrak(Sheet, y, 5 + ((TblKelasDiajar.RecNo - 1) * 2));
              Inc(JumError);
              Break;
            end;
          end;

          for k := 0 to JumFitAturan[3] - 1 do
          begin
            Gen := k + 1 + JumFitAturan[1] + JumFitAturan[2];
            if (MatTabrak[Gen] = KdKelas) or (MatTabrak1[Gen] = KdKelas) then
            begin
              if DEBUG_MODE then
                Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)].value :=
                  Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)]
                  .value + ',3';

              TandaiCellTabrak(Sheet, y, 4 + ((TblKelasDiajar.RecNo - 1) * 2));
              TandaiCellTabrak(Sheet, y, 5 + ((TblKelasDiajar.RecNo - 1) * 2));
              Inc(JumError);
              Break;
            end;
          end;

          for k := 0 to JumFitAturan[4] - 1 do
          begin
            Gen := k + 1 + JumFitAturan[1] + JumFitAturan[2] + JumFitAturan[3];
            if (MatTabrak[Gen] = KdKelas) or (MatTabrak1[Gen] = KdKelas) then
            begin
              if DEBUG_MODE then
                Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)].value :=
                  Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)]
                  .value + ',4';

              TandaiCellTabrak(Sheet, y, 4 + ((TblKelasDiajar.RecNo - 1) * 2));
              Inc(JumError);
              Break;
            end;
          end;

          for k := 0 to JumFitAturan[5] - 1 do
          begin
            Gen := k + 1 + JumFitAturan[1] + JumFitAturan[2] + JumFitAturan[3]
              + JumFitAturan[4];
            if (MatTabrak[Gen] = KdKelas) or (MatTabrak1[Gen] = KdKelas) then
            begin
              if DEBUG_MODE then
                Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)].value :=
                  Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)]
                  .value + ',5';

              TandaiCellTabrak(Sheet, y, 5 + ((TblKelasDiajar.RecNo - 1) * 2));
              Inc(JumError);
              Break;
            end;
          end;

          for k := 0 to JumFitAturan[6] - 1 do
          begin
            Gen := k + 1 + JumFitAturan[1] + JumFitAturan[2] + JumFitAturan[3]
              + JumFitAturan[4] + JumFitAturan[5];
            if (MatTabrak[Gen] = KdKelas) or (MatTabrak1[Gen] = KdKelas) then
            begin
              if DEBUG_MODE then
                Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)].value :=
                  Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)]
                  .value + ',6';

              TandaiCellTabrak(Sheet, y, 4 + ((TblKelasDiajar.RecNo - 1) * 2));
              Inc(JumError);
              Break;
            end;
          end;

          for k := 0 to JumFitAturan[7] - 1 do
          begin
            Gen := k + 1 + JumFitAturan[1] + JumFitAturan[2] + JumFitAturan[3]
              + JumFitAturan[4] + JumFitAturan[5] + JumFitAturan[6];
            if (MatTabrak[Gen] = KdKelas) or (MatTabrak1[Gen] = KdKelas) then
            begin
              if DEBUG_MODE then
                Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)].value :=
                  Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)]
                  .value + ',7';

              TandaiCellTabrak(Sheet, y, 4 + ((TblKelasDiajar.RecNo - 1) * 2));
              Inc(JumError);
              Break;
            end;
          end;

          for k := 0 to JumFitAturan[8] - 1 do
          begin
            Gen := k + 1 + JumFitAturan[1] + JumFitAturan[2] + JumFitAturan[3]
              + JumFitAturan[4] + JumFitAturan[5] + JumFitAturan[6]
              + JumFitAturan[7];
            if (MatTabrak[Gen] = KdKelas) or (MatTabrak1[Gen] = KdKelas) then
            begin
              if DEBUG_MODE then
                Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)].value :=
                  Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)]
                  .value + ',8';

              TandaiCellTabrak(Sheet, y, 4 + ((TblKelasDiajar.RecNo - 1) * 2));
              Inc(JumError);
              Break;
            end;
          end;

          for k := 0 to JumFitAturan[9] - 1 do
          begin
            Gen := k + 1 + JumFitAturan[1] + JumFitAturan[2] + JumFitAturan[3]
              + JumFitAturan[4] + JumFitAturan[5] + JumFitAturan[6]
              + JumFitAturan[7] + JumFitAturan[8];
            if (MatTabrak[Gen] = KdKelas) or (MatTabrak1[Gen] = KdKelas) then
            begin
              if DEBUG_MODE then
                Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)].value :=
                  Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)]
                  .value + ',9';

              TandaiCellTabrak(Sheet, y, 4 + ((TblKelasDiajar.RecNo - 1) * 2));
              Inc(JumError);
              Break;
            end;
          end;
          {
            for k := 0 to JumFitAturan[10] - 1 do
            begin
            Gen := k + 1 + JumFitAturan[1] + JumFitAturan[2] + JumFitAturan[3]
            + JumFitAturan[4] + JumFitAturan[5] + JumFitAturan[6]
            + JumFitAturan[7] + JumFitAturan[8] + JumFitAturan[9];
            if (MatTabrak[Gen] = KdKelas) or (MatTabrak1[Gen] = KdKelas) then
            begin
            if DEBUG_MODE then
            Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)].value :=
            Sheet.Cells[y, 4 + ((TblKelasDiajar.RecNo - 1) * 2)]
            .value + ',10';

            TandaiCellTabrak(Sheet, y, 4 + ((TblKelasDiajar.RecNo - 1) * 2));
            Inc(JumError);
            Break;
            end;
            end;
            }
        end;
      end;

      ProgressBar.Position := ProgressBar.Position + 1;
    end;

  end;

  { if DEBUG_MODE then
    Sheet.Cells[Baris + 1, 2] := 'Jumlah Kelas : ' + IntToStr(JumKelas);
    if (JumError > 0) then
    begin
    oRange := Sheet.Range[CellRange[1] + IntToStr(Baris) + ':' + CellRange[2]
    + IntToStr(Baris)];
    oRange.Merge;
    oRange.Font.Italic := True;
    oRange.Font.Bold := True;
    oRange.Font.Color := clRed;
    Sheet.Cells[Baris, 1] := '*** Masih ada jadwal yang kurang sesuai';
    end; }
  Status := '';

  if (TblKelasDiajar.Active = True) then
    TblKelasDiajar.Active := false;
end;

procedure TFrmPenjadwalan.BuatLaporan(var Sheet: Variant; Json: TlkJSONobject);
var
  J, I, Baris, No: Integer;
  KdKelas, aValue, headerKode: String;
  IsAdaKuliah: Boolean;
  Gen, c, d, k, JumKelas, JumError: Integer;
  CellRange: array [1 .. 2] of Char;
  oRange: Variant;
  AtrnTbrk: String;
begin
  // ShowMessage(IntToStr(Json.Field['data'].Count));
  Status := Json.Field['excel'].Field['status'].value;
  Sheet.Name := Json.Field['excel'].Field['sheetname'].value;
  Baris := 1;
  CellRange[1] := 'A';
  CellRange[2] := Chr(Ord(CellRange[1]) + Json.Field['fields'].Count);
  with ProgressBar do
  begin
    Min := 0;
    Max := Json.Field['data'].Count * TblKegiatanQuery.RecordCount - 1;
    Position := 0;
  end;
  // Judul Sheet
  for c := 0 to Json.Field['judul'].Count - 1 do
  begin
    oRange := Sheet.Range[CellRange[1] + IntToStr(Baris) + ':' + CellRange[2]
      + IntToStr(Baris)];
    oRange.Merge;
    oRange.HorizontalAlignment := 3;
    oRange.Font.size := 11;
    oRange.Font.Bold := True;
    oRange.Font.Color := clBlue;
    Sheet.Cells[Baris, 1] := Json.Field['judul'].Child[c].value;
    Inc(Baris);
  end;
  // Atur Lebar Kolom
  Sheet.Columns[1].ColumnWidth := 3;
  Sheet.Columns[1].HorizontalAlignment := 3;
  for c := 0 to Json.Field['fields'].Count - 1 do
  begin
    Sheet.Columns[c + 2].ColumnWidth := Json.Field['fields'].Child[c].Field
      ['colwidth'].value;
    Sheet.Columns[c + 2].HorizontalAlignment := Json.Field['fields'].Child[c]
      .Field['horalign'].value;
  end;
  // Inisialisasi
  Baris := Baris + 2;
  JumKelas := 0;
  JumError := 0;
  with TblKegiatanQuery, AG do
  begin
    // Mulai Membuat Laporan
    for J := 0 to Json.Field['data'].Count - 1 do
    begin
      First;
      No := 1;
      IsAdaKuliah := false;
      for I := 0 to RecordCount - 1 do
      begin
        if Json.Field['compfield'].value = 'hari' then
          aValue := AmbilHari(FieldByName(KEY_FIELD).AsString)
        else if Json.Field['compfield'].value = 'kode_kelas' then
          aValue := ParseKode(KODE_KELAS, TblKegiatanQuery)
        else
          aValue := FieldByName(Json.Field['compfield'].value).AsString;
        if aValue = Json.Field['data'].Child[J].value then
        begin
          if not(IsAdaKuliah) then
          begin
            // Header di masing-masing tabel yang sejenis
            for c := 0 to Json.Field['header'].Count - 1 do
            begin
              headerKode := Json.Field['header'].Child[c].value;
              headerKode := StringReplace(headerKode, '|data|', aValue,
                [rfReplaceAll, rfIgnoreCase]);
              Sheet.Cells[Baris, 1] := ParseKode(headerKode, TblKegiatanQuery);
              oRange := Sheet.Range[CellRange[1] + IntToStr(Baris)
                + ':' + CellRange[2] + IntToStr(Baris)];
              oRange.Merge;
              oRange.HorizontalAlignment := 1;
              oRange.Font.Color := clBlue;
              oRange.Font.Bold := True;
              oRange.Interior.ColorIndex := 36;
              Baris := Baris + 1;
            end;
            // Membuat judul kolom
            oRange := Sheet.Range[CellRange[1] + IntToStr(Baris)
              + ':' + CellRange[2] + IntToStr(Baris)];
            oRange.Font.Bold := True;
            oRange.Font.Color := clGreen;
            oRange.Interior.ColorIndex := 36;
            Sheet.Cells[Baris, 1] := 'No';
            for c := 0 to Json.Field['fields'].Count - 1 do
            begin
              Sheet.Cells[Baris, c + 2] := Json.Field['fields'].Child[c].Field
                ['alias'].value;
            end;
            IsAdaKuliah := True;
          end; // if not(IsAdaKuliah)

          // Isi Kolom
          KdKelas := FieldByName(KEY_FIELD).AsString;
          Sheet.Cells[Baris + No, 1] := IntToStr(No);
          for c := 0 to Json.Field['fields'].Count - 1 do
          begin
            if Json.Field['fields'].Child[c].Field['field']
              .value = 'kode_kelas' then
              Sheet.Cells[Baris + No, c + 2] := ParseKode
                (KODE_KELAS, TblKegiatanQuery)
            else if Json.Field['fields'].Child[c].Field['field']
              .value = 'ruang' then
              Sheet.Cells[Baris + No, c + 2] := AmbilRuang(KdKelas)
            else if Json.Field['fields'].Child[c].Field['field']
              .value = 'jam_pertemuan' then
              Sheet.Cells[Baris + No, c + 2] := AmbilJamPertemuan
                (KdKelas, FieldByName(JAM_PERTEMUAN_FIELD).AsInteger)
            else if Json.Field['fields'].Child[c].Field['field']
              .value = 'hari' then
              Sheet.Cells[Baris + No, c + 2] := AmbilHari(KdKelas)
            else
              Sheet.Cells[Baris + No, c + 2] := FieldByName
                (Json.Field['fields'].Child[c].Field['field'].value).AsString;
          end;
          if (No mod 2 = 0) then
          begin
            Sheet.Range[CellRange[1] + IntToStr(Baris + No)
              + ':' + CellRange[2] + IntToStr(Baris + No)].Interior.Color :=
              clSilver;
          end;

          // Tandai Jadwal Yang Bentrok
          AtrnTbrk := '';
          // Waktu Over
          if JumFitAturan[1] <> 0 then
          begin
            for k := 1 to JumFitAturan[1] do
            begin
              if (MatTabrak[k] = KdKelas) or (MatTabrak1[k] = KdKelas) then
              begin
                for c := 0 to Json.Field['fields'].Count - 1 do
                begin
                  for d := 0 to Json.Field['fields'].Child[c].Field
                    ['markaturan'].Count - 1 do
                  begin
                    if Json.Field['fields'].Child[c].Field['markaturan'].Child
                      [d].value = 1 then
                    begin
                      TandaiCellTabrak(Sheet, Baris + No, c + 2);
                      AtrnTbrk := AtrnTbrk + '[1]';
                      Break;
                    end;
                  end;
                end;
                Inc(JumError);
              end;
            end;
          end; // JumFitAturan[1]

          // Kelas Tabrakan
          if JumFitAturan[2] <> 0 then
          begin
            for k := 1 to JumFitAturan[2] do
            begin
              Gen := k + JumFitAturan[1];
              if (MatTabrak[Gen] = KdKelas) or (MatTabrak1[Gen] = KdKelas) then
              begin
                for c := 0 to Json.Field['fields'].Count - 1 do
                begin
                  for d := 0 to Json.Field['fields'].Child[c].Field
                    ['markaturan'].Count - 1 do
                  begin
                    if Json.Field['fields'].Child[c].Field['markaturan'].Child
                      [d].value = 2 then
                    begin
                      TandaiCellTabrak(Sheet, Baris + No, c + 2);
                      AtrnTbrk := AtrnTbrk + '[2]';
                      Break;
                    end;
                  end;
                end;
                Inc(JumError);
              end;
            end;
          end; // JumFitAturan[2]

          if JumFitAturan[3] <> 0 then
          begin
            for k := 1 to JumFitAturan[3] do
            begin
              Gen := k + JumFitAturan[1] + JumFitAturan[2];
              if (MatTabrak[Gen] = KdKelas) or (MatTabrak1[Gen] = KdKelas) then
              begin
                for c := 0 to Json.Field['fields'].Count - 1 do
                begin
                  for d := 0 to Json.Field['fields'].Child[c].Field
                    ['markaturan'].Count - 1 do
                  begin
                    if Json.Field['fields'].Child[c].Field['markaturan'].Child
                      [d].value = 3 then
                    begin
                      TandaiCellTabrak(Sheet, Baris + No, c + 2);
                      AtrnTbrk := AtrnTbrk + '[3]';
                      Break;
                    end;
                  end;
                end;
                Inc(JumError);
              end;
            end;
          end; // JumFitAturan[3]

          if JumFitAturan[4] <> 0 then
          begin
            for k := 1 to JumFitAturan[4] do
            begin
              Gen := k + JumFitAturan[1] + JumFitAturan[2] + JumFitAturan[3];
              if (MatTabrak[Gen] = KdKelas) or (MatTabrak1[Gen] = KdKelas) then
              begin
                for c := 0 to Json.Field['fields'].Count - 1 do
                begin
                  for d := 0 to Json.Field['fields'].Child[c].Field
                    ['markaturan'].Count - 1 do
                  begin
                    if Json.Field['fields'].Child[c].Field['markaturan'].Child
                      [d].value = 4 then
                    begin
                      TandaiCellTabrak(Sheet, Baris + No, c + 2);
                      AtrnTbrk := AtrnTbrk + '[4]';
                      Break;
                    end;
                  end;
                end;
                Inc(JumError);
              end;
            end;
          end; // JumFitAturan[4]

          if JumFitAturan[5] <> 0 then
          begin
            for k := 1 to JumFitAturan[5] do
            begin
              Gen := k + JumFitAturan[1] + JumFitAturan[2] + JumFitAturan[3]
                + JumFitAturan[4];
              if (MatTabrak[Gen] = KdKelas) or (MatTabrak1[Gen] = KdKelas) then
              begin
                for c := 0 to Json.Field['fields'].Count - 1 do
                begin
                  for d := 0 to Json.Field['fields'].Child[c].Field
                    ['markaturan'].Count - 1 do
                  begin
                    if Json.Field['fields'].Child[c].Field['markaturan'].Child
                      [d].value = 5 then
                    begin
                      TandaiCellTabrak(Sheet, Baris + No, c + 2);
                      AtrnTbrk := AtrnTbrk + '[5]';
                      Break;
                    end;
                  end;
                end;
                Inc(JumError);
              end;
            end;
          end; // JumFitAturan[5]

          // Aturan Pengajar
          if JumFitAturan[6] <> 0 then
          begin
            for k := 1 to JumFitAturan[6] do
            begin
              Gen := k + JumFitAturan[1] + JumFitAturan[2] + JumFitAturan[3]
                + JumFitAturan[4] + JumFitAturan[5];
              if (MatTabrak[Gen] = KdKelas) or (MatTabrak1[Gen] = KdKelas) then
              begin
                for c := 0 to Json.Field['fields'].Count - 1 do
                begin
                  for d := 0 to Json.Field['fields'].Child[c].Field
                    ['markaturan'].Count - 1 do
                  begin
                    if Json.Field['fields'].Child[c].Field['markaturan'].Child
                      [d].value = 6 then
                    begin
                      TandaiCellTabrak(Sheet, Baris + No, c + 2);
                      AtrnTbrk := AtrnTbrk + '[6]';
                      Break;
                    end;
                  end;
                end;
                Inc(JumError);
              end;
            end;
          end; // JumFitAturan[6]

          // Apabila Jam Awal adalah waktu istirahat
          if JumFitAturan[7] <> 0 then
          begin
            for k := 1 to JumFitAturan[7] do
            begin
              Gen := k + JumFitAturan[1] + JumFitAturan[2] + JumFitAturan[3]
                + JumFitAturan[4] + JumFitAturan[5] + JumFitAturan[6];
              if (MatTabrak[Gen] = KdKelas) or (MatTabrak1[Gen] = KdKelas) then
              begin
                for c := 0 to Json.Field['fields'].Count - 1 do
                begin
                  for d := 0 to Json.Field['fields'].Child[c].Field
                    ['markaturan'].Count - 1 do
                  begin
                    if Json.Field['fields'].Child[c].Field['markaturan'].Child
                      [d].value = 7 then
                    begin
                      TandaiCellTabrak(Sheet, Baris + No, c + 2);
                      AtrnTbrk := AtrnTbrk + '[7]';
                      Break;
                    end;
                  end;
                end;
                Inc(JumError);
              end;
            end;
          end; // JumFitAturan[7]

          // Kelasifikasi Kelas A B C
          if JumFitAturan[8] <> 0 then
          begin
            for k := 1 to JumFitAturan[8] do
            begin
              Gen := k + JumFitAturan[1] + JumFitAturan[2] + JumFitAturan[3]
                + JumFitAturan[4] + JumFitAturan[5] + JumFitAturan[6]
                + JumFitAturan[7];
              if (MatTabrak[Gen] = KdKelas) or (MatTabrak1[Gen] = KdKelas) then
              begin
                for c := 0 to Json.Field['fields'].Count - 1 do
                begin
                  for d := 0 to Json.Field['fields'].Child[c].Field
                    ['markaturan'].Count - 1 do
                  begin
                    if Json.Field['fields'].Child[c].Field['markaturan'].Child
                      [d].value = 8 then
                    begin
                      TandaiCellTabrak(Sheet, Baris + No, c + 2);
                      AtrnTbrk := AtrnTbrk + '[8]';
                      Break;
                    end;
                  end;
                end;
                Inc(JumError);
              end;
            end;
          end; // JumFitAturan[8]

          // Apabila Kegiatan ada di waktu Jum'at-an
          if JumFitAturan[9] <> 0 then
          begin
            for k := 1 to JumFitAturan[9] do
            begin
              Gen := k + JumFitAturan[1] + JumFitAturan[2] + JumFitAturan[3]
                + JumFitAturan[4] + JumFitAturan[5] + JumFitAturan[6]
                + JumFitAturan[7] + JumFitAturan[8];
              if (MatTabrak[Gen] = KdKelas) then
              begin
                for c := 0 to Json.Field['fields'].Count - 1 do
                begin
                  for d := 0 to Json.Field['fields'].Child[c].Field
                    ['markaturan'].Count - 1 do
                  begin
                    if Json.Field['fields'].Child[c].Field['markaturan'].Child
                      [d].value = 9 then
                    begin
                      TandaiCellTabrak(Sheet, Baris + No, c + 2);
                      AtrnTbrk := AtrnTbrk + '[9]';
                      Break;
                    end;
                  end;
                end;
                Inc(JumError);
              end;
            end;
          end; // JumFitAturan[9]

          // Tampilkan aturan2 yang dilanggar
          if DEBUG_MODE then
          begin
            Sheet.Cells[Baris + No, Json.Field['fields'].Count + 2] := AtrnTbrk;
          end;

          Inc(No);
          Inc(JumKelas);
        end;
        // Tampilkan header untuk data yang kosong
        if (I = RecordCount - 1) and
          (Json.Field['excel'].Field['showempty'].value) and not(IsAdaKuliah)
          then
        begin
          aValue := Json.Field['data'].Child[J].value;
          // Header di masing-masing tabel yang sejenis
          for c := 0 to Json.Field['header'].Count - 1 do
          begin
            headerKode := Json.Field['header'].Child[c].value;
            headerKode := StringReplace(headerKode, '|data|', aValue,
              [rfReplaceAll, rfIgnoreCase]);
            Sheet.Cells[Baris, 1] := ParseKode(headerKode, TblKegiatanQuery);
            oRange := Sheet.Range[CellRange[1] + IntToStr(Baris)
              + ':' + CellRange[2] + IntToStr(Baris)];
            oRange.Merge;
            oRange.HorizontalAlignment := 1;
            oRange.Font.Color := clBlue;
            oRange.Font.Bold := True;
            oRange.Interior.ColorIndex := 36;
            Baris := Baris + 1;
          end;
          // Membuat judul kolom
          oRange := Sheet.Range[CellRange[1] + IntToStr(Baris)
            + ':' + CellRange[2] + IntToStr(Baris)];
          oRange.Font.Bold := True;
          oRange.Font.Color := clGreen;
          oRange.Interior.ColorIndex := 36;
          Sheet.Cells[Baris, 1] := 'No';
          for c := 0 to Json.Field['fields'].Count - 1 do
          begin
            Sheet.Cells[Baris, c + 2] := Json.Field['fields'].Child[c].Field
              ['alias'].value;
          end;
        end;
        Next;
        ProgressBar.Position := ProgressBar.Position + 1;
      end; // for I
      if (IsAdaKuliah) or (Json.Field['excel'].Field['showempty'].value) then
      begin
        Sheet.Range[CellRange[1] + IntToStr(Baris - Json.Field['header'].Count)
          + ':' + CellRange[2] + IntToStr(Baris + No - 1)].Borders.Weight :=
          xlThin;
        Baris := Baris + 2 + No;
      end;
    end; // for Index
  end; // with TblKegiatanQuery, AG
  if DEBUG_MODE then
    Sheet.Cells[Baris + 1, 2] := 'Jumlah Kelas : ' + IntToStr(JumKelas);
  if (JumError > 0) then
  begin
    oRange := Sheet.Range[CellRange[1] + IntToStr(Baris) + ':' + CellRange[2]
      + IntToStr(Baris)];
    oRange.Merge;
    oRange.Font.Italic := True;
    oRange.Font.Bold := True;
    oRange.Font.Color := clRed;
    Sheet.Cells[Baris, 1] := '*** Masih ada jadwal yang kurang sesuai';
  end;
  Status := '';
end;

// ============================================================================

procedure TFrmPenjadwalan.CreateReportExecute(Sender: TObject);
var
  I: Integer;
  Xls: Variant;
  Sheet: array [1 .. 4] of Variant;
  jParams: TlkJSONobject;
  jData, jFields: TlkJSONList;
begin
  GenerateAG.Enabled := false;
  StartRegenerasi.Enabled := false;
  StopRegenerasi.Enabled := false;
  CreateReport.Enabled := false;
  with ProgressBar do
  begin
    Visible := True;
    Position := 0;
  end;
  Status := 'Memuat Jadwal...';
  AG.HitungFitness(1);
  try
    Xls := CreateOleobject('Excel.Application');
    Xls.Visible := false;
    Xls.Caption :=
      'Jadwal Kegiatan Akademik UBSI Menggunakan Algoritma Genetik (17090069)';
    Xls.Workbooks.Add;

    // Laporan Kelas =============================================================
    if 4 in ENABLEDLAPORAN then
    begin
      jParams := TlkJSONobject.Create;
      jData := TlkJSONList.Create;
      jFields := TlkJSONList.Create;
      jParams.Add('judul', TlkJSON.ParseText(
          '["Jadwal Kelas","Universitas BSI Bandung","Semester"]'));
      jParams.Add('excel', TlkJSON.ParseText(
          '{"status":"Memuat Jadwal Kelas..","sheetname":"Jadwal Kelas","showempty":false}'));
      jParams.Add('header', TlkJSON.ParseText('["Kelas : |data|"]'));
      jParams.Add('compfield', 'kode_kelas');

      if TblKelasDiajar.Active = false then
        TblKelasDiajar.Active := True;
      // TblKelasDiajar.Filtered := false;
      // TblKelasDiajar.Filter := 'grup="' + (TblGrup.Fields[0].AsString) + '"';
      // TblKelasDiajar.Filtered := True;
      TblKelasDiajar.First;
      for I := 0 to TblKelasDiajar.RecordCount - 1 do
      begin
        jData.Add(TlkJSONString.Generate(ParseKode(KODE_KELAS, TblKelasDiajar))
          );
        TblKelasDiajar.Next;
      end;
      TblKelasDiajar.Active := false;

      jParams.Add('data', jData);
      jFields.Add(TlkJSON.ParseText(
          '{"field":"matapelajaran","alias":"Mata Pelajaran","colwidth":27,"horalign":1,"markaturan":[]}'));
      jFields.Add(TlkJSON.ParseText(
          '{"field":"kode_pengajar","alias":"Kode Pengajar","colwidth":15,"horalign":3,"markaturan":[3]}'));
      jFields.Add(TlkJSON.ParseText(
          '{"field":"pengajar","alias":"Nama Pengajar","colwidth":23,"horalign":1,"markaturan":[3]}'));
      jFields.Add(TlkJSON.ParseText(
          '{"field":"hari","alias":"Hari","colwidth":10,"horalign":3,"markaturan":[2]}'));
      jFields.Add(TlkJSON.ParseText(
          '{"field":"ruang","alias":"Ruang","colwidth":7,"horalign":3,"markaturan":[2,3,5]}'));
      jFields.Add(TlkJSON.ParseText(
          '{"field":"jam_pertemuan","alias":"Jam Pertemuan","colwidth":15,"horalign":3,"markaturan":[1,2,3]}'));
      jParams.Add('fields', jFields as TlkJSONList);
      Sheet[4] := Xls.Workbooks[1].Sheets.Add;
      BuatLaporan(Sheet[4], jParams);
      FreeAndNil(jParams);
    end;
    // END Laporan Kelas =========================================================

    // Laporan Dosen =============================================================
    if 3 in ENABLEDLAPORAN then
    begin
      jParams := TlkJSONobject.Create;
      jData := TlkJSONList.Create;
      jFields := TlkJSONList.Create;
      jParams.Add('judul', TlkJSON.ParseText(
          '["Jadwal Pengajar","SMK Bina Sarana Cendikia","2013"]'));
      jParams.Add('excel', TlkJSON.ParseText(
          '{"status":"Memuat Jadwal Pengajar..","sheetname":"Jadwal Pengajar","showempty":false}'));
      jParams.Add('header', TlkJSON.ParseText(
          '["Kode Pengajar : |data|","Nama Pengajar : %pengajar%"]'));
      jParams.Add('compfield', 'kode_pengajar');

      // with ZQueryLaporan do begin
      // Active := False;
      // SQL.Text := 'SELECT DISTINCT p.kode FROM kegiatan k ' +
      // 'JOIN jurusan j ON k.jid = j.jid ' +
      // 'JOIN kelas kl ON k.kelasid = kl.kelasid '+
      // 'JOIN tingkat ti ON k.tingkatid = ti.tingkatid ' +
      // 'JOIN pengajar p ON k.pid = p.pid ' +
      // 'WHERE k.tingkatid = 0 ' +
      // 'ORDER BY p.kode ASC;';
      // end;

      if TblDosenMengajar.Active = false then
        TblDosenMengajar.Active := True;
      TblDosenMengajar.First;
      for I := 0 to TblDosenMengajar.RecordCount - 1 do
      begin
        jData.Add(TlkJSONString.Generate(TblDosenMengajar.FieldByName('kode')
              .AsString));
        TblDosenMengajar.Next;
      end;
      TblDosenMengajar.Active := false;

      jParams.Add('data', jData);
      jFields.Add(TlkJSON.ParseText(
          '{"field":"matapelajaran","alias":"Mata Pelajaran","colwidth":27,"horalign":1,"markaturan":[]}'));
      jFields.Add(TlkJSON.ParseText(
          '{"field":"kode_kelas","alias":"Kelas","colwidth":15,"horalign":3,"markaturan":[2,5]}'));
      jFields.Add(TlkJSON.ParseText(
          '{"field":"hari","alias":"Hari","colwidth":10,"horalign":3,"markaturan":[2,3]}'));
      jFields.Add(TlkJSON.ParseText(
          '{"field":"ruang","alias":"Ruang","colwidth":7,"horalign":3,"markaturan":[2,3,5]}'));
      jFields.Add(TlkJSON.ParseText(
          '{"field":"jam_pertemuan","alias":"Jam Pertemuan","colwidth":15,"horalign":3,"markaturan":[1,2,3]}'));
      jParams.Add('fields', jFields as TlkJSONList);
      Sheet[3] := Xls.Workbooks[1].Sheets.Add;
      BuatLaporan(Sheet[3], jParams);
      FreeAndNil(jParams);
    end;
    // END Laporan Dosen =========================================================

    // Laporan Hari =============================================================
    if 2 in ENABLEDLAPORAN then
    begin
      jParams := TlkJSONobject.Create;
      jData := TlkJSONList.Create;
      jFields := TlkJSONList.Create;
      jParams.Add('judul', TlkJSON.ParseText(
          '["Jadwal Kegiatan Belajar","SMK Bina Sarana Cendikia","2013"]'));
      jParams.Add('excel', TlkJSON.ParseText(
          '{"status":"Memuat Jadwal Hari..","sheetname":"Jadwal Hari","showempty":true}'));
      jParams.Add('header', TlkJSON.ParseText('["Hari : |data|"]'));
      jParams.Add('compfield', 'hari');
      for I := 0 to Length(AG.NamaHari) - 1 do
        jData.Add(TlkJSONString.Generate(AG.NamaHari[I]));
      jParams.Add('data', jData);
      jFields.Add(TlkJSON.ParseText(
          '{"field":"kode_kelas","alias":"Kelas","colwidth":15,"horalign":3,"markaturan":[2,5]}'));
      jFields.Add(TlkJSON.ParseText(
          '{"field":"matapelajaran","alias":"Mata Pelajaran","colwidth":27,"horalign":1,"markaturan":[]}'));
      jFields.Add(TlkJSON.ParseText(
          '{"field":"kode_pengajar","alias":"Kode Pengajar","colwidth":15,"horalign":3,"markaturan":[3,4]}'));
      jFields.Add(TlkJSON.ParseText(
          '{"field":"pengajar","alias":"Nama Pengajar","colwidth":23,"horalign":1,"markaturan":[3,4]}'));
      jFields.Add(TlkJSON.ParseText(
          '{"field":"ruang","alias":"Ruang","colwidth":7,"horalign":3,"markaturan":[2,3,5]}'));
      jFields.Add(TlkJSON.ParseText(
          '{"field":"jam_pertemuan","alias":"Jam Pertemuan","colwidth":15,"horalign":3,"markaturan":[1,2,3,4]}'));
      jFields.Add(TlkJSON.ParseText(
          '{"field":"jam","alias":"Jam","colwidth":4,"horalign":3,"markaturan":[]}'));
      jParams.Add('fields', jFields as TlkJSONList);
      Sheet[2] := Xls.Workbooks[1].Sheets.Add;
      BuatLaporan(Sheet[2], jParams);
      FreeAndNil(jParams);
    end;
    // END Laporan Hari ==========================================================

    // Laporan Utama =============================================================
    if 1 in ENABLEDLAPORAN then
    begin

      jParams := TlkJSONobject.Create;
      jParams.Add('judul', TlkJSON.ParseText(
          '["Jadwal Kegiatan Belajar","SMK BINA SARANA CENDIKIA","Jln.PHH Mustofa No.25 - Bandung"]'));
      jParams.Add('excel', TlkJSON.ParseText(
          '{"status":"Memuat Jadwal Umum..","sheetname":"Jadwal Umum","showempty":true}'));
      (*
        jParams.Add('header', TlkJSON.ParseText('["Hari : |data|"]'));
        jParams.Add('compfield', 'hari');
        jData := TlkJSONList.Create;
        jFields := TlkJSONList.Create;
        for I := 0 to Length(AG.NamaHari) - 1 do
        jData.Add(TlkJSONString.Generate(AG.NamaHari[I]));
        jParams.Add('data', jData);
        jFields.Add(TlkJSON.ParseText(
        '{"field":"kode_kelas","alias":"Kelas","colwidth":15,"horalign":3,"markaturan":[2,3,8]}'));
        jFields.Add(TlkJSON.ParseText(
        '{"field":"matapelajaran","alias":"Mata Pelajaran","colwidth":27,"horalign":1,"markaturan":[]}'));
        jFields.Add(TlkJSON.ParseText(
        '{"field":"kode_pengajar","alias":"Kode Pengajar","colwidth":15,"horalign":3,"markaturan":[4,5]}'));
        jFields.Add(TlkJSON.ParseText(
        '{"field":"pengajar","alias":"Nama Pengajar","colwidth":23,"horalign":1,"markaturan":[4,5]}'));
        jFields.Add(TlkJSON.ParseText(
        '{"field":"ruang","alias":"Ruang","colwidth":7,"horalign":3,"markaturan":[2,4,5,8]}'));
        jFields.Add(TlkJSON.ParseText(
        '{"field":"jam_pertemuan","alias":"Jam Pertemuan","colwidth":15,"horalign":3,"markaturan":[1,2,4,5,7,9]}'));
        jFields.Add(TlkJSON.ParseText(
        '{"field":"jam","alias":"Jam","colwidth":4,"horalign":3,"markaturan":[]}')
        );
        jParams.Add('fields', jFields as TlkJSONList);
        *)
      Sheet[1] := Xls.Workbooks[1].Sheets.Add;
      BuatLaporan2(Sheet[1], jParams);
      FreeAndNil(jParams);
    end;
    // END Laporan Utama ==========================================================

    ProgressBar.Visible := false;
    Xls.Visible := True;
    Xls.UserControl := True;
  except
    on E: Exception do
    begin
      // Xls := nil;
      MessageDLG(E.Message, MTError, [MBOk], 0);
    end;
  end;
  GenerateAG.Enabled := True;
  StartRegenerasi.Enabled := True;
  StopRegenerasi.Enabled := True;
  CreateReport.Enabled := True;
end;
(*
  procedure TFrmPenjadwalan.ApplicationIdle(Sender: TObject; var Done: Boolean);
  var
  pt: TPoint;
  w: Hwnd;
  ItemBuffer: array [0 .. 256] of Char;
  idx: Integer;
  s: string;
  begin
  pt := Mouse.CursorPos;
  w := WindowFromPoint(pt);
  if w = 0 then
  Exit;

  GetClassName(w, ItemBuffer, SizeOf(ItemBuffer));
  if StrIComp(ItemBuffer, 'ComboLBox') = 0 then
  begin
  Windows.ScreenToClient(w, pt);
  idx := SendMessage(w, LB_ITEMFROMPOINT, 0, LParam(PointToSmallPoint(pt)));
  if idx >= 0 then
  begin
  if LB_ERR <> SendMessage(w, LB_GETTEXT, idx, LParam(@ItemBuffer)) then
  begin
  s := 'Mouse over item: ' + #13#10 + Format
  ('Combo.Name: %s,%sItem.Text: %s', [ActiveControl.Name, #13#10,
  ItemBuffer]);

  ComboItemLabel.Caption := s;

  // explained  later
  hw.DoActivateHint(ActiveControl.Name + ItemBuffer,
  'Hint for: ' + ItemBuffer);
  end;
  end;
  end;
  end; ApplicationIdle *)

end.
