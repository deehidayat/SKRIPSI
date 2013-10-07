unit pengajar_aturan;

interface

uses
  DML, PARENT, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, DB, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls,
  Mask, Buttons,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, sDBMemo, sDBEdit, sLabel,
  sGroupBox, acDBGrid, sPanel, ZAbstractTable;

type
  TFrmPengajarAturan = class(TFormDee)
    Panel1: TsPanel;
    Panel2: TPanel;
    Edit1: TEdit;
    DBGrid3: TDBGrid;
    DSPengajar: TDataSource;
    TblPengajar: TZTable;
    TblPengajarpid: TIntegerField;
    TblPengajarkode: TWideStringField;
    TblPengajarpengajar: TWideStringField;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DSHari: TDataSource;
    DSJam: TDataSource;
    DBLookupComboBox1: TDBLookupComboBox;
    DSQuery: TDataSource;
    ZQuery: TZQuery;
    DBGrid1: TDBGrid;
    ZQueryhariid: TIntegerField;
    ZQueryhari: TWideStringField;
    ZQueryjamid: TIntegerField;
    ZQueryjam: TWideStringField;
    ZQuerypid: TIntegerField;
    ZQuerypaid: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure TblFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure DSQueryDataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure ToggleState(Status: Boolean = True);
    procedure DSourceStateChange(Sender: TObject);
    procedure DSourceUpdateData(Sender: TObject);
  public
    { Public declarations }
  end;

var
  FrmPengajarAturan: TFrmPengajarAturan;

implementation

uses datamodul, SESSION;
{$R *.dfm}

procedure TFrmPengajarAturan.DSQueryDataChange(Sender: TObject; Field: TField);
begin
  FrmDML.DBGrid.DataSource.DataSet.Locate('paid', ZQuery.FieldByName('paid')
      .AsInteger, []);
end;

procedure TFrmPengajarAturan.Edit1Change(Sender: TObject);
begin
  FrmDataModul.DSPengajar.DataSet.Filtered := False;
  if not(Edit1.Text = '') then
    FrmDataModul.DSPengajar.DataSet.Filtered := True;
end;

procedure TFrmPengajarAturan.FormActivate(Sender: TObject);
begin
  ZQuery.Refresh;
end;

procedure TFrmPengajarAturan.FormClose
  (Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmPengajarAturan := nil;
end;

procedure TFrmPengajarAturan.FormCreate(Sender: TObject);
var
  i: integer;
begin
  // self.FiterField := 'hari';
  inherited;
  DBGrid1.OnDrawColumnCell := DBGridDrawColumnCell;
  ZQuery.Active := True;
  TblPengajar.Active := True;

  FrmDML.DSource.OnStateChange := DSourceStateChange;
  FrmDML.DSource.OnUpdateData := DSourceUpdateData;

  if DEBUG_MODE then
    DBGrid1.Visible := False;
end;

procedure TFrmPengajarAturan.TblFilterRecord
  (DataSet: TDataSet; var Accept: Boolean);
begin ;
  Accept := Pos(LowerCase(Edit1.Text), LowerCase(DataSet.FieldByName('kode')
        .AsString)) > 0;
end;

procedure TFrmPengajarAturan.DSourceStateChange(Sender: TObject);
begin
  if (FrmDML.DSource.State = dsInsert) or (FrmDML.DSource.State = dsEdit) then
    ToggleState(False)
  else if (FrmDML.DSource.State = dsBrowse) then
    ToggleState(True);
end;

procedure TFrmPengajarAturan.DSourceUpdateData(Sender: TObject);
begin
end;

procedure TFrmPengajarAturan.ToggleState(Status: Boolean);
begin
  if Status then ZQuery.Refresh;
  DBGrid1.Enabled := Status;
end;

end.
