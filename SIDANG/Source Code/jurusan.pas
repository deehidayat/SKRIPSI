unit jurusan;

interface

uses
  DML, PARENT, Windows, Messages, SysUtils, Variants, Classes, Graphics, 
  Controls, Forms, Dialogs, StdCtrls, Mask, DBCtrls, sDBEdit, sLabel, sGroupBox, acDBGrid,
  ExtCtrls, sPanel;

type
  TFrmJurusan = class(TFormDee)
    Panel1: TsPanel;
    DBEdit2: TsDBEdit;
    DBEdit1: TsDBEdit;
    Label2: TsLabel;
    Label1: TsLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmJurusan: TFrmJurusan;

implementation

uses datamodul;

{$R *.dfm}

procedure TFrmJurusan.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmJurusan := nil;
end;


procedure TFrmJurusan.FormCreate(Sender: TObject);
begin
  self.FiterField := 'jurusan';
  inherited;
end;

end.