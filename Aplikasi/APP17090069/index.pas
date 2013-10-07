unit index;

interface

uses
  SESSION, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ComCtrls, ToolWin, ZDataset, StdCtrls, ActnList,
  ActnMan,
  ActnCtrls, ExtCtrls, Menus, StdActns, ExtActns, StrUtils, XPMan, ImgList,
  PlatformDefaultStyleActnCtrls, Buttons, Jpeg, sSpeedButton, sPanel,
  sSkinManager, acAlphaImageList;

type
  TFrmIndex = class(TForm)
    ShowPengajar: TAction;
    ShowJurusan: TAction;
    XPManifest1: TXPManifest;
    ShowMatapelajaran: TAction;
    Panel1: TsPanel;
    SpeedButton2: TsSpeedButton;
    SpeedButton3: TsSpeedButton;
    SpeedButton4: TsSpeedButton;
    ShowKegiatan: TAction;
    SpeedButton6: TsSpeedButton;
    ShowPenjadwalan: TAction;
    SpeedButton7: TsSpeedButton;
    imgBgMain: TImage;
    sSkinManager1: TsSkinManager;
    ActionList1: TActionList;
    ShowRuangan: TAction;
    SpeedButton8: TsSpeedButton;
    ShowPA: TAction;
    sSpeedButton1: TsSpeedButton;
    ImgToolbar: TsAlphaImageList;

    procedure FormCreate(Sender: TObject);
    procedure ShowSettingExecute(Sender: TObject);
    procedure ShowRuanganExecute(Sender: TObject);
    procedure ShowJurusanExecute(Sender: TObject);
    procedure ShowPengajarExecute(Sender: TObject);
    procedure ShowMatapelajaranExecute(Sender: TObject);
    procedure ShowKegiatanExecute(Sender: TObject);
    procedure ShowPenjadwalanExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ShowPAExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmIndex: TFrmIndex;

implementation

uses datamodul, ruangan, jurusan, pengajar, matapelajaran, kegiatan,
  penjadwalan, pengajar_aturan;
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
      if (TA_DB.Password <> '') then
        DB.Password := Decode(DBase.Password, SECURITY_KEY)
      else
        DB.Password := '';
    end;
    DB.AutoCommit := True;
    DB.Protocol := DBase.Protocol;
    try
      DB.Connect;
    except
      on E: Exception do
      begin
      end;
    end;
    Result := DB.Connected = True;
  end;
end;

procedure TFrmIndex.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    if FrmRuangan <> nil then
      FrmRuangan.Close;
    if FrmPengajar <> nil then
      FrmPengajar.Close;
    if FrmJurusan <> nil then
      FrmJurusan.Close;
    if FrmMatapelajaran <> nil then
      FrmMatapelajaran.Close;
    if FrmKegiatan <> nil then
      FrmKegiatan.Close;
    if FrmPenjadwalan <> nil then
      FrmPenjadwalan.Close;
    FrmDataModul.DB.Connected := False;
  except
  end;
end;

procedure TFrmIndex.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  with FrmDataModul do
  begin
    if OpenDB(TA_DB) then
    begin
      for i := 0 to ComponentCount - 1 do
      begin
        if Components[i] is TZTable then (Components[i] as TZTable)
          .Active := True;
      end;
      sSkinManager1.Active := SKIN.Aktif;
      sSkinManager1.SkinName := SKIN.Template;
    end
    else
    begin
      MessageDLG('Tidak bisa menghubungkan ke Database Periksa Konfigurasi', MTError, [MBOk], 0);
      ActionList1.State := asSuspended;
    end;
    // ShowMessage(Encode('Dede',SECURITY_KEY));
  end;
end;

procedure TFrmIndex.ShowJurusanExecute(Sender: TObject);
begin
  if (FrmJurusan = nil) then
  begin
    FrmJurusan := TFrmJurusan.Create(Application);
  end;
  FrmJurusan.Show;
end;

procedure TFrmIndex.ShowKegiatanExecute(Sender: TObject);
begin
  if (FrmKegiatan = nil) then
  begin
    FrmKegiatan := TFrmKegiatan.Create(Application);
  end;
  FrmKegiatan.Show;
end;

procedure TFrmIndex.ShowMatapelajaranExecute(Sender: TObject);
begin
  if (FrmMatapelajaran = nil) then
  begin
    FrmMatapelajaran := TFrmMatapelajaran.Create(Application);
  end;
  FrmMatapelajaran.Show;
end;

procedure TFrmIndex.ShowPAExecute(Sender: TObject);
begin
  if (FrmPengajarAturan = nil) then
  begin
    FrmPengajarAturan := TFrmPengajarAturan.Create(Application);
  end;
  FrmPengajarAturan.Show;
end;

procedure TFrmIndex.ShowPengajarExecute(Sender: TObject);
begin
  if (FrmPengajar = nil) then
  begin
    FrmPengajar := TFrmPengajar.Create(Application);
  end;
  FrmPengajar.Show;
end;

procedure TFrmIndex.ShowPenjadwalanExecute(Sender: TObject);
begin
  if (FrmPenjadwalan = nil) then
  begin
    FrmPenjadwalan := TFrmPenjadwalan.Create(Application);;
  end;
  FrmPenjadwalan.Show;
end;

procedure TFrmIndex.ShowRuanganExecute(Sender: TObject);
begin
  if (FrmRuangan = nil) then
  begin
    FrmRuangan := TFrmRuangan.Create(Application);;
  end;
  FrmRuangan.Show;
end;

procedure TFrmIndex.ShowSettingExecute(Sender: TObject);
begin
end;

{
  procedure TFrmIndex.CreateJson;
  var
  js:TlkJSONobject;
  ws: TlkJSONstring;
  s: String;
  i: Integer;
  begin
  js := TlkJSONobject.Create;
  //  js.add('namestring', TlkJSONstring.Generate('namevalue'));
  js.Add('namestring','namevalue');
  // get the text of object
  s := TlkJSON.GenerateText(js);
  //memo1.Lines.Add(s);

  // (ver 1.03+) generate readable text
  i := 0;
  s := GenerateReadableText(js,i);
  //memo1.Lines.Add(s);

  js.Free;
  // restore object (parse text)
  js := TlkJSON.ParseText(s) as TlkJSONobject;
  // and get String back
  // old syntax
  ws := js.Field['namestring'] as TlkJSONstring;
  s := ws.Value;
  //memo1.Lines.Add(s);
  // syntax of 0.99+
  s := js.getString('namestring');
  //memo1.Lines.Add(s);

  js.Free;

  end;
}

end.
