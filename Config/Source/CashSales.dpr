program CashSales;

uses
  Forms,
  Udatamodule in 'Udatamodule.pas' {FrmDataModule: TDataModule},
  Ulogon in 'Ulogon.pas' {FrmLogon},
  Ubill in 'Ubill.pas' {FrmBill},
  UThai2 in 'UThai2.pas',
  UPrint in 'UPrint.pas',
  Ukey_billno in 'Ukey_billno.pas' {FrmKeybillno},
  Ureport4 in 'Ureport4.pas' {FrmReport4},
  Ureport2 in 'Ureport2.pas' {FrmReport2},
  Ureport3 in 'Ureport3.pas' {FrmReport3},
  Ureport1 in 'Ureport1.pas' {FrmReport1},
  PickDate in 'PickDate.pas' {BrDateForm},
  Uendday in 'Uendday.pas' {FrmEndday},
  Uload in 'Uload.pas',
  Uposload in 'Uposload.pas' {FrmLoadtxt},
  Ucompany in 'Ucompany.pas' {FrmCompany},
  Ucust in 'Ucust.pas' {FrmCust},
  Ufg in 'Ufg.pas' {FrmFG},
  Usalesman in 'Usalesman.pas' {FrmSalesman},
  Uunit in 'Uunit.pas' {FrmUnit},
  Ugrp in 'Ugrp.pas' {FrmPrdGrp};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmDataModule, FrmDataModule);
  Application.CreateForm(TFrmBill, FrmBill);
  Application.CreateForm(TFrmCompany, FrmCompany);
  Application.CreateForm(TFrmCust, FrmCust);
  Application.CreateForm(TFrmFG, FrmFG);
  Application.CreateForm(TFrmSalesman, FrmSalesman);
  Application.CreateForm(TFrmUnit, FrmUnit);
  Application.CreateForm(TFrmPrdGrp, FrmPrdGrp);
  Application.Run;
end.  
