unit Ukey_billno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UQRprint;

type
  TBill_Det = record
    comp_id: string;
    no: string;
    line: longint;
    goods_id: string; //mat_num
    goods_prc: double; //price
    goods_num: double; //qty
    amt: double;
    units: string;
    barcode: string;
    des: string;
    promo: string;
  end;

  TKeyBill = record
    Edtmat_num: string;
    Lblmat_num: string;
    Lblmat_des: string;
    Lblmat_price: string;
    EdtQty: string;
    Lblmat_unit: string;
    Lblamount: string;
  end;

  TFrmKeybillno = class(TForm)
    EdtKeybillno: TEdit;
    Label4: TLabel;
    BtnOk: TButton;
    BtnCancel: TButton;
    Label1: TLabel;
    Panel2: TPanel;
    Lblmat_des1: TLabel;
    Lblmat_des2: TLabel;
    Lblmat_des3: TLabel;
    Lblmat_des4: TLabel;
    Lblmat_des5: TLabel;
    Lblmat_des6: TLabel;
    Lblmat_des7: TLabel;
    Lblmat_des8: TLabel;
    Lblmat_des9: TLabel;
    Lblmat_des10: TLabel;
    Lblmat_price1: TLabel;
    Lblmat_price2: TLabel;
    Lblmat_price3: TLabel;
    Lblmat_price4: TLabel;
    Lblmat_price5: TLabel;
    Lblmat_price6: TLabel;
    Lblmat_price7: TLabel;
    Lblmat_price8: TLabel;
    Lblmat_price9: TLabel;
    Lblmat_price10: TLabel;
    Lblmat_unit1: TLabel;
    Lblmat_unit2: TLabel;
    Lblmat_unit3: TLabel;
    Lblmat_unit4: TLabel;
    Lblmat_unit5: TLabel;
    Lblmat_unit6: TLabel;
    Lblmat_unit7: TLabel;
    Lblmat_unit8: TLabel;
    Lblmat_unit9: TLabel;
    Lblmat_unit10: TLabel;
    Lblamount1: TLabel;
    Lblamount2: TLabel;
    Lblamount3: TLabel;
    Lblamount4: TLabel;
    Lblamount5: TLabel;
    Lblamount6: TLabel;
    Lblamount7: TLabel;
    Lblamount8: TLabel;
    Lblamount9: TLabel;
    Lblamount10: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label9: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Lblmat_num1: TLabel;
    Lblmat_num2: TLabel;
    Lblmat_num3: TLabel;
    Lblmat_num4: TLabel;
    Lblmat_num5: TLabel;
    Lblmat_num6: TLabel;
    Lblmat_num7: TLabel;
    Lblmat_num8: TLabel;
    Lblmat_num9: TLabel;
    Lblmat_num10: TLabel;
    Edtmat_num1: TEdit;
    Edtmat_num2: TEdit;
    Edtmat_num3: TEdit;
    Edtmat_num4: TEdit;
    Edtmat_num5: TEdit;
    Edtmat_num6: TEdit;
    Edtmat_num7: TEdit;
    Edtmat_num8: TEdit;
    Edtmat_num9: TEdit;
    Edtmat_num10: TEdit;
    EdtQty1: TEdit;
    EdtQty2: TEdit;
    EdtQty3: TEdit;
    EdtQty4: TEdit;
    EdtQty5: TEdit;
    EdtQty6: TEdit;
    EdtQty7: TEdit;
    EdtQty8: TEdit;
    EdtQty9: TEdit;
    EdtQty10: TEdit;
    EdtCust_ID: TEdit;
    Label6: TLabel;
    LabelCust_name: TLabel;
    Lbl_Bill_status: TLabel;
    PNo01: TLabel;
    PNo02: TLabel;
    PNo03: TLabel;
    PNo04: TLabel;
    PNo05: TLabel;
    PNo06: TLabel;
    PNo07: TLabel;
    PNo08: TLabel;
    PNo09: TLabel;
    PNo10: TLabel;
    Label65: TLabel;
    LblDiscount: TLabel;
    LblTot_amount: TLabel;
    LblDisValue: TLabel;
    Gtot_Amt: TLabel;
    LblVat: TLabel;
    LblNetprice: TLabel;
    procedure EdtKeybillnoKeyPress(Sender: TObject; var Key: Char);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdtKeybillnoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    {declar  array}
    billdet_arr: array[1..10] of TBill_Det;
    { Private declarations }
    bill_num: string;
    line_number: integer;
    discount : double;
    { Procedure declarations }

    procedure ClearData2;
    procedure ReadDataShow;
    procedure ShowData;
    procedure Caltotprice2;

  public

    { Public declarations }
  end;

var
  FrmKeybillno: TFrmKeybillno;

implementation

uses Udatamodule, UThai2, UPrint, Ubill;

{$R *.dfm}

procedure TFrmKeybillno.EdtKeybillnoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    BtnOk.SetFocus;
  end;
end;

procedure TFrmKeybillno.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmKeybillno.BtnOkClick(Sender: TObject);
var reps: word;
strsql: string;
begin

  if (FrmDatamodule.ADOQuery1.RecordCount > 0) and (FrmDatamodule.ADOQuery1.FieldValues['BILLH_STATUS'] = 'C') and (FrmBill.chkactive = 'cancel') then
  begin
    ShowMessage('บิลเลขที่ ' + Trim(EdtKeybillno.Text) + 'ได้ถูก Cancel ไปแล้ว');
    EdtKeybillno.SetFocus;
  end

  else //be
  begin
    if FrmBill.chkactive = 'cancel' then
    begin
      reps := MessageDlg('คุณต้องการ CANCEL บิลเลขที่ ''' + bill_num + ''' ใช่หรือไม่', mtConfirmation, [mbYes, mbNo], 0);
      if reps = mrYes then
      begin
        FrmBill.status_bill := 'C';
        FrmBill.status_print := '0';
             // bill_no := bill_num;
        FrmBill.process_data(bill_num);
      end
    end
    else
    begin
      reps := MessageDlg('คุณต้องการพิมพ์บิลเลขที่ ''' + bill_num + ''' ใช่หรือไม่', mtConfirmation, [mbYes, mbNo], 0);
      if reps = mrYes then
      begin

      with frmdatamodule.ADOQuery1 do
      begin
       close;
       sql.clear;
       strsql := 'SELECT * ' + #13#10 +
         '  FROM ( ( BILL_HEAD INNER JOIN BILL_DETAIL ON BILL_HEAD.BILLH_NO = BILL_DETAIL.BILLD_NO ' +
         '  AND  BILL_HEAD.BILLH_COMP_ID = BILL_DETAIL.BILLD_COMP_ID ) ' + #13#10 +
         '  INNER JOIN FINISH_GOODS ON BILL_DETAIL.BILLD_GOODS_ID = FINISH_GOODS.FG_ID ) ' + #13#10 +
         '  WHERE BILL_HEAD.BILLH_COMP_ID = ''' + FrmBill.comp_id + '''' +
         '    AND BILL_HEAD.BILLH_NO      = ''' + bill_num + '''';
       sql.Add(strsql);
       open;
     end;
       QRForm.QRExpr1.Expression   := FrmDataModule.ADOQuery1.FieldValues['BILLH_AMT'] -
                                      FrmDataModule.ADOQuery1.FieldValues['BILLH_AMT_VAT'];
       QRForm.HDVALUE.Expression   := ( FrmDataModule.ADOQuery1.FieldValues['BILLH_TOTAMT'] *
                                        FrmDataModule.ADOQuery1.FieldValues['BILLH_DISCOUNT'] ) /100;
       QRForm.Hchg.Expression      := FrmDataModule.ADOQuery1.FieldValues['BILLH_TOTPAY'] -
                                      FrmDataModule.ADOQuery1.FieldValues['BILLH_AMT'];

       if FrmDatamodule.ADOQuery1.RecordCount <> 0 then
       begin

 // B1 add print company address in billing header
         with frmdatamodule.ADOQuery0 do
          begin
           close;
           sql.clear;
           strsql := 'SELECT * FROM COMPANY WHERE COMP_ID = ''' + FrmBill.comp_id + ''' ';
           sql.Add(strsql);
           open;
         end;
         QRForm.QRLabel2.Caption := FrmDataModule.ADOQuery0.FieldValues['COMP_NAME'];
         QRForm.QRLabel3.Caption := FrmDataModule.ADOQuery0.FieldValues['COMP_ADD1'];
         QRForm.QRLabel4.Caption := FrmDataModule.ADOQuery0.FieldValues['COMP_ADD2'] + ' ' +
                                    FrmDataModule.ADOQuery0.FieldValues['COMP_POST'] + ' โทร. ' +
                                    FrmDataModule.ADOQuery0.FieldValues['COMP_ADD3'];
         QRForm.QRLabel5.Caption := 'Tax ID. ' + FrmDataModule.ADOQuery0.FieldValues['COMP_TAX'] +
                                    ' สาขา ' + FrmDataModule.ADOQuery0.FieldValues['COMP_BRANCH'];

// B1 end add

         QRForm.QuickRep1.Print;
         FrmBill.status_bill := 'A';
         FrmBill.status_print := '1';
         FrmBill.process_data(bill_num); //save data in table Bch status print =1
       end;
       end
(*
        if generate_print_bill(FrmBill.comp_id, bill_num, FrmBill.msg_err) = true then
        begin
          FrmBill.status_bill := 'A';
          FrmBill.status_print := '1';
                //  bill_no := bill_num;
          FrmBill.process_data(bill_num); //save data in table Bch status print =1
        end;
      end
*)
    end;

    ClearData2;
    EdtKeyBillno.Clear;
    EdtCust_ID.Clear;
    LabelCust_name.Caption := '';
    EdtKeybillno.SetFocus;
  end;
end;

procedure TFrmKeybillno.FormShow(Sender: TObject);
begin
  EdtKeybillno.Text := FrmDatamodule.Curr_bill_num;
  EdtKeybillno.SetFocus;
  Cleardata2;
end;

procedure TFrmKeybillno.ClearData2;
begin
  Edtmat_num1.Clear;
  Edtmat_num2.Clear;
  Edtmat_num3.Clear;
  Edtmat_num4.Clear;
  Edtmat_num5.Clear;
  Edtmat_num6.Clear;
  Edtmat_num7.Clear;
  Edtmat_num8.Clear;
  Edtmat_num9.Clear;
  Edtmat_num10.Clear;
  EdtQty1.Clear;
  EdtQty2.Clear;
  EdtQty3.Clear;
  EdtQty4.Clear;
  EdtQty5.Clear;
  EdtQty6.Clear;
  EdtQty7.Clear;
  EdtQty8.Clear;
  EdtQty9.Clear;
  EdtQty10.Clear;
  Lblmat_num1.Caption := '';
  Lblmat_num2.Caption := '';
  Lblmat_num3.Caption := '';
  Lblmat_num4.Caption := '';
  Lblmat_num5.Caption := '';
  Lblmat_num6.Caption := '';
  Lblmat_num7.Caption := '';
  Lblmat_num8.Caption := '';
  Lblmat_num9.Caption := '';
  Lblmat_num10.Caption := '';
  Lblmat_des1.Caption := '';
  Lblmat_des2.Caption := '';
  Lblmat_des3.Caption := '';
  Lblmat_des4.Caption := '';
  Lblmat_des5.Caption := '';
  Lblmat_des6.Caption := '';
  Lblmat_des7.Caption := '';
  Lblmat_des8.Caption := '';
  Lblmat_des9.Caption := '';
  Lblmat_des10.Caption := '';
  Lblmat_price1.Caption := '';
  Lblmat_price2.Caption := '';
  Lblmat_price3.Caption := '';
  Lblmat_price4.Caption := '';
  Lblmat_price5.Caption := '';
  Lblmat_price6.Caption := '';
  Lblmat_price7.Caption := '';
  Lblmat_price8.Caption := '';
  Lblmat_price9.Caption := '';
  Lblmat_price10.Caption := '';
  Lblmat_unit1.Caption := '';
  Lblmat_unit2.Caption := '';
  Lblmat_unit3.Caption := '';
  Lblmat_unit4.Caption := '';
  Lblmat_unit5.Caption := '';
  Lblmat_unit6.Caption := '';
  Lblmat_unit7.Caption := '';
  Lblmat_unit8.Caption := '';
  Lblmat_unit9.Caption := '';
  Lblmat_unit10.Caption := '';
  Lblamount1.Caption := '';
  Lblamount2.Caption := '';
  Lblamount3.Caption := '';
  Lblamount4.Caption := '';
  Lblamount5.Caption := '';
  Lblamount6.Caption := '';
  Lblamount7.Caption := '';
  Lblamount8.Caption := '';
  Lblamount9.Caption := '';
  Lblamount10.Caption := '';
  PNo01.Caption := '';
  PNo02.Caption := '';
  PNo03.Caption := '';
  PNo04.Caption := '';
  PNo05.Caption := '';
  PNo06.Caption := '';
  PNo07.Caption := '';
  PNo08.Caption := '';
  PNo09.Caption := '';
  PNo10.Caption := '';

  LblDisValue.Caption   := '0.00';
  LblDiscount.Caption   := '0.00';
  LblNetprice.Caption   := '0.00';
  LblVat.Caption        := '0.00';
  LblTot_amount.Caption := '0.00';
  Gtot_Amt.Caption      := '0.00';

end;

procedure TFrmKeybillno.ReadDataShow;
var i: integer;
  sqls_billdet: string;
  sqls_fg: string;
begin
  for i := 1 to line_number do
  begin
    sqls_billdet := 'Select * From BILL_DETAIL Where BILLD_COMP_ID = ''' + FrmBill.comp_id + ''' and BILLD_NO = ''' + bill_num + ''' and BILLD_LINE = ' + inttostr(i);
    with FrmDatamodule.ADOQuery3 do
    begin
      Close;
      SQL.Clear;
      SQL.Add(sqls_billdet);
      Open;
    end;

    if (FrmDatamodule.ADOQuery3.RecordCount > 0) then
    begin
      sqls_fg := 'Select * From FINISH_GOODS Where FG_ID = ''' + FrmDatamodule.ADOQuery3.FieldValues['BILLD_GOODS_ID'] + ''' ';
      with FrmDatamodule.ADOQuery2 do
      begin
        Close;
        SQL.Clear;
        SQL.Add(sqls_fg);
        Open;
      end;

      billdet_arr[i].comp_id   := FrmDatamodule.ADOQuery3.FieldValues['BILLD_COMP_ID'];
      billdet_arr[i].no        := FrmDatamodule.ADOQuery3.FieldValues['BILLD_NO'];
      billdet_arr[i].line      := FrmDatamodule.ADOQuery3.FieldValues['BILLD_LINE'];
      billdet_arr[i].goods_id  := FrmDatamodule.ADOQuery3.FieldValues['BILLD_GOODS_ID']; //mat_num
      billdet_arr[i].goods_prc := FrmDatamodule.ADOQuery3.FieldValues['BILLD_GOODS_PRC']; //price
      billdet_arr[i].goods_num := FrmDatamodule.ADOQuery3.FieldValues['BILLD_GOODS_NUM']; ; //qty
      billdet_arr[i].amt       := FrmDatamodule.ADOQuery3.FieldValues['BILLD_AMT']; //amount
      billdet_arr[i].promo     := FrmDatamodule.ADOQuery3.FieldValues['BILLD_PROMO'];

      if (FrmDatamodule.ADOQuery2.RecordCount > 0) then
      begin
        billdet_arr[i].units := FrmDatamodule.ADOQuery2.FieldValues['FG_UNITS'];
        billdet_arr[i].barcode := FrmDatamodule.ADOQuery2.FieldValues['FG_BAR_CODE'];
        billdet_arr[i].des := FrmDataModule.Ck_null(FrmDatamodule.ADOQuery2.FieldValues['FG_DES']);
      end;
    end;
  end;
end;

procedure TFrmKeybillno.ShowData;
begin
  Edtmat_num1.Text := billdet_arr[1].barcode;
  Edtmat_num2.Text := billdet_arr[2].barcode;
  Edtmat_num3.Text := billdet_arr[3].barcode;
  Edtmat_num4.Text := billdet_arr[4].barcode;
  Edtmat_num5.Text := billdet_arr[5].barcode;
  Edtmat_num6.Text := billdet_arr[6].barcode;
  Edtmat_num7.Text := billdet_arr[7].barcode;
  Edtmat_num8.Text := billdet_arr[8].barcode;
  Edtmat_num9.Text := billdet_arr[9].barcode;
  Edtmat_num10.Text := billdet_arr[10].barcode;

  if line_number >= 1 then
    EdtQty1.Text := formatcurr('#,##0.00', billdet_arr[1].goods_num);
  if line_number >= 2 then
    EdtQty2.Text := formatcurr('#,##0.00', billdet_arr[2].goods_num);
  if line_number >= 3 then
    EdtQty3.Text := formatcurr('#,##0.00', billdet_arr[3].goods_num);
  if line_number >= 4 then
    EdtQty4.Text := formatcurr('#,##0.00', billdet_arr[4].goods_num);
  if line_number >= 5 then
    EdtQty5.Text := formatcurr('#,##0.00', billdet_arr[5].goods_num);
  if line_number >= 6 then
    EdtQty6.Text := formatcurr('#,##0.00', billdet_arr[6].goods_num);
  if line_number >= 7 then
    EdtQty7.Text := formatcurr('#,##0.00', billdet_arr[7].goods_num);
  if line_number >= 8 then
    EdtQty8.Text := formatcurr('#,##0.00', billdet_arr[8].goods_num);
  if line_number >= 9 then
    EdtQty9.Text := formatcurr('#,##0.00', billdet_arr[9].goods_num);
  if line_number >= 10 then
    EdtQty10.Text := formatcurr('#,##0.00', billdet_arr[10].goods_num);

  if line_number >= 1 then
    Lblamount1.Caption := formatcurr('#,##0.00', billdet_arr[1].amt);
  if line_number >= 2 then
    Lblamount2.Caption := formatcurr('#,##0.00', billdet_arr[2].amt);
  if line_number >= 3 then
    Lblamount3.Caption := formatcurr('#,##0.00', billdet_arr[3].amt);
  if line_number >= 4 then
    Lblamount4.Caption := formatcurr('#,##0.00', billdet_arr[4].amt);
  if line_number >= 5 then
    Lblamount5.Caption := formatcurr('#,##0.00', billdet_arr[5].amt);
  if line_number >= 6 then
    Lblamount6.Caption := formatcurr('#,##0.00', billdet_arr[6].amt);
  if line_number >= 7 then
    Lblamount7.Caption := formatcurr('#,##0.00', billdet_arr[7].amt);
  if line_number >= 8 then
    Lblamount8.Caption := formatcurr('#,##0.00', billdet_arr[8].amt);
  if line_number >= 9 then
    Lblamount9.Caption := formatcurr('#,##0.00', billdet_arr[9].amt);
  if line_number >= 10 then
    Lblamount10.Caption := formatcurr('#,##0.00', billdet_arr[10].amt);

  Lblmat_des1.Caption := billdet_arr[1].des;
  Lblmat_des2.Caption := billdet_arr[2].des;
  Lblmat_des3.Caption := billdet_arr[3].des;
  Lblmat_des4.Caption := billdet_arr[4].des;
  Lblmat_des5.Caption := billdet_arr[5].des;
  Lblmat_des6.Caption := billdet_arr[6].des;
  Lblmat_des7.Caption := billdet_arr[7].des;
  Lblmat_des8.Caption := billdet_arr[8].des;
  Lblmat_des9.Caption := billdet_arr[9].des;
  Lblmat_des10.Caption := billdet_arr[10].des;

  Lblmat_num1.Caption := billdet_arr[1].goods_id;
  Lblmat_num2.Caption := billdet_arr[2].goods_id;
  Lblmat_num3.Caption := billdet_arr[3].goods_id;
  Lblmat_num4.Caption := billdet_arr[4].goods_id;
  Lblmat_num5.Caption := billdet_arr[5].goods_id;
  Lblmat_num6.Caption := billdet_arr[6].goods_id;
  Lblmat_num7.Caption := billdet_arr[7].goods_id;
  Lblmat_num8.Caption := billdet_arr[8].goods_id;
  Lblmat_num9.Caption := billdet_arr[9].goods_id;
  Lblmat_num10.Caption := billdet_arr[10].goods_id;

  if line_number >= 1 then
    Lblmat_price1.Caption := formatcurr('#,##0.00', billdet_arr[1].goods_prc);
  if line_number >= 2 then
    Lblmat_price2.Caption := formatcurr('#,##0.00', billdet_arr[2].goods_prc);
  if line_number >= 3 then
    Lblmat_price3.Caption := formatcurr('#,##0.00', billdet_arr[3].goods_prc);
  if line_number >= 4 then
    Lblmat_price4.Caption := formatcurr('#,##0.00', billdet_arr[4].goods_prc);
  if line_number >= 5 then
    Lblmat_price5.Caption := formatcurr('#,##0.00', billdet_arr[5].goods_prc);
  if line_number >= 6 then
    Lblmat_price6.Caption := formatcurr('#,##0.00', billdet_arr[6].goods_prc);
  if line_number >= 7 then
    Lblmat_price7.Caption := formatcurr('#,##0.00', billdet_arr[7].goods_prc);
  if line_number >= 8 then
    Lblmat_price8.Caption := formatcurr('#,##0.00', billdet_arr[8].goods_prc);
  if line_number >= 9 then
    Lblmat_price9.Caption := formatcurr('#,##0.00', billdet_arr[9].goods_prc);
  if line_number >= 10 then
    Lblmat_price10.Caption := formatcurr('#,##0.00', billdet_arr[10].goods_prc);

  Lblmat_unit1.Caption := billdet_arr[1].units;
  Lblmat_unit2.Caption := billdet_arr[2].units;
  Lblmat_unit3.Caption := billdet_arr[3].units;
  Lblmat_unit4.Caption := billdet_arr[4].units;
  Lblmat_unit5.Caption := billdet_arr[5].units;
  Lblmat_unit6.Caption := billdet_arr[6].units;
  Lblmat_unit7.Caption := billdet_arr[7].units;
  Lblmat_unit8.Caption := billdet_arr[8].units;
  Lblmat_unit9.Caption := billdet_arr[9].units;
  Lblmat_unit10.Caption := billdet_arr[10].units;

  PNo01.Caption := billdet_arr[1].promo;
  PNo02.Caption := billdet_arr[2].promo;
  PNo03.Caption := billdet_arr[3].promo;
  PNo04.Caption := billdet_arr[4].promo;
  PNo05.Caption := billdet_arr[5].promo;
  PNo06.Caption := billdet_arr[6].promo;
  PNo07.Caption := billdet_arr[7].promo;
  PNo08.Caption := billdet_arr[8].promo;
  PNo09.Caption := billdet_arr[9].promo;
  PNo10.Caption := billdet_arr[10].promo;

end;

procedure TFrmKeybillno.EdtKeybillnoExit(Sender: TObject);
var j: integer;
  sqls_h: string;
  sqls_cust: string;
begin
  if EdtKeyBillno.Text <> '' then
  begin
    sqls_h := 'Select * From BILL_HEAD Where BILLH_COMP_ID = ''' + FrmBill.comp_id + ''' and BILLH_NO = ''' + Trim(Edtkeybillno.Text) + ''' and BILLH_LOAD = ''0''';
    with FrmDatamodule.ADOQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add(sqls_h);
      Open;
    end;

    if (FrmDatamodule.ADOQuery1.RecordCount = 0) then
    begin
      Showmessage('ใส่เลขที่เอกสารไม่ถูกต้องกรุณาใส่ใหม่');
      EdtKeybillno.SetFocus;
      Lbl_Bill_status.Caption := 'เลขที่เอกสารไม่ถูกต้อง';
    end
    else
    begin
      bill_num        := Trim(EdtKeybillno.Text);
      line_number     := FrmDatamodule.ADOQuery1.FieldValues['BILLH_NUM'];
      EdtCust_ID.Text := FrmDatamodule.ADOQuery1.FieldValues['BILLH_CUST_ID'];
      if VarIsnull(FrmDataModule.ADOQuery1.FieldValues['BILLH_DISCOUNT']) then
         Discount        := 0
      else
         Discount        := FrmDataModule.ADOQuery1.FieldValues['BILLH_DISCOUNT'];
      if FrmDatamodule.ADOQuery1.FieldValues['BILLH_STATUS'] = 'C' then
        Lbl_Bill_status.Caption := 'เอกสารนี้ถูก Cancle แล้ว'
      else if FrmDatamodule.ADOQuery1.FieldValues['BILLH_STATUS'] = 'A' then
        Lbl_Bill_status.Caption := ''
      else Lbl_Bill_status.Caption := 'เอกสารมีข้อผิดพลาด';


      sqls_cust := 'Select * From CUSTOMER Where CUST_ID = ''' + FrmDatamodule.ADOQuery1.FieldValues['BILLH_CUST_ID'] + ''' ';
      with FrmDatamodule.ADOQuery4 do
      begin
        Close;
        SQL.Clear;
        SQL.Add(sqls_cust);
        Open;
      end;

      if (FrmDatamodule.ADOQuery4.RecordCount > 0) then
        LabelCust_name.Caption := FrmDatamodule.ADOQuery4.FieldValues['CUST_NAME'];

      for j := 1 to 10 do
      begin
        billdet_arr[j].comp_id := '';
        billdet_arr[j].no := '';
        billdet_arr[j].line := 0;
        billdet_arr[j].goods_id := '';
        billdet_arr[j].goods_prc := 0;
        billdet_arr[j].goods_num := 0;
        billdet_arr[j].amt := 0;
        billdet_arr[j].units := '';
        billdet_arr[j].barcode := '';
        billdet_arr[j].des := '';
        billdet_arr[j].promo  :=  '';
      end;
      Cleardata2;
      ReadDataShow;
      ShowData;
      Caltotprice2;
    end;
  end
  else
  begin
    EdtCust_ID.Clear;
    LabelCust_name.Caption := '';
    ClearData2;
  end;
end;

procedure TFrmKeyBillno.Caltotprice2;
var netprice, vat, tot_amount, DValue, GAmount: double;
begin
  tot_amount := 0;
  if (Trim(Lblamount1.Caption) <> '') then
    tot_amount := tot_amount + strtofloat(Rem_comma(Lblamount1.Caption));
  if (Trim(Lblamount2.Caption) <> '') then
    tot_amount := tot_amount + strtofloat(Rem_comma(Lblamount2.Caption));
  if (Trim(Lblamount3.Caption) <> '') then
    tot_amount := tot_amount + strtofloat(Rem_comma(Lblamount3.Caption));
  if (Trim(Lblamount4.Caption) <> '') then
    tot_amount := tot_amount + strtofloat(Rem_comma(Lblamount4.Caption));
  if (Trim(Lblamount5.Caption) <> '') then
    tot_amount := tot_amount + strtofloat(Rem_comma(Lblamount5.Caption));
  if (Trim(Lblamount6.Caption) <> '') then
    tot_amount := tot_amount + strtofloat(Rem_comma(Lblamount6.Caption));
  if (Trim(Lblamount7.Caption) <> '') then
    tot_amount := tot_amount + strtofloat(Rem_comma(Lblamount7.Caption));
  if (Trim(Lblamount8.Caption) <> '') then
    tot_amount := tot_amount + strtofloat(Rem_comma(Lblamount8.Caption));
  if (Trim(Lblamount9.Caption) <> '') then
    tot_amount := tot_amount + strtofloat(Rem_comma(Lblamount9.Caption));
  if (Trim(Lblamount10.Caption) <> '') then
    tot_amount := tot_amount + strtofloat(Rem_comma(Lblamount10.Caption));

  if Discount > 0 then
     begin
        DValue   := ( tot_amount * Discount ) / 100;
        GAmount  := tot_amount - DValue;
     end
  else
     begin
        DValue   := 0;
        GAmount  := tot_amount;
     end;
  vat      := GAmount  * (7 / 107);
  netprice := GAmount - vat;

  LblDiscount.caption   := formatfloat('#,##0.00', Discount);
  LblTot_amount.Caption := formatfloat('#,##0.00', tot_amount);
  LblDisValue.Caption   := formatfloat('#,##0.00', DValue);
  Gtot_Amt.Caption      := formatfloat('#,##0.00', GAmount);
  LblNetprice.Caption   := formatfloat('#,##0.00', netprice);
  LblVat.Caption        := formatfloat('#,##0.00', vat);

end;

procedure TFrmKeybillno.FormCreate(Sender: TObject);
begin
  Lbl_Bill_status.Caption := '';
end;

end.
