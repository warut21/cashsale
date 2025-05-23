program Cleardata;

uses
  Forms,
  Udatamodule in 'Udatamodule.pas' {FrmDataModule: TDataModule},
  Uconfig in 'Uconfig.pas' {FrmConfig},
  Upassconfig in 'Upassconfig.pas' {FrmPassconfig},
  UThai2 in 'UThai2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmDataModule, FrmDataModule);
  Application.CreateForm(TFrmConfig, FrmConfig);
  Application.Run;
end.
