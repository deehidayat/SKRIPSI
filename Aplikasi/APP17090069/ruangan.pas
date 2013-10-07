unit ruangan;

interface

uses
  DML, PARENT, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, sDBMemo, sDBEdit, sLabel,
  sGroupBox, acDBGrid, StdCtrls, Mask, DBCtrls, ExtCtrls, sPanel;

type
  TFrmRuangan = class(TFormDee)
    Panel1: TsPanel;
    DBEdit1: TsDBEdit;
    Label1: TsLabel;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRuangan: TFrmRuangan;

implementation

uses datamodul;
{$R *.dfm}

procedure TFrmRuangan.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmRuangan := nil;
end;

procedure TFrmRuangan.FormCreate(Sender: TObject);
begin
  self.FiterField := 'ruangan';
  inherited;
end;

end.
