unit UQRprint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, QRCtrls, ExtCtrls;

type
  TQRForm = class(TForm)
    QuickRep1: TQuickRep;
    PageHeaderBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    DMAT: TQRDBText;
    DQTY: TQRDBText;
    DPRICE: TQRDBText;
    DAMT: TQRDBText;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    HVAT: TQRDBText;
    QRLabel6: TQRLabel;
    HDATE: TQRDBText;
    HTIME: TQRSysData;
    QRLabel7: TQRLabel;
    BILL_NO: TQRDBText;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRExpr1: TQRExpr;
    QRLabel4: TQRLabel;
    QRDBText1: TQRDBText;
    HpayLabel: TQRLabel;
    QRLabel19: TQRLabel;
    Hchg: TQRExpr;
    QRLabel18: TQRLabel;
    QRLabel20: TQRLabel;
    HGAMT: TQRDBText;
    HDISC: TQRDBText;
    HDVALUE: TQRExpr;
    HAMT: TQRDBText;
    HPAY: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel21: TQRLabel;

    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
 QRForm: TQRForm;

implementation
uses Udatamodule;
{$R *.dfm}

procedure TQRForm.FormActivate(Sender: TObject);

begin
(*
  with frmdatamodule.ADOQuery1 do
  begin
    close;
    sql.clear;
    strsql := 'SELECT * ' + #13#10 +
      '  FROM BILL_HEAD INNER JOIN BILL_DETAIL ON BILL_HEAD.BILLH_NO = BILL_DETAIL.BILLD_NO ' +
      '  AND  BILL_HEAD.BILLH_COMP_ID = BILL_DETAIL.BILLD_COMP_ID ' + #13#10 +
      '  WHERE BILL_HEAD.BILLH_COMP_ID = ''' + comcode + '''' +
      '    AND BILL_HEAD.BILLH_NO      = ''' + billno + '''';
    sql.Add(strsql);
    open;
  end;
*)
  with frmdatamodule.ADOQuery1 do
  begin
//    repeat

      BILL_NO.DataSet    := FrmDataModule.ADOQuery1;
      BILL_NO.DataField  := FrmDataModule.ADOQuery1.FieldValues['BILLH_NO'];

      DMAT.DataSet    := FrmDataModule.ADOQuery1;
      DMAT.DataField  := FrmDataModule.ADOQuery1.FieldValues['BILLD_GOODS_ID'];

      DQTY.DataSet         := FrmDataModule.ADOQuery1;
      DQTY.DataField       := FrmDataModule.ADOQuery1.fieldvalues['BILLD_GOODS_NUM'];
      DPRICE.DataSet       := FrmDataModule.ADOQuery1;
      DPRICE.DataField     := FrmDataModule.ADOQuery1.FieldValues['BILLD_GOODS_PRC'];
      DAMT.DataSet         := FrmDataModule.ADOQuery1;
      DAMT.DataField       := FrmDataModule.ADOQuery1.FieldValues['BILLD_AMT'];

      HAMT.DataSet         := FrmDataModule.ADOQuery1;
      HAMT.DataField       := FrmDataModule.ADOQuery1.FieldValues['BILLH_AMT'];
      HVAT.DataSet         := FrmDataModule.ADOQuery1;
      HVAT.DataField       := FrmDataModule.ADOQuery1.FieldValues['BILLH_AMT_VAT'];

//      QRExpr1.Expression   := FrmDataModule.ADOQuery1.FieldValues['BILLH_AMT'] -
//                              FrmDataModule.ADOQuery1.FieldValues['BILLH_AMT_VAT'];

//    next;
//    until eof;



  end;

end;

end.

