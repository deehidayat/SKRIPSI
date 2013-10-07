unit debugdb;

interface

uses
  StrUtils, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms,
  Dialogs, StdCtrls, sLabel, sGroupBox, Buttons, sSpeedButton, sEdit, sComboBox;

type
  TFrmDebugDB = class(TForm)
    sGroupBox1: TsGroupBox;
    Label1: TsLabel;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    Edit1: TsEdit;
    Edit2: TsEdit;
    Edit3: TsEdit;
    Edit4: TsEdit;
    SpeedButton1: TsSpeedButton;
    ComboBox1: TsComboBox;
    sLabel4: TsLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDebugDB: TFrmDebugDB;

implementation

uses SESSION, datamodul;
{$R *.dfm}
function Encode(Data: String; Key: String): String; stdcall;
external SECURITY_FILE;
function Decode(Data: String; Key: String): String; stdcall;
external SECURITY_FILE;

function OpenDB(DBase: TUserDB): Boolean;
begin
  with FrmDataModul do
  begin
    if DB.Connected = True then
      DB.Connected := False;
    if (DBase.Protocol = 'sqlite-3') then
    begin
      DB.Database := BASE_PATH + DBase.Name;
    end
    else if (AnsiContainsText(DBase.Protocol, 'mysql')) then
    begin
      DB.Database := DBase.Name;
      DB.HostName := DBase.Host;
      DB.User := DBase.User;
      if (DBase.Password <> '') then
        DB.Password := Decode(DBase.Password, SECURITY_KEY)
      else
        DB.Password := '';
    end;
    DB.AutoCommit := True;
    DB.Protocol := DBase.Protocol;
    try
      DB.Connect;
      Result := DB.Connected;
    except
      on E: Exception do
      begin
        Result := False;
      end;
    end;
  end;
end;

procedure TFrmDebugDB.FormCreate(Sender: TObject);
begin
  Edit1.Text := TA_DB.Name;
  Edit2.Text := TA_DB.Host;
  Edit3.Text := TA_DB.User;
  Edit4.Text := '';
  ComboBox1.ItemIndex := ComboBox1.IndexOf(TA_DB.Protocol);
end;

procedure TFrmDebugDB.SpeedButton1Click(Sender: TObject);
var
  DB: TUserDB;
begin
  DB.Name := Edit1.Text;
  DB.Host := Edit2.Text;
  DB.User := Edit3.Text;
  if Edit4.Text <> '' then  
  DB.Password := Encode(Edit4.Text,SECURITY_KEY);
  DB.Protocol := ComboBox1.Text;
  if OpenDB(DB) then
    MessageDLG('Konfigurasi OK', MTInformation, [MBOk], 0)
  else
    MessageDLG('Konfigurasi Gagal', MTWarning, [MBOk], 0);
end;

end.
