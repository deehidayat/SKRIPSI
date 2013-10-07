unit matapelajaran;

interface

uses
  DML, PARENT, Windows, Messages, SysUtils, Variants, Classes, Graphics, 
  Controls, Forms, Dialogs, DB, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls, Mask, Buttons, 
  ZAbstractRODataset, ZAbstractDataset, ZDataset, sDBMemo, sDBEdit, sLabel,
  sGroupBox, acDBGrid, sPanel;

type
  TFrmMatapelajaran = class(TFormDee)
    Panel1: TsPanel;
    DBEdit3: TsDBEdit;
    Label1: TsLabel;
    Label4: TsLabel;
    sDBEdit1: TsDBEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMatapelajaran: TFrmMatapelajaran;

implementation

uses datamodul;
{$R *.dfm}

procedure TFrmMatapelajaran.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmMatapelajaran := nil;
end;

procedure TFrmMatapelajaran.FormCreate(Sender: TObject);
begin
  self.FiterField := 'matapelajaran';
  inherited;
end;

end.