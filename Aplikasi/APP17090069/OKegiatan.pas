unit OKegiatan;

interface

type
  TKegiatan = class
  private
    Fid: string;
    Fpengajar: integer;
    Fsks: integer;
    Fkelas: integer;
    Ftingkat: integer;
    Fjurusan: integer;
    Fmatapelajaran: integer;
    Fjam: integer;
    procedure Setid(const Value: string);
    procedure Setjurusan(const Value: integer);
    procedure Setkelas(const Value: integer);
    procedure Setmatapelajaran(const Value: integer);
    procedure Setpengajar(const Value: integer);
    procedure Setsks(const Value: integer);
    procedure Settingkat(const Value: integer);
    procedure Setjam(const Value: integer);
  protected

  published

  public
    constructor Create;
    destructor Destroy;
    property id: string read Fid write Setid;
    property tingkat: integer read Ftingkat write Settingkat;
    property jurusan: integer read Fjurusan write Setjurusan;
    property kelas: integer read Fkelas write Setkelas;
    property matapelajaran: integer read Fmatapelajaran write Setmatapelajaran;
    property pengajar: integer read Fpengajar write Setpengajar;
    property sks: integer read Fsks write Setsks;
    property jam: integer read Fjam write Setjam;
  end;

implementation

{ TKegiatan }

constructor TKegiatan.Create;
begin
  Fid := '';
  Fpengajar := 0;
  Fsks := 0;
  Fkelas := 0;
  Ftingkat := 0;
  Fjurusan := 0;
end;

destructor TKegiatan.Destroy;
begin
  //inherited;
end;

procedure TKegiatan.Setid(const Value: string);
begin
  Fid := Value;
end;

procedure TKegiatan.Setjam(const Value: integer);
begin
  Fjam := Value;
end;

procedure TKegiatan.Setjurusan(const Value: integer);
begin
  Fjurusan := Value;
end;

procedure TKegiatan.Setkelas(const Value: integer);
begin
  Fkelas := Value;
end;

procedure TKegiatan.Setmatapelajaran(const Value: integer);
begin
  Fmatapelajaran := Value;
end;

procedure TKegiatan.Setpengajar(const Value: integer);
begin
  Fpengajar := Value;
end;

procedure TKegiatan.Setsks(const Value: integer);
begin
  Fsks := Value;
end;

procedure TKegiatan.Settingkat(const Value: integer);
begin
  Ftingkat := Value;
end;

end.
