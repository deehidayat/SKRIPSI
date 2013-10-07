
{******************************************************************************************}
{                                                                                          }
{                                     XML Data Binding                                     }
{                                                                                          }
{         Generated on: 2/11/2013 12:38:23 PM                                              }
{       Generated from: D:\Programmer's\Dee\Kuliah\TA\Aplikasi\17090069\libs\setting.xdb   }
{   Settings stored in: D:\Programmer's\Dee\Kuliah\TA\Aplikasi\17090069\libs\setting.xdb   }
{                                                                                          }
{******************************************************************************************}

unit XMLSetting;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLDeehiedayType = interface;
  IXMLDatabaseType = interface;
  IXMLSkinType = interface;

{ IXMLDeehiedayType }

  IXMLDeehiedayType = interface(IXMLNode)
    ['{C907D431-8334-48E1-9B1A-F7248ACBE4FB}']
    { Property Accessors }
    function Get_Debug: string;
    function Get_Kodekelas: string;
    function Get_Splashimage: string;
    function Get_Jpfield: string;
    function Get_Populasi: integer;
    function Get_Database: IXMLDatabaseType;
    function Get_Skin: IXMLSkinType;
    function Get_aturan: string;
    function Get_laporan: string;
    procedure Set_Debug(Value: string);
    procedure Set_Kodekelas(Value: string);
    procedure Set_Splashimage(Value: string);
    procedure Set_Jpfield(Value: string);
    procedure Set_Populasi(Value: integer);
    procedure Set_aturan(Value: string);
    procedure Set_laporan(Value: string);
    { Methods & Properties }
    property Debug: string read Get_Debug write Set_Debug;
    property Kodekelas: string read Get_Kodekelas write Set_Kodekelas;
    property Splashimage: string read Get_Splashimage write Set_Splashimage;
    property Jpfield: string read Get_Jpfield write Set_Jpfield;
    property Populasi: integer read Get_Populasi write Set_Populasi;
    property Database: IXMLDatabaseType read Get_Database;
    property Skin: IXMLSkinType read Get_Skin;
    property ExAturan: string read Get_aturan write Set_aturan;
    property ExLaporan: string read Get_laporan write Set_laporan;
  end;

{ IXMLDatabaseType }

  IXMLDatabaseType = interface(IXMLNode)
    ['{95F3CF14-B4CA-4294-96A2-823507C92C0B}']
    { Property Accessors }
    function Get_Protocol: string;
    function Get_Name: string;
    function Get_Host: string;
    function Get_User: string;
    function Get_Password: UnicodeString;
    procedure Set_Protocol(Value: string);
    procedure Set_Name(Value: string);
    procedure Set_Host(Value: string);
    procedure Set_User(Value: string);
    procedure Set_Password(Value: UnicodeString);
    { Methods & Properties }
    property Protocol: string read Get_Protocol write Set_Protocol;
    property Name: string read Get_Name write Set_Name;
    property Host: string read Get_Host write Set_Host;
    property User: string read Get_User write Set_User;
    property Password: UnicodeString read Get_Password write Set_Password;
  end;

{ IXMLSkinType }

  IXMLSkinType = interface(IXMLNode)
    ['{5C147D72-7D24-4795-851C-DE6B95A5ECBB}']
    { Property Accessors }
    function Get_Aktif: string;
    function Get_Template: string;
    procedure Set_Aktif(Value: string);
    procedure Set_Template(Value: string);
    { Methods & Properties }
    property Aktif: string read Get_Aktif write Set_Aktif;
    property Template: string read Get_Template write Set_Template;
  end;

{ Forward Decls }

  TXMLDeehiedayType = class;
  TXMLDatabaseType = class;
  TXMLSkinType = class;

{ TXMLDeehiedayType }

  TXMLDeehiedayType = class(TXMLNode, IXMLDeehiedayType)
  protected
    { IXMLDeehiedayType }
    function Get_Debug: string;
    function Get_Kodekelas: string;
    function Get_Splashimage: string;
    function Get_Jpfield: string;
    function Get_Populasi: integer;
    function Get_Database: IXMLDatabaseType;
    function Get_Skin: IXMLSkinType;
    function Get_aturan: string;
    function Get_laporan: string;
    procedure Set_Debug(Value: string);
    procedure Set_Kodekelas(Value: string);
    procedure Set_Splashimage(Value: string);
    procedure Set_Jpfield(Value: string);
    procedure Set_Populasi(Value: integer);
    procedure Set_aturan(Value: string);
    procedure Set_laporan(Value: string);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDatabaseType }

  TXMLDatabaseType = class(TXMLNode, IXMLDatabaseType)
  protected
    { IXMLDatabaseType }
    function Get_Protocol: string;
    function Get_Name: string;
    function Get_Host: string;
    function Get_User: string;
    function Get_Password: UnicodeString;
    procedure Set_Protocol(Value: string);
    procedure Set_Name(Value: string);
    procedure Set_Host(Value: string);
    procedure Set_User(Value: string);
    procedure Set_Password(Value: UnicodeString);
  end;

{ TXMLSkinType }

  TXMLSkinType = class(TXMLNode, IXMLSkinType)
  protected
    { IXMLSkinType }
    function Get_Aktif: string;
    function Get_Template: string;
    procedure Set_Aktif(Value: string);
    procedure Set_Template(Value: string);
  end;

{ Global Functions }

function Getdeehieday(Doc: IXMLDocument): IXMLDeehiedayType;
function Loaddeehieday(const FileName: string): IXMLDeehiedayType;
function Newdeehieday: IXMLDeehiedayType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function Getdeehieday(Doc: IXMLDocument): IXMLDeehiedayType;
begin
  Result := Doc.GetDocBinding('deehieday', TXMLDeehiedayType, TargetNamespace) as IXMLDeehiedayType;
end;

function Loaddeehieday(const FileName: string): IXMLDeehiedayType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('deehieday', TXMLDeehiedayType, TargetNamespace) as IXMLDeehiedayType;
end;

function Newdeehieday: IXMLDeehiedayType;
begin
  Result := NewXMLDocument.GetDocBinding('deehieday', TXMLDeehiedayType, TargetNamespace) as IXMLDeehiedayType;
end;

{ TXMLDeehiedayType }

procedure TXMLDeehiedayType.AfterConstruction;
begin
  RegisterChildNode('database', TXMLDatabaseType);
  RegisterChildNode('skin', TXMLSkinType);
  inherited;
end;

function TXMLDeehiedayType.Get_Debug: string;
begin
  Result := ChildNodes['debug'].Text;
end;

procedure TXMLDeehiedayType.Set_Debug(Value: string);
begin
  ChildNodes['debug'].NodeValue := Value;
end;

function TXMLDeehiedayType.Get_Kodekelas: string;
begin
  Result := ChildNodes['kodekelas'].Text;
end;

procedure TXMLDeehiedayType.Set_Kodekelas(Value: string);
begin
  ChildNodes['kodekelas'].NodeValue := Value;
end;

function TXMLDeehiedayType.Get_Splashimage: string;
begin
  Result := ChildNodes['splashimage'].Text;
end;

procedure TXMLDeehiedayType.Set_Splashimage(Value: string);
begin
  ChildNodes['splashimage'].NodeValue := Value;
end;

function TXMLDeehiedayType.Get_Jpfield: string;
begin
  Result := ChildNodes['jpfield'].Text;
end;

procedure TXMLDeehiedayType.Set_Jpfield(Value: string);
begin
  ChildNodes['jpfield'].NodeValue := Value;
end;

function TXMLDeehiedayType.Get_Populasi: integer;
begin
  Result := ChildNodes['populasi'].NodeValue;
end;

procedure TXMLDeehiedayType.Set_Populasi(Value: integer);
begin
  ChildNodes['populasi'].NodeValue := Value;
end;

function TXMLDeehiedayType.Get_Database: IXMLDatabaseType;
begin
  Result := ChildNodes['database'] as IXMLDatabaseType;
end;

function TXMLDeehiedayType.Get_Skin: IXMLSkinType;
begin
  Result := ChildNodes['skin'] as IXMLSkinType;
end;

function TXMLDeehiedayType.Get_aturan: string;
begin
  Result := ChildNodes['exaturan'].Text;
end;

procedure TXMLDeehiedayType.Set_aturan(Value: string);
begin
  ChildNodes['exaturan'].NodeValue := Value;
end;

function TXMLDeehiedayType.Get_laporan: string;
begin
  Result := ChildNodes['exlaporan'].Text;
end;

procedure TXMLDeehiedayType.Set_laporan(Value: string);
begin
  ChildNodes['exlaporan'].NodeValue := Value;
end;

{ TXMLDatabaseType }

function TXMLDatabaseType.Get_Protocol: string;
begin
  Result := ChildNodes['protocol'].Text;
end;

procedure TXMLDatabaseType.Set_Protocol(Value: string);
begin
  ChildNodes['protocol'].NodeValue := Value;
end;

function TXMLDatabaseType.Get_Name: string;
begin
  Result := ChildNodes['name'].Text;
end;

procedure TXMLDatabaseType.Set_Name(Value: string);
begin
  ChildNodes['name'].NodeValue := Value;
end;

function TXMLDatabaseType.Get_Host: string;
begin
  Result := ChildNodes['host'].Text;
end;

procedure TXMLDatabaseType.Set_Host(Value: string);
begin
  ChildNodes['host'].NodeValue := Value;
end;

function TXMLDatabaseType.Get_User: string;
begin
  Result := ChildNodes['user'].Text;
end;

procedure TXMLDatabaseType.Set_User(Value: string);
begin
  ChildNodes['user'].NodeValue := Value;
end;

function TXMLDatabaseType.Get_Password: UnicodeString;
begin
  Result := ChildNodes['password'].Text;
end;

procedure TXMLDatabaseType.Set_Password(Value: UnicodeString);
begin
  ChildNodes['password'].NodeValue := Value;
end;

{ TXMLSkinType }

function TXMLSkinType.Get_Aktif: string;
begin
  Result := ChildNodes['aktif'].Text;
end;

procedure TXMLSkinType.Set_Aktif(Value: string);
begin
  ChildNodes['aktif'].NodeValue := Value;
end;

function TXMLSkinType.Get_Template: string;
begin
  Result := ChildNodes['template'].Text;
end;

procedure TXMLSkinType.Set_Template(Value: string);
begin
  ChildNodes['template'].NodeValue := Value;
end;

end.
