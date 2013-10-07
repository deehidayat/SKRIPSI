unit splashscreen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, pngimage, jpeg, sLabel;

type
  TFrmSplashScreen = class(TForm)
    Timer1: TTimer;
    Image1: TImage;
    LblMessage: TsLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure DoCreate(); override;
  public
    { Public declarations }
  end;

var
  FrmSplashScreen: TFrmSplashScreen;

implementation

uses SESSION;
{$R *.dfm}

procedure TFrmSplashScreen.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
end;

procedure TFrmSplashScreen.FormCreate(Sender: TObject);
begin
  TransparentColor := True;
  TransparentColorValue := Color;
  self.Position := poScreenCenter;
end;

procedure TFrmSplashScreen.DoCreate;
begin
  if FileExists(SPLASH_IMG) then
    Image1.Picture.LoadFromFile(SPLASH_IMG);
  inherited;
end;

end.
