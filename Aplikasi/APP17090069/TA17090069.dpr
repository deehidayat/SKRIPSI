program TA17090069;

uses
  Forms,
  datamodul in 'datamodul.pas' {FrmDataModul: TDataModule},
  index in 'index.pas' {FrmIndex},
  PARENT in 'PARENT.pas',
  DML in 'DML.pas' {FrmDML: TFrame},
  XMLSetting in 'XMLSetting.pas',
  XMLLog in 'XMLLog.pas',
  ruangan in 'ruangan.pas' {FrmRuangan},
  splashscreen in 'splashscreen.pas' {FrmSplashScreen},
  debugdb in 'debugdb.pas' {FrmDebugDB},
  jurusan in 'jurusan.pas' {FrmJurusan},
  SESSION in 'SESSION.pas',
  pengajar in 'pengajar.pas' {FrmPengajar},
  matapelajaran in 'matapelajaran.pas' {FrmMatapelajaran},
  kegiatan in 'kegiatan.pas' {FrmKegiatan},
  penjadwalan in 'penjadwalan.pas' {FrmPenjadwalan},
  uLkJSON in 'uLkJSON.pas',
  MODULE in 'MODULE.pas',
  pengajar_aturan in 'pengajar_aturan.pas' {FrmPengajarAturan},
  configag in 'configag.pas' {FrmConfigAG},
  OKegiatan in 'OKegiatan.pas',
  ORuangan in 'ORuangan.pas',
  OAturanPengajar in 'OAturanPengajar.pas',
  about in 'about.pas' {FrmAbout};

{*.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  FrmSplashScreen := TFrmSplashScreen.Create(Application);
  FrmSplashScreen.LblMessage.Caption := 'Buka Aplikasi..';
  FrmSplashScreen.Show;
  FrmSplashScreen.Update;
  while FrmSplashScreen.Timer1.Enabled do Application.ProcessMessages;
  FrmSplashScreen.LblMessage.Caption := 'Inisialisasi Aplikasi..';
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  FrmSplashScreen.LblMessage.Caption := 'Load Form..';
  Application.Title := 'UBSI-17090069';
  Application.CreateForm(TFrmDataModul, FrmDataModul);
  Application.CreateForm(TFrmIndex, FrmIndex);
  Application.CreateForm(TFrmConfigAG, FrmConfigAG);
  Application.CreateForm(TFrmAbout, FrmAbout);
  if FrmDataModul.DB.Connected = true then
    Application.CreateForm(TFrmPenjadwalan, FrmPenjadwalan)
  else
    Application.CreateForm(TFrmDebugDB, FrmDebugDB);
  FrmSplashScreen.LblMessage.Caption := 'Run..';
  FrmSplashScreen.Hide;
  FrmSplashScreen.Free;
  Application.Run;
end.
