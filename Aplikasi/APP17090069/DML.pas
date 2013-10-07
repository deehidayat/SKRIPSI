unit DML;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, DB, ActnList, ImgList,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, sPanel, sEdit, sBitBtn,
  sSpeedButton, acDBGrid, sLabel;

type
  TFrmDML = class(TFrame)
    Panel1: TsPanel;
    BtnAdd: TsBitBtn;
    BtnEdit: TsBitBtn;
    DSource: TDataSource;
    ActionList: TActionList;
    DBAdd: TAction;
    DBEdit: TAction;
    DBDelete: TAction;
    DBConfirm: TAction;
    DBCancel: TAction;
    ImageListDML: TImageList;
    Query: TZQuery;
    BtnDelete: TsSpeedButton;
    DBGrid: TsDBGrid;
    EdtSearch: TsEdit;
    BtnSearch: TsSpeedButton;
    DBClear: TAction;
    BtnRefresh: TsSpeedButton;
    DBRefresh: TAction;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    function Validation(): Boolean;
    procedure ToggleState(Status: Boolean = True);
    procedure Requery();
    procedure DBAddExecute(Sender: TObject);
    procedure DBEditExecute(Sender: TObject);
    procedure DBDeleteExecute(Sender: TObject);
    procedure DBConfirmExecute(Sender: TObject);
    procedure DBCancelExecute(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DBGridTitleClick(Column: TColumn);
    procedure DBRefreshExecute(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtSearchChange(Sender: TObject);
    procedure DBClearExecute(Sender: TObject);
    procedure DBGridMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DSourceDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  SortField: String;
  SortType: String;

implementation

uses datamodul;
{$R *.dfm}

procedure TFrmDML.ToggleState(Status: Boolean = True);
begin
  if Status = True then
  begin
    BtnAdd.Action := DBAdd;
    BtnEdit.Action := DBEdit;
  end
  else
  begin
    BtnAdd.Action := DBConfirm;
    BtnEdit.Action := DBCancel;
  end;

  DBGrid.Enabled := Status;
  DBRefresh.Enabled := Status;
  DBClear.Enabled := Status;
  DBDelete.Enabled := Status;
end;

function TFrmDML.Validation(): Boolean;
var
  options: TLocateOptions;
  zTable: TZTable;
  tableName: String;
begin
  with DSource.DataSet do
  begin
    if (ClassType = TZTable) then
      zTable := (DSource.DataSet as TZTable);
    Query.Close;
    Query.SQL.Text := 'select count(*) from ' + zTable.tableName + ' where ' +
      zTable.Fields[0].FieldName + '=:value';
    Query.Params.ParamValues['value'] := Fields[0].AsVariant;
    Query.Open;
    if State = dsInsert then
    begin
      if Query.RecordCount >= 1 then
        result := False;
    end
    else if State = dsEdit then
    begin
      if Query.RecordCount > 1 then
        result := False;
    end;
    ShowMessage(IntToStr(Query.RecordCount));
  end;
end;

procedure TFrmDML.Requery();
var
  zTable: TZTable;
  zQuery: TZQuery;
begin
  if (DSource.DataSet.ClassType = TZTable) then
  begin
    if (DSource.DataSet.ClassType = TZTable) then
      zTable := (DSource.DataSet as TZTable);
    with zTable do
    begin
      if (tableName = 'dosen') then
      begin
        // FrmDataModul.TblDosenJurusan.Refresh;
      end
      else if (tableName = 'jurusan') then
      begin
        // FrmDataModul.TblDosenJurusan.Refresh;
        // FrmDataModul.TblMatakuliah.Refresh;
      end;
    end;
  end
  else if (DSource.DataSet.ClassType = TZQuery) then
  begin
    if (DSource.DataSet.ClassType = TZQuery) then
      zQuery := (DSource.DataSet as TZQuery);
    zQuery.Close;
    zQuery.Open;
  end;

end;

procedure TFrmDML.DBAddExecute(Sender: TObject);
begin
  DSource.DataSet.Append;
  ToggleState(False);
end;

procedure TFrmDML.DBEditExecute(Sender: TObject);
begin
  DSource.DataSet.Edit;
  ToggleState(False);
end;

procedure TFrmDML.DBGridDblClick(Sender: TObject);
begin
  DBEdit.Execute;
end;

procedure TFrmDML.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if ((Sender as TDBGrid).DataSource.DataSet.RecNo mod 2) = 0 then
  (Sender as TDBGrid)
    .Canvas.Brush.Color := $00E1FFF9
  else (Sender as TDBGrid)
    .Canvas.Brush.Color := $00FFEBDF;
  if gdSelected IN State then
  begin (Sender as TDBGrid)
    .Canvas.Brush.Color := clBlue; (Sender as TDBGrid)
    .Canvas.Font.Color := clWhite; (Sender as TDBGrid)
    .Canvas.Font.Style := [fsBold]; (Sender as TDBGrid)
    .Canvas.FillRect(Rect);
  end; (Sender as TDBGrid)
  .DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFrmDML.DBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    46:
      DBDelete.Execute;
    27:
      DBCancel.Execute;
  end;
end;

procedure TFrmDML.DBGridMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  pt: TGridcoord;
begin
  pt := DBGrid.MouseCoord(X, Y);

  if pt.Y = 0 then
    DBGrid.Cursor := crHandPoint
  else
    DBGrid.Cursor := crDefault;
end;

procedure TFrmDML.DBGridTitleClick(Column: TColumn);
var
  tabel: TZTable;
begin
  tabel := DSource.DataSet as TZTable;
  if tabel.SortedFields = Column.FieldName then
  begin
    if tabel.SortType = stAscending then
      tabel.SortType := stDescending
    else
      tabel.SortType := stAscending;
  end
  else
  begin
    tabel.SortedFields := Column.FieldName;
    tabel.SortType := stAscending;
  end;
end;

procedure TFrmDML.DBRefreshExecute(Sender: TObject);
begin
  DSource.DataSet.Refresh;
end;

procedure TFrmDML.DSourceDataChange(Sender: TObject; Field: TField);
begin
  with DSource.DataSet do
  begin
    sLabel1.Caption := IntToStr(RecNo);
    sLabel2.Caption := IntToStr(RecordCount);
  end;
end;

procedure TFrmDML.DBClearExecute(Sender: TObject);
begin
  EdtSearch.Text := '';
end;

procedure TFrmDML.EdtSearchChange(Sender: TObject);
begin
  DSource.DataSet.Filtered := False;
  if not(EdtSearch.Text = '') then
    DSource.DataSet.Filtered := True;
end;

procedure TFrmDML.DBDeleteExecute(Sender: TObject);
begin
  try
    if MessageDlg('Hapus data ?', MTConfirmation, [MBYes, MBNo], 0) = MRYes then
      DSource.DataSet.Delete;
  except
    on E: Exception do
    begin
      DSource.DataSet.Cancel;
      MessageDlg(E.ToString, MTWarning, [MBok], 0);
    end;
  end;
end;

procedure TFrmDML.DBConfirmExecute(Sender: TObject);
begin
  try
    DSource.DataSet.Post;
    ToggleState(True);
  except
    on E: Exception do
    begin
      DSource.DataSet.Cancel;
      MessageDlg(E.ToString, MTWarning, [MBok], 0);
    end;
  end;
end;

procedure TFrmDML.DBCancelExecute(Sender: TObject);
begin
  DSource.DataSet.Cancel;
  ToggleState(True);
end;

end.
