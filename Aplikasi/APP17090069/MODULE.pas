unit MODULE;

interface

uses SESSION, OKegiatan, ORuangan, OAturanPengajar, Forms, Classes, Dialogs,
  Sysutils, Messages;

const
  JUM_ATURAN = 10;

type
  RANGE_KROM = 1 .. POPULATION_SIZE + 2;

  TKromosom = array of String;

  TAlelle = record
    Hari: String;
    Ruang: String;
    Jam: String;
    KodeJam: integer;
    KodeHari: integer;
    KodeRuang: integer;
  end;

  TAGenetika = class

  private
    // Data Dari Database
    NilaiFitness: array [RANGE_KROM] of integer;

    function AmbilIndex(KdKelas: String): integer;
    procedure KombinasiHariRuangJam;
    procedure UrutKromosom;
    function CekKromCross(Index: integer): integer;
    function AmbilNamaJam(Index: integer): String;

    // JUMLAHRUANG,JUMLAHJAM,JUMLAHHARI : Integer;
    function GetJumHari: integer;
    function GetJumRuang: integer;
    function GetJumJam: integer;
    function GetJumGen: integer;

  protected

  public
    // Komponen
    Kegiatan: array of TKegiatan;
    Kromosom: array [RANGE_KROM] of TKromosom;
    NamaHari, NamaJam: TArray<string>;
    Ruangan: TArray<TRuangan>;
    AturanPengajar: array of TAturanPengajar;

    // Parameter
    PbCross: real;
    PbMutasi: real;
    TgFitness: integer;

    JumFitAturan: array [1 .. JUM_ATURAN] of integer;
    Alelle: array of TAlelle; // Alelle / GEN

    constructor Create(aHari, aJam: TArray<string>; aRuang: TArray<TRuangan>);
    destructor Destroy; Override;

    function AmbilKromosom(NoKromosom, Gen: integer): String;
    function AmbilFitness(NoKromosom: integer): integer;
    function AmbilHari(KdKelas: String): String;
    function AmbilRuang(KdKelas: String): String;
    function AmbilJam(KdKelas: String): String;
    function AmbilKodeJam(KdKelas: String): integer;
    function AmbilJamPertemuan(KdKelas: String; JP: integer): String;
    function AmbilKegiatan(KdKelas: String): TKegiatan;
    function AmbilRuangan(NamaRuangan: String): TRuangan;
    function AmbilAturanPengajar(Pengajar: integer): TArray<TAturanPengajar>;

    procedure BangkitkanPopulasi();
    procedure HitungFitness(NoKromosom: integer);
    procedure CrossOver;
    procedure Mutasi;
    procedure UrutSolusi;

    property JUMLAHHARI: integer read GetJumHari;
    property JUMLAHRUANG: integer read GetJumRuang;
    property JUMLAHJAM: integer read GetJumJam;
    property JUMLAHGEN: integer read GetJumGen;

  end;

var
  PosGenTabrk: integer;
  MatTabrak: array [1 .. 1000] of String;
  MatTabrak1: array [1 .. 1000] of String;

implementation

uses penjadwalan, datamodul;

constructor TAGenetika.Create(aHari, aJam: TArray<string>;
  aRuang: TArray<TRuangan>);
begin
  NamaHari := Copy(aHari, 0, Length(aHari));
  NamaJam := Copy(aJam, 0, Length(aJam));
  Ruangan := Copy(aRuang, 0, Length(aRuang));
  KombinasiHariRuangJam();
end;

procedure TAGenetika.KombinasiHariRuangJam();
var
  i, j, k, Gen: integer;
begin
  SetLength(Alelle, JUMLAHGEN);
  Gen := 0;
  for i := 0 to JUMLAHHARI - 1 do
  begin
    for j := 0 to JUMLAHRUANG - 1 do
    begin
      for k := 0 to JUMLAHJAM - 1 do
      begin
        Alelle[Gen].Hari := NamaHari[i];
        Alelle[Gen].Ruang := Ruangan[j].Ruangan;
        Alelle[Gen].Jam := NamaJam[k];
        Alelle[Gen].KodeHari := i;
        Alelle[Gen].KodeRuang := j;
        Alelle[Gen].KodeJam := k;
        Gen := Gen + 1;
      end;
    end;
  end;
end;

// DYNAMIC PROPERTY
function TAGenetika.GetJumHari: integer;
begin
  Result := Length(NamaHari);
end;

function TAGenetika.GetJumRuang: integer;
begin
  Result := Length(Ruangan);
end;

function TAGenetika.GetJumJam: integer;
begin
  Result := Length(NamaJam) - 1;
end;

function TAGenetika.GetJumGen: integer;
begin
  Result := JUMLAHRUANG * JUMLAHJAM * JUMLAHHARI;
end;

function TAGenetika.AmbilKegiatan(KdKelas: String): TKegiatan;
var
  i, j: integer;
begin
  if KdKelas = '0' then
  begin
    Result := nil;
    Exit;
  end;
  j := Length(Kegiatan);
  for i := 0 to j - 1 do
  begin
    if Kegiatan[i].id = KdKelas then
    begin
      Result := Kegiatan[i];
      Break;
    end;
  end;
end;

function TAGenetika.AmbilRuangan(NamaRuangan: String): TRuangan;
var
  i, j: integer;
begin
  if NamaRuangan = '' then
  begin
    Result := nil;
    Exit;
  end;
  j := Length(Ruangan);
  for i := 0 to j - 1 do
  begin
    if Ruangan[i].Ruangan = NamaRuangan then
    begin
      Result := Ruangan[i];
      Break;
    end;
  end;
end;

function TAGenetika.AmbilAturanPengajar(Pengajar: integer)
  : TArray<TAturanPengajar>;
var
  i, j, k: integer;
begin
  Result := nil;
  j := Length(AturanPengajar);
  k := 0;
  for i := 0 to j - 1 do
  begin
    if AturanPengajar[i].Pengajar = Pengajar then
    begin
      SetLength(Result, k + 1);
      Result[k] := AturanPengajar[i];
      k := k + 1;
      // Break;
    end;
  end;
end;
// END DYNAMIC PROPERTY

// PEMBUATAN LAPORAN
function TAGenetika.AmbilKromosom(NoKromosom, Gen: integer): String;
begin
  Result := Kromosom[NoKromosom][Gen];
end;

function TAGenetika.AmbilFitness(NoKromosom: integer): integer;
begin
  Result := NilaiFitness[NoKromosom];
end;

function TAGenetika.AmbilIndex(KdKelas: String): integer;
var
  i: integer;
begin
  for i := 0 to JUMLAHGEN - 1 do
  begin
    if Kromosom[1][i] = KdKelas then
    begin
      Result := i;
      Exit;
    end;
  end;
  Result := -1;
end;

function TAGenetika.AmbilHari(KdKelas: String): String;
var
  ind: integer;
begin
  ind := AmbilIndex(KdKelas);
  if ind = -1 then
  begin
    Result := '-----';
    Exit;
  end;
  Result := Alelle[ind].Hari;
end;

function TAGenetika.AmbilRuang(KdKelas: String): String;
var
  ind: integer;
begin
  ind := AmbilIndex(KdKelas);
  if ind = -1 then
  begin
    Result := '----';
    Exit;
  end;
  Result := Alelle[ind].Ruang;
end;

function TAGenetika.AmbilJam(KdKelas: String): String;
var
  ind: integer;
begin
  ind := AmbilIndex(KdKelas);
  if ind = -1 then
  begin
    Result := '-----';
    Exit;
  end;
  Result := Alelle[ind].Jam;
end;

function TAGenetika.AmbilKodeJam(KdKelas: String): integer;
var
  ind: integer;
begin
  ind := AmbilIndex(KdKelas);
  if ind = -1 then
  begin
    Result := 0;
    Exit;
  end;
  Result := Alelle[ind].KodeJam;
end;

function TAGenetika.AmbilNamaJam(Index: integer): String;
begin
  if Index <= (JUMLAHJAM) then
    Result := NamaJam[Index]
  else
    Result := 'OVER';
end;

function TAGenetika.AmbilJamPertemuan(KdKelas: String; JP: integer): String;
var
  KJams: array [1 .. 3] of integer;
begin
  KJams[1] := AmbilKodeJam(KdKelas);
  KJams[2] := KJams[1] + JP;
  Result := AmbilNamaJam(KJams[1]) + ' - ' + AmbilNamaJam(KJams[2]);
  // Result := IntToStr(KJams[1])+'-'+IntToStr(KJams[2])+ ' = '  + AmbilNamaJam(KJams[1])+' - '+AmbilNamaJam(KJams[2])
end;
// END PEMBUATAN LAPORAN

// =====================  PROSES ALGORITMA GENETIKA  ===========================

// SORTIR
procedure TAGenetika.UrutKromosom;
var
  i, j, k, Fitness1, Fitness2: integer;
  BantuKromosom: array [1 .. 2] of TKromosom;
begin
  SetLength(BantuKromosom[1], JUMLAHGEN);
  SetLength(BantuKromosom[2], JUMLAHGEN);
  for i := 1 to POPULATION_SIZE - 1 do
  begin
    for j := i + 1 to POPULATION_SIZE do
    begin
      Fitness1 := NilaiFitness[i];
      Fitness2 := NilaiFitness[j];
      for k := 0 to JUMLAHGEN - 1 do
      begin
        BantuKromosom[1][k] := Kromosom[i][k];
        BantuKromosom[2][k] := Kromosom[j][k];
      end;
      if Fitness1 > Fitness2 then
      begin
        NilaiFitness[i] := Fitness2;
        NilaiFitness[j] := Fitness1;
        for k := 0 to JUMLAHGEN - 1 do
        begin
          Kromosom[i][k] := BantuKromosom[2][k];
          Kromosom[j][k] := BantuKromosom[1][k]
        end;
      end
      else if Fitness1 <= Fitness2 then
      begin
        NilaiFitness[i] := Fitness1;
        for k := 0 to JUMLAHGEN - 1 do
          Kromosom[i][k] := BantuKromosom[1][k];
      end;
    end;
  end;
end;
// END SORTIR

procedure TAGenetika.UrutSolusi;
type
  TDetailGen = record
    id: string;
    pos: integer;
  end;

  TSummary = record
    kelas: integer;
    total: integer;
    Hari: array [0 .. 5] of integer;
    hasAwal: array [0 .. 5] of boolean;
  end;

var
  CurrSolusi: array of array of array of array of TDetailGen;
  Summary: array of TSummary;
  JumKegiatan: array of integer;
  i, j, k, l, TotalGen: integer;
  CurrKegiatan: TKegiatan;
begin

  TotalGen := JUMLAHGEN;
  // Sortir current solusi untuk memudahkan pencarian Fitness;
  // Apabila disimpan di SQL proses menjadi lambat;
  with FrmPenjadwalan do
  begin
    if TblKelasDiajar.Active = false then
      TblKelasDiajar.Active := True;
    SetLength(CurrSolusi, TblKelasDiajar.RecordCount, JUMLAHHARI, JUMLAHJAM);
    // SetLength(JumKegiatan, TblKelasDiajar.RecordCount);
    SetLength(Summary, TblKelasDiajar.RecordCount);
    for i := 0 to TblKelasDiajar.RecordCount - 1 do
    begin
      TblKelasDiajar.RecNo := i + 1;
      for j := 0 to TotalGen - 1 do
      begin
        // TblKegiatanQuery.Locate(KEY_FIELD, Solusi[j].id, []);
        CurrKegiatan := AmbilKegiatan(Kromosom[1][j]);
        if Assigned(CurrKegiatan) and
          (CurrKegiatan.tingkat = TblKelasDiajar.FieldByName('tingkatid')
            .AsInteger) and (CurrKegiatan.jurusan = TblKelasDiajar.FieldByName
            ('jid').AsInteger) and
          (CurrKegiatan.kelas = TblKelasDiajar.FieldByName('kelasid')
            .AsInteger) then
        begin
          k := Length(CurrSolusi[i][Alelle[j].KodeHari][Alelle[j].KodeJam]);
          SetLength(CurrSolusi[i][Alelle[j].KodeHari][Alelle[j].KodeJam],
            k + 1);
          CurrSolusi[i][Alelle[j].KodeHari][Alelle[j].KodeJam][k].id := Kromosom
            [1][j];
          CurrSolusi[i][Alelle[j].KodeHari][Alelle[j].KodeJam][k].pos := j;
          // JumKegiatan[i] := JumKegiatan[i] + 1;
          Summary[i].total := Summary[i].total + 1;
          Summary[i].Hari[Alelle[j].KodeHari] := Summary[i].Hari
            [Alelle[j].KodeHari] + 1;
          if (Alelle[j].KodeJam = 0) then
          begin
            Summary[i].hasAwal[Alelle[j].KodeHari] := True;
          end;
        end;
      end;
    end;
  end;

  with FrmPenjadwalan do
  begin
    for i := 0 to TblKelasDiajar.RecordCount - 1 do
    begin
      for j := 0 to 5 do
      begin
        if (Summary[i].Hari[j] <> 0) and (Summary[i].hasAwal[j] = false) then
        begin
          l := 0;
          for k := 0 to JUMLAHJAM - 1 do
          begin
            if Length(CurrSolusi[i][j][k]) > 0 then
            begin
              l := l + 1;
              if l = Summary[i].Hari[j] then
              begin
                Kromosom[1][CurrSolusi[i][j][k][0].pos - k] := CurrSolusi[i][j]
                  [k][0].id;
                Kromosom[1][CurrSolusi[i][j][k][0].pos] := '0';
                // SetLength(CurrSolusi[i][j][0], Length(CurrSolusi[i][j][0]) + 1);
                // CurrSolusi[i][j][0][Length(CurrSolusi[i][j][0])-1].id := CurrSolusi[i][j][k][0].id;
                // CurrSolusi[i][j][k][0].pos := CurrSolusi[i][j][k][0].pos - k;
                Break;
                // CurrSolusi[i][j][k][0].pos;
                // ShowMessage('dee');
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  HitungFitness(1);
  // ShowMessage('dee');
end;

// Hitung Fittnes : Sesuaikan dengan aturan2 yang ingin diterapkan
procedure TAGenetika.HitungFitness(NoKromosom: integer);
type
  TDetailGen = record
    id: string;
    pos: integer;
  end;

  TSummary = record
    kelas: integer;
    total: integer;
    Hari: array [0 .. 5] of integer;
    hasAwal: array [0 .. 5] of boolean;
  end;
var
  Temp, Fitness, i, j, k, l, Index: integer;
  // JedaHari, IndRuang, IndHari, TotalGen: integer;

  JumKuliah: array of array of array of integer;
  Semester1, KodeMtk1, Dosen1, Kelas1, Jurusan1, Hari1: integer;
  Semester2, KodeMtk2, Dosen2, Kelas2, Jurusan2, Hari2: integer;
  JP1, JP2, Ruang1, Ruang2: integer;

  // CurrSolusi: array of array of array of array of TDetailGen;
  // Summary: array of TSummary;
  // JumKegiatan: array of integer;
  // HasJadwal, hasAwal: boolean;
  Solusi: array of TDetailGen;
  CurrKegiatan: TKegiatan;
  CurrRuangan: TRuangan;
  CurrAturanPengajar: TArray<TAturanPengajar>;

  procedure AturanOJI();
  var
    i, j, k: integer;
  begin
    // Overtime, Jumatan, Waktu Istirahat, dan bentrok ruangan sebelum waktu habis
    try
      for k := 0 to Length(Solusi) - 1 do
      begin
        i := Solusi[k].pos;
        if Kromosom[NoKromosom][i] <> '0' then
        begin
          CurrKegiatan := AmbilKegiatan(Kromosom[NoKromosom][i]);
          JP1 := Alelle[i].KodeJam;
          JP2 := JP1 + CurrKegiatan.Jam;
          Hari1 := Alelle[i].KodeHari;
          // KodeMtk1 := CurrKegiatan.matapelajaran;
          // Over Time
          if JP2 > JUMLAHJAM then
          begin
            Fitness := Fitness + 1;
            PosGenTabrk := i;
            MatTabrak[Fitness] := Kromosom[NoKromosom][i];
            MatTabrak1[Fitness] := Kromosom[NoKromosom][i];
          end
          // Jumatan
          else if (Hari1 = 4) and (JP1 >= 7) and (JP1 <= 8) then
          begin
            Fitness := Fitness + 1;
            PosGenTabrk := i;
            MatTabrak[Fitness] := Kromosom[NoKromosom][i];
            MatTabrak1[Fitness] := Kromosom[NoKromosom][i];
          end
          // Jam Istirahat
          else if (JP1 = 4) or (JP1 = 8) or (JP1 = 13) then
          begin
            Fitness := Fitness + 1;
            PosGenTabrk := i;
            MatTabrak[Fitness] := Kromosom[NoKromosom][i];
            MatTabrak1[Fitness] := Kromosom[NoKromosom][i];
          end
          // Apabila ada mata pelajaran dalam satu ruangan seblum jam habis..
          else
          begin
            j := 1;

            if ((JP1 < 4) and (JP2 >= 5)) or ((JP1 < 13) and (JP2 >= 14)) or
              ((Hari1 <> 4) and (JP1 < 8) and (JP2 >= 9)) then
              j := j + 1
            else if (Hari1 = 4) and (JP1 = 6) and (JP2 >= 7) then
              j := j + 2;
            {
              if ((JP1 < 4) and (JP2 >= 5)) or ((JP1 < 8) and (JP2 >= 9)) or
              ((JP1 < 13) and (JP2 >= 14)) then
              j := j + 1;
              }
            if (JP2 - JP1 = 2) or (JP2 - JP1 = 3) or (JP2 - JP1 = 4) then
            begin
              if (Kromosom[NoKromosom][i + j] <> '0') and
                (Alelle[i].KodeRuang = Alelle[i + j].KodeRuang) then
              begin
                Fitness := Fitness + 1;
                PosGenTabrk := i;
                MatTabrak[Fitness] := Kromosom[NoKromosom][i];
                MatTabrak1[Fitness] := Kromosom[NoKromosom][i + j];
              end;
            end;
            if (JP2 - JP1 = 3) or (JP2 - JP1 = 4) then
            begin
              if (Kromosom[NoKromosom][i + j + 1] <> '0') and
                (Alelle[i].KodeRuang = Alelle[i + j + 1].KodeRuang) then
              begin
                Fitness := Fitness + 1;
                PosGenTabrk := i;
                MatTabrak[Fitness] := Kromosom[NoKromosom][i];
                MatTabrak1[Fitness] := Kromosom[NoKromosom][i + j + 1];
              end;
            end;
            if (JP2 - JP1 = 4) then
            begin
              if (Kromosom[NoKromosom][i + j + 2] <> '0') and
                (Alelle[i].KodeRuang = Alelle[i + j + 2].KodeRuang) then
              begin
                Fitness := Fitness + 1;
                PosGenTabrk := i;
                MatTabrak[Fitness] := Kromosom[NoKromosom][i];
                MatTabrak1[Fitness] := Kromosom[NoKromosom][i + j + 2];
              end;
            end;
          end;
        end; // if <> 0
      end; // for i

    except
      FrmPenjadwalan.StopRegenerasi.Execute;
      MessageDLG('Terjadi Kesalahan Sistem [Aturan OJI] !!!', MTWarning,
        [MBOk], 0);
    end;
  end;

  procedure AturanKelas();
  var
    i, j, k: integer;
    JedaHari, IndRuang, IndHari: integer;
  begin
    // Kelas berada lebih dari satu ruangan pada waktu yg sama
    try
      IndRuang := 1;
      IndHari := 1;
      JedaHari := JUMLAHRUANG * JUMLAHJAM;
      // with FrmPenjadwalan.TblKegiatanQuery do
      // begin
      for i := 0 to JUMLAHGEN - 1 do
      begin
        if (i >= ((IndHari - 1) * JedaHari)) and
          (i < ((IndHari * JedaHari) - JUMLAHJAM)) then
        begin
          for j := 1 to JUMLAHRUANG - IndRuang do
          begin
            if (Kromosom[NoKromosom][i] <> '0') and
              (Alelle[i].KodeJam < JUMLAHJAM) then
            begin
              if i + (j * JUMLAHJAM) >= (IndHari * JedaHari) then
                ShowMessage(inttostr(j) + #13#10 + inttostr(IndRuang));

              // Locate(KEY_FIELD, Kromosom[NoKromosom][i], []);
              CurrKegiatan := AmbilKegiatan(Kromosom[NoKromosom][i]);
              Jurusan1 := CurrKegiatan.jurusan;
              Semester1 := CurrKegiatan.tingkat;
              Kelas1 := CurrKegiatan.kelas;

              JP1 := Alelle[i].KodeJam;
              JP2 := JP1 + CurrKegiatan.Jam;
              Hari1 := Alelle[i].KodeHari;

              // Bentrok pada waktu yang sama
              CurrKegiatan := AmbilKegiatan
                (Kromosom[NoKromosom][i + (j * JUMLAHJAM)]);
              if Assigned(CurrKegiatan) then
              begin
                Jurusan2 := CurrKegiatan.jurusan;
                Semester2 := CurrKegiatan.tingkat;
                Kelas2 := CurrKegiatan.kelas;
                if (Semester1 = Semester2) and (Jurusan1 = Jurusan2) and
                  (Kelas1 = Kelas2) then
                begin
                  Fitness := Fitness + 1;
                  PosGenTabrk := i;
                  MatTabrak[Fitness] := Kromosom[NoKromosom][i];
                  MatTabrak1[Fitness] := Kromosom[NoKromosom]
                    [i + (j * JUMLAHJAM)];
                end;
              end
              // Bentrok pada range waktu yang sama
              else if (JP2 <= JUMLAHJAM) then
              //else
              begin
                // Maju
                k := 1;
                if ((JP1 < 4) and (JP2 >= 5)) or ((JP1 < 13) and (JP2 >= 14))
                  or ((Hari1 <> 4) and (JP1 < 8) and (JP2 >= 9)) then
                  k := k + 1
                else if (Hari1 = 4) and (JP1 = 6) and (JP2 >= 7) then
                  k := k + 2;

                // Jam Pertemuan 2 or 3 +
                if i + (j * JUMLAHJAM) + k < JUMLAHGEN then
                CurrKegiatan := AmbilKegiatan
                  (Kromosom[NoKromosom][i + (j * JUMLAHJAM) + k]);
                if Assigned(CurrKegiatan) and
                  ((JP2 - JP1 = 2) or (JP2 - JP1 = 3)) then
                begin
                  Jurusan2 := CurrKegiatan.jurusan;
                  Semester2 := CurrKegiatan.tingkat;
                  Kelas2 := CurrKegiatan.kelas;
                  // KodeMtk2 := FieldByName('mpid').AsInteger;
                  if (Semester1 = Semester2) and (Jurusan1 = Jurusan2) and
                    (Kelas1 = Kelas2) then
                  begin
                    Fitness := Fitness + 1;
                    PosGenTabrk := i;
                    MatTabrak[Fitness] := Kromosom[NoKromosom][i];
                    MatTabrak1[Fitness] := Kromosom[NoKromosom]
                      [i + (j * JUMLAHJAM) + k];
                  end;
                end;

                // Jam Pertemuan 3 +
                if i + (j * JUMLAHJAM) + k + 1 < JUMLAHGEN then
                  CurrKegiatan := AmbilKegiatan
                    (Kromosom[NoKromosom][i + (j * JUMLAHJAM) + k + 1]);
                if Assigned(CurrKegiatan) and (JP2 - JP1 = 3) then
                begin
                  Jurusan2 := CurrKegiatan.jurusan;
                  Semester2 := CurrKegiatan.tingkat;
                  Kelas2 := CurrKegiatan.kelas;
                  // KodeMtk2 := FieldByName('mpid').AsInteger;
                  if (Semester1 = Semester2) and (Jurusan1 = Jurusan2) and
                    (Kelas1 = Kelas2) then
                  begin
                    Fitness := Fitness + 1;
                    PosGenTabrk := i;
                    MatTabrak[Fitness] := Kromosom[NoKromosom][i];
                    MatTabrak1[Fitness] := Kromosom[NoKromosom]
                      [i + (j * JUMLAHJAM) + k + 1];
                  end;
                end;

                // Mundur
                k := 1;
                if (JP1 = 5) or (JP1 = 14) or ((Hari1 <> 4) and (JP1 = 9)) then
                  k := k + 1
                else if (Hari1 = 4) and (JP1 = 9) then
                  k := k + 2;

                // Jam Pertemuan 2 or 3 -
                if i + (j * JUMLAHJAM) - k >= 0 then
                CurrKegiatan := AmbilKegiatan
                  (Kromosom[NoKromosom][i + (j * JUMLAHJAM) - k]);
                if Assigned(CurrKegiatan) and (JP1 > 0) and
                  ((JP2 - JP1 = 2) or (JP2 - JP1 = 3)) then
                begin
                  Jurusan2 := CurrKegiatan.jurusan;
                  Semester2 := CurrKegiatan.tingkat;
                  Kelas2 := CurrKegiatan.kelas;
                  // KodeMtk2 := FieldByName('mpid').AsInteger;
                  if (Semester1 = Semester2) and (Jurusan1 = Jurusan2) and
                    (Kelas1 = Kelas2) then
                  begin
                    Fitness := Fitness + 1;
                    PosGenTabrk := i;
                    MatTabrak[Fitness] := Kromosom[NoKromosom][i];
                    MatTabrak1[Fitness] := Kromosom[NoKromosom]
                      [i + (j * JUMLAHJAM) - k];
                  end;
                end;

                // Jam Pertemuan 3 -
                if i + (j * JUMLAHJAM) - k - 1 >= 0 then
                  CurrKegiatan := AmbilKegiatan
                    (Kromosom[NoKromosom][i + (j * JUMLAHJAM) - k - 1]);
                if Assigned(CurrKegiatan) and (JP1 > 1) and (JP2 - JP1 = 3) then
                begin
                  Jurusan2 := CurrKegiatan.jurusan;
                  Semester2 := CurrKegiatan.tingkat;
                  Kelas2 := CurrKegiatan.kelas;
                  // KodeMtk2 := FieldByName('mpid').AsInteger;
                  if (Semester1 = Semester2) and (Jurusan1 = Jurusan2) and
                    (Kelas1 = Kelas2) then
                  begin
                    Fitness := Fitness + 1;
                    PosGenTabrk := i;
                    MatTabrak[Fitness] := Kromosom[NoKromosom][i];
                    MatTabrak1[Fitness] := Kromosom[NoKromosom]
                      [i + (j * JUMLAHJAM) - k - 1];
                  end;
                end;
              end;
            end; // end if Kromosom[NoKromosom][i] <> '0'
          end; // end for j
          // Cek Ruangan 1 - Ruangan n dalam 1 Hari...
          if ((i + 1) mod JUMLAHJAM = 0) then
            IndRuang := IndRuang + 1;
          if IndRuang = JUMLAHRUANG then
            IndRuang := 1;
        end; // end if ( (i >= ((IndHari-1)*JedaHari)) and (i < ((IndHari*JedaHari)-JUMLAHJAM)) )
        if i = ((IndHari * JedaHari) - JUMLAHJAM) then
          IndHari := IndHari + 1;
      end; // end for TotalGen..
      // end;

    except
      FrmPenjadwalan.StopRegenerasi.Execute;
      MessageDLG('Terjadi Kesalahan Sistem [Aturan Kelas] !!!', MTWarning,
        [MBOk], 0);
    end;
  end;

  procedure AturanPengajar();
  var
    i, j, k: integer;
    JedaHari, IndRuang, IndHari: integer;
  begin
    // Pengajar berada lebih dari satu ruangan pada waktu yg sama
    try
      IndRuang := 1;
      IndHari := 1;
      JedaHari := JUMLAHRUANG * JUMLAHJAM;
      for i := 0 to JUMLAHGEN - 1 do
      begin
        if (i >= ((IndHari - 1) * JedaHari)) and
          (i < ((IndHari * JedaHari) - JUMLAHJAM)) then
        begin
          for j := 1 to JUMLAHRUANG - IndRuang do
          begin
            if (Kromosom[NoKromosom][i] <> '0') and
              (Alelle[i].KodeJam < JUMLAHJAM) then
            begin
              if i + (j * JUMLAHJAM) >= (IndHari * JedaHari) then
                ShowMessage(inttostr(j) + #13#10 + inttostr(IndRuang));

              // Locate(KEY_FIELD, Kromosom[NoKromosom][i], []);
              CurrKegiatan := AmbilKegiatan(Kromosom[NoKromosom][i]);
              Dosen1 := CurrKegiatan.Pengajar;

              JP1 := Alelle[i].KodeJam;
              JP2 := JP1 + CurrKegiatan.Jam;

              // Bentrok pada waktu yang sama
              CurrKegiatan := AmbilKegiatan
                (Kromosom[NoKromosom][i + (j * JUMLAHJAM)]);
              if Assigned(CurrKegiatan) then
              begin
                Dosen2 := CurrKegiatan.Pengajar;
                if Dosen1 = Dosen2 then
                begin
                  Fitness := Fitness + 1;
                  PosGenTabrk := i;
                  MatTabrak[Fitness] := Kromosom[NoKromosom][i];
                  MatTabrak1[Fitness] := Kromosom[NoKromosom]
                    [i + (j * JUMLAHJAM)];
                end;
              end
              // Bentrok pada range waktu yang sama
              else if (JP2 <= JUMLAHJAM) then
              //else
              begin

                // Maju
                k := 1;
                if ((JP1 < 4) and (JP2 >= 5)) or ((JP1 < 13) and (JP2 >= 14))
                  or ((Hari1 <> 4) and (JP1 < 8) and (JP2 >= 9)) then
                  k := k + 1
                else if (Hari1 = 4) and (JP1 = 6) and (JP2 >= 7) then
                  k := k + 2;

                // Jam Pertemuan 2 or 3 +
                if i + (j * JUMLAHJAM) + k < JUMLAHGEN then
                CurrKegiatan := AmbilKegiatan
                  (Kromosom[NoKromosom][i + (j * JUMLAHJAM) + k]);
                if Assigned(CurrKegiatan) and
                  ((JP2 - JP1 = 2) or (JP2 - JP1 = 3)) then
                begin
                  Dosen2 := CurrKegiatan.Pengajar;
                  if Dosen1 = Dosen2 then
                  begin
                    Fitness := Fitness + 1;
                    PosGenTabrk := i;
                    MatTabrak[Fitness] := Kromosom[NoKromosom][i];
                    MatTabrak1[Fitness] := Kromosom[NoKromosom]
                      [i + (j * JUMLAHJAM) + k];
                  end;
                end;
                // Jam Pertemuan 3 +
                if i + (j * JUMLAHJAM) + k + 1 < JUMLAHGEN then
                  CurrKegiatan := AmbilKegiatan
                    (Kromosom[NoKromosom][i + (j * JUMLAHJAM) + k + 1]);
                if Assigned(CurrKegiatan) and (JP2 - JP1 = 3) then
                begin
                  Dosen2 := CurrKegiatan.Pengajar;
                  if Dosen1 = Dosen2 then
                  begin
                    Fitness := Fitness + 1;
                    PosGenTabrk := i;
                    MatTabrak[Fitness] := Kromosom[NoKromosom][i];
                    MatTabrak1[Fitness] := Kromosom[NoKromosom]
                      [i + (j * JUMLAHJAM) + k + 1];
                  end;
                end;

                // Mundur
                k := 1;
                if (JP1 = 5) or (JP1 = 9) or (JP1 = 14) then
                begin
                  k := k + 1;
                  if (Hari1 = 4) and (JP1 = 9) then
                    k := k + 2;
                end;

                // Jam Pertemuan 2 or 3 -
                if i + (j * JUMLAHJAM) - k >= 0 then
                CurrKegiatan := AmbilKegiatan
                  (Kromosom[NoKromosom][i + (j * JUMLAHJAM) - k]);
                if Assigned(CurrKegiatan) and (JP1 > 0) and
                  ((JP2 - JP1 = 2) or (JP2 - JP1 = 3)) then
                begin
                  Dosen2 := CurrKegiatan.Pengajar;
                  if Dosen1 = Dosen2 then
                  begin
                    Fitness := Fitness + 1;
                    PosGenTabrk := i;
                    MatTabrak[Fitness] := Kromosom[NoKromosom][i];
                    MatTabrak1[Fitness] := Kromosom[NoKromosom]
                      [i + (j * JUMLAHJAM) - k];
                  end;
                end;
                // Jam Pertemuan 3 -
                if i + (j * JUMLAHJAM) - k - 1 >= 0 then
                  CurrKegiatan := AmbilKegiatan
                    (Kromosom[NoKromosom][i + (j * JUMLAHJAM) - k - 1]);
                if Assigned(CurrKegiatan) and (JP1 > 1) and (JP2 - JP1 = 3) then
                begin
                  Dosen2 := CurrKegiatan.Pengajar;
                  if Dosen1 = Dosen2 then
                  begin
                    Fitness := Fitness + 1;
                    PosGenTabrk := i;
                    MatTabrak[Fitness] := Kromosom[NoKromosom][i];
                    MatTabrak1[Fitness] := Kromosom[NoKromosom]
                      [i + (j * JUMLAHJAM) - k - 1];
                  end;
                end;
              end;
            end; // end if Kromosom[NoKromosom][i] <> '0'
          end; // end for j
          // Cek Ruangan 1 - Ruangan n dalam 1 Hari...
          if ((i + 1) mod JUMLAHJAM = 0) then
            IndRuang := IndRuang + 1;
          if IndRuang = JUMLAHRUANG then
            IndRuang := 1;
        end; // end if ( (i >= ((IndHari-1)*JedaHari)) and (i < ((IndHari*JedaHari)-JUMLAHJAM)) )
        if i = ((IndHari * JedaHari) - JUMLAHJAM) then
          IndHari := IndHari + 1;
      end; // end for TotalGen..

    except
      FrmPenjadwalan.StopRegenerasi.Execute;
      MessageDLG('Terjadi Kesalahan Sistem [Aturan Pengajar] !!!', MTWarning,
        [MBOk], 0);
    end;
  end;

  procedure AturanPengajar2();
  var
    i, j, k: integer;
  begin
    // Aturan Pengajar
    try
      for i := 0 to Length(Solusi) - 1 do
      begin
        if Kromosom[NoKromosom][Solusi[i].pos] <> '0' then
        begin
          CurrKegiatan := AmbilKegiatan(Kromosom[NoKromosom][Solusi[i].pos]);
          CurrAturanPengajar := AmbilAturanPengajar(CurrKegiatan.Pengajar);

          if Assigned(CurrAturanPengajar) then
          begin
            JP1 := Alelle[Solusi[i].pos].KodeJam;
            JP2 := JP1 + CurrKegiatan.Jam;
            // Penyesuaian dengan waktu istirahat dan jumatan
            k := 0;
            if ((JP1 < 4) and (JP2 >= 5)) or ((JP1 < 13) and (JP2 >= 14)) then
              k := k + 1
            else
            begin
              if (Hari1 = 4) and (JP1 < 7) and (JP2 >= 8) then
                k := k + 2
              else if (Hari1 <> 4) and (JP1 < 8) and (JP2 >= 9) then
                k := k + 1;
            end;

            for j := 0 to Length(CurrAturanPengajar) - 1 do
            begin
              if (CurrAturanPengajar[j].Hari = Alelle[Solusi[i].pos].KodeHari)
                and (CurrAturanPengajar[j].Jam >= JP1) and
                (CurrAturanPengajar[j].Jam < JP2 + k) then
              begin
                // ShowMessageFmt('JP1:%d JP2:%d Jam:%d',[JP1,JP2,CurrAturanPengajar[j].jam]);
                Fitness := Fitness + 1;
                PosGenTabrk := Solusi[i].pos;
                MatTabrak[Fitness] := Kromosom[NoKromosom][Solusi[i].pos];
                MatTabrak1[Fitness] := Kromosom[NoKromosom][Solusi[i].pos];
              end;
            end;
          end;
        end;
      end;
    except
      FrmPenjadwalan.StopRegenerasi.Execute();
      MessageDLG('Terjadi Kesalahan Sistem [Aturan Pengajar2]!!!', MTWarning,
        [MBOk], 0);
    end;
  end;

  procedure AturanRuangan();
  var
    i, j, k: integer;
  begin
    // Penempatan Tingkat (X-XI-XII) di ruangan yang seharusnya
    try
      if FrmPenjadwalan.ComboBox1.ItemIndex > 0 then
        Exit;
      for k := 0 to Length(Solusi) - 1 do
      begin
        i := Solusi[k].pos;
        if Kromosom[NoKromosom][i] <> '0' then
        begin
          CurrKegiatan := AmbilKegiatan(Kromosom[NoKromosom][i]);
          Semester1 := CurrKegiatan.tingkat;
          CurrRuangan := AmbilRuangan(Alelle[i].Ruang);
          if ((Semester1 = 0) and not(CurrRuangan.tingkat_1)) or
            ((Semester1 = 1) and not(CurrRuangan.tingkat_2)) or
            ((Semester1 = 2) and not(CurrRuangan.tingkat_3)) then
          begin
            Fitness := Fitness + 1;
            PosGenTabrk := i;
            MatTabrak[Fitness] := Kromosom[NoKromosom][i];
            MatTabrak1[Fitness] := Kromosom[NoKromosom][i];
          end;
        end;
      end;
    except
      FrmPenjadwalan.StopRegenerasi.Execute;
      MessageDLG('Terjadi Kesalahan Sistem [Aturan Ruangan]!!!', MTWarning,
        [MBOk], 0);
    end;
  end;
{
  procedure AturanRataKelas();
  var
  i, j, k: integer;
  begin
  // Kelas harus merata
  for k := 0 to Length(CurrSolusi) - 1 do
  begin
  for j := 0 to JUMLAHHARI - 1 do
  begin
  // Supaya menjadi genap
  if Summary[k].total mod 2 <> 0 then
  i := 1
  else
  i := 0;
  // persentase per hari
  case j of
  0, 1, 2, 3:
  Temp := Round(20 / 100 * (Summary[k].total + i));
  4, 5:
  Temp := Round(10 / 100 * (Summary[k].total + i));
  end;
  // Apabila total perhari lebih banyak dari prosentase
  if Summary[k].Hari[j] > Temp then
  begin
  Fitness := Fitness + 1;
  end;
  end;
  end;
  end;
  }
{
  procedure AturanPosisi();
  var
  i, j, k: integer;
  begin
  // Ada Jam Awal
  for k := 0 to Length(CurrSolusi) - 1 do
  begin
  for j := 0 to JUMLAHHARI - 1 do
  begin
  if (Summary[k].Hari[j] > 0) and not(Summary[k].hasAwal[j]) then
  begin
  Fitness := Fitness + 1;
  end
  else if (Summary[k].Hari[j] > 0) and (Summary[k].hasAwal[j])
  then
  begin
  l := 0;
  for i := 0 to JUMLAHJAM - 1 do
  begin
  if (Length(CurrSolusi[k][j][i]) > 0) and (l <> i) then
  begin
  CurrKegiatan := AmbilKegiatan(CurrSolusi[k][j][l][0].id);
  // ShowMessageFmt('%d %d', [l, i]);
  if (l + CurrKegiatan.Jam <> i - 1) then
  begin
  Fitness := Fitness + 1;
  PosGenTabrk := CurrSolusi[k][j][i][0].pos;
  MatTabrak[Fitness] := CurrSolusi[k][j][i][0].id;
  Break;
  end;
  l := i;
  end;
  end;
  end;
  end;
  end;
  // Selisih waktu antara mata pelajaran tidak padat
  with FrmPenjadwalan do
  begin
  if TblKelasDiajar.Active = false then
  TblKelasDiajar.Active := True;
  for i := 0 to TblKelasDiajar.RecordCount - 1 do
  begin
  TblKelasDiajar.RecNo := i + 1;
  for j := 0 to JUMLAHHARI - 1 do
  begin
  l := -1;
  for k := 0 to JUMLAHJAM - 1 do
  begin
  if Length(CurrSolusi[i][j][k]) > 0 then
  begin
  if l <> -1 then
  begin
  TblKegiatanQuery.Locate(KEY_FIELD, CurrSolusi[i][j][l][0].id,
  []);
  // ShowMessageFmt('%s %d %d',[Alelle[CurrSolusi[i][j][l][0].pos].Hari,l,k]);
  if (k - l > TblKegiatanQuery.FieldByName('jam').AsInteger) then
  begin
  Fitness := Fitness + 1;
  PosGenTabrk := CurrSolusi[i][j][k][0].pos;
  MatTabrak[Fitness] := CurrSolusi[i][j][l][0].id;
  MatTabrak1[Fitness] := CurrSolusi[i][j][k][0].id;
  end;
  end;
  l := k;
  end;
  end;
  end;
  end;
  end;
  end;
  }

  procedure AturanPosisi2();
  var
    // Key for CurrSolusi : Jurusan - KodeHari - KodeJam
    CurrSolusi: array of array of array of array of TDetailGen;
    // Key for Summary : Jurusan
    Summary: array of TSummary;
    JumKegiatan: array of integer;
    HasJadwal, hasAwal: boolean;
    i, j, k: integer;
  begin
    // Sortir current solusi untuk memudahkan pencarian Fitness;
    // Apabila disimpan di SQL proses menjadi lambat;
    with FrmPenjadwalan do
    begin
      if TblKelasDiajar.Active = false then
        TblKelasDiajar.Active := True;
      SetLength(CurrSolusi, TblKelasDiajar.RecordCount, JUMLAHHARI, JUMLAHJAM);
      // SetLength(JumKegiatan, TblKelasDiajar.RecordCount);
      SetLength(Summary, TblKelasDiajar.RecordCount);
      for i := 0 to TblKelasDiajar.RecordCount - 1 do
      begin
        TblKelasDiajar.RecNo := i + 1;
        for j := 0 to Length(Solusi) - 1 do
        begin
          CurrKegiatan := AmbilKegiatan(Solusi[j].id);
          if Assigned(CurrKegiatan) and
            (CurrKegiatan.tingkat = TblKelasDiajar.FieldByName('tingkatid')
              .AsInteger) and (CurrKegiatan.jurusan = TblKelasDiajar.FieldByName
              ('jid').AsInteger) and
            (CurrKegiatan.kelas = TblKelasDiajar.FieldByName('kelasid')
              .AsInteger) then
          begin
            k := Length(CurrSolusi[i][Alelle[Solusi[j].pos].KodeHari]
                [Alelle[Solusi[j].pos].KodeJam]);
            SetLength(CurrSolusi[i][Alelle[Solusi[j].pos].KodeHari]
                [Alelle[Solusi[j].pos].KodeJam], k + 1);
            CurrSolusi[i][Alelle[Solusi[j].pos].KodeHari]
              [Alelle[Solusi[j].pos].KodeJam][k].id := Solusi[j].id;
            CurrSolusi[i][Alelle[Solusi[j].pos].KodeHari]
              [Alelle[Solusi[j].pos].KodeJam][k].pos := Solusi[j].pos;
            // JumKegiatan[i] := JumKegiatan[i] + 1;
            Summary[i].total := Summary[i].total + 1;
            Summary[i].Hari[Alelle[Solusi[j].pos].KodeHari] := Summary[i].Hari
              [Alelle[Solusi[j].pos].KodeHari] + 1;
            if (Alelle[Solusi[j].pos].KodeJam = 0) then
            begin
              Summary[i].hasAwal[Alelle[Solusi[j].pos].KodeHari] := True;
            end;
          end;
        end;
      end;
    end;

  end;

begin
  Fitness := 0;
  Solusi := nil;
  SetLength(Solusi, Length(Kegiatan));
  j := 0;
  for i := 0 to JUMLAHGEN - 1 do
  begin
    if Kromosom[NoKromosom][i] <> '0' then
    begin
      Solusi[j].id := Kromosom[NoKromosom][i];
      Solusi[j].pos := i;
      j := j + 1;
    end;
  end;
  {
    // Sortir current solusi untuk memudahkan pencarian Fitness;
    // Apabila disimpan di SQL proses menjadi lambat;
    with FrmPenjadwalan do
    begin
    if TblKelasDiajar.Active = false then
    TblKelasDiajar.Active := True;
    SetLength(CurrSolusi, TblKelasDiajar.RecordCount, JUMLAHHARI, JUMLAHJAM);
    // SetLength(JumKegiatan, TblKelasDiajar.RecordCount);
    SetLength(Summary, TblKelasDiajar.RecordCount);
    for i := 0 to TblKelasDiajar.RecordCount - 1 do
    begin
    TblKelasDiajar.RecNo := i + 1;
    for j := 0 to Length(Solusi) - 1 do
    begin
    // TblKegiatanQuery.Locate(KEY_FIELD, Solusi[j].id, []);
    CurrKegiatan := AmbilKegiatan(Solusi[j].id);
    if Assigned(CurrKegiatan) and
    (CurrKegiatan.tingkat = TblKelasDiajar.FieldByName('tingkatid')
    .AsInteger) and (CurrKegiatan.jurusan = TblKelasDiajar.FieldByName
    ('jid').AsInteger) and
    (CurrKegiatan.kelas = TblKelasDiajar.FieldByName('kelasid')
    .AsInteger) then
    begin
    k := Length(CurrSolusi[i][Alelle[Solusi[j].pos].KodeHari]
    [Alelle[Solusi[j].pos].KodeJam]);
    SetLength(CurrSolusi[i][Alelle[Solusi[j].pos].KodeHari]
    [Alelle[Solusi[j].pos].KodeJam], k + 1);
    CurrSolusi[i][Alelle[Solusi[j].pos].KodeHari]
    [Alelle[Solusi[j].pos].KodeJam][k].id := Solusi[j].id;
    CurrSolusi[i][Alelle[Solusi[j].pos].KodeHari]
    [Alelle[Solusi[j].pos].KodeJam][k].pos := Solusi[j].pos;
    // JumKegiatan[i] := JumKegiatan[i] + 1;
    Summary[i].total := Summary[i].total + 1;
    Summary[i].Hari[Alelle[Solusi[j].pos].KodeHari] := Summary[i].Hari
    [Alelle[Solusi[j].pos].KodeHari] + 1;
    if (Alelle[Solusi[j].pos].KodeJam = 0) then
    begin
    Summary[i].hasAwal[Alelle[Solusi[j].pos].KodeHari] := True;
    end;
    end;
    end;
    end;
    end;
    }
  // ===========================================================================
  if 1 in ENABLEDATURAN then
  begin
    // AturanRataKelas();
  end;
  JumFitAturan[1] := Fitness;

  // ===========================================================================
  if 2 in ENABLEDATURAN then
  begin
    AturanOJI();
  end;
  JumFitAturan[2] := Fitness - JumFitAturan[1];
  // ===========================================================================
  if 3 in ENABLEDATURAN then
  begin
    AturanKelas();
  end;
  JumFitAturan[3] := Fitness - (JumFitAturan[1] + JumFitAturan[2]);
  // ===========================================================================
  if 4 in ENABLEDATURAN then
  begin
    AturanPengajar();
  end;
  JumFitAturan[4] := Fitness -
    (JumFitAturan[1] + JumFitAturan[2] + JumFitAturan[3]);
  // ===========================================================================
  if 5 in ENABLEDATURAN then
  begin
    AturanPengajar2();
  end;
  JumFitAturan[5] := Fitness -
    (JumFitAturan[1] + JumFitAturan[2] + JumFitAturan[3] + JumFitAturan[4]);
  // ===========================================================================
  if 6 in ENABLEDATURAN then
  begin
    AturanRuangan();
  end;
  JumFitAturan[6] := Fitness -
    (JumFitAturan[1] + JumFitAturan[2] + JumFitAturan[3] + JumFitAturan[4]
      + JumFitAturan[5]);
  // ===========================================================================
  if 7 in ENABLEDATURAN then
  begin
    AturanPosisi2();
  end;
  JumFitAturan[7] := Fitness -
    (JumFitAturan[1] + JumFitAturan[2] + JumFitAturan[3] + JumFitAturan[4]
      + JumFitAturan[5] + JumFitAturan[6]);
  // ===========================================================================
  if 8 in ENABLEDATURAN then
  begin
  end;
  JumFitAturan[8] := Fitness -
    (JumFitAturan[1] + JumFitAturan[2] + JumFitAturan[3] + JumFitAturan[4]
      + JumFitAturan[5] + JumFitAturan[6] + JumFitAturan[7]);
  // ===========================================================================
  if 9 in ENABLEDATURAN then
  begin
  end;
  JumFitAturan[9] := Fitness -
    (JumFitAturan[1] + JumFitAturan[2] + JumFitAturan[3] + JumFitAturan[4]
      + JumFitAturan[5] + JumFitAturan[6] + JumFitAturan[7] + JumFitAturan[8]);
  // ===========================================================================
  if 10 in ENABLEDATURAN then
  begin
  end;
  JumFitAturan[10] := Fitness - (JumFitAturan[1] + JumFitAturan[2]
      + JumFitAturan[3] + JumFitAturan[4] + JumFitAturan[5] + JumFitAturan[6]
      + JumFitAturan[7] + JumFitAturan[8] + JumFitAturan[9]);

  // ===========================================================================

  NilaiFitness[NoKromosom] := Fitness;
  // Result := NilaiFitness[NoKromosom];
end;
// END HITUNG FITNESS

// BANGKITKAN POPULASI AWAL
procedure TAGenetika.BangkitkanPopulasi();
var
  BilRandom, i, NoKromosom, JumRuang, JedaHari: integer;
  TotalGen, d: integer;
  TabuList: array of integer;

  function isAllowed(Index: integer): boolean;
  var
    allowed: boolean;
  begin
    allowed := TabuList[Index] = 0;
    allowed := allowed and (Alelle[Index].KodeJam <> 4) and
      (Alelle[Index].KodeJam <> 13) and (Alelle[Index].KodeJam <> 8) and
      (Alelle[Index].KodeJam < JUMLAHJAM - 2);
    if Kegiatan[d].tingkat = 0 then
      allowed := allowed and Ruangan[Alelle[index].KodeRuang].tingkat_1
    else if Kegiatan[d].tingkat = 1 then
      allowed := allowed and Ruangan[Alelle[index].KodeRuang].tingkat_2
    else if Kegiatan[d].tingkat = 2 then
      allowed := allowed and Ruangan[Alelle[index].KodeRuang].tingkat_3;
    Result := allowed;
  end;

begin
  try
    Randomize;
    FrmPenjadwalan.Status := 'Bangkitkan Populasi..';
    JedaHari := JUMLAHRUANG * JUMLAHJAM;
    TotalGen := JUMLAHGEN;
    for NoKromosom := 1 to POPULATION_SIZE do
    begin
      SetLength(Kromosom[NoKromosom], TotalGen);
      TabuList := nil;
      SetLength(TabuList, TotalGen);
      for i := 0 to TotalGen - 1 do
      begin
        Kromosom[NoKromosom][i] := '0';
      end;
      for d := 0 to Length(Kegiatan) - 1 do
      begin
        repeat
          BilRandom := Random(TotalGen);
        until (isAllowed(BilRandom));
        // awal hari
        if (BilRandom = 0) Or (BilRandom mod JUMLAHJAM = 0) then
        begin
          Kromosom[NoKromosom][BilRandom] := Kegiatan[d].id;
          TabuList[BilRandom] := 1;
        end
        // akhir hari
        else if (BilRandom = 16) Or (BilRandom mod JUMLAHJAM = JUMLAHJAM - 1)
          then
        begin
          if TabuList[BilRandom - 16] = 0 then
          begin
            Kromosom[NoKromosom][BilRandom - 16] := Kegiatan[d].id;
            TabuList[BilRandom - 16] := 1;
          end
          else
          begin
            Kromosom[NoKromosom][BilRandom] := Kegiatan[d].id;
            TabuList[BilRandom] := 1;
          end;
        end
        // pertengahan hari
        else if (BilRandom >= 1) and (BilRandom < (TotalGen - 1)) then
        begin
          if (BilRandom = 1) or (BilRandom = TotalGen - 1) then
          begin
            Kromosom[NoKromosom][BilRandom] := Kegiatan[d].id;
            TabuList[BilRandom] := 1;
          end
          else if (Kromosom[NoKromosom][BilRandom + 2] = '0') and
            (Kromosom[NoKromosom][BilRandom - 2] = '0') then
          begin
            Kromosom[NoKromosom][BilRandom] := Kegiatan[d].id;
            TabuList[BilRandom] := 1;
            TabuList[BilRandom + 2] := 1;
            TabuList[BilRandom - 2] := 1;
          end
          else if (Kromosom[NoKromosom][BilRandom + 1] = '0') and
            (Kromosom[NoKromosom][BilRandom - 1] = '0') then
          begin
            Kromosom[NoKromosom][BilRandom] := Kegiatan[d].id;
            TabuList[BilRandom] := 1;
            TabuList[BilRandom + 1] := 1;
            TabuList[BilRandom - 1] := 1;
          end
          else
          begin
            Kromosom[NoKromosom][BilRandom] := Kegiatan[d].id;
            TabuList[BilRandom] := 1;
          end;
        end
        else
        begin
          ShowMessageFmt('%d', [BilRandom]);
        end;
      end;
      HitungFitness(NoKromosom);
    end;
    UrutKromosom;
  except
    on E: Exception do
    begin
      // ShowMessageFmt('%d %d %s',[BilRandom, d ,E.Message]);
      MessageDLG('Maaf Terjadi Kesalahan Sistem...', MTError, [MBOk], 0);
      Application.Destroy;
    end;
  end;
end;
// END BANGKITKAN POPULASI AWAL

// =================================== REGENERASI

// MUTASI
procedure TAGenetika.Mutasi;
var
  NoKromosom1, i, j: integer;
  a, b, Kecil: integer;
  CalonAnak: array [1 .. 5] of TKromosom;
  Fitness: array [1 .. 5] of integer;
  TotalGen: integer;
  Fitness1, Fitness2, k: integer;
  BantuKromosom: array [1 .. 2] of TKromosom;
begin
  TotalGen := JUMLAHGEN;
  SetLength(Kromosom[POPULATION_SIZE + 1], TotalGen);
  SetLength(Kromosom[POPULATION_SIZE + 2], TotalGen);
  SetLength(BantuKromosom[1], TotalGen);
  SetLength(BantuKromosom[2], TotalGen);

  Randomize;
  // FrmPenjadwalan.Status := 'Mutasi..';
  // Application.ProcessMessages;

  NoKromosom1 := 1;
  HitungFitness(NoKromosom1);

  for i := 1 to 5 do
  begin
    SetLength(CalonAnak[i], TotalGen);
    repeat
      a := PosGenTabrk;
      // PosGenTabrk : Posisi Gen Yang Tabrakkan
      // Variabel ini ada pada Fungsi Hitung Fitness
      b := Random(TotalGen);
    until (a <> b);

    for j := 0 to TotalGen - 1 do
    begin
      if (j <> a) and (j <> b) then
        CalonAnak[i][j] := Kromosom[NoKromosom1][j]
      else if j = a then
        CalonAnak[i][j] := Kromosom[NoKromosom1][b]
      else if j = b then
        CalonAnak[i][j] := Kromosom[NoKromosom1][a];
    end;

    for j := 0 to TotalGen - 1 do
      Kromosom[POPULATION_SIZE + 1][j] := CalonAnak[i][j];

    HitungFitness(POPULATION_SIZE + 1);

    Fitness[i] := AmbilFitness(POPULATION_SIZE + 1);
  end;

  // Sort Calon Anak
  Kecil := 1;
  for i := 2 to 5 do
  begin
    if Fitness[Kecil] > Fitness[i] then
      Kecil := i;
  end;

  // Simpan Calon Anak Terbaik ke Kromosom +1 (Terakhir)
  for i := 0 to TotalGen - 1 do
  begin
    Kromosom[POPULATION_SIZE + 1][i] := CalonAnak[Kecil][i];
  end;
  NilaiFitness[POPULATION_SIZE + 1] := Fitness[Kecil];

  // Offspring
  if NilaiFitness[POPULATION_SIZE + 1] <= NilaiFitness[NoKromosom1] then
  begin
    for i := 0 to TotalGen - 1 do
      Kromosom[NoKromosom1][i] := Kromosom[POPULATION_SIZE + 1][i];
    NilaiFitness[NoKromosom1] := NilaiFitness[POPULATION_SIZE + 1];
    UrutKromosom;
  end
  else
  begin
    for i := 1 to POPULATION_SIZE do
    begin
      for j := i + 1 to POPULATION_SIZE + 1 do
      begin
        Fitness1 := NilaiFitness[i];
        Fitness2 := NilaiFitness[j];
        for k := 0 to TotalGen - 1 do
        begin
          BantuKromosom[1][k] := Kromosom[i][k];
          BantuKromosom[2][k] := Kromosom[j][k];
        end;
        if Fitness1 >= Fitness2 then
        begin
          NilaiFitness[i] := Fitness2;
          NilaiFitness[j] := Fitness1;
          for k := 0 to TotalGen - 1 do
          begin
            Kromosom[i][k] := BantuKromosom[2][k];
            Kromosom[j][k] := BantuKromosom[1][k]
          end;
        end;
        {
          else if Fitness1 < Fitness2 then
          begin
          NilaiFitness[i] := Fitness1;
          for k := 0 to TotalGen - 1 do
          Kromosom[i][k] := BantuKromosom[1][k];
          end;
          }
      end;
    end;
  end;

end;
// END MUTASI

// CekKromCross
function TAGenetika.CekKromCross(Index: integer): integer;
var
  i, j, Jumlah, TotalGen: integer;
begin
  TotalGen := JUMLAHGEN;
  for i := 1 to POPULATION_SIZE do
  begin
    Jumlah := 0;
    for j := 0 to TotalGen - 1 do
    begin
      if Kromosom[Index][j] <> Kromosom[i][j] then
        Jumlah := Jumlah + 1;
    end;
    // Kenapa 10 ?[BIG QUESTION]
    if Jumlah <= 10 then
    begin
      Result := i;
      Exit;
    end;
  end;
  Result := 0;
end;
// END CekKromCross

// AMBIL POINT a dan b secara Acak
procedure AmbilCOPoint(TotalGen: integer;

  var a, b: integer);
var
  BilRandom: integer;
begin
  Randomize;
  BilRandom := Random(3) + 1;
  if BilRandom = 1 then
  begin
    a := 0;
    repeat
      b := Random(TotalGen);
    until (b > 0) and (b <= (TotalGen - (TotalGen / 4)));
  end
  else if BilRandom = 2 then
  begin
    repeat
      a := Random(TotalGen);
    until (a <> 0) and (a <= (TotalGen - (TotalGen / 4)));
    b := TotalGen - 1;
  end
  else if BilRandom = 3 then
  begin
    repeat
      a := Random(TotalGen);
      b := Random(TotalGen);
    until (a > 0) and (b < (TotalGen - 1)) and (b > a);
  end;
end;

function GetJumBedaGen(Kromosom1, Kromosom2: TKromosom; a, b: integer): integer;
var
  i, JumBeda: integer;
begin
  JumBeda := 0;
  if (a <> b) and (a < b) then
  begin
    for i := a to b do
    begin
      if Kromosom1[i] <> Kromosom2[i] then
        JumBeda := JumBeda + 1;
    end;
  end;
  Result := JumBeda;
end;

// CROSS OVER
procedure TAGenetika.CrossOver;
var
  i, j, k, l, a, b, BilRandom, NoKromosom, ind: integer;
  NoKromosom1, NoKromosom2, JumlahBeda, TotalBeda: integer;
  Index, Fitness1, Fitness2, IndX1, IndX2: integer;
  CalonAnak, BantuKromosom: array [1 .. 2] of TKromosom;
  Jumlah, eror: array [1 .. 2] of integer;
  JumBedaKromosom: array [2 .. POPULATION_SIZE] of integer;
  Kelas1, Kelas2: String;
  TotalGen: integer;
begin

  Randomize;
  // FrmPenjadwalan.Status := 'Crossover..';
  // Application.ProcessMessages;
  // Tentukan Kromosom untuk dijadikan induk 1
  NoKromosom1 := 1;
  TotalGen := JUMLAHGEN;
  for i := 2 to POPULATION_SIZE do
  begin
    TotalBeda := 0;
    for j := 0 to TotalGen - 1 do
    begin
      if Kromosom[NoKromosom1][j] <> Kromosom[i][j] then
        TotalBeda := TotalBeda + 1;
    end;
    JumBedaKromosom[i] := TotalBeda;
  end;

  // Tentukan Kromosom untuk dijadikan induk 2
  // Yang Mempunyai Karakteristik Yg paling berbeda
  // Krom := 2;
  ind := 2;
  for i := 3 to POPULATION_SIZE do
  begin
    if JumBedaKromosom[ind] < JumBedaKromosom[i] then
    begin
      ind := i;
      // Krom := ind;
    end;
  end;
  NoKromosom2 := ind;
  TotalBeda := JumBedaKromosom[NoKromosom2];

  // Cari range Two-Point CrossOver secara random (a - b)

  if TotalBeda >= 70 then
  begin
    repeat
      AmbilCOPoint(TotalGen, a, b);
      JumlahBeda := GetJumBedaGen(Kromosom[NoKromosom1], Kromosom[NoKromosom2],
        a, b);
    until (JumlahBeda >= 15) and (JumlahBeda <= 20);
  end
  else if (TotalBeda >= 50) and (TotalBeda < 70) then
  begin
    repeat
      AmbilCOPoint(TotalGen, a, b);
      JumlahBeda := GetJumBedaGen(Kromosom[NoKromosom1], Kromosom[NoKromosom2],
        a, b);
    until (JumlahBeda >= 10) and (JumlahBeda <= 20);
  end
  else if (TotalBeda >= 40) and (TotalBeda < 50) then
  begin
    repeat
      AmbilCOPoint(TotalGen, a, b);
      JumlahBeda := GetJumBedaGen(Kromosom[NoKromosom1], Kromosom[NoKromosom2],
        a, b);
    until (JumlahBeda >= 10) and (JumlahBeda <= 15);
  end
  else if (TotalBeda >= 30) and (TotalBeda < 40) then
  begin
    repeat
      AmbilCOPoint(TotalGen, a, b);
      JumlahBeda := GetJumBedaGen(Kromosom[NoKromosom1], Kromosom[NoKromosom2],
        a, b);
    until (JumlahBeda >= 5) and (JumlahBeda <= 10);
  end
  else if (TotalBeda >= 20) and (TotalBeda < 30) then
  begin
    repeat
      AmbilCOPoint(TotalGen, a, b);
      JumlahBeda := GetJumBedaGen(Kromosom[NoKromosom1], Kromosom[NoKromosom2],
        a, b);
    until (JumlahBeda >= 5) and (JumlahBeda <= 10);
  end
  else
  begin
    // ShowMessage('Beda dibawah 20');
    Exit;
  end; {
    else if (TotalBeda >= 10) and (TotalBeda < 20) then
    begin
    repeat
    AmbilCOPoint(TotalGen, a, b);
    JumlahBeda := GetJumBedaGen(Kromosom[NoKromosom1], Kromosom[NoKromosom2],
    a, b);
    until (JumlahBeda >= 5) and (JumlahBeda <= 7);
    end
    else if (TotalBeda < 10) then
    begin
    repeat
    AmbilCOPoint(TotalGen, a, b);
    JumlahBeda := GetJumBedaGen(Kromosom[NoKromosom1], Kromosom[NoKromosom2],
    a, b);
    until (JumlahBeda >= 2) and (JumlahBeda <= 5);
    end;
    }

  {
    repeat
    AmbilCOPoint(TotalGen, a, b);
    JumlahBeda := GetJumBedaGen(Kromosom[NoKromosom1], Kromosom[NoKromosom2],
    a, b);
    until (JumlahBeda >= (PB_CROSS-5) * TotalBeda / 100 ) and (JumlahBeda <= (PB_CROSS+5) * TotalBeda / 100 );
    }
  JumlahBeda := JumlahBeda;
  SetLength(Kromosom[POPULATION_SIZE + 1], TotalGen);
  SetLength(Kromosom[POPULATION_SIZE + 2], TotalGen);

  SetLength(CalonAnak[1], ((b - a) + 1));
  SetLength(CalonAnak[2], ((b - a) + 1));

  // ============================================================================
  // Posisi Range di awal kromosom 0 - ???
  if (a = 0) and (b < (TotalGen - 1)) then
  begin
    // calon Anak
    for i := 0 to TotalGen - 1 do
    begin
      if (i >= 0) and (i <= b) then
      begin
        CalonAnak[1][i] := Kromosom[NoKromosom2][i];
        CalonAnak[2][i] := Kromosom[NoKromosom1][i];
        Kromosom[POPULATION_SIZE + 1][i] := CalonAnak[1][i];
        Kromosom[POPULATION_SIZE + 2][i] := CalonAnak[2][i];
      end
      else
      begin
        Kromosom[POPULATION_SIZE + 1][i] := Kromosom[NoKromosom1][i];
        Kromosom[POPULATION_SIZE + 2][i] := Kromosom[NoKromosom2][i];
      end;
    end;

    // Hubungan kedua Calon Anak dan Anak
    for i := 0 to b do
    begin
      if (CalonAnak[1][i] <> '0') and (CalonAnak[2][i] <> '0') then
      begin
        if (CalonAnak[1][i] <> CalonAnak[2][i]) then
        begin
          for j := b + 1 to TotalGen - 1 do
          begin
            IndX2 := TotalGen - 1;
            if (CalonAnak[1][i] = Kromosom[POPULATION_SIZE + 1][j]) then
            begin
              for k := b + 1 to TotalGen - 1 do
              begin
                IndX2 := TotalGen - 1;
                if (CalonAnak[2][i] = Kromosom[POPULATION_SIZE + 2][k]) then
                begin
                  Kromosom[POPULATION_SIZE + 1][j] := CalonAnak[2][i];
                  Kromosom[POPULATION_SIZE + 2][k] := CalonAnak[1][i];
                  IndX2 := k;
                end;
                if (k = (TotalGen - 1)) and
                  (CalonAnak[2][i] <> Kromosom[POPULATION_SIZE + 2][IndX2]) then
                  for l := 0 to b do
                    if (l <> i) and (CalonAnak[2][i] = CalonAnak[1][l]) then
                      Kromosom[POPULATION_SIZE + 1][j] := CalonAnak[2][l];
              end;
              // end for K = b+1
              IndX2 := j;
            end;

            if (j = (TotalGen - 1)) and
              (CalonAnak[1][i] <> Kromosom[POPULATION_SIZE + 1][IndX2]) then
              for k := b + 1 to TotalGen - 1 do
                if (CalonAnak[2][i] = Kromosom[POPULATION_SIZE + 2][k]) then
                  for l := 0 to b do
                    if (l <> i) and (CalonAnak[1][i] = CalonAnak[2][l]) then
                      Kromosom[POPULATION_SIZE + 2][k] := CalonAnak[1][l];
          end;
          // end for J = b+1
        end; // if (CalonAnak[1][i] <> CalonAnak[2][i])
      end // if (CalonAnak[1][i] <> '0') and (CalonAnak[2][i] <> '0')
      else if (CalonAnak[1][i] <> '0') and (CalonAnak[2][i] = '0') then
      begin
        for j := b + 1 to TotalGen - 1 do
        begin
          IndX1 := TotalGen - 1;
          if CalonAnak[1][i] = Kromosom[POPULATION_SIZE + 1][j] then
          begin
            Kromosom[POPULATION_SIZE + 1][j] := '0';
            repeat
              Randomize;
              BilRandom := Random((TotalGen - (b + 1))) + (b + 1);
              Kelas1 := '0';
            until Kromosom[POPULATION_SIZE + 2][BilRandom] = Kelas1;
            Kromosom[POPULATION_SIZE + 2][BilRandom] := CalonAnak[1][i];
            IndX1 := j;
          end;

          if (j = (TotalGen - 1)) and
            (CalonAnak[1][i] <> Kromosom[POPULATION_SIZE + 1][IndX1]) then
            for k := 0 to b do
              if (k <> i) and (CalonAnak[2][k] = CalonAnak[1][i]) then
              begin
                repeat
                  Randomize;
                  BilRandom := Random((TotalGen - (b + 1))) + (b + 1);
                  Kelas1 := '0';
                until Kromosom[POPULATION_SIZE + 2][BilRandom] = Kelas1;
                Kromosom[POPULATION_SIZE + 2][BilRandom] := CalonAnak[1][k];
              end;
        end; // for j := b + 1 to TotalGen - 1
      end // if (CalonAnak[1][i] <> '0') and (CalonAnak[2][i] = '0')
      else if (CalonAnak[1][i] = '0') and (CalonAnak[2][i] <> '0') then
      begin
        for j := b + 1 to TotalGen - 1 do
        begin
          IndX1 := TotalGen - 1;
          if CalonAnak[2][i] = Kromosom[POPULATION_SIZE + 2][j] then
          begin
            Kromosom[POPULATION_SIZE + 2][j] := '0';
            repeat
              Randomize;
              BilRandom := Random((TotalGen - (b + 1))) + (b + 1);
              Kelas1 := '0';
            until Kromosom[POPULATION_SIZE + 1][BilRandom] = Kelas1;
            Kromosom[POPULATION_SIZE + 1][BilRandom] := CalonAnak[2][i];
            IndX1 := j;
          end;

          if (j = (TotalGen - 1)) and
            (CalonAnak[2][i] <> Kromosom[POPULATION_SIZE + 2][IndX1]) then
            for k := 0 to b do
              if (k <> i) and (CalonAnak[2][i] = CalonAnak[1][k]) then
              begin
                repeat
                  Randomize;
                  BilRandom := Random((TotalGen - (b + 1))) + (b + 1);
                  Kelas1 := '0';
                until Kromosom[POPULATION_SIZE + 1][BilRandom] = Kelas1;
                Kromosom[POPULATION_SIZE + 1][BilRandom] := CalonAnak[2][k];
              end;
        end; // for j := b + 1 to TotalGen - 1
      end; // if (CalonAnak[1][i] = '0') and (CalonAnak[2][i] <> '0')
    end; // end for i = 0 to b
  end // end if (a = 0) and (b < (TotalGen - 1))

  // ============================================================================
  // Posisi Range di Akhir kromosom ??? - (TotalGen-1)
  else if (a > 0) and (a < (TotalGen - 1)) and (b = (TotalGen - 1)) then
  begin
    // Calon Anak
    index := 0;
    for i := 0 to TotalGen - 1 do
    begin
      if i < a then
      begin
        Kromosom[POPULATION_SIZE + 1][i] := Kromosom[NoKromosom1][i];
        Kromosom[POPULATION_SIZE + 2][i] := Kromosom[NoKromosom2][i];
      end
      else
      begin
        CalonAnak[1][index] := Kromosom[NoKromosom2][i];
        CalonAnak[2][index] := Kromosom[NoKromosom1][i];
        Kromosom[POPULATION_SIZE + 1][i] := CalonAnak[1][index];
        Kromosom[POPULATION_SIZE + 2][i] := CalonAnak[2][index];
        index := index + 1;
      end;
    end;

    // Hubungan Kedua Calon Anak dan Anak
    for i := 0 to (b - a) do
    begin
      if (CalonAnak[1][i] <> '0') and (CalonAnak[2][i] <> '0') then
      begin
        if (CalonAnak[1][i] <> CalonAnak[2][i]) then
        begin
          for j := 0 to a - 1 do
          begin
            IndX1 := a - 1;
            if (CalonAnak[1][i] = Kromosom[POPULATION_SIZE + 1][j]) then
            begin
              for k := 0 to a - 1 do
              begin
                IndX2 := a - 1;
                if (CalonAnak[2][i] = Kromosom[POPULATION_SIZE + 2][k]) then
                begin
                  Kromosom[POPULATION_SIZE + 1][j] := CalonAnak[2][i];
                  Kromosom[POPULATION_SIZE + 2][k] := CalonAnak[1][i];
                  IndX2 := k;
                end;

                if (k = (a - 1)) and
                  (CalonAnak[2][i] <> Kromosom[POPULATION_SIZE + 2][IndX2]) then
                  for l := 0 to (b - a) do
                    if (l <> i) and (CalonAnak[2][i] = CalonAnak[1][l]) then
                      Kromosom[POPULATION_SIZE + 1][j] := CalonAnak[2][l];
              end;
              // for k := 0 to a - 1
              IndX1 := j;
            end; // if (CalonAnak[1][i] = Kromosom[POPULATION_SIZE + 1][j])

            if (j = (a - 1)) and
              (CalonAnak[1][i] <> Kromosom[POPULATION_SIZE + 1][IndX1]) then
              for k := 0 to a - 1 do
                if (CalonAnak[2][i] = Kromosom[POPULATION_SIZE + 2][k]) then
                  for l := 0 to (b - a) do
                    if (l <> i) and (CalonAnak[1][i] = CalonAnak[2][l]) then
                      Kromosom[POPULATION_SIZE + 2][k] := CalonAnak[1][l];
          end;
          // for j := 0 to a - 1
        end; // if (CalonAnak[1][i] <> CalonAnak[2][i])
      end // end CalonAnak[1][i] <> '0' and CalonAnak[2][i] <> '0'
      else if (CalonAnak[1][i] <> '0') and (CalonAnak[2][i] = '0') then
      begin
        for j := 0 to a - 1 do
        begin
          IndX1 := a - 1;
          if CalonAnak[1][i] = Kromosom[POPULATION_SIZE + 1][j] then
          begin
            Kromosom[POPULATION_SIZE + 1][j] := '0';
            repeat
              Randomize;
              BilRandom := Random(a);
              Kelas1 := '0';
            until Kromosom[POPULATION_SIZE + 2][BilRandom] = Kelas1;
            Kromosom[POPULATION_SIZE + 2][BilRandom] := CalonAnak[1][i];
            IndX1 := j;
          end;

          if (j = (a - 1)) and
            (CalonAnak[1][i] <> Kromosom[POPULATION_SIZE + 1][IndX1]) then
            for k := 0 to (b - a) do
              if (k <> i) and (CalonAnak[2][k] = CalonAnak[1][i]) then
              begin
                repeat
                  Randomize;
                  BilRandom := Random(a);
                  Kelas1 := '0';
                until Kromosom[POPULATION_SIZE + 2][BilRandom] = Kelas1;
                Kromosom[POPULATION_SIZE + 2][BilRandom] := CalonAnak[1][k];
              end;
        end; // for j := 0 to a - 1
      end // if (CalonAnak[1][i] <> '0') and (CalonAnak[2][i] = '0')
      else if (CalonAnak[1][i] = '0') and (CalonAnak[2][i] <> '0') then
        for j := 0 to a - 1 do
        begin
          IndX1 := a - 1;
          if CalonAnak[2][i] = Kromosom[POPULATION_SIZE + 2][j] then
          begin
            Kromosom[POPULATION_SIZE + 2][j] := '0';
            repeat
              Randomize;
              BilRandom := Random(a);
              Kelas1 := '0';
            until Kromosom[POPULATION_SIZE + 1][BilRandom] = Kelas1;
            Kromosom[POPULATION_SIZE + 1][BilRandom] := CalonAnak[2][i];
            IndX1 := j;
          end;

          if (j = (a - 1)) and
            (CalonAnak[2][i] <> Kromosom[POPULATION_SIZE + 2][IndX1]) then
            for k := 0 to (b - a) do
              if (k <> i) and (CalonAnak[2][i] = CalonAnak[1][k]) then
              begin
                repeat
                  Randomize;
                  BilRandom := Random(a);
                  Kelas1 := '0';
                until Kromosom[POPULATION_SIZE + 1][BilRandom] = Kelas1;
                Kromosom[POPULATION_SIZE + 1][BilRandom] := CalonAnak[2][k];
              end;
        end; // for j := 0 to a - 1
    end; // if (CalonAnak[1][i] = '0') and (CalonAnak[2][i] <> '0')
  end // if ((a > 0) and (a < (TotalGen - 1)) and (b = (TotalGen - 1)))

  // ============================================================================
  // Posisi Range di tengah kromosom ??? - ???
  else if (a > 0) and (b < (TotalGen - 1)) then
  begin
    // Lakukan pertukaran dari titik a - titik b
    index := 0;
    for i := 0 to TotalGen - 1 do
    begin
      if (i >= a) and (i <= b) then
      begin
        CalonAnak[1][index] := Kromosom[NoKromosom2][i];
        CalonAnak[2][index] := Kromosom[NoKromosom1][i];
        Kromosom[POPULATION_SIZE + 1][i] := CalonAnak[1][index];
        Kromosom[POPULATION_SIZE + 2][i] := CalonAnak[2][index];
        index := index + 1;
      end
      else
      begin
        Kromosom[POPULATION_SIZE + 1][i] := Kromosom[NoKromosom1][i];
        Kromosom[POPULATION_SIZE + 2][i] := Kromosom[NoKromosom2][i];
      end;
    end;

    // Hubungan Calon Anak dan Anak dan Perbaiki Kode Yang Kemungkinan Ganda
    for i := 0 to (b - a) do
    begin

      if (CalonAnak[1][i] <> '0') and (CalonAnak[2][i] <> '0') then
      begin
        if (CalonAnak[1][i] <> CalonAnak[2][i]) then
          for j := 0 to TotalGen - 1 do
          begin
            IndX1 := TotalGen - 1;
            if (j < a) or (j > b) then
            begin
              if (CalonAnak[1][i] = Kromosom[POPULATION_SIZE + 1][j]) then
              begin
                for k := 0 to TotalGen - 1 do
                begin
                  IndX2 := TotalGen - 1;
                  if (k < a) or (k > b) then
                  begin
                    if (CalonAnak[2][i] = Kromosom[POPULATION_SIZE + 2][k]) then
                    begin
                      Kromosom[POPULATION_SIZE + 1][j] := CalonAnak[2][i];
                      Kromosom[POPULATION_SIZE + 2][k] := CalonAnak[1][i];
                      IndX2 := k;
                    end;
                    if (k = (TotalGen - 1)) and
                      (CalonAnak[2][i] <> Kromosom[POPULATION_SIZE + 2][IndX2])
                      then
                      for l := 0 to (b - a) do
                        if (l <> i) and (CalonAnak[2][i] = CalonAnak[1][l]) then
                          Kromosom[POPULATION_SIZE + 1][j] := CalonAnak[2][l];
                  end;
                  // end if (k < a) and (k > b)
                end; // end for K = 0
                IndX1 := j;
              end; // if (CalonAnak[1][i] = Kromosom[POPULATION_SIZE + 1][j])

              if (j = (TotalGen - 1)) and
                (CalonAnak[1][i] <> Kromosom[POPULATION_SIZE + 1][IndX1]) then
              begin
                for k := 0 to TotalGen - 1 do
                  if (k < a) or (k > b) then
                    if (CalonAnak[2][i] = Kromosom[POPULATION_SIZE + 2][k]) then
                      for l := 0 to (b - a) do
                        if (l <> i) and (CalonAnak[1][i] = CalonAnak[2][l]) then
                          Kromosom[POPULATION_SIZE + 2][k] := CalonAnak[1][l];
              end;
              // if (j = (TotalGen - 1))
            end; // if (j < a) and (j > b)
          end; // for j := 0 to TotalGen - 1
      end // (CalonAnak[1][i] <> '0') and (CalonAnak[2][i] <> '0')
      else if (CalonAnak[1][i] <> '0') and (CalonAnak[2][i] = '0') then
      begin
        for j := 0 to TotalGen - 1 do
        begin
          IndX1 := TotalGen - 1;
          if (j < a) or (j > b) then
          begin
            if CalonAnak[1][i] = Kromosom[POPULATION_SIZE + 1][j] then
            begin
              Kromosom[POPULATION_SIZE + 1][j] := '0';
              repeat
                Randomize;
                BilRandom := Random(TotalGen);
                Kelas1 := '0';
              until ((BilRandom < a) or (BilRandom > b)) and
                (Kromosom[POPULATION_SIZE + 2][BilRandom] = Kelas1);
              Kromosom[POPULATION_SIZE + 2][BilRandom] := CalonAnak[1][i];
              IndX1 := j;
            end;

            if (j = (TotalGen - 1)) and
              (CalonAnak[1][i] <> Kromosom[POPULATION_SIZE + 1][IndX1]) then
              for k := 0 to (b - a) do
                if k <> i then
                  if CalonAnak[2][k] = CalonAnak[1][i] then
                  begin
                    repeat
                      Randomize;
                      BilRandom := Random(TotalGen);
                      Kelas1 := '0';
                    until ((BilRandom < a) or (BilRandom > b)) and
                      (Kromosom[POPULATION_SIZE + 2][BilRandom] = Kelas1);
                    Kromosom[POPULATION_SIZE + 2][BilRandom] := CalonAnak[1][k];
                  end;
          end; // if (j < a) and (j > b)
        end; // for j := 0 to TotalGen - 1
      end // C.Anak[1][i] <> '0' and C.Anak[2][i] = '0'
      else if (CalonAnak[1][i] = '0') and (CalonAnak[2][i] <> '0') then
      begin
        for j := 0 to TotalGen - 1 do
        begin
          IndX1 := TotalGen - 1;
          if (j < a) or (j > b) then
          begin
            if CalonAnak[2][i] = Kromosom[POPULATION_SIZE + 2][j] then
            begin
              Kromosom[POPULATION_SIZE + 2][j] := '0';
              repeat
                Randomize;
                BilRandom := Random(TotalGen);
                Kelas1 := '0';
              until ((BilRandom < a) or (BilRandom > b)) and
                (Kromosom[POPULATION_SIZE + 1][BilRandom] = Kelas1);
              Kromosom[POPULATION_SIZE + 1][BilRandom] := CalonAnak[2][i];
              IndX1 := j;
            end;

            if (j = (TotalGen - 1)) and
              (CalonAnak[2][i] <> Kromosom[POPULATION_SIZE + 2][IndX1]) then
              for k := 0 to (b - a) do
                if k <> i then
                  if CalonAnak[2][i] = CalonAnak[1][k] then
                  begin
                    repeat
                      Randomize;
                      BilRandom := Random(TotalGen);
                      Kelas1 := '0';
                    until ((BilRandom < a) or (BilRandom > b)) and
                      (Kromosom[POPULATION_SIZE + 1][BilRandom] = Kelas1);
                    Kromosom[POPULATION_SIZE + 1][BilRandom] := CalonAnak[2][k];
                  end;
          end; // end if (j < a) and (j > b)
        end; // end for J = 0
      end; // end C.Anak[1][i] = '0' and C.Anak[2][i] <> '0'
    end; // for i := 0 to (b - a) do
  end; // if (a > 0) and (b < (TotalGen - 1))
  // ============================================================================

  // Cek jika masih ada kelas yang sama
  for NoKromosom := 1 to 2 do
  begin
    for j := 0 to TotalGen - 1 do
    begin
      if (j >= a) and (j <= b) then
      begin
        if Kromosom[NoKromosom + POPULATION_SIZE][j] <> '0' then
        begin
          Kelas1 := Kromosom[NoKromosom + POPULATION_SIZE][j];
          for i := 0 to TotalGen - 1 do
          begin
            if (i < a) and (i > b) then
            begin
              if Kromosom[NoKromosom + POPULATION_SIZE][i] <> '0' then
              begin
                Kelas2 := Kromosom[NoKromosom + POPULATION_SIZE][i];
                if Kelas1 = Kelas2 then
                  Kromosom[NoKromosom + POPULATION_SIZE][i] := '0';
              end;
            end;
            // if (i < a) and (i > b)
          end; // for i
        end; // if Kromosom[NoKromosom + POPULATION_SIZE][j] <> '0'
      end; // if (j >= a) and (j <= b)
    end; // for j

    for i := 0 to TotalGen - 1 do
    begin
      if Kromosom[NoKromosom + POPULATION_SIZE][i] <> '0' then
      begin
        for j := i + 1 to TotalGen - 1 do
        begin
          if Kromosom[NoKromosom + POPULATION_SIZE][i] = Kromosom
            [NoKromosom + POPULATION_SIZE][j] then
            Kromosom[NoKromosom + POPULATION_SIZE][j] := '0';
        end;
      end;
    end;
  end;
  // end for NoKromosom

  {
    for NoKromosom := 1 to 2 do
    begin
    Jumlah[NoKromosom] := 0;
    for i := 0 to TotalGen - 1 do
    begin
    if Kromosom[POPULATION_SIZE + NoKromosom][i] <> '0' then
    begin
    Jumlah[NoKromosom] := Jumlah[NoKromosom] + 1;
    end;
    end;
    end;
    }

  HitungFitness(POPULATION_SIZE + 1);
  HitungFitness(POPULATION_SIZE + 2);

  SetLength(BantuKromosom[1], TotalGen);
  SetLength(BantuKromosom[2], TotalGen);

  ind := CekKromCross(POPULATION_SIZE + 1);
  if ind <> 0 then
  begin
    if NilaiFitness[POPULATION_SIZE + 1] <= NilaiFitness[ind] then
    begin
      for i := 0 to TotalGen - 1 do
      begin
        Kromosom[ind][i] := Kromosom[POPULATION_SIZE + 1][i];
      end;
      NilaiFitness[ind] := NilaiFitness[POPULATION_SIZE + 1];
    end;
    UrutKromosom;
  end
  else
  begin
    // Urut Kromosom Sampai POPULATION_SIZE + 1
    for i := 1 to POPULATION_SIZE do
    begin
      for j := i + 1 to POPULATION_SIZE + 1 do
      begin
        Fitness1 := NilaiFitness[i];
        Fitness2 := NilaiFitness[j];
        for k := 0 to TotalGen - 1 do
        begin
          BantuKromosom[1][k] := Kromosom[i][k];
          BantuKromosom[2][k] := Kromosom[j][k];
        end;
        if Fitness1 >= Fitness2 then
        begin
          NilaiFitness[i] := Fitness2;
          NilaiFitness[j] := Fitness1;
          for k := 0 to TotalGen - 1 do
          begin
            Kromosom[i][k] := BantuKromosom[2][k];
            Kromosom[j][k] := BantuKromosom[1][k]
          end;
        end
        else if Fitness1 < Fitness2 then
        begin
          NilaiFitness[i] := Fitness1;
          for k := 0 to TotalGen - 1 do
            Kromosom[i][k] := BantuKromosom[1][k];
        end;
      end; // end for j
    end; // end for i
  end;

  ind := CekKromCross(POPULATION_SIZE + 2);
  if ind <> 0 then
  begin
    if NilaiFitness[POPULATION_SIZE + 2] <= NilaiFitness[ind] then
    begin
      for i := 0 to TotalGen - 1 do
      begin
        Kromosom[ind][i] := Kromosom[POPULATION_SIZE + 2][i];
      end;
      NilaiFitness[ind] := NilaiFitness[POPULATION_SIZE + 2];
    end;
    UrutKromosom;
  end
  else
  begin
    for i := 0 to TotalGen - 1 do
    begin
      Kromosom[POPULATION_SIZE + 1][i] := Kromosom[POPULATION_SIZE + 2][i];
    end;
    NilaiFitness[POPULATION_SIZE + 1] := NilaiFitness[POPULATION_SIZE + 2];
    for i := 1 to POPULATION_SIZE do
    begin
      for j := i + 1 to POPULATION_SIZE + 1 do
      begin
        Fitness1 := NilaiFitness[i];
        Fitness2 := NilaiFitness[j];
        for k := 0 to TotalGen - 1 do
        begin
          BantuKromosom[1][k] := Kromosom[i][k];
          BantuKromosom[2][k] := Kromosom[j][k];
        end;
        if Fitness1 >= Fitness2 then
        begin
          NilaiFitness[i] := Fitness2;
          NilaiFitness[j] := Fitness1;
          for k := 0 to TotalGen - 1 do
          begin
            Kromosom[i][k] := BantuKromosom[2][k];
            Kromosom[j][k] := BantuKromosom[1][k]
          end;
        end
        else if Fitness1 < Fitness2 then
        begin
          NilaiFitness[i] := Fitness1;
          for k := 0 to TotalGen - 1 do
            Kromosom[i][k] := BantuKromosom[1][k];
        end;
      end; // end for j
    end; // end for i
  end;

end;
// END CROSSOVER

destructor TAGenetika.Destroy;
var
  i: integer;
begin
  for i := 0 to Length(Kegiatan) - 1 do
  begin
    FreeAndNil(Kegiatan[i]);
  end;
  for i := 0 to Length(Ruangan) - 1 do
  begin
    FreeAndNil(Ruangan[i]);
  end;
  for i := 0 to Length(AturanPengajar) - 1 do
  begin
    FreeAndNil(AturanPengajar[i]);
  end;
  // Kegiatan := nil;
  // FreeAndNil(Kromosom);
  // FreeAndNil(NilaiFitness);
  // FreeAndNil(JumFitAturan);
  // FreeAndNil(AG);
  // inherited;
end;

end.
