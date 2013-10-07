unit ORuangan;

interface

type
  TRuangan = class
  private
    Ftingkat_2: boolean;
    Ftingkat_3: boolean;
    Ftingkat_1: boolean;
    Fid: integer;
    Fruangan: string;
    procedure Setid(const Value: integer);
    procedure Setruangan(const Value: string);
    procedure Settingkat_1(const Value: boolean);
    procedure Settingkat_2(const Value: boolean);
    procedure Settingkat_3(const Value: boolean);
  published

  public
    property id: integer read Fid write Setid;
    property ruangan: string read Fruangan write Setruangan;
    property tingkat_1: boolean read Ftingkat_1 write Settingkat_1;
    property tingkat_2: boolean read Ftingkat_2 write Settingkat_2;
    property tingkat_3: boolean read Ftingkat_3 write Settingkat_3;

  end;

implementation

{ TRuangan }

procedure TRuangan.Setid(const Value: integer);
begin
  Fid := Value;
end;

procedure TRuangan.Setruangan(const Value: string);
begin
  Fruangan := Value;
end;

procedure TRuangan.Settingkat_1(const Value: boolean);
begin
  Ftingkat_1 := Value;
end;

procedure TRuangan.Settingkat_2(const Value: boolean);
begin
  Ftingkat_2 := Value;
end;

procedure TRuangan.Settingkat_3(const Value: boolean);
begin
  Ftingkat_3 := Value;
end;

end.
