unit PARENT;

interface

uses
  DML, DB, ZDataset, ZAbstractRODataset, ZAbstractDataset, Grids, DBGrids,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TFormDee = class(TForm)
    FrmDML: TfrmDML;
  private
    { Private declarations }
    _FiterField: string;
    procedure SetFilterField(field: string);

  protected
    { Fungsi Yang Ingin diturunkan }
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DSourceStateChange(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DrawColumnCellOnSelect(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    // property MouseOverRow : integer read fMouseOverRow write SetMouseOverRow; 
    procedure DBGridTitleClick(Column: TColumn);
    procedure TblFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure FormDeactivate(Sender: TObject);
    property FiterField: string write SetFilterField;
  public
    { Public declarations }
  end;

implementation

procedure TFormDee.FormCreate(Sender: TObject);
begin
  FrmDML.DBGrid.DataSource.OnStateChange := DSourceStateChange;
  if _FiterField<>'' then  
    FrmDML.DBGrid.DataSource.DataSet.OnFilterRecord := TblFilterRecord
  else begin
    FrmDML.EdtSearch.Visible := False;
    FrmDML.BtnSearch.Visible := False;
  end;
  Self.OnDeactivate := FormDeactivate;
  // Self.OnClose := FormClose; 
end;

procedure TFormDee.FormDeactivate(Sender: TObject);
begin
  FrmDML.EdtSearch.Text := '';
end;

procedure TFormDee.SetFilterField(field: string);
begin
  _FiterField := field;
end;

procedure TFormDee.TblFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  if _FiterField <> '' then
    Accept := Pos(LowerCase(FrmDML.EdtSearch.Text), LowerCase
        (DataSet.FieldByName(_FiterField).AsString)) > 0
  else
    Accept := False;
end;

procedure TFormDee.FormClose(Sender: TObject; var Action: TCloseAction);
var
  confirm: Integer;
begin
  if Not(FrmDML = nil) then
    with FrmDML.DSource.DataSet do
    begin
      if (Active = True) and ((State = dsEdit) or (State = dsInsert)) then
      begin
        confirm := MessageDlg('Simpan data ?', MTConfirmation,
          [MBYes, MBNo, MBCancel], 0);
        if confirm = MRYes then
          FrmDML.DBConfirm.Execute
        else if confirm = MRNo then
          FrmDML.DBCancel.Execute
        else
        begin
          Action := caNone;
          Exit;
        end;
      end;
    end;
  Action := caFree;
  // Self := nil; 
end;

procedure TFormDee.DSourceStateChange(Sender: TObject);
begin
  with (Sender as TDataSource).DataSet do
  begin
    if (State = dsInsert) or (State = dsEdit) then
      FrmDML.ToggleState(False)
    else
      FrmDML.ToggleState(True);
  end;
end;

procedure TFormDee.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
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

procedure TFormDee.DrawColumnCellOnSelect(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if gdSelected IN State then
  begin (Sender as TDBGrid)
    .Canvas.Brush.Color := clRed; (Sender as TDBGrid)
    .Canvas.Font.Color := clWhite; (Sender as TDBGrid)
    .Canvas.Font.Style := (Sender as TDBGrid).Font.Style + [fsBold];
(Sender as TDBGrid)
    .Canvas.FillRect(Rect);
    // (Sender as TDBGrid).Canvas.TextRect(Rect, Rect.Left, Rect.Top, Column.Field.Value); 
(Sender as TDBGrid)
    .DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TFormDee.DBGridTitleClick(Column: TColumn);
var
  Tabel: TZTable;
  Query: TZQuery;
begin
  if Column.Grid.DataSource.DataSet.ClassType = TZTable then
    Tabel := Column.Grid.DataSource.DataSet as TZTable
  else if Column.Grid.DataSource.DataSet.ClassType = TZQuery then
    Query := Column.Grid.DataSource.DataSet as TZQuery;

  if Query.SortedFields = Column.FieldName then
    if Query.SortType = stAscending then
      Query.SortType := stDescending
    else
      Query.SortType := stAscending
    else
    begin
      Query.SortedFields := Column.FieldName;
      Query.SortType := stAscending;
    end;
end;

end.
