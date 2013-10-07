unit pengajar;

interface

uses
  DML, PARENT, Windows, Messages, SysUtils, Variants, Classes, Graphics, 
  Controls, Forms, Dialogs, DB, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls, Mask, Buttons, 
  ZAbstractRODataset, ZAbstractDataset, ZDataset, sDBMemo, sDBEdit, sLabel,
  sGroupBox, acDBGrid, sPanel;

type
  TFrmPengajar = class(TFormDee)
    Panel1: TsPanel;
    DBEdit1: TsDBEdit;
    DBEdit3: TsDBEdit;
    Label1: TsLabel;
    Label4: TsLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPengajar: TFrmPengajar;

implementation

uses datamodul;
{$R *.dfm}

procedure TFrmPengajar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmPengajar := nil;
end;

procedure TFrmPengajar.FormCreate(Sender: TObject);
begin
  self.FiterField := 'pengajar';
  inherited;
end;

end.