unit configag;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, sCheckBox, sGroupBox, Buttons, sBitBtn, ExtCtrls, sPanel,
  ComCtrls, sUpDown, sLabel, sEdit, sTrackBar;

type
  TFrmConfigAG = class(TForm)
    sGroupBox1: TsGroupBox;
    sGroupBox2: TsGroupBox;
    aturan1: TsCheckBox;
    aturan2: TsCheckBox;
    aturan3: TsCheckBox;
    aturan4: TsCheckBox;
    laporan1: TsCheckBox;
    laporan2: TsCheckBox;
    laporan3: TsCheckBox;
    laporan4: TsCheckBox;
    aturan5: TsCheckBox;
    aturan10: TsCheckBox;
    aturan9: TsCheckBox;
    aturan8: TsCheckBox;
    aturan7: TsCheckBox;
    aturan6: TsCheckBox;
    sBitBtn1: TsBitBtn;
    sGroupBox3: TsGroupBox;
    EdTgFitness: TsEdit;
    sLabel3: TsLabel;
    EdMaxIterasi: TsEdit;
    sLabel4: TsLabel;
    Panel1: TPanel;
    sLabel1: TsLabel;
    EdPbCross: TsEdit;
    sUpDown1: TsUpDown;
    sLabel2: TsLabel;
    EdPbMutasi: TsEdit;
    sUpDown2: TsUpDown;
    procedure aturan1Click(Sender: TObject);
    procedure aturan2Click(Sender: TObject);
    procedure aturan3Click(Sender: TObject);
    procedure aturan4Click(Sender: TObject);
    procedure aturan5Click(Sender: TObject);
    procedure aturan6Click(Sender: TObject);
    procedure aturan7Click(Sender: TObject);
    procedure aturan8Click(Sender: TObject);
    procedure aturan9Click(Sender: TObject);
    procedure aturan10Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure laporan1Click(Sender: TObject);
    procedure laporan2Click(Sender: TObject);
    procedure laporan3Click(Sender: TObject);
    procedure laporan4Click(Sender: TObject);
    procedure EdTgFitnessChange(Sender: TObject);
    procedure EdPbCrossChange(Sender: TObject);
    procedure EdPbMutasiChange(Sender: TObject);
  private
    { Private declarations }
    procedure ConfigAturan(Idx: Integer; Status: Boolean);
    procedure ConfigLaporan(Idx: Integer; Status: Boolean);
  public
    { Public declarations }
  end;

var
  FrmConfigAG: TFrmConfigAG;

implementation

uses SESSION;
{$R *.dfm}

procedure TFrmConfigAG.aturan10Click(Sender: TObject);
begin
  ConfigAturan(10, (Sender as TsCheckBox).Checked);
end;

procedure TFrmConfigAG.aturan1Click(Sender: TObject);
begin
  ConfigAturan(1, (Sender as TsCheckBox).Checked);
end;

procedure TFrmConfigAG.aturan2Click(Sender: TObject);
begin
  ConfigAturan(2, (Sender as TsCheckBox).Checked);
end;

procedure TFrmConfigAG.aturan3Click(Sender: TObject);
begin
  ConfigAturan(3, (Sender as TsCheckBox).Checked);
end;

procedure TFrmConfigAG.aturan4Click(Sender: TObject);
begin
  ConfigAturan(4, (Sender as TsCheckBox).Checked);
end;

procedure TFrmConfigAG.aturan5Click(Sender: TObject);
begin
  ConfigAturan(5, (Sender as TsCheckBox).Checked);
end;

procedure TFrmConfigAG.aturan6Click(Sender: TObject);
begin
  ConfigAturan(6, (Sender as TsCheckBox).Checked);
end;

procedure TFrmConfigAG.aturan7Click(Sender: TObject);
begin
  ConfigAturan(7, (Sender as TsCheckBox).Checked);
end;

procedure TFrmConfigAG.aturan8Click(Sender: TObject);
begin
  ConfigAturan(8, (Sender as TsCheckBox).Checked);
end;

procedure TFrmConfigAG.aturan9Click(Sender: TObject);
begin
  ConfigAturan(9, (Sender as TsCheckBox).Checked);
end;

procedure TFrmConfigAG.ConfigAturan(Idx: Integer; Status: Boolean);
begin
  if not(Status) then
    Exclude(ENABLEDATURAN, Idx)
  else
    Include(ENABLEDATURAN, Idx);
end;

procedure TFrmConfigAG.ConfigLaporan(Idx: Integer; Status: Boolean);
begin
  if not(Status) then
    Exclude(ENABLEDLAPORAN, Idx)
  else
    Include(ENABLEDLAPORAN, Idx);
end;

procedure TFrmConfigAG.EdPbCrossChange(Sender: TObject);
begin
  if EdPbCross.Text <> '' then
    PB_CROSS := StrToInt(EdPbCross.Text);
end;

procedure TFrmConfigAG.EdPbMutasiChange(Sender: TObject);
begin
  if EdPbMutasi.Text <> '' then
    PB_MUTASI := StrToInt(EdPbMutasi.Text);
end;

procedure TFrmConfigAG.EdTgFitnessChange(Sender: TObject);
begin
  if EdTgFitness.Text <> '' then
    TGT_FITNESS := StrToInt(EdTgFitness.Text);
end;

procedure TFrmConfigAG.FormCreate(Sender: TObject);
var
  I: Integer;
  Comp: TObject;
begin
  for I := 1 to 10 do
  begin
    Comp := FindComponent('aturan' + inttostr(I));
    if I In ENABLEDATURAN then (Comp as TsCheckBox)
      .Checked := True;
  end;
  for I := 1 to 4 do
  begin
    Comp := FindComponent('laporan' + inttostr(I));
    if I In ENABLEDLAPORAN then (Comp as TsCheckBox)
      .Checked := True;
  end;

  EdMaxIterasi.Text := inttostr(MAX_ITERASI);
  EdTgFitness.Text := inttostr(TGT_FITNESS);
  //EdPbCross.Text := FloatToStr(PB_CROSS);
  //EdPbMutasi.Text := FloatToStr(PB_MUTASI);
  sUpDown1.Position := PB_CROSS;
  sUpDown2.Position := PB_MUTASI;

  Panel1.Visible := DEBUG_MODE;

end;

procedure TFrmConfigAG.laporan1Click(Sender: TObject);
begin
  ConfigLaporan(1, (Sender as TsCheckBox).Checked);
end;

procedure TFrmConfigAG.laporan2Click(Sender: TObject);
begin
  ConfigLaporan(2, (Sender as TsCheckBox).Checked);
end;

procedure TFrmConfigAG.laporan3Click(Sender: TObject);
begin
  ConfigLaporan(3, (Sender as TsCheckBox).Checked);
end;

procedure TFrmConfigAG.laporan4Click(Sender: TObject);
begin
  ConfigLaporan(4, (Sender as TsCheckBox).Checked);
end;

end.
