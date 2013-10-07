unit OAturanPengajar;

interface

type
  TAturanPengajar = class
  private
    Fpengajar: integer;
    Fhari: integer;
    Fjam: integer;
    procedure Sethari(const Value: integer);
    procedure Setpengajar(const Value: integer);
    procedure Setjam(const Value: integer);
  published
  public
    property pengajar: integer read Fpengajar write Setpengajar;
    property hari: integer read Fhari write Sethari;
    property jam: integer read Fjam write Setjam;
  end;

implementation

{ TAturanPengajar }

procedure TAturanPengajar.Sethari(const Value: integer);
begin
  Fhari := Value;
end;

procedure TAturanPengajar.Setjam(const Value: integer);
begin
  Fjam := Value;
end;

procedure TAturanPengajar.Setpengajar(const Value: integer);
begin
  Fpengajar := Value;
end;

end.
