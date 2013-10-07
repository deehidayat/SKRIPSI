unit SESSION;

interface

uses
  XMLLog, XMLSetting, Windows, SysUtils, Variants, Classes, Graphics, Controls,
  Forms;

const
  // Konstanta U/ Excel
  xlVAlignCenter = -4108;
  xlThin = 2;
  xlEdgeBottom = 9;
  xlDouble = -4119;
  xlThick = 4;
  xl3DColumn = -4100;
  xlColumns = 2;
  xlLocationAsObject = 2;

  // Konstanta U/ Aplikasi
  SETTING_FILE = 'libs\setting.xml';
  SECURITY_FILE = 'libs\security.dll';
  LOG_FILE = 'libs\log.xml';
  SECURITY_KEY = 'MJ6jYlEHUIeVR7Nx';
  POPULATION_SIZE = 10;
  KEY_FIELD = 'kid';

  {
    JAM_KULIAH: array [0 .. 13] of string = ('08.00', '09.00', '10.00', '11.00',
    '12.00', '13.00', '14.00', '15.00', '16.00', '17.00', '18.00', '19.00',
    '20.00', '21.00');
    }
  {
    JAM_KULIAH: array [0 .. 17] of string = ('07.00', '07.45', '08.30', '09.15',
    '10.00', '10.15', '11.00', '11.45', '12.30', '12.45', '13.25', '14.05',
    '14.45', '15.25', '15.40', '16.20', '17.00', '17.40');
    HARI_KULIAH: array [0 .. 5] of string = ('Senin', 'Selasa', 'Rabu', 'Kamis',
    'Jum''at', 'Sabtu');
    KELAS_KULIAH: array [0 .. 3] of string = ('-','A', 'B', 'C');
    SKS_KULIAH: array [0 .. 2] of string = ('2', '3', '4');
    TINGKAT: array[0..2] of string = ('X','XI','XII');

    }
  // SIGN: array [0 .. 5] of char = ('.', ',', '/', '-', '!', '>');
  // ENABLEATURAN: array [1 .. 10] of boolean = (True, True, True, True, True, True, True, True, True, True);
  // ENABLEATURAN: array [1 .. 10] of boolean = (False, False, False, False, False, False, False, False, True, False);
  // ENABLELAPORAN: array [1 .. 4] of boolean = (True, False, False, False);
type
  TUserDB = record
    Protocol: string;
    Host: string;
    Name: string;
    User: string;
    Password: string;
  end;

type
  TSkin = record
    Aktif: boolean;
    Template: string;
  end;

var
  JAM_PERTEMUAN_FIELD: string = 'jam';
  APP_SETTING: IXMLDeehiedayType;
  DEE_LOG: IXMLDeehiedaylogType;
  BASE_PATH: string;
  SYSDIR32: array [0 .. MAX_PATH] of char;
  DEBUG_MODE: boolean = false;
  TA_DB: TUserDB;
  SPLASH_IMG: string;
  CurrYear, CurrDate, CurrMonth: word;
  KODE_KELAS: string;
  SKIN: TSkin;
  ENABLEDATURAN: set of 1 .. 10 = [1..10];
  ENABLEDLAPORAN: set of 1 .. 4 = [1..4];
  MAX_ITERASI : integer = 1000;
  PB_CROSS : integer = 25;
  PB_MUTASI : integer = 1;
  TGT_FITNESS : integer;

implementation

uses ShellAPI, Consts;

// procedure untuk split string
procedure Split(const Delimiter: char; Input: string; const Strings: TStrings);
begin
  Assert(Assigned(Strings));
  Strings.Clear;
  Strings.Delimiter := Delimiter;
  Strings.DelimitedText := Input;
end;

procedure PreLoaded();
var
  i: integer;
  A : TStringList;
begin
  // SKIN.Aktif := True;
  // SKIN.Template := 'Mint';
  BASE_PATH := ExtractFilePath(Application.ExeName);
  if (FileExists(BASE_PATH + SETTING_FILE)) then
  begin
    APP_SETTING := Loaddeehieday(BASE_PATH + SETTING_FILE);
    if not(FileExists(BASE_PATH + LOG_FILE)) then
    begin
      DEE_LOG := Newdeehiedaylog;
      DEE_LOG.OwnerDocument.SaveToFile(BASE_PATH + LOG_FILE);
    end
    else
      DEE_LOG := Loaddeehiedaylog(BASE_PATH + LOG_FILE);
    if APP_SETTING.Jpfield <> '' then
      JAM_PERTEMUAN_FIELD := APP_SETTING.Jpfield;
    DEBUG_MODE := APP_SETTING.Debug = 'true';
    TA_DB.Protocol := APP_SETTING.Database.Protocol;
    TA_DB.Name := APP_SETTING.Database.Name;
    TA_DB.Host := APP_SETTING.Database.Host;
    TA_DB.User := APP_SETTING.Database.User;
    TA_DB.Password := APP_SETTING.Database.Password;
    SPLASH_IMG := BASE_PATH + 'assets\' + APP_SETTING.Splashimage;
    KODE_KELAS := APP_SETTING.Kodekelas;
    SKIN.Aktif := APP_SETTING.SKIN.Aktif = 'true';
    SKIN.Template := APP_SETTING.SKIN.Template;

    A := TStringList.Create;
    Split(',', APP_SETTING.ExAturan, A);
    for I := 0 to A.Count - 1 do Exclude(ENABLEDATURAN,StrToInt(A[I]));
    //FreeAndNil(A);
    Split(',', APP_SETTING.ExLaporan, A);
    for I := 0 to A.Count - 1 do Exclude(ENABLEDLAPORAN,StrToInt(A[I]));
    //FreeAndNil(A);
    A.Free;

  end;
  GetSystemDirectory(@SYSDIR32, MAX_PATH);
  DecodeDate(Now, CurrYear, CurrMonth, CurrDate);
  ThousandSeparator := '.';
  DateSeparator := '/';
  TimeSeparator := ':';
  ShortDateFormat := 'dd/mm/yyyy';
  ShortTimeFormat := 'hh:nn:ss';
  LongTimeFormat := 'hh:nn:ss';
  // LongDateFormat := 'dd/mm/yyyy';
  // LongDateFormat := 'dddd dd of mmmm yyyy'; //http://www.delphibasics.co.uk/RTL.asp?Name=LongDateFormat
  // FormatDateTime('c', myDate); //http://www.delphibasics.co.uk/RTL.asp?Name=FormatDateTime
end;

// --------------------------------------------------------------------------------
// Customisasi Message Dialog dengan menggunakan Bahasa Indonesia
const
  _NewSMsgDlgWarning = 'Peringatan';
  _NewSMsgDlgError = 'Kesalahan';
  _NewSMsgDlgInformation = 'Informasi';
  _NewSMsgDlgConfirm = 'Konfirmasi';
  _NewSMsgDlgYes = '&Ya';
  _NewSMsgDlgNo = '&Tidak';
  _NewSMsgDlgOK = '&OK';
  _NewSMsgDlgCancel = '&Batal';
  _NewSMsgDlgHelp = '&Panduan';
  _NewSMsgDlgHelpNone = 'Panduan tidak tersedia';
  _NewSMsgDlgHelpHelp = 'Panduan';
  _NewSMsgDlgAbort = '&Batal';
  _NewSMsgDlgRetry = '&Ulang';
  _NewSMsgDlgIgnore = 'A&cuh';
  _NewSMsgDlgAll = '&Semua';
  _NewSMsgDlgNoToAll = 'T&idak untuk Semua';
  _NewSMsgDlgYesToAll = 'Y&a untuk Semua';

  { -- taken from bpCodeReplacement.pas by Bayu Prasetio }
procedure ReplaceResourceString(RStringRec: PResStringRec; AString: PChar);
var
  OldProtect: Cardinal;
begin
  if RStringRec = nil then
    Exit;
  if VirtualProtect(RStringRec, SizeOf(RStringRec^), PAGE_EXECUTE_READWRITE,
    OldProtect) then
  begin
    RStringRec^.Identifier := integer(AString);
    VirtualProtect(RStringRec, SizeOf(RStringRec^), OldProtect, @OldProtect);
  end;
end;

initialization

ReplaceResourceString(@SMsgDlgWarning, _NewSMsgDlgWarning);
ReplaceResourceString(@SMsgDlgError, _NewSMsgDlgError);
ReplaceResourceString(@SMsgDlgInformation, _NewSMsgDlgInformation);
ReplaceResourceString(@SMsgDlgConfirm, _NewSMsgDlgConfirm);
ReplaceResourceString(@SMsgDlgYes, _NewSMsgDlgYes);
ReplaceResourceString(@SMsgDlgNo, _NewSMsgDlgNo);
ReplaceResourceString(@SMsgDlgOK, _NewSMsgDlgOK);
ReplaceResourceString(@SMsgDlgCancel, _NewSMsgDlgCancel);
ReplaceResourceString(@SMsgDlgHelp, _NewSMsgDlgHelp);
ReplaceResourceString(@SMsgDlgHelpNone, _NewSMsgDlgHelpNone);
ReplaceResourceString(@SMsgDlgHelpHelp, _NewSMsgDlgHelpHelp);
ReplaceResourceString(@SMsgDlgAbort, _NewSMsgDlgAbort);
ReplaceResourceString(@SMsgDlgRetry, _NewSMsgDlgRetry);
ReplaceResourceString(@SMsgDlgIgnore, _NewSMsgDlgIgnore);
ReplaceResourceString(@SMsgDlgAll, _NewSMsgDlgAll);
ReplaceResourceString(@SMsgDlgNoToAll, _NewSMsgDlgNoToAll);
ReplaceResourceString(@SMsgDlgYesToAll, _NewSMsgDlgYesToAll);
PreLoaded();

end.
