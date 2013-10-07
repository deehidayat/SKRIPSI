unit kegiatan;

interface

uses
  DML, PARENT, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, DB, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls,
  Mask, Buttons,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, sDBMemo, sDBEdit, sLabel,
  sGroupBox, acDBGrid, sPanel, sButton, sComboBox;

type
  TFrmKegiatan = class(TFormDee)
    Panel1: TsPanel;
    DBEdit3: TsDBEdit;
    Label1: TsLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    DSJurusan: TDataSource;
    DBLookupComboBox2: TDBLookupComboBox;
    DSMatapelajaran: TDataSource;
    DSPengajar: TDataSource;
    DBLookupComboBox3: TDBLookupComboBox;
    DBGrid1: TDBGrid;
    DSQuery: TDataSource;
    ZQuery: TZQuery;
    ZQuerykid: TIntegerField;
    ZQuerytingkat: TWideStringField;
    ZQueryjurusan: TWideStringField;
    ZQuerykelas: TWideStringField;
    ZQuerymatapelajaran: TWideStringField;
    ZQueryjam: TIntegerField;
    ZQuerypengajar: TWideStringField;
    DSKelas: TDataSource;
    DBLookupComboBox5: TDBLookupComboBox;
    DBLookupComboBox6: TDBLookupComboBox;
    DSTingkat: TDataSource;
    ZQuerytingkatid: TIntegerField;
    ZQueryjid: TIntegerField;
    ZQuerykode_jurusan: TWideStringField;
    ZQuerykelasid: TIntegerField;
    ZQuerympid: TIntegerField;
    ZQuerykode_matapelajaran: TWideStringField;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    sLabel4: TsLabel;
    sLabel5: TsLabel;
    sPanel1: TsPanel;
    ComboBox1: TsComboBox;
    ComboBox2: TsComboBox;
    ComboBox3: TsComboBox;
    sButton1: TsButton;
    ZQuerypid: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DSQueryDataChange(Sender: TObject; Field: TField);
    procedure ComboBox1Change(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure ToggleState(Status: Boolean = True);
    procedure DSourceStateChange(Sender: TObject);
  public
    { Public declarations }
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
  FrmKegiatan: TFrmKegiatan;

implementation

uses datamodul, SESSION, TypInfo;
{$R *.dfm}

constructor TString.Create(const AStr: String);
begin
  inherited Create;
  fStr := AStr;
end;

procedure FreeObjects(const strings: TStrings);
var
  idx: integer;
begin
  for idx := 0 to Pred(strings.Count) do
  begin
    strings.Objects[idx].Free;
    strings.Objects[idx] := nil;
  end;
end;

procedure TFrmKegiatan.ComboBox1Change(Sender: TObject);
var
  Query: string;
  tingkat, jurusan, kelas: string;
begin
  // ShowMessage(TString(ComboBox1.Items.Objects[ComboBox1.ItemIndex]).Str);
  if ComboBox1.ItemIndex > -1 then
    tingkat := TString(ComboBox1.Items.Objects[ComboBox1.ItemIndex]).Str;
  if ComboBox2.ItemIndex > -1 then
    jurusan := TString(ComboBox2.Items.Objects[ComboBox2.ItemIndex]).Str;
  if ComboBox3.ItemIndex > -1 then
    kelas := TString(ComboBox3.Items.Objects[ComboBox3.ItemIndex]).Str;
  FrmDML.DSource.DataSet.Filtered := False;
  FrmDML.DSource.DataSet.Filter := '';
  ZQuery.Filtered := False;
  ZQuery.Filter := '';

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

  FrmDML.DSource.DataSet.Filter := Query;
  FrmDML.DSource.DataSet.Filtered := True;
  FrmDML.DSource.DataSet.First;
  ZQuery.Filter := Query;
  ZQuery.Filtered := True;
  ZQuery.First;
end;

procedure TFrmKegiatan.DSQueryDataChange(Sender: TObject; Field: TField);
begin
  FrmDML.DBGrid.DataSource.DataSet.Locate('kid', ZQuery.FieldByName('kid')
      .AsInteger, []);
end;

procedure TFrmKegiatan.FormActivate(Sender: TObject);
begin
  ZQuery.Refresh;
end;

procedure TFrmKegiatan.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  inherited;
  FrmKegiatan := nil;
  FreeObjects(ComboBox1.Items);
  FreeObjects(ComboBox2.Items);
  FreeObjects(ComboBox3.Items);
end;

procedure TFrmKegiatan.FormCreate(Sender: TObject);
var
  i: integer;
begin
  // self.FiterField := 'matapelajaran';
  inherited;
  DBGrid1.OnDrawColumnCell := DBGridDrawColumnCell;
  ZQuery.Active := True;

  if DEBUG_MODE then
    DBGrid1.Visible := False;

  ComboBox1.Items.Clear;
  with FrmDataModul.TblTingkat do
    for i := 1 to RecordCount do
    begin
      RecNo := i;
      ComboBox1.Items.AddObject(FieldByName('tingkat').AsString, TString.Create
          (FieldByName('tingkatid').AsString));
    end;

  ComboBox2.Items.Clear;
  with FrmDataModul.TblJurusan do
    for i := 1 to RecordCount do
    begin
      RecNo := i;
      ComboBox2.Items.AddObject(FieldByName('kode').AsString, TString.Create
          (FieldByName('jid').AsString));
    end;

  ComboBox3.Items.Clear;
  with FrmDataModul.TblKelas do
    for i := 1 to RecordCount do
    begin
      RecNo := i;
      ComboBox3.Items.AddObject(FieldByName('kelas').AsString, TString.Create
          (FieldByName('kelasid').AsString));
    end;

  FrmDML.DSource.OnStateChange := DSourceStateChange;
end;

procedure TFrmKegiatan.sButton1Click(Sender: TObject);
begin
  ComboBox1.ItemIndex := -1;
  ComboBox2.ItemIndex := -1;
  ComboBox3.ItemIndex := -1;
  FrmDML.DSource.DataSet.Filtered := False;
end;

procedure TFrmKegiatan.DSourceStateChange(Sender: TObject);
begin
  if (FrmDML.DSource.State = dsInsert) or (FrmDML.DSource.State = dsEdit) then
    ToggleState(False)
  else if (FrmDML.DSource.State = dsBrowse) or
    (FrmDML.DSource.State = dsFilter) then
    ToggleState(True);
end;

procedure TFrmKegiatan.ToggleState(Status: Boolean = True);
begin
  if Status then
    ZQuery.Refresh;
  DBGrid1.Enabled := Status;
end;

end.
