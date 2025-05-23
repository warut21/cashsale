program Configuration;

uses
  Forms,
  Udatamodule in 'Udatamodule.pas' {FrmDataModule: TDataModule},
  Uconfig in 'Uconfig.pas' {FrmConfig},
  Upassconfig in 'Upassconfig.pas' {FrmPassconfig},
  PickDate in 'PickDate.pas' {BrDateForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmDataModule, FrmDataModule);
  Application.CreateForm(TFrmConfig, FrmConfig);
  Application.CreateForm(TBrDateForm, BrDateForm);
  Application.Run;
end.
