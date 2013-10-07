
{**************************************************************************************}
{                                                                                      }
{                                   XML Data Binding                                   }
{                                                                                      }
{         Generated on: 1/30/2013 10:26:20 AM                                          }
{       Generated from: D:\Programmer's\Dee\Kuliah\TA\Aplikasi\17090069\libs\log.xml   }
{   Settings stored in: D:\Programmer's\Dee\Kuliah\TA\Aplikasi\17090069\libs\log.xdb   }
{                                                                                      }
{**************************************************************************************}

unit XMLLog;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLDeehiedaylogType = interface;
  IXMLLogType = interface;

{ IXMLDeehiedaylogType }

  IXMLDeehiedaylogType = interface(IXMLNodeCollection)
    ['{E1E3C23B-BADF-473B-BB6D-BB3805291208}']
    { Property Accessors }
    function Get_Log(Index: Integer): IXMLLogType;
    { Methods & Properties }
    function Add: IXMLLogType;
    function Insert(const Index: Integer): IXMLLogType;
    property Log[Index: Integer]: IXMLLogType read Get_Log; default;
  end;

{ IXMLLogType }

  IXMLLogType = interface(IXMLNode)
    ['{69D3172C-8333-4186-B4AF-A266EEDA3CFE}']
    { Property Accessors }
    function Get_Datetime: string;
    function Get_Hari: Integer;
    function Get_Ruang: Integer;
    function Get_Jam: Integer;
    function Get_Kelas: Integer;
    function Get_Fawal: Integer;
    function Get_Fakhir: Integer;
    function Get_Iterasi: Integer;
    function Get_Time: string;
    function Get_Ket: string;
    procedure Set_Datetime(Value: string);
    procedure Set_Hari(Value: Integer);
    procedure Set_Ruang(Value: Integer);
    procedure Set_Jam(Value: Integer);
    procedure Set_Kelas(Value: Integer);
    procedure Set_Fawal(Value: Integer);
    procedure Set_Fakhir(Value: Integer);
    procedure Set_Iterasi(Value: Integer);
    procedure Set_Time(Value: string);
    procedure Set_Ket(Value: string);
    { Methods & Properties }
    property Datetime: string read Get_Datetime write Set_Datetime;
    property Hari: Integer read Get_Hari write Set_Hari;
    property Ruang: Integer read Get_Ruang write Set_Ruang;
    property Jam: Integer read Get_Jam write Set_Jam;
    property Kelas: Integer read Get_Kelas write Set_Kelas;
    property Fawal: Integer read Get_Fawal write Set_Fawal;
    property Fakhir: Integer read Get_Fakhir write Set_Fakhir;
    property Iterasi: Integer read Get_Iterasi write Set_Iterasi;
    property Time: string read Get_Time write Set_Time;
    property Ket: string read Get_Ket write Set_Ket;
  end;

{ Forward Decls }

  TXMLDeehiedaylogType = class;
  TXMLLogType = class;

{ TXMLDeehiedaylogType }

  TXMLDeehiedaylogType = class(TXMLNodeCollection, IXMLDeehiedaylogType)
  protected
    { IXMLDeehiedaylogType }
    function Get_Log(Index: Integer): IXMLLogType;
    function Add: IXMLLogType;
    function Insert(const Index: Integer): IXMLLogType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLLogType }

  TXMLLogType = class(TXMLNode, IXMLLogType)
  protected
    { IXMLLogType }
    function Get_Datetime: string;
    function Get_Hari: Integer;
    function Get_Ruang: Integer;
    function Get_Jam: Integer;
    function Get_Kelas: Integer;
    function Get_Fawal: Integer;
    function Get_Fakhir: Integer;
    function Get_Iterasi: Integer;
    function Get_Time: string;
    function Get_Ket: string;
    procedure Set_Datetime(Value: string);
    procedure Set_Hari(Value: Integer);
    procedure Set_Ruang(Value: Integer);
    procedure Set_Jam(Value: Integer);
    procedure Set_Kelas(Value: Integer);
    procedure Set_Fawal(Value: Integer);
    procedure Set_Fakhir(Value: Integer);
    procedure Set_Iterasi(Value: Integer);
    procedure Set_Time(Value: string);
    procedure Set_Ket(Value: string);
  end;

{ Global Functions }

function Getdeehiedaylog(Doc: IXMLDocument): IXMLDeehiedaylogType;
function Loaddeehiedaylog(const FileName: string): IXMLDeehiedaylogType;
function Newdeehiedaylog: IXMLDeehiedaylogType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function Getdeehiedaylog(Doc: IXMLDocument): IXMLDeehiedaylogType;
begin
  Result := Doc.GetDocBinding('deehiedaylog', TXMLDeehiedaylogType, TargetNamespace) as IXMLDeehiedaylogType;
end;

function Loaddeehiedaylog(const FileName: string): IXMLDeehiedaylogType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('deehiedaylog', TXMLDeehiedaylogType, TargetNamespace) as IXMLDeehiedaylogType;
end;

function Newdeehiedaylog: IXMLDeehiedaylogType;
begin
  Result := NewXMLDocument.GetDocBinding('deehiedaylog', TXMLDeehiedaylogType, TargetNamespace) as IXMLDeehiedaylogType;
end;

{ TXMLDeehiedaylogType }

procedure TXMLDeehiedaylogType.AfterConstruction;
begin
  RegisterChildNode('log', TXMLLogType);
  ItemTag := 'log';
  ItemInterface := IXMLLogType;
  inherited;
end;

function TXMLDeehiedaylogType.Get_Log(Index: Integer): IXMLLogType;
begin
  Result := List[Index] as IXMLLogType;
end;

function TXMLDeehiedaylogType.Add: IXMLLogType;
begin
  Result := AddItem(-1) as IXMLLogType;
end;

function TXMLDeehiedaylogType.Insert(const Index: Integer): IXMLLogType;
begin
  Result := AddItem(Index) as IXMLLogType;
end;

{ TXMLLogType }

function TXMLLogType.Get_Datetime: string;
begin
  Result := ChildNodes['datetime'].Text;
end;

procedure TXMLLogType.Set_Datetime(Value: string);
begin
  ChildNodes['datetime'].NodeValue := Value;
end;

function TXMLLogType.Get_Hari: Integer;
begin
  Result := ChildNodes['hari'].NodeValue;
end;

procedure TXMLLogType.Set_Hari(Value: Integer);
begin
  ChildNodes['hari'].NodeValue := Value;
end;

function TXMLLogType.Get_Ruang: Integer;
begin
  Result := ChildNodes['ruang'].NodeValue;
end;

procedure TXMLLogType.Set_Ruang(Value: Integer);
begin
  ChildNodes['ruang'].NodeValue := Value;
end;

function TXMLLogType.Get_Jam: Integer;
begin
  Result := ChildNodes['jam'].NodeValue;
end;

procedure TXMLLogType.Set_Jam(Value: Integer);
begin
  ChildNodes['jam'].NodeValue := Value;
end;

function TXMLLogType.Get_Kelas: Integer;
begin
  Result := ChildNodes['kelas'].NodeValue;
end;

procedure TXMLLogType.Set_Kelas(Value: Integer);
begin
  ChildNodes['kelas'].NodeValue := Value;
end;

function TXMLLogType.Get_Fawal: Integer;
begin
  Result := ChildNodes['fawal'].NodeValue;
end;

procedure TXMLLogType.Set_Fawal(Value: Integer);
begin
  ChildNodes['fawal'].NodeValue := Value;
end;

function TXMLLogType.Get_Fakhir: Integer;
begin
  Result := ChildNodes['fakhir'].NodeValue;
end;

procedure TXMLLogType.Set_Fakhir(Value: Integer);
begin
  ChildNodes['fakhir'].NodeValue := Value;
end;

function TXMLLogType.Get_Iterasi: Integer;
begin
  Result := ChildNodes['iterasi'].NodeValue;
end;

procedure TXMLLogType.Set_Iterasi(Value: Integer);
begin
  ChildNodes['iterasi'].NodeValue := Value;
end;

function TXMLLogType.Get_Time: string;
begin
  Result := ChildNodes['time'].Text;
end;

procedure TXMLLogType.Set_Time(Value: string);
begin
  ChildNodes['time'].NodeValue := Value;
end;

function TXMLLogType.Get_Ket: string;
begin
  Result := ChildNodes['ket'].Text;
end;

procedure TXMLLogType.Set_Ket(Value: string);
begin
  ChildNodes['ket'].NodeValue := Value;
end;

end.
