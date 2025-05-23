{**********************************************}
{     Author : Ms.Nattaporn Sittichartburana.  }
{     Created date : August 31, 2004.          }
{     Modified date :                          }
{     Modifier :                               }
{**********************************************}
unit Ubill;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,UThai2,
  Dialogs, StdCtrls, ExtCtrls, Menus, ActnList, XPStyleActnCtrls, ActnMan,
  Mask, StdStyleActnCtrls, QuickRpt, QRCtrls;
  

type
  TBillLine = record
    Edtmat_num: string;
    Lblmat_num: string;
    Lblmat_des: string;
    Lblmat_price: string;
    EdtQty: string;
    Lblmat_unit: string;
    Lblamount: string;
    Promo: string;
  end;

  TBill_SQL = record
    sql_billdet: string;
  end;

  TBill_Detail = record
    comp_id: string;
    no: string;
    line: longint;
    goods_id: string; //mat_num
    goods_prc: double; //price
    goods_num: double; //qty
    amt: double;
    amt_vat: double;
    status: string;
    load: string;
    promo: string;
  end;

  TFrmBill = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N5: TMenuItem;
    N3: TMenuItem;
    N2: TMenuItem;
    N4: TMenuItem;
    N6: TMenuItem;
    N16: TMenuItem;
    INVOICE1: TMenuItem;
    N17: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    ActionManager1: TActionManager;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    LabelComp_name: TLabel;
    Label2: TLabel;
    LabelDate: TLabel;
    Label4: TLabel;
    LabelBill_No: TLabel;
    Label6: TLabel;
    LabelCust_name: TLabel;
    EdtCust_ID: TEdit;
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
    Label59: TLabel;
    Label65: TLabel;
    LblNetprice: TLabel;
    LblVat: TLabel;
    LblTot_amount: TLabel;
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
    BtnSave: TButton;
    BtnPrint: TButton;
    BtnClear: TButton;
    BtnExit: TButton;
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
    Panel3: TPanel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Labelpc_id: TLabel;
    Labelsales_id: TLabel;
    LabelSales_name: TLabel;
    LabelSum: TLabel;
    LabelAcc: TLabel;
    MemoPrint: TMemo;
    EdtComp_id: TEdit;
    N15: TMenuItem;
    Total_pay: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Chg_amt: TLabel;
    N18: TMenuItem;
    Action7: TAction;
    Label5: TLabel;
    Action8: TAction;
    PNO01: TLabel;
    PNO02: TLabel;
    PNO03: TLabel;
    PNO04: TLabel;
    PNO05: TLabel;
    PNO06: TLabel;
    PNO07: TLabel;
    PNO08: TLabel;
    PNO09: TLabel;
    PNO10: TLabel;
    Action9: TAction;
    LblDisValue: TLabel;
    LblDiscount: TLabel;
    Gtot_Amt: TLabel;
    procedure Action1Execute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure BtnClearClick(Sender: TObject);
    procedure Edtmat_num1Exit(Sender: TObject);
    procedure EdtCust_IDExit(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure INVOICE1Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EdtQty1Exit(Sender: TObject);
    procedure Edtmat_num2Exit(Sender: TObject);
    procedure Edtmat_num3Exit(Sender: TObject);
    procedure Edtmat_num4Exit(Sender: TObject);
    procedure Edtmat_num5Exit(Sender: TObject);
    procedure Edtmat_num6Exit(Sender: TObject);
    procedure Edtmat_num7Exit(Sender: TObject);
    procedure Edtmat_num8Exit(Sender: TObject);
    procedure Edtmat_num9Exit(Sender: TObject);
    procedure Edtmat_num10Exit(Sender: TObject);
    procedure Edtmat_num1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Total_payExit(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure Action9Execute(Sender: TObject);
    procedure Caltotprice;

  private
    main_status : string;
    { Private declarations }
    mat_num, mat_des, mat_unit, mat_barcode, mat_grp: string;
    mat_price: double;
    price, qty: string;
    sales_id: string;
    bill_date: Tdatetime;
    netprice, vat, tot_amount, DValue, GAmount: double;
    amount: double;
    chkgrp: string;
    {declar  array}
    line_arr: array[1..10] of TBillLine;
    sql_arr: array[1..10] of TBill_SQL;
    billdetail_arr: array[1..10] of TBill_Detail;
    sql_tbillh, sql_tcontrol: string;
    have_sql_tbillh, have_sql_tbilldet, have_sql_tcontrol, have_sql_tcontrol_c: integer;
    {procedure declaration}
    bill_no: string;

    procedure ShowDatamat(var mat_num, FG_DES, FG_UNITS, FG_SHORT, PFG_BAR_CODE, FG_GRP: string; var FG_PRICE: double);
    procedure BtnSetEnable(n: integer);
    procedure CalAmount(price, qty: string; var amount: double);
    procedure Read_Control; // read table control for display data
    procedure moverecord(i, j: integer);
    procedure chkarr_data;
    procedure edttoarr;
    procedure arrtoedt;
    procedure arrtobilldet;
    procedure count_rec;
    procedure fillcharmat; //ยกเลิก
    function have_mat2(PMat : string;var Pmat_num,PMat_barcode:string):boolean;
    function have_mat3(PMat : string;var Pmat_num,PMat_short:string):boolean;
    function fillcharmat2(PMat : string):string;
    Procedure Set_line2(line:integer; P_Qty,P_mat_num,P_mat_des,P_mat_unit,P_mat_price:string);
    Procedure Edit_num_Change2(line:integer; var Edt_num_X :Tedit);
    function passedit_QTY2:boolean;
    Procedure InsertBillPromo;

//    procedure totrec_same(b : TEdit; qty , amount : double));
  public
    { Public declarations }
    chkactive: string;
    comp_id: string;
    bill_load: string;
    msg_err: string;
    PromoStatus : String;
    PromoMatPrc : double;
    {procedure declaration}
    status_bill, status_print: string;
    CHK_LINE, CUR_LINE: integer;
    procedure SetEnable; //set ennable of edit&label
    procedure Cleardata; //Clear data in edit&label
    procedure endday;
    procedure process_data(PBill_no: string);
    procedure process_billhead(PBill_no: string);
    procedure process_billdet(PBill_no: string);
    procedure process_control(Currnet_Bill_no: string;update_bill_no:boolean);
    procedure chkvalue_arrtolbl(a: TLabel; arr_value: string);
    procedure chkvalue_arrtoedt(b: TEdit; arr_qty: string);
    function passchkformatQty(a, b: TEdit; c, d: TLabel; line: integer):boolean;
    Procedure CheckLine;
    Procedure setenabled;

  end;

var
  FrmBill: TFrmBill;
  line_num: integer;

implementation

uses Udatamodule, Uconfig, Ulogon,  UPrint, Ukey_billno, Ureport1,
  Ureport2, Ureport3, Ureport4, Uendday, Uunit, Ufg, Ucompany, Ugrp,
  Usalesman, Ucust, PickDate, Uposload, UQRprint, Upromo, Upromo_bill,
  Udiscount;

{$R *.dfm}



procedure TFrmBill.Action1Execute(Sender: TObject);
var reps: word;
begin
  if line_num > 0 then
  begin
    reps := MessageDlg('คุณต้องการบันทึก หรือพิมพ์บิลก่อนออกจากรายการนี้ใช่หรือไม่', mtConfirmation, [mbYes, mbNo], 0);
    if reps = mrNo then
    begin
      setenabled;
      FrmDiscount.Free;
      FrmDiscount  := TFrmDiscount.Create(Application);
      FrmPROMOBILL.Free;
      FrmPROMOBILL := TFrmPROMOBILL.create(Application);
      Cleardata;
      SetEnable; //set ennable of edit&label
      Panel1.Visible := false;
    end;
  end
  else
  begin
    reps := MessageDlg('คุณต้องการออกจากรายการนี้ใช่หรือไม่', mtConfirmation, [mbYes, mbNo], 0);
    if reps = mrYes then
    begin
      setenabled;
      FrmDiscount.Free;
      FrmDiscount  := TFrmDiscount.Create(Application);
      FrmPROMOBILL.Free;
      FrmPROMOBILL := TFrmPROMOBILL.create(Application);
      Cleardata;
      SetEnable; //set ennable of edit&label
      Panel1.Visible := false;
    end;
  end;

end;

procedure TFrmBill.Read_Control; // read table control for display data
var sqls: string; bill_id: integer;
  today_amt: currency;
  Accu_amt_amt: currency;
  Curr_id: string;

begin
  sqls := 'Select * From CONTROL Where COMP_ID = ''' + Trim(EdtComp_id.Text) + ''' ';
  with FrmDatamodule.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sqls);
    Open;
  end;
  if not FrmDatamodule.ADOQuery1.Eof then
  begin
    Labelpc_id.Caption := FrmDatamodule.ADOQuery1.FieldValues['PC_ID'];
    today_amt := FrmDatamodule.ADOQuery1.FieldValues['TODAY_AMT'];
    Accu_amt_amt := FrmDatamodule.ADOQuery1.FieldValues['ACCU_AMT'];

    LabelSum.Caption := formatfloat('#,##0.00', today_amt);
    LabelAcc.Caption := formatfloat('#,##0.00', Accu_amt_amt);
    Curr_id := FrmDatamodule.ADOQuery1.FieldValues['CUR_BILL_NO'];
    bill_id := strtoint(Copy(FrmDatamodule.ADOQuery1.FieldValues['CUR_BILL_NO'], 4, 5));
    bill_id := bill_id + 1;
    LabelBill_No.Caption := Copy(Curr_id, 1, 3) + ThaiRight('00000' + inttostr(bill_id), 5);
    FrmDatamodule.Curr_bill_num := Curr_id;

  end;
end;

procedure TFrmBill.FormShow(Sender: TObject);
var sqls, day, day1: string;
begin
  chkactive := '';
  if FrmLogon.pass = false then FrmBill.Close
  else
  begin //start
    bill_load := '0';
    comp_id := Trim(frmlogon.EdtComp_id.Text);
    sqls := 'SELECT * FROM PROGRAMER';
    with FrmDatamodule.ADOQuery0 do
    begin
      Close;
      SQL.Clear;
      SQL.Add(sqls);
      Open;
      day := fieldvalues['date'];
      day1 := fieldvalues['create_date'];
    end;
    if day <> day1 then bill_date := StrToDate(FrmLogon.DateSales.Text)
    else
      bill_date := StrToDate(FrmLogon.DateSales.Text);


    sales_id := Trim(FrmLogon.EdtSales_id.Text);

    LabelDate.Caption := FrmLogon.DateSales.Text;
    LabelComp_name.Caption := FrmLogon.LabelComp_name.Caption;
    LabelSales_id.Caption := sales_id;

    sqls := 'Select SALES_NAME From SALESMAN Where COMP_ID = ''' + Trim(frmlogon.EdtComp_id.Text) + ''' ' +
      'And SALES_ID = ''' + TRIM(frmlogon.EdtSales_id.Text) + ''' ';
    with FrmDatamodule.ADOQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add(sqls);
      Open;
    end;

    LabelSales_name.Caption := FrmDatamodule.ADOQuery1.FieldValues['SALES_NAME'];
    EdtCust_ID.Text := '0000';
    LabelCust_name.Caption := 'เงินสด';
    Edtmat_num1.SetFocus;
    Cleardata; //Clear data in edit&label  //set line_num = 0
    SetEnable; //set ennable of edit&label
    EdtComp_id.Text := frmlogon.EdtComp_id.Text;
    Read_Control; // read table control for display data
    Panel1.Visible := false;
    FrmLogon.Free;
  end; //stop
end;

procedure TFrmBill.SetEnable;
begin
  EdtCust_ID.Enabled := true;
  BtnSave.Enabled := false;
  BtnPrint.Enabled := false;

end;

procedure TfrmBill.ShowDatamat(var mat_num, FG_DES, FG_UNITS, FG_SHORT, PFG_BAR_CODE, FG_GRP: string; var FG_PRICE: double);
var sqls: string;
begin
  sqls := 'Select * From FINISH_GOODS Where FG_ID = ''' + mat_num + ''' OR FG_BAR_CODE = ''' + PFG_BAR_CODE + ''' OR FG_SHORT = ''' + FG_SHORT + '''';
  with FrmDatamodule.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sqls);
    Open;
  end;
  if FrmDatamodule.ADOQuery1.RecordCount > 0 then
  begin
    FG_DES := FrmDataModule.Ck_null(FrmDatamodule.ADOQuery1.FieldValues['FG_DES']);
    FG_UNITS := FrmDatamodule.ADOQuery1.FieldValues['FG_UNITS'];
    if PromoStatus = 'N'  then
       FG_PRICE := FrmDatamodule.ADOQuery1.FieldValues['FG_PRICE']
    else
       FG_PRICE := PromoMatPrc;
    FG_SHORT := FrmDataModule.Ck_null(FrmDatamodule.ADOQuery1.FieldValues['FG_SHORT']);
    PFG_BAR_CODE := FrmDatamodule.ADOQuery1.FieldValues['FG_BAR_CODE'];
    FG_GRP := FrmDatamodule.ADOQuery1.FieldValues['FG_GRP'];
    mat_num := FrmDatamodule.ADOQuery1.FieldValues['FG_ID'];
  end
  else
    Showmessage('รหัสไม่ถูกต้องกรุณาใส่อีกครั้ง');
end;

procedure TFrmBill.N15Click(Sender: TObject);
var
  sqls: string;
  d1, d2, d3: TDateTime;
  S_D1, S_D2, S_D3: string;
  chked: integer;
  reps: word;
begin
  Read_Control;
  chked := 0;
  sqls := 'SELECT * FROM CONTROL Where COMP_ID =''' + EdtComp_id.Text + '''';
  with FrmDatamodule.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sqls);
    Open;
    d1 := fieldvalues['SALESDATE']; // แก้ ยังไม่ได้กำหนดเลขที่ bill
    d2 := fieldvalues['TRANSFERDATE'];
  end;
{    d1:=StrToDate(day);
    d2:=StrToDate(day1);}
  d3 := bill_date;

  S_D1 := FormatDatetime('DD/MM/YYYY', d1);
  S_D2 := FormatDatetime('DD/MM/YYYY', d2);
  S_D3 := FormatDatetime('DD/MM/YYYY', d3);

  if (d1 <> d2) and (d3 <> d1) then chked := 1; //ยังไม่ได้ยกยอด
  if (d1 = d2) and (d3 <= d2) then chked := 2; //ยกยอดไปแล้วทำการขายในวันนั้นไม่ได้
  case chked of
    0: begin
        Panel1.Visible := true;
        FrmPROMOBILL := TFrmPROMOBILL.create(Application);
        FrmDiscount  := TFrmDiscount.Create(Application);
        PromoMatPrc  := 0;
        PromoStatus := 'N';
        Edtmat_num1.SetFocus;
      end;
    1: begin
        reps := MessageDlg('!!!! ไม่สามารทำรายการขายได้เนื่องจากยังไม่ได้ทำการยกยอด ณ สิ้นวัน ในวันที่ ' +
          S_d1 + ' !!!!' + #13 + 'หากต้องการยกยอดเพื่อทำรายการขายในวันที่ ' + Formatdatetime('DD/MM/YYYY', bill_date)
          + ' ให้กด YES' + #13 + 'หากต้องการทำรายการขายในวันที่ ' + S_D1 + ' ให้ออกจากระบบแล้วเข้าสู่ระบบในวันที่ ' + S_d1, mtConfirmation, [mbYes, mbNo], 0);
        if reps = mrYes then
        begin
          endday;
          if FrmEndday.endfinish then Panel1.Visible := true;
          Read_Control;
        end;
      end;
    2: showmessage('!!!! ไม่สามารถทำรายการขายในวันที่' + LabelDate.Caption + 'ได้เนื่องจากมีการยกยอด ณ สิ้นวันไปแล้ว !!!!');
  end;
end;

procedure TFrmBill.BtnClearClick(Sender: TObject);
begin
  setenabled;
  FrmDiscount.Free;
  FrmDiscount  := TFrmDiscount.Create(Application);
  FrmPROMOBILL.Free;
  FrmPROMOBILL := TFrmPROMOBILL.create(Application);
  Cleardata;
  SetEnable; //set ennable of edit&label
  Edtmat_num1.SetFocus;
end;

procedure TFrmBill.Cleardata;
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
  LblDisValue.Caption := '0.00';
  LblDiscount.Caption := '0.00';
  LblNetprice.Caption := '0.00';
  LblVat.Caption := '0.00';
  LblTot_amount.Caption := '0.00';
  Gtot_Amt.Caption  :=  '0.00';
  chkgrp := '';
  Edtmat_num1.SetFocus;
  line_num := 0;
  PromoMatPrc :=  0;
  PromoStatus := 'N';
  Total_pay.Text  :=  '0';
  Chg_amt.Caption :=  '0';
  PNO01.Caption   :=  '';
  PNO02.Caption   :=  '';
  PNO03.Caption   :=  '';
  PNO04.Caption   :=  '';
  PNO05.Caption   :=  '';
  PNO06.Caption   :=  '';
  PNO07.Caption   :=  '';
  PNO08.Caption   :=  '';
  PNO09.Caption   :=  '';
  PNO10.Caption   :=  '';
end;

procedure TFrmBill.BtnSetEnable(n: integer);
begin
  if n = 1 then
//  if true then
  begin
    BtnSave.Enabled := true;
    BtnPrint.Enabled := true;
  end
  else
  begin
    BtnSave.Enabled := false;
    BtnPrint.Enabled := false;
  end;
end;

procedure TFrmBill.CalAmount(price, qty: string; var amount: double); //calculate amount
begin
  amount := strtofloat(qty) * strtofloat(price);
//  line_num := line_num+1;
end;

function PrintDirectLPT1(Data: string): Boolean;
var
  LPTHandle: THandle; // Handle of the print file
  B: array[1..1024] of Char;
begin
  FillChar(B, SizeOf(B), 0); // this should be faster
  Move(Data[1], B[1], Length(Data)); // this should also increase speed.
  LPTHandle := FileOpen('LPT1', fmOpenWrite);
  Result := FileWrite(LPTHandle, B, SizeOf(B)) <> -1;
  FileClose(LPTHandle);
end;



procedure TFrmBill.Edtmat_num1Exit(Sender: TObject);
begin
  Edit_num_Change2(1,Edtmat_num1);
end;

procedure TFrmBill.EdtCust_IDExit(Sender: TObject);
var
  sqls: string;
begin
//  Edtmat_num1.Enabled := true;
  if Trim(EdtCust_ID.Text) = '' then
  begin
    Showmessage('กรุณาใส่รหัสลูกค้า');
    EdtCust_ID.SetFocus;
  end
  else
  begin
    sqls := 'Select CUST_NAME From CUSTOMER Where CUST_ID = ''' + Trim(EdtCUST_ID.Text) + ''' ';
    with FrmDatamodule.ADOQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add(sqls);
      Open;
    end;
    if FrmDatamodule.ADOQuery1.RecordCount = 0 then
    begin
      Showmessage('รหัสลูกค้าไม่ถูกต้อง กรุณาใส่อีกครั้ง');
      EdtCUST_ID.SetFocus;
    end
    else
    begin
      LabelCust_name.Caption := FrmDatamodule.ADOQuery1.FieldValues['CUST_NAME'];
      EdtCust_ID.Enabled := false;
    end;
  end;
end;

procedure TFrmBill.fillcharmat;
begin
  if (Copy(mat_num, 1, 1) = 'l') or (Copy(mat_num, 1, 1) = 'L') then
  begin
    mat_num := 'F' + mat_num;
  end
  else if (Copy(mat_num, 1, 1) <> 'f') and (Copy(mat_num, 1, 1) <> 'F') and (Copy(mat_num, 1, 1) <> 'g') and (Copy(mat_num, 1, 1) <> 'G') then
  begin
    mat_num := 'FCN' + mat_num;
  end;
end;

procedure TFrmBill.Caltotprice;
//var netprice, vat, tot_amount : double;
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

  if StrToFloat(trim(LblDiscount.Caption)) > 0 then
     begin
        DValue   := ( tot_amount * StrToFloat(trim(LblDiscount.Caption)) ) / 100;
        GAmount  := tot_amount - DValue;
     end
  else
     begin
        DValue   := 0;
        GAmount  := tot_amount;
     end;
  vat      := GAmount  * (7 / 107);
  netprice := GAmount - vat;

  LblTot_amount.Caption := formatfloat('#,##0.00', tot_amount);
  LblDisValue.Caption   := formatfloat('#,##0.00', DValue);
  Gtot_Amt.Caption      := formatfloat('#,##0.00', GAmount);
  LblNetprice.Caption   := formatfloat('#,##0.00', netprice);
  LblVat.Caption        := formatfloat('#,##0.00', vat);

end;

procedure TFrmBill.Action2Execute(Sender: TObject);
var
  strsql: string;
  
begin
  if BtnPrint.Enabled = true then
  begin
    passEdit_qty2;
    bill_no := Trim(LabelBill_No.Caption);
    status_bill := 'A';
    status_print := '0';
    setenabled;
    process_data(bill_no); //save data in table BILL_HEAD
    InsertBillPromo;
    FrmDiscount.Free;
    FrmDiscount  := TFrmDiscount.Create(Application);
    FrmPROMOBILL.Free;
    FrmPROMOBILL := TFrmPROMOBILL.create(Application);
    with frmdatamodule.ADOQuery1 do
    begin
     close;
     sql.clear;
     strsql := 'SELECT * ' + #13#10 +
       '  FROM ( ( BILL_HEAD INNER JOIN BILL_DETAIL ON BILL_HEAD.BILLH_NO = BILL_DETAIL.BILLD_NO ' +
       '  AND  BILL_HEAD.BILLH_COMP_ID = BILL_DETAIL.BILLD_COMP_ID ) ' + #13#10 +
       '  INNER JOIN FINISH_GOODS ON BILL_DETAIL.BILLD_GOODS_ID = FINISH_GOODS.FG_ID ) ' + #13#10 +
       '  WHERE BILL_HEAD.BILLH_COMP_ID = ''' + comp_id + '''' +
       '    AND BILL_HEAD.BILLH_NO      = ''' + bill_no + '''';
     sql.Add(strsql);
     open;
   end;
   QRForm.QRExpr1.Expression   := FrmDataModule.ADOQuery1.FieldValues['BILLH_AMT'] -
                                  FrmDataModule.ADOQuery1.FieldValues['BILLH_AMT_VAT'];
   QRForm.HDVALUE.Expression   := ( FrmDataModule.ADOQuery1.FieldValues['BILLH_TOTAMT'] *
                                    FrmDataModule.ADOQuery1.FieldValues['BILLH_DISCOUNT'] ) /100;
   QRForm.Hchg.Expression      := FrmDataModule.ADOQuery1.FieldValues['BILLH_TOTPAY'] -
                                  FrmDataModule.ADOQuery1.FieldValues['BILLH_AMT'];


(*
    if generate_print_bill(comp_id, bill_no, msg_err) = true then
    begin
      status_print := '1';
      process_data(bill_no); //save data in table BILL_HEAD ch status print =1
    end
    else
    begin
      MessageDlg(msg_err, mtError, [mbok], 0);
    end;
*)
   if FrmDatamodule.ADOQuery1.RecordCount <> 0 then
   begin
     status_print := '1';

// B1 add print company address in billing header
     with frmdatamodule.ADOQuery0 do
      begin
       close;
       sql.clear;
       strsql := 'SELECT * FROM COMPANY WHERE COMP_ID = ''' + comp_id + ''' ';
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
//     QRForm.QuickRep1.Preview;
     process_data(bill_no); //save data in table BILL_HEAD ch status print =1
   end
   else
   begin
     msg_err := 'ไม่สามารถค้นหาข้อมูลที่จะทำการพิมพ์ได้';
     MessageDlg(msg_err, mtError, [mbok], 0);
   end;

  end;
end;

procedure TFrmBill.process_billhead(PBill_no: string);
var cust_id: string;
    totpay, totamt, amt, vats, disc: string;
begin
  cust_id := Trim(EdtCust_id.Text);
  amt     := formatfloat('#0.00', strtofloat(Rem_comma(Gtot_Amt.Caption)));
  totamt  := formatfloat('#0.00', strtofloat(Rem_comma(LblTot_amount.Caption)));
  vats    := formatfloat('#0.00', vat);
  disc    := formatfloat('#0.00', strtofloat(Rem_comma(LblDiscount.Caption)));
  if strtofloat(Rem_comma(Total_pay.Text)) = 0 then
     totpay  := formatfloat('#0.00', strtofloat(Rem_comma(Gtot_Amt.Caption)))
  else
     totpay  := formatfloat('#0.00', strtofloat(Rem_comma(Total_pay.Text)));

  if (status_bill = 'A') then
  begin
    //update table BILL_HEAD
    if (FrmDatamodule.ADOQuery2.RecordCount = 0) then
    begin
      sql_tbillh := 'INSERT INTO BILL_HEAD' + #13 +
        '(BILLH_COMP_ID, BILLH_NO, BILLH_DATE, BILLH_CUST_ID, BILLH_SALES_ID, BILLH_FG_GRP, BILLH_NUM, BILLH_AMT, BILLH_AMT_VAT, BILLH_STATUS, BILLH_PRINT, BILLH_LOAD, BILLH_TOTAMT, BILLH_DISCOUNT, BILLH_TOTPAY )' +
        'VALUES (''' + comp_id + ''', ''' + PBill_no + ''', #' +
        formatdatetime('YYYY/MM/DD', bill_date) +
        '# , ''' + cust_id + ''', ''' + sales_id + ''', ''' + chkgrp + ''',''' + intTostr(line_num) + ''', ''' + amt + ''', ''' + vats + ''', ''' + status_bill + ''', ''' + status_print + ''', ''' + bill_load + ''', ''' + totamt + ''', ''' + disc + ''', ''' + totpay + ''')';
      have_sql_tbillh := 1;
    end
    else
    begin
      if status_print <> FrmDatamodule.ADOQuery2.FieldValues['BILLH_PRINT'] then
      begin
        sql_tbillh := 'UPDATE BILL_HEAD ' +
          'SET BILLH_PRINT = ''' + status_print + ''' ' +
          'WHERE BILLH_COMP_ID = ''' + comp_id + ''' and BILLH_NO = ''' + PBill_no + ''' ';
        have_sql_tbillh := 1;

      end;
    end;
  end
  else if (status_bill = 'C') then
  begin
    if (FrmDatamodule.ADOQuery2.RecordCount > 0) then
    begin
      line_num := FrmDatamodule.ADOQuery2.FieldValues['BILLH_NUM']; // set line_num because (count_rec not find)
      if FrmDatamodule.ADOQuery2.FieldValues['BILLH_STATUS'] = 'C' then
      begin
        Showmessage('เลขที่บิล ''' + PBill_no + ''' ได้ถูก CANCEL เรียบร้อยแล้ว');
      end
      else
      begin
        sql_tbillh := 'UPDATE BILL_HEAD' + #13 +
          'SET BILLH_STATUS = ''C''' + #13 +
          'WHERE BILLH_COMP_ID = ''' + comp_id + ''' and BILLH_NO = ''' + PBill_no + ''' ';
        have_sql_tbillh := 1;

      end;
    end;
  end;
end;

procedure TFrmBill.process_control(Currnet_Bill_no: string;update_bill_no:boolean);
var //sql_update : string;
  today_bill: longint;
  today_amt: double;
  today_bill_c: longint;
  today_amt_c: double;

  ACCU_AMT: double;
  ACCU_BILL: longint;
  ACCU_AMT_C: double;
  ACCU_BILL_C: longint;

  S: string;
  amt: double;
begin
{  S := 'SELECT Sum([BILL_DETAIL].[BILLD_AMT]) AS Expr1,' + #13#10 +
    '[BILL_DETAIL].[BILLD_STATUS], Sum([BILL_DETAIL].[BILLD_AMT_VAT]) AS Expr2,' + #13#10 +
    ' Count([BILL_DETAIL].[BILLD_NO]) AS CountOfBILLD_NO' + #13#10 +
    'FROM BILL_HEAD INNER JOIN BILL_DETAIL ON (BILL_HEAD.BILLH_NO = BILL_DETAIL.BILLD_NO)' + #13#10 +
    ' AND (BILL_HEAD.BILLH_COMP_ID = BILL_DETAIL.BILLD_COMP_ID)' + #13#10 +
    'WHERE (((BILL_HEAD.BILLH_DATE)<=#' + formatdatetime('YYYY/MM/DD', bill_date)
    + '#))' + #13#10 +
    'GROUP BY BILL_DETAIL.BILLD_STATUS' + #13#10;
}
  S := 'SELECT Sum([BILL_HEAD].[BILLH_AMT]) AS Expr1,' + #13#10 +
    '[BILL_HEAD].[BILLH_STATUS], Sum([BILL_HEAD].[BILLH_AMT_VAT]) AS Expr2,' + #13#10 +
    ' Count([BILL_HEAD].[BILLH_NO]) AS CountOfBILLD_NO' + #13#10 +
    'FROM BILL_HEAD' + #13#10 +
    'WHERE (((BILL_HEAD.BILLH_DATE)<=#' + formatdatetime('YYYY/MM/DD', bill_date)
    + '#))' + #13#10 +
    'GROUP BY BILL_HEAD.BILLH_STATUS' + #13#10;

  FrmDatamodule.SQL_Q(FrmDatamodule.ADOQuery5,S,FrmDatamodule.App_Sql+'process_control1.txt');

  ACCU_AMT := 0;
  ACCU_BILL := 0;
  ACCU_AMT_C := 0;
  ACCU_BILL_C := 0;

  while not FrmDatamodule.ADOQuery5.eof do
  begin
    if FrmDatamodule.ADOQuery5.FieldValues['BILLH_STATUS'] = 'A' then
    begin
      ACCU_BILL := FrmDatamodule.ADOQuery5.FieldValues['CountOfBILLD_NO'];
      ACCU_AMT := FrmDatamodule.ADOQuery5.FieldValues['Expr1'];
    end
    else if FrmDatamodule.ADOQuery5.FieldValues['BILLH_STATUS'] = 'C' then
    begin
      ACCU_BILL_C := FrmDatamodule.ADOQuery5.FieldValues['CountOfBILLD_NO'];
      ACCU_AMT_C := FrmDatamodule.ADOQuery5.FieldValues['Expr1'];
    end;
    FrmDatamodule.ADOQuery5.next;
  end;


{  S := 'SELECT Sum([BILL_DETAIL].[BILLD_AMT]) AS Expr1,' + #13#10 +
    '[BILL_DETAIL].[BILLD_STATUS], Sum([BILL_DETAIL].[BILLD_AMT_VAT]) AS Expr2,' + #13#10 +
    ' Count([BILL_DETAIL].[BILLD_NO]) AS CountOfBILLD_NO' + #13#10 +
    'FROM BILL_HEAD INNER JOIN BILL_DETAIL ON (BILL_HEAD.BILLH_NO = BILL_DETAIL.BILLD_NO)' + #13#10 +
    ' AND (BILL_HEAD.BILLH_COMP_ID = BILL_DETAIL.BILLD_COMP_ID)' + #13#10 +
    'WHERE (((BILL_HEAD.BILLH_DATE)=#' + formatdatetime('YYYY/MM/DD', bill_date)
    + '#))' + #13#10 +
    'GROUP BY BILL_DETAIL.BILLD_STATUS' + #13#10;
 }
  S := 'SELECT Sum([BILL_HEAD].[BILLH_AMT]) AS Expr1,' + #13#10 +
    '[BILL_HEAD].[BILLH_STATUS], Sum([BILL_HEAD].[BILLH_AMT_VAT]) AS Expr2,' + #13#10 +
    ' Count([BILL_HEAD].[BILLH_NO]) AS CountOfBILLD_NO' + #13#10 +
    'FROM BILL_HEAD' + #13#10 +
    'WHERE (((BILL_HEAD.BILLH_DATE)=#' + formatdatetime('YYYY/MM/DD', bill_date)
    + '#))' + #13#10 +
    'GROUP BY BILL_HEAD.BILLH_STATUS' + #13#10;

  FrmDatamodule.SQL_Q(FrmDatamodule.ADOQuery5,S,FrmDatamodule.App_Sql+'process_control2.txt');

  today_bill := 0;
  today_amt := 0;
  today_bill_c := 0;
  today_amt_c := 0;
  FrmDatamodule.ADOQuery5.open;
  FrmDatamodule.ADOQuery5.first;
  while not FrmDatamodule.ADOQuery5.eof do
  begin
    if FrmDatamodule.ADOQuery5.FieldValues['BILLH_STATUS'] = 'A' then
    begin
      today_bill := FrmDatamodule.ADOQuery5.FieldValues['CountOfBILLD_NO'];
      today_amt := FrmDatamodule.ADOQuery5.FieldValues['Expr1'];
    end
    else if FrmDatamodule.ADOQuery5.FieldValues['BILLH_STATUS'] = 'C' then
    begin
      today_bill_c := FrmDatamodule.ADOQuery5.FieldValues['CountOfBILLD_NO'];
      today_amt_c := FrmDatamodule.ADOQuery5.FieldValues['Expr1'];
    end;
    FrmDatamodule.ADOQuery5.next;
  end;

  amt := strtofloat(formatfloat('#0.00', strtofloat(Rem_Comma(Gtot_Amt.Caption))));

  sql_tcontrol := 
    'SALESDATE = #' + Formatdatetime('YYYY/MM/DD', bill_date) + '# , ' + #13#10 +
    'TODAY_BILL_C = ''' + inttostr(today_bill_c) + ''' , ' + #13#10 +
    'TODAY_AMT_C = ''' + floattostr(today_amt_c) + ''' , ' + #13#10 +
    'TODAY_BILL = ''' + inttostr(today_bill) + ''' , ' + #13#10 +
    'TODAY_AMT = ''' + floattostr(today_amt) + ''' , ' + #13#10 +
    'ACCU_AMT = ''' + floattostr(ACCU_AMT) + ''' , ' + #13#10 +
    'ACCU_BILL = ''' + inttostr(ACCU_BILL) + ''' , ' + #13#10 +
    'ACCU_AMT_C = ''' + floattostr(ACCU_AMT_C) + ''' , ' + #13#10 +
    'ACCU_BILL_C = ''' + inttostr(ACCU_BILL_C) + ''' ' + #13#10 +
    'WHERE COMP_ID = ''' + comp_id + ''' ';

  if update_bill_no then
  begin
    sql_tcontrol := 'UPDATE CONTROL ' + #13#10 +
    'SET CUR_BILL_NO = ''' + Currnet_Bill_no + ''' , ' + #13#10 + sql_tcontrol
  end
  else
  begin
    sql_tcontrol := 'UPDATE CONTROL ' + #13#10 +
    'SET '+ sql_tcontrol;
  end;

  FrmDatamodule.EXE_SQL(FrmDatamodule.ADOQuery5,S,FrmDatamodule.App_Sql+'process_control3.txt');
  have_sql_tcontrol := 1;
end;


procedure TFrmBill.process_billdet(PBill_no: string);
var sql_billd: string;
  i: integer;
begin

  for i := 1 to line_num do
  begin
    if (status_bill = 'A') then
    begin
        //insert table BILL_DETAIL
      sql_arr[i].sql_billdet := 'INSERT INTO BILL_DETAIL' + #13 +
        '(BILLD_COMP_ID, BILLD_NO, BILLD_LINE, BILLD_GOODS_ID, BILLD_GOODS_PRC, BILLD_GOODS_NUM, BILLD_AMT, BILLD_AMT_VAT, BILLD_STATUS, BILLD_LOAD, BILLD_PROMO)' + #13 +
        'VALUES (''' + comp_id + ''', ''' + PBill_no + ''', ''' + inttostr(i) + ''', ''' + billdetail_arr[i].goods_id + ''', ''' + floattostr(billdetail_arr[i].goods_prc) +
        ''',''' + floattostr(billdetail_arr[i].goods_num) + ''', ''' + floattostr(billdetail_arr[i].amt) +
        ''', ''' + floattostr(billdetail_arr[i].amt_vat) + ''', ''' + billdetail_arr[i].status + ''', ''' + billdetail_arr[i].load + ''', ''' + billdetail_arr[i].promo + ''' )';
      if i = line_num then
        have_sql_tbilldet := 1;

    end // status = 'A'
    else if (status_bill = 'C') then
    begin
      sql_billd := 'Select * From BILL_DETAIL Where BILLD_COMP_ID = ''' + comp_id + ''' and BILLD_NO = ''' + PBill_no + ''' and BILLD_LINE = ' + inttostr(i);
      with FrmDatamodule.ADOQuery3 do
      begin
        Close;
        SQL.Clear;
        SQL.Add(sql_billd);
        Open;
      end;

      if (FrmDatamodule.ADOQuery3.RecordCount > 0) then
      begin
        if FrmDatamodule.ADOQuery3.FieldValues['BILLD_STATUS'] = 'C' then
        begin
          Showmessage('เลขที่บิล ''' + PBill_no + ''' ได้ถูก CANCEL เรียบร้อยแล้ว');
        end
        else
        begin
          sql_arr[i].sql_billdet := 'UPDATE BILL_DETAIL SET BILLD_STATUS = ''' + status_bill + ''' ' +
            'WHERE BILLD_COMP_ID = ''' + comp_id + ''' and BILLD_NO = ''' + PBill_no + ''' and BILLD_LINE = ' + inttostr(i);
          if i = line_num then
            have_sql_tbilldet := 1;

        end;
      end; //end  FrmDatamodule.ADOQuery3.RecordCount > 0

    end; //end status == 'c'
  end; //end loop for
end;

procedure TFrmBill.Action3Execute(Sender: TObject);
begin
  if (BtnSave.Enabled = true) then
  begin
    passEdit_qty2;
    bill_no := Trim(LabelBill_No.Caption);
    setenabled;
    status_bill := 'A';
    status_print := '0';  
    process_data(bill_no); //save data in table BILL_HEAD
    InsertBillPromo;
    FrmDiscount.Free;
    FrmDiscount  := TFrmDiscount.Create(Application);
    FrmPROMOBILL.Free;
    FrmPROMOBILL := TFrmPROMOBILL.create(Application);
  end;
end;

procedure TFrmBill.Action5Execute(Sender: TObject);
begin
  chkactive := 'cancel';
  bill_no := Trim(LabelBill_No.Caption);
  FrmKeybillno := TFrmKeybillno.create(Application);
  FrmKeybillno.Label1.Caption := 'รายการ CANCEL';
  FrmKeybillno.ShowModal;
  FrmKeybillno.Free;
end;

procedure TFrmBill.Action4Execute(Sender: TObject);
begin
  chkactive := 'reprint';
  bill_no := Trim(LabelBill_No.Caption);
  FrmKeybillno := TFrmKeybillno.create(Application);
  FrmKeybillno.Label1.Caption := 'รายการ REPRINT';
  FrmKeybillno.ShowModal;
  FrmKeybillno.Free;
end;

procedure TFrmBill.process_data(PBill_no: string);
var i: integer;
  sql_billh: string;
  sql_control: string;
begin
  have_sql_tbillh := 0;
  have_sql_tbilldet := 0;
  have_sql_tcontrol := 0;
  have_sql_tcontrol_c := 0;

  count_rec;
  sql_billh := 'Select * From BILL_HEAD Where BILLH_COMP_ID = ''' + comp_id + ''' and BILLH_NO = ''' + Pbill_no + ''' ';
  with FrmDatamodule.ADOQuery2 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sql_billh);
    Open;
  end;

  arrtobilldet; //get value to array billdetail

  sql_control := 'Select * From CONTROL Where COMP_ID = ''' + comp_id + ''' ';
  with FrmDatamodule.ADOQuery5 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sql_control);
    Open;
  end;
  FrmDataModule.ADOConnection.BeginTrans;
  try
    Process_billhead(PBill_no);
    Process_billdet(PBill_no);
    if have_sql_tbillh = 1 then
      FrmDataModule.EXE_SQL(FrmDataModule.ADOQuery1, sql_tbillh,FrmDataModule.APP_SQL+'process_data1.txt');
    if (status_print = '0') and (have_sql_tbilldet = 1) then
    begin
      for i := 1 to line_num do
      begin
        FrmDataModule.EXE_SQL(FrmDataModule.ADOQuery1, sql_arr[i].sql_billdet,FrmDataModule.APP_SQL+'process_data2.txt');
      end;

      if FrmBill.status_bill = 'C' then Process_control(Bill_no,False) //ใช้เลขที่บิลล่าสุด
      else Process_control(Bill_no,True);
      if (status_print = '0') and (have_sql_tcontrol = 1) then
      FrmDataModule.EXE_SQL(FrmDataModule.ADOQuery1, sql_tcontrol,FrmDataModule.APP_SQL+'process_data2.txt');

      have_sql_tbillh := 0;
      have_sql_tbilldet := 0;
      have_sql_tcontrol := 0;
      have_sql_tcontrol_c := 0;
      Read_Control;
      if (FrmBill.status_bill <> 'C')  and Panel1.Visible  then
      begin
        Cleardata; //Clear data in edit&label
        SetEnable; //set ennable of edit&label
      end
      else if (FrmBill.status_bill <> 'C')  and not Panel1.Visible  then
      begin
        Panel1.visible := True;
        Cleardata; //Clear data in edit&label
        SetEnable; //set ennable of edit&label
        Panel1.visible := False;
      end
      else
      begin
        // ไม่ต้องทำอะไร
      end ;
    end;
    FrmDataModule.ADOConnection.CommitTrans;
  except
    on E: Exception do
    begin
      FrmDataModule.ADOConnection.RollbackTrans;
      Showmessage('เกิดการผิดพลาดในการบันทึกข้อมูล');
    end;
  end;
end;

procedure TFrmBill.chkarr_data;
var i, j: integer;
begin
  edttoarr;
  for i := 1 to 9 do
  begin
    if line_arr[i].Edtmat_num = '' then
    begin
      j := i + 1;
      while j <= 10 do
      begin
        if line_arr[j].Edtmat_num <> '' then
        begin
          moverecord(i, j);
          j := 11;
        end;
        j := j + 1;
      end;
    end;
  end;

  count_rec;
  arrtoedt;
  if line_num = 0 then BtnSetEnable(0);
end;

procedure TFrmBill.count_rec;
var i: integer;
begin
  line_num := 0;
  for i := 1 to 10 do
  begin
    if line_arr[i].Edtmat_num <> '' then
      line_num := line_num + 1;
  end;
end;

procedure TFrmBill.arrtoedt;
begin
  Edtmat_num1.Text := line_arr[1].Edtmat_num;
  Lblmat_num1.Caption := line_arr[1].Lblmat_num;
  Lblmat_des1.Caption := line_arr[1].Lblmat_des;
  chkvalue_arrtolbl(Lblmat_price1, line_arr[1].Lblmat_price);
  chkvalue_arrtolbl(Lblamount1, line_arr[1].Lblamount);
  chkvalue_arrtoedt(EdtQty1, line_arr[1].EdtQty);
  Lblmat_unit1.Caption := line_arr[1].Lblmat_unit;
  PNo01.Caption   := line_arr[1].Promo;

  Edtmat_num2.Text := line_arr[2].Edtmat_num;
  Lblmat_num2.Caption := line_arr[2].Lblmat_num;
  Lblmat_des2.Caption := line_arr[2].Lblmat_des;
  chkvalue_arrtolbl(Lblmat_price2, line_arr[2].Lblmat_price);
  chkvalue_arrtolbl(Lblamount2, line_arr[2].Lblamount);
  chkvalue_arrtoedt(EdtQty2, line_arr[2].EdtQty);
  Lblmat_unit2.Caption := line_arr[2].Lblmat_unit;
  PNo02.Caption   := line_arr[2].Promo;

  Edtmat_num3.Text := line_arr[3].Edtmat_num;
  Lblmat_num3.Caption := line_arr[3].Lblmat_num;
  Lblmat_des3.Caption := line_arr[3].Lblmat_des;
  chkvalue_arrtolbl(Lblmat_price3, line_arr[3].Lblmat_price);
  chkvalue_arrtolbl(Lblamount3, line_arr[3].Lblamount);
  chkvalue_arrtoedt(EdtQty3, line_arr[3].EdtQty);
  Lblmat_unit3.Caption := line_arr[3].Lblmat_unit;
  PNo03.Caption   := line_arr[3].Promo;

  Edtmat_num4.Text := line_arr[4].Edtmat_num;
  Lblmat_num4.Caption := line_arr[4].Lblmat_num;
  Lblmat_des4.Caption := line_arr[4].Lblmat_des;
  chkvalue_arrtolbl(Lblmat_price4, line_arr[4].Lblmat_price);
  chkvalue_arrtolbl(Lblamount4, line_arr[4].Lblamount);
  chkvalue_arrtoedt(EdtQty4, line_arr[4].EdtQty);
  Lblmat_unit4.Caption := line_arr[4].Lblmat_unit;
  PNo04.Caption   := line_arr[4].Promo;

  Edtmat_num5.Text := line_arr[5].Edtmat_num;
  Lblmat_num5.Caption := line_arr[5].Lblmat_num;
  Lblmat_des5.Caption := line_arr[5].Lblmat_des;
  chkvalue_arrtolbl(Lblmat_price5, line_arr[5].Lblmat_price);
  chkvalue_arrtolbl(Lblamount5, line_arr[5].Lblamount);
  chkvalue_arrtoedt(EdtQty5, line_arr[5].EdtQty);
  Lblmat_unit5.Caption := line_arr[5].Lblmat_unit;
  PNo05.Caption   := line_arr[5].Promo;

  Edtmat_num6.Text := line_arr[6].Edtmat_num;
  Lblmat_num6.Caption := line_arr[6].Lblmat_num;
  Lblmat_des6.Caption := line_arr[6].Lblmat_des;
  chkvalue_arrtolbl(Lblmat_price6, line_arr[6].Lblmat_price);
  chkvalue_arrtolbl(Lblamount6, line_arr[6].Lblamount);
  chkvalue_arrtoedt(EdtQty6, line_arr[6].EdtQty);
  Lblmat_unit6.Caption := line_arr[6].Lblmat_unit;
  PNo06.Caption   := line_arr[6].Promo;

  Edtmat_num7.Text := line_arr[7].Edtmat_num;
  Lblmat_num7.Caption := line_arr[7].Lblmat_num;
  Lblmat_des7.Caption := line_arr[7].Lblmat_des;
  chkvalue_arrtolbl(Lblmat_price7, line_arr[7].Lblmat_price);
  chkvalue_arrtolbl(Lblamount7, line_arr[7].Lblamount);
  chkvalue_arrtoedt(EdtQty7, line_arr[7].EdtQty);
  Lblmat_unit7.Caption := line_arr[7].Lblmat_unit;
  PNo07.Caption   := line_arr[7].Promo;

  Edtmat_num8.Text := line_arr[8].Edtmat_num;
  Lblmat_num8.Caption := line_arr[8].Lblmat_num;
  Lblmat_des8.Caption := line_arr[8].Lblmat_des;
  chkvalue_arrtolbl(Lblmat_price8, line_arr[8].Lblmat_price);
  chkvalue_arrtolbl(Lblamount8, line_arr[8].Lblamount);
  chkvalue_arrtoedt(EdtQty8, line_arr[8].EdtQty);
  Lblmat_unit8.Caption := line_arr[8].Lblmat_unit;
  PNo08.Caption   := line_arr[8].Promo;

  Edtmat_num9.Text := line_arr[9].Edtmat_num;
  Lblmat_num9.Caption := line_arr[9].Lblmat_num;
  Lblmat_des9.Caption := line_arr[9].Lblmat_des;
  chkvalue_arrtolbl(Lblmat_price9, line_arr[9].Lblmat_price);
  chkvalue_arrtolbl(Lblamount9, line_arr[9].Lblamount);
  chkvalue_arrtoedt(EdtQty9, line_arr[9].EdtQty);
  Lblmat_unit9.Caption := line_arr[9].Lblmat_unit;
  PNo09.Caption   := line_arr[9].Promo;

  Edtmat_num10.Text := line_arr[10].Edtmat_num;
  Lblmat_num10.Caption := line_arr[10].Lblmat_num;
  Lblmat_des10.Caption := line_arr[10].Lblmat_des;
  chkvalue_arrtolbl(Lblmat_price10, line_arr[10].Lblmat_price);
  chkvalue_arrtolbl(Lblamount10, line_arr[10].Lblamount);
  chkvalue_arrtoedt(EdtQty10, line_arr[10].EdtQty);
  Lblmat_unit10.Caption := line_arr[10].Lblmat_unit;
  PNo10.Caption   := line_arr[10].Promo;
  
end;

procedure TFrmBill.edttoarr;
begin
  line_arr[1].Edtmat_num := Edtmat_num1.Text;
  line_arr[1].Lblmat_num := Lblmat_num1.Caption;
  line_arr[1].Lblmat_des := Lblmat_des1.Caption;
  line_arr[1].Lblmat_price := Trim(Rem_comma(Lblmat_price1.Caption));
  line_arr[1].EdtQty := Trim(Rem_comma(EdtQty1.Text));
  line_arr[1].Lblmat_unit := Lblmat_unit1.Caption;
  line_arr[1].Lblamount := Trim(Rem_comma(Lblamount1.Caption));
  line_arr[1].Promo     := PNo01.Caption;

  line_arr[2].Edtmat_num := Edtmat_num2.Text;
  line_arr[2].Lblmat_num := Lblmat_num2.Caption;
  line_arr[2].Lblmat_des := Lblmat_des2.Caption;
  line_arr[2].Lblmat_price := Trim(Rem_comma(Lblmat_price2.Caption));
  line_arr[2].EdtQty := Trim(Rem_comma(EdtQty2.Text));
  line_arr[2].Lblmat_unit := Lblmat_unit2.Caption;
  line_arr[2].Lblamount := Trim(Rem_comma(Lblamount2.Caption));
  line_arr[2].Promo     := PNo02.Caption;

  line_arr[3].Edtmat_num := Edtmat_num3.Text;
  line_arr[3].Lblmat_num := Lblmat_num3.Caption;
  line_arr[3].Lblmat_des := Lblmat_des3.Caption;
  line_arr[3].Lblmat_price := Trim(Rem_comma(Lblmat_price3.Caption));
  line_arr[3].EdtQty := Trim(Rem_comma(EdtQty3.Text));
  line_arr[3].Lblmat_unit := Lblmat_unit3.Caption;
  line_arr[3].Lblamount := Trim(Rem_comma(Lblamount3.Caption));
  line_arr[3].Promo     := PNo03.Caption;

  line_arr[4].Edtmat_num := Edtmat_num4.Text;
  line_arr[4].Lblmat_num := Lblmat_num4.Caption;
  line_arr[4].Lblmat_des := Lblmat_des4.Caption;
  line_arr[4].Lblmat_price := Trim(Rem_comma(Lblmat_price4.Caption));
  line_arr[4].EdtQty := Trim(Rem_comma(EdtQty4.Text));
  line_arr[4].Lblmat_unit := Lblmat_unit4.Caption;
  line_arr[4].Lblamount := Trim(Rem_comma(Lblamount4.Caption));
  line_arr[4].Promo     := PNo04.Caption;

  line_arr[5].Edtmat_num := Edtmat_num5.Text;
  line_arr[5].Lblmat_num := Lblmat_num5.Caption;
  line_arr[5].Lblmat_des := Lblmat_des5.Caption;
  line_arr[5].Lblmat_price := Trim(Rem_comma(Lblmat_price5.Caption));
  line_arr[5].EdtQty := EdtQty5.Text;
  line_arr[5].Lblmat_unit := Trim(Rem_comma(Lblmat_unit5.Caption));
  line_arr[5].Lblamount := Trim(Rem_comma(Lblamount5.Caption));
  line_arr[5].Promo     := PNo05.Caption;

  line_arr[6].Edtmat_num := Edtmat_num6.Text;
  line_arr[6].Lblmat_num := Lblmat_num6.Caption;
  line_arr[6].Lblmat_des := Lblmat_des6.Caption;
  line_arr[6].Lblmat_price := Trim(Rem_comma(Lblmat_price6.Caption));
  line_arr[6].EdtQty := Trim(Rem_comma(EdtQty6.Text));
  line_arr[6].Lblmat_unit := Lblmat_unit6.Caption;
  line_arr[6].Lblamount := Trim(Rem_comma(Lblamount6.Caption));
  line_arr[6].Promo     := PNo06.Caption;

  line_arr[7].Edtmat_num := Edtmat_num7.Text;
  line_arr[7].Lblmat_num := Lblmat_num7.Caption;
  line_arr[7].Lblmat_des := Lblmat_des7.Caption;
  line_arr[7].Lblmat_price := Trim(Rem_comma(Lblmat_price7.Caption));
  line_arr[7].EdtQty := Trim(Rem_comma(EdtQty7.Text));
  line_arr[7].Lblmat_unit := Lblmat_unit7.Caption;
  line_arr[7].Lblamount := Trim(Rem_comma(Lblamount7.Caption));
  line_arr[7].Promo     := PNo07.Caption;

  line_arr[8].Edtmat_num := Edtmat_num8.Text;
  line_arr[8].Lblmat_num := Lblmat_num8.Caption;
  line_arr[8].Lblmat_des := Lblmat_des8.Caption;
  line_arr[8].Lblmat_price := Trim(Rem_comma(Lblmat_price8.Caption));
  line_arr[8].EdtQty := Trim(Rem_comma(EdtQty8.Text));
  line_arr[8].Lblmat_unit := Lblmat_unit8.Caption;
  line_arr[8].Lblamount := Trim(Rem_comma(Lblamount8.Caption));
  line_arr[8].Promo     := PNo08.Caption;

  line_arr[9].Edtmat_num := Edtmat_num9.Text;
  line_arr[9].Lblmat_num := Lblmat_num9.Caption;
  line_arr[9].Lblmat_des := Lblmat_des9.Caption;
  line_arr[9].Lblmat_price := Trim(Rem_comma(Lblmat_price9.Caption));
  line_arr[9].EdtQty := Trim(Rem_comma(EdtQty9.Text));
  line_arr[9].Lblmat_unit := Lblmat_unit9.Caption;
  line_arr[9].Lblamount := Trim(Rem_comma(Lblamount9.Caption));
  line_arr[9].Promo     := PNo09.Caption;

  line_arr[10].Edtmat_num := Edtmat_num10.Text;
  line_arr[10].Lblmat_num := Lblmat_num10.Caption;
  line_arr[10].Lblmat_des := Lblmat_des10.Caption;
  line_arr[10].Lblmat_price := Trim(Rem_comma(Lblmat_price10.Caption));
  line_arr[10].EdtQty := Trim(Rem_comma(EdtQty10.Text));
  line_arr[10].Lblmat_unit := Lblmat_unit10.Caption;
  line_arr[10].Lblamount := Trim(Rem_comma(Lblamount10.Caption));
  line_arr[10].Promo     := PNo10.Caption;
end;

procedure TFrmBill.moverecord(i, j: integer);
begin
  line_arr[i] := line_arr[j];
  line_arr[j].Edtmat_num := '';
  line_arr[j].Lblmat_num := '';
  line_arr[j].Lblmat_des := '';
  line_arr[j].Lblmat_price := '';
  line_arr[j].EdtQty := '';
  line_arr[j].Lblmat_unit := '';
  line_arr[j].LblAmount := '';
  line_arr[j].Promo     := '';
end;

function TFrmBill.passchkformatQty(a, b: TEdit; c, d: TLabel; line: integer):boolean;
var i, j: integer;
    Chk_Qty : boolean;
begin
  result := True; //นับ Error เฉพาะ คีย์ผิดเท่านั้น ว่างไม่นับ
  if Trim(a.Text) <> '' then
  begin
    if Trim(b.Text) <> '' then
    begin
      Chk_Qty := false;
      try
        a.Text := formatfloat('#0.00', strtofloat(Rem_comma(a.Text)));
        Chk_Qty := true;
      except
        on E: EConvertError do
        begin
          Showmessage('ใส่ปริมาณไม่ถูกต้องกรุณาใส่ใหม่');
          a.SetFocus;
          result := false;
        end;
      end;

      if result = true then
      begin
        j := length(a.Text);
        for i := 1 to j do
        begin
          if (Copy(a.Text, i, 1) <> '1') and
            (Copy(a.Text, i, 1) <> '2') and
            (Copy(a.Text, i, 1) <> '3') and
            (Copy(a.Text, i, 1) <> '4') and
            (Copy(a.Text, i, 1) <> '5') and
            (Copy(a.Text, i, 1) <> '6') and
            (Copy(a.Text, i, 1) <> '7') and
            (Copy(a.Text, i, 1) <> '8') and
            (Copy(a.Text, i, 1) <> '9') and
            (Copy(a.Text, i, 1) <> '0') and
            (Copy(a.Text, i, 1) <> '.') then
          begin
            Showmessage('ใส่ปริมาณไม่ถูกต้องกรุณาใส่ใหม่');
            a.SetFocus;
            result := False;
//                  chkkeyqty := false;
          end;
        end;

        if strtofloat(a.Text) <= 0 then
        begin
          Showmessage('ใส่ปริมาณไม่ถูกต้องกรุณาใส่ใหม่');
          a.SetFocus;
          result := False;
        end
        else
        begin
          price := Rem_comma(c.Caption);
          qty := Rem_comma(a.Text);
          CalAmount(price, qty, amount); //calculate amount
          d.Caption := formatfloat('#0.00', amount);
          Caltotprice;
          BtnSetEnable(1);
          chkarr_data;
        end;
      end;
    end
    else
    begin
      Showmessage('กรุณาใส่รหัสสินค้า');
      b.SetFocus;
      a.Clear;
    end;
  end
  else
  begin
    if Trim(b.Text) <> '' then
    begin
      Showmessage('กรุณาใส่ปริมาณสินค้า');
      a.SetFocus;
    end
    else
      chkarr_data;
  end;

end;

procedure TFrmBill.chkvalue_arrtolbl(a: TLabel; arr_value: string);
begin
  if arr_value = '' then
  begin
    a.Caption := '';
  end
  else
    a.Caption := formatfloat('#,##0.00', strtofloat((arr_value)));
end;

procedure TFrmBill.chkvalue_arrtoedt(b: TEdit; arr_qty: string);
begin
  if arr_qty = '' then
  begin
    b.Text := '';
  end
  else
    b.Text := formatfloat('#,##0.00', strtofloat(arr_qty));
end;

procedure TFrmBill.arrtobilldet;
var i: integer;
  vat: double;
begin
  for i := 1 to line_num do
  begin
    billdetail_arr[i].comp_id := comp_id;
    billdetail_arr[i].no := bill_no;
    billdetail_arr[i].line := i;
    billdetail_arr[i].goods_id := line_arr[i].Lblmat_num; //mat_num
    billdetail_arr[i].goods_prc := strtofloat(line_arr[i].Lblmat_price); //price
    billdetail_arr[i].goods_num := strtofloat(line_arr[i].EdtQty); //qty
    billdetail_arr[i].amt := strtofloat(line_arr[i].Lblamount); //amount
    vat := (7 / 107) * (strtofloat(formatfloat('#0.00', strtofloat(line_arr[i].Lblamount))));
    billdetail_arr[i].amt_vat := strtofloat(formatfloat('#0.00', vat)); //vat
    billdetail_arr[i].status  := status_bill; //status of bill
    billdetail_arr[i].load    := bill_load; //status load with sap
    billdetail_arr[i].promo   := line_arr[i].Promo;

  end;
end;

procedure TFrmBill.N16Click(Sender: TObject);
begin
  FrmReport3 := TFrmReport3.create(Application);
  FrmReport3.showModal;
  FrmReport3.Free;
end;

procedure TFrmBill.INVOICE1Click(Sender: TObject);
begin
  FrmReport4 := TFrmReport4.create(Application);
  FrmReport4.showModal;
  FrmReport4.Free;
end;

procedure TFrmBill.N17Click(Sender: TObject);
begin
  FrmReport1 := TFrmReport1.create(Application);
  FrmReport1.showModal;
  FrmReport1.Free;
end;

procedure TFrmBill.Action6Execute(Sender: TObject);
begin
  FrmReport2 := TFrmReport2.create(Application);
  FrmReport2.showModal;
  FrmReport2.Free;
end;

procedure TFrmBill.N7Click(Sender: TObject);
begin
  endday;
  Read_Control;
  Panel1.Visible := false;
end;

procedure TFrmBill.endday;
var
  sqls, day, day1: string;
begin
  sqls := 'SELECT * FROM CONTROL Where COMP_ID =''' + FrmBill.EdtComp_id.Text + '''';
  with FrmDatamodule.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sqls);
    Open;

    day := FieldByName('SALESDATE').AsString;
    day1 := FieldByName('TRANSFERDATE').AsString;
  end;
  if day = day1 then ShowMessage('มีการยกยอด ณ สิ้นวันไปแล้ว ไม่สามารถทำการยกยอดได้อีก')
  else
  begin
    ShowMessage('กรุณาทำการสำรองแฟ้มข้อมูลก่อนยกยอด ณ สิ้นวัน');
    SaveDialog1.Filename := FormatDateTime('YYMMDD', now) + 'billcash.mdb';
    if SaveDialog1.Execute then
    begin
      if FileExists(SaveDialog1.Filename) then
        if MessageDlg('Overwrite ' + SaveDialog1.FileName + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
          then deletefile(SaveDialog1.Filename);

      Frmdatamodule.ADOConnection.Close;
      copyFile(pchar('C:\CashSales\Database\billcash.mdb'), pchar(SaveDialog1.Filename), False);
      Frmdatamodule.ADOConnection.Open;
    end;
    FrmEndday := TFrmEndday.create(Application);
    FrmEndday.showModal;
    FrmEndday.Free;
  end;
end;

procedure TFrmBill.FormCreate(Sender: TObject);
begin

  BrDateForm := TBrDateForm.create(Application);
  FrmLogon := TFrmLogon.create(Application);
  FrmLogon.ShowModal;

  FrmBill.Caption := 'BILL '+ CK_Version;
end;

procedure TFrmBill.N9Click(Sender: TObject);
begin
  Panel1.Visible := false;
  FrmUnit := TFrmUnit.create(Application);
  FrmUnit.showModal;
  FrmUnit.Free;
end;

procedure TFrmBill.N10Click(Sender: TObject);
begin
  Panel1.Visible := false;
  FrmFG := TFrmFG.create(Application);
  FrmFG.showModal;
  FrmFG.Free;
end;

procedure TFrmBill.N11Click(Sender: TObject);
begin
  Panel1.Visible := false;
  FrmCompany := TFrmCompany.create(Application);
  FrmCompany.showModal;
  FrmCompany.Free;
end;

procedure TFrmBill.N12Click(Sender: TObject);
begin
  Panel1.Visible := false;
  FrmPrdGrp := TFrmPrdGrp.create(Application);
  FrmPrdGrp.showModal;
  FrmPrdGrp.Free;
end;

procedure TFrmBill.N13Click(Sender: TObject);
begin
  Panel1.Visible := false;
  FrmSalesman := TFrmSalesman.create(Application);
  FrmSalesman.showModal;
  FrmSalesman.Free;
end;

procedure TFrmBill.N14Click(Sender: TObject);
begin
  Panel1.Visible := false;
  FrmCust := TFrmCust.create(Application);
  FrmCust.showModal;
  FrmCust.Free;
end;

procedure TFrmBill.N2Click(Sender: TObject);
begin
  Panel1.Visible := false;
  FrmLoadtxt := TFrmLoadtxt.create(Application);
  FrmLoadtxt.showModal;
  FrmLoadtxt.Free;
end;

procedure TFrmBill.N3Click(Sender: TObject);
begin
  Panel1.Visible := false;
  SaveDialog1.Filename := FormatDateTime('YYMMDD', now) + 'billcash.mdb';
  if SaveDialog1.Execute then
  begin
    if FileExists(SaveDialog1.Filename) then
      if MessageDlg('Overwrite ' + SaveDialog1.FileName + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
        then deletefile(SaveDialog1.Filename);

    Frmdatamodule.ADOConnection.Close;
    copyFile(pchar('C:\CashSales\Database\billcash.mdb'), pchar(SaveDialog1.Filename), False);
    Frmdatamodule.ADOConnection.Open;
    ShowMessage('ทำการสำรองแฟ้มข้อมูลเรียบร้อยแล้ว');
  end;
end;

procedure TFrmBill.N4Click(Sender: TObject);
begin
  Panel1.Visible := false;
  if OpenDialog1.Execute then
  begin
    Frmdatamodule.ADOConnection.Close;
    if MessageDlg('คุณต้องการทีจะทำการเรียกคืนแฟ้ม ' + OpenDialog1.FileName + 'ใช่หรือไม่?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
      then begin
      copyFile(pchar(OpenDialog1.Filename), pchar('C:\CashSales\Database\billcash.mdb'), False);
      ShowMessage('ทำการเรียกคืนแฟ้มข้อมูลเรียบร้อยแล้ว');
    end;
    Frmdatamodule.ADOConnection.Open;
  end;
  Read_Control;
end;

procedure TFrmBill.N8Click(Sender: TObject);
var reps: word;
begin
  reps := MessageDlg('คุณต้องการออกจากระบบใช่หรือไม่', mtConfirmation, [mbYes, mbNo], 0);
  if reps = mrYes then
  begin
    Close;
    Application.Terminate;
  end;

end;

procedure TFrmBill.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in [#13,#39]  then
  begin
    SelectNext(ActiveControl, True, True);
    Key := #0;
  end;
{  else
  if Key in [#38]  then
  begin
    SelectNext(ActiveControl, false, True);
    Key := #0;
  end
}  ;

end;

function TFrmBill.have_mat2(PMat : string;var PMat_num,Pmat_barcode:String):boolean;
var sqls: string;

begin
{  Pmat_num := fillcharmat2(Trim(PMat));}
  Pmat_barcode := Trim(PMat);

  sqls := 'Select * From FINISH_GOODS Where FG_ID = ''' + Pmat +
       ''' OR FG_BAR_CODE = ''' + Pmat_barcode + ''' ';

  with FrmDatamodule.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sqls);
    Open;
  end;
  if FrmDatamodule.ADOQuery1.RecordCount > 0 then result := true
  else result := false;
end;

function TFrmBill.have_mat3(PMat : string;var PMat_num,Pmat_short:String):boolean;
var sqls: string;

begin
{  Pmat_num := fillcharmat2(Trim(PMat));}
  Pmat_short := Trim(PMat);

  sqls := 'Select * From FINISH_GOODS Where FG_ID = ''' + Pmat +
       ''' OR FG_SHORT = ''' + Pmat_short + ''' ';

  with FrmDatamodule.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sqls);
    Open;
  end;
  if FrmDatamodule.ADOQuery1.RecordCount > 0 then result := true
  else result := false;
end;

function TFrmBill.fillcharmat2(PMat : string):string;
begin
  if (Copy(PMat, 1, 1) = 'l') or (Copy(PMat, 1, 1) = 'L') then
  begin
    result := 'F' + PMat;
  end
  else if (Copy(PMat, 1, 1) = 'v') or (Copy(PMat, 1, 1) = 'V') then
  begin
    result := 'GCN' + PMat;
  end
  else if (Copy(PMat, 1, 1) <> 'f') and (Copy(PMat, 1, 1) <> 'F')
      and (Copy(PMat, 1, 1) <> 'g') and (Copy(PMat, 1, 1) <> 'G') then
  begin
    result := 'FCN' + PMat;
  end
  else result :=  PMat;
end;


Procedure TFrmBill.Set_line2(line:integer;  P_Qty,P_mat_num,P_mat_des,P_mat_unit,P_mat_price:string);
begin
  case Line of
  1:begin
      if EdtQty1.text = '' then EdtQty1.text := P_Qty;
      Lblmat_num1.Caption := P_mat_num;
      Lblmat_des1.Caption := P_mat_des;
      Lblmat_unit1.Caption := P_mat_unit;
      Lblmat_price1.Caption := P_mat_price;
      if P_Qty =''then Lblamount1.Caption := '';
    end;
  2:begin
      if EdtQty2.text = '' then EdtQty2.text := P_Qty;
      Lblmat_num2.Caption := P_mat_num;
      Lblmat_des2.Caption := P_mat_des;
      Lblmat_unit2.Caption := P_mat_unit;
      Lblmat_price2.Caption := P_mat_price;
      if P_Qty =''then Lblamount2.Caption := '';
    end;
  3:begin
      if EdtQty3.text = '' then EdtQty3.text := P_Qty;
      Lblmat_num3.Caption := P_mat_num;
      Lblmat_des3.Caption := P_mat_des;
      Lblmat_unit3.Caption := P_mat_unit;
      Lblmat_price3.Caption := P_mat_price;
      if P_Qty =''then Lblamount3.Caption := '';
    end;
  4:begin
      if EdtQty4.text = '' then EdtQty4.text := P_Qty;
      Lblmat_num4.Caption := P_mat_num;
      Lblmat_des4.Caption := P_mat_des;
      Lblmat_unit4.Caption := P_mat_unit;
      Lblmat_price4.Caption := P_mat_price;
      if P_Qty =''then Lblamount4.Caption := '';
    end;
  5:begin
      if EdtQty5.text = '' then EdtQty5.text := P_Qty;
      Lblmat_num5.Caption := P_mat_num;
      Lblmat_des5.Caption := P_mat_des;
      Lblmat_unit5.Caption := P_mat_unit;
      Lblmat_price5.Caption := P_mat_price;
      if P_Qty =''then Lblamount5.Caption := '';
    end;
  6:begin
      if EdtQty6.text = '' then EdtQty6.text := P_Qty;
      Lblmat_num6.Caption := P_mat_num;
      Lblmat_des6.Caption := P_mat_des;
      Lblmat_unit6.Caption := P_mat_unit;
      Lblmat_price6.Caption := P_mat_price;
      if P_Qty =''then Lblamount6.Caption := '';
    end;
  7:begin
      if EdtQty7.text = '' then EdtQty7.text := P_Qty;
      Lblmat_num7.Caption := P_mat_num;
      Lblmat_des7.Caption := P_mat_des;
      Lblmat_unit7.Caption := P_mat_unit;
      Lblmat_price7.Caption := P_mat_price;
      if P_Qty =''then Lblamount7.Caption := '';
    end;
  8:begin
      if EdtQty8.text = '' then EdtQty8.text := P_Qty;
      Lblmat_num8.Caption := P_mat_num;
      Lblmat_des8.Caption := P_mat_des;
      Lblmat_unit8.Caption := P_mat_unit;
      Lblmat_price8.Caption := P_mat_price;
      if P_Qty =''then Lblamount8.Caption := '';
    end;
  9:begin
      if EdtQty9.text = '' then EdtQty9.text := P_Qty;
      Lblmat_num9.Caption := P_mat_num;
      Lblmat_des9.Caption := P_mat_des;
      Lblmat_unit9.Caption := P_mat_unit;
      Lblmat_price9.Caption := P_mat_price;
      if P_Qty =''then Lblamount9.Caption := '';
    end;
  10:begin
      if EdtQty10.text = '' then EdtQty10.text := P_Qty;
      Lblmat_num10.Caption := P_mat_num;
      Lblmat_des10.Caption := P_mat_des;
      Lblmat_unit10.Caption := P_mat_unit;
      Lblmat_price10.Caption := P_mat_price;
      if P_Qty =''then Lblamount10.Caption := '';
    end;
  end;//case
end;


procedure TFrmBill.Edit_num_Change2(line:integer; var Edt_num_X :Tedit);
var Lmat_num ,Lmat_short,Lmat_barcode,Lmat_des, Lmat_unit,Lmat_grp: string;
    Lmat_price: double;
begin
  Lmat_num := Trim(Edt_num_X.Text);
  line := Edt_num_X.tag;
  if Trim(Edt_num_X.Text) = '' then
  begin
    Set_line2(line,'','','','','');
    chkarr_data;
  end
  else if (Trim(Edt_num_X.Text) <> '') and Have_mat2(Edt_num_X.Text,Lmat_num,Lmat_barcode) then
    begin
      ShowDatamat(Lmat_num, Lmat_des, Lmat_unit, Lmat_short, Lmat_barcode, Lmat_grp, Lmat_price);
      Set_line2(line,'1',Lmat_num,Lmat_des,Lmat_unit,formatfloat('#,##0.00', Lmat_price));
      Edt_num_X.Text := Lmat_barcode;    //รหัสถูกต้อง
      chkgrp := Lmat_grp;
    end
  else if (Trim(Edt_num_X.Text) <> '') and Have_mat3(Edt_num_X.Text,Lmat_num,Lmat_short) then
    begin
      ShowDatamat(Lmat_num, Lmat_des, Lmat_unit, Lmat_short, Lmat_barcode, Lmat_grp, Lmat_price);
      Set_line2(line,'1',Lmat_num,Lmat_des,Lmat_unit,formatfloat('#,##0.00', Lmat_price));
      Edt_num_X.Text := Lmat_num;    //รหัสถูกต้อง
      chkgrp := Lmat_grp;
    end

  else
  begin
    Edt_num_X.SetFocus;      //รหัสไม่ถูกต้อง
    Showmessage('รหัสไม่ถูกต้องกรุณาใส่อีกครั้ง');
  end;
  Caltotprice;
end;

function TFrmBill.passEdit_qty2:boolean;
begin

  result := passchkformatQty(EdtQty1, Edtmat_num1, Lblmat_price1, Lblamount1, 1)
        and passchkformatQty(EdtQty2, Edtmat_num2, Lblmat_price2, Lblamount2, 2)
        and passchkformatQty(EdtQty3, Edtmat_num3, Lblmat_price3, Lblamount3, 3)
        and passchkformatQty(EdtQty4, Edtmat_num4, Lblmat_price4, Lblamount4, 4)
        and passchkformatQty(EdtQty5, Edtmat_num5, Lblmat_price5, Lblamount5, 5)
        and passchkformatQty(EdtQty6, Edtmat_num6, Lblmat_price6, Lblamount6, 6)
        and passchkformatQty(EdtQty7, Edtmat_num7, Lblmat_price7, Lblamount7, 7)
        and passchkformatQty(EdtQty8, Edtmat_num8, Lblmat_price8, Lblamount8, 8)
        and passchkformatQty(EdtQty9, Edtmat_num9, Lblmat_price9, Lblamount9, 9)
        and passchkformatQty(EdtQty10, Edtmat_num10, Lblmat_price10, Lblamount10, 10);

end;


procedure TFrmBill.EdtQty1Exit(Sender: TObject);
begin
  passEdit_qty2;
end;

procedure TFrmBill.Edtmat_num2Exit(Sender: TObject);
begin
  Edit_num_Change2(2,Edtmat_num2);
end;

procedure TFrmBill.Edtmat_num3Exit(Sender: TObject);
begin
  Edit_num_Change2(3,Edtmat_num3);
end;

procedure TFrmBill.Edtmat_num4Exit(Sender: TObject);
begin
  Edit_num_Change2(4,Edtmat_num4);
end;

procedure TFrmBill.Edtmat_num5Exit(Sender: TObject);
begin
  Edit_num_Change2(5,Edtmat_num5);
end;

procedure TFrmBill.Edtmat_num6Exit(Sender: TObject);
begin
  Edit_num_Change2(6,Edtmat_num6);
end;

procedure TFrmBill.Edtmat_num7Exit(Sender: TObject);
begin
  Edit_num_Change2(7,Edtmat_num7);
end;

procedure TFrmBill.Edtmat_num8Exit(Sender: TObject);
begin
  Edit_num_Change2(8,Edtmat_num8);
end;

procedure TFrmBill.Edtmat_num9Exit(Sender: TObject);
begin
  Edit_num_Change2(9,Edtmat_num9);
end;

procedure TFrmBill.Edtmat_num10Exit(Sender: TObject);
begin
  Edit_num_Change2(10,Edtmat_num10);
end;

procedure TFrmBill.Edtmat_num1Change(Sender: TObject);
begin
  SetEnable;
end;

procedure TFrmBill.FormActivate(Sender: TObject);
begin
 //N15Click(self);
end;

procedure TFrmBill.Total_payExit(Sender: TObject);
var payamt, totamt : string;
begin
  if Total_pay.Text <> '' then
     begin
      payamt := Rem_comma(Total_pay.Text);
      totamt := Rem_comma(Gtot_Amt.Caption);
      amount := strtofloat(payamt) - strtofloat(totamt);
      Total_pay.Text  := formatfloat('#0.00', strtofloat(payamt));
      Chg_amt.Caption := formatfloat('#0.00', amount);
    end;
end;

procedure TFrmBill.N18Click(Sender: TObject);
begin
  Panel1.Visible := false;
  FrmPromo := TFrmPromo.create(Application);
  FrmPromo.showModal;
  FrmPromo.Free;
end;

procedure TFrmBill.Action7Execute(Sender: TObject);
begin
  CheckLine;
  FrmPROMOBILL.BILLNO.Text := Trim(LabelBill_No.Caption);
  if CUR_LINE  =  0 then
     CUR_LINE := CHK_LINE + 1;
  FrmPROMOBILL.chkline     :=  CHK_LINE;
  FrmPROMOBILL.curline     :=  CUR_LINE;
  FrmPROMOBILL.Visible     :=  True;
  FrmPROMOBILL.Show;
end;

procedure TFrmBill.CheckLine;
begin
  CHK_LINE  :=  0;
  CUR_LINE  :=  0;
  if ( Edtmat_num1.Text <> '' )  and ( Edtmat_num1.Enabled = True ) then CHK_LINE := CHK_LINE + 1;
  if ( Edtmat_num2.Text <> '' )  and ( Edtmat_num2.Enabled = True ) then CHK_LINE := CHK_LINE + 1;
  if ( Edtmat_num3.Text <> '' )  and ( Edtmat_num3.Enabled = True ) then CHK_LINE := CHK_LINE + 1;
  if ( Edtmat_num4.Text <> '' )  and ( Edtmat_num4.Enabled = True ) then CHK_LINE := CHK_LINE + 1;
  if ( Edtmat_num5.Text <> '' )  and ( Edtmat_num5.Enabled = True ) then CHK_LINE := CHK_LINE + 1;
  if ( Edtmat_num6.Text <> '' )  and ( Edtmat_num6.Enabled = True ) then CHK_LINE := CHK_LINE + 1;
  if ( Edtmat_num7.Text <> '' )  and ( Edtmat_num7.Enabled = True ) then CHK_LINE := CHK_LINE + 1;
  if ( Edtmat_num8.Text <> '' )  and ( Edtmat_num8.Enabled = True ) then CHK_LINE := CHK_LINE + 1;
  if ( Edtmat_num9.Text <> '' )  and ( Edtmat_num9.Enabled = True ) then CHK_LINE := CHK_LINE + 1;
  if ( Edtmat_num10.Text <> '' ) and ( Edtmat_num10.Enabled = True ) then CHK_LINE := CHK_LINE + 1;

  if ( Edtmat_num1.Text <> '' )  and ( Edtmat_num1.Enabled = False ) then CUR_LINE := 1 else
  if ( Edtmat_num2.Text <> '' )  and ( Edtmat_num2.Enabled = False ) then CUR_LINE := 2 else
  if ( Edtmat_num3.Text <> '' )  and ( Edtmat_num3.Enabled = False ) then CUR_LINE := 3 else
  if ( Edtmat_num4.Text <> '' )  and ( Edtmat_num4.Enabled = False ) then CUR_LINE := 4 else
  if ( Edtmat_num5.Text <> '' )  and ( Edtmat_num5.Enabled = False ) then CUR_LINE := 5 else
  if ( Edtmat_num6.Text <> '' )  and ( Edtmat_num6.Enabled = False ) then CUR_LINE := 6 else
  if ( Edtmat_num7.Text <> '' )  and ( Edtmat_num7.Enabled = False ) then CUR_LINE := 7 else
  if ( Edtmat_num8.Text <> '' )  and ( Edtmat_num8.Enabled = False ) then CUR_LINE := 8 else
  if ( Edtmat_num9.Text <> '' )  and ( Edtmat_num9.Enabled = False ) then CUR_LINE := 9 else
  if ( Edtmat_num10.Text <> '' ) and ( Edtmat_num10.Enabled = False ) then CUR_LINE :=10;

end;

Procedure TFrmBill.setenabled;
begin
  Edtmat_num1.Enabled  := True;
  Edtmat_num2.Enabled  := True;
  Edtmat_num3.Enabled  := True;
  Edtmat_num4.Enabled  := True;
  Edtmat_num5.Enabled  := True;
  Edtmat_num6.Enabled  := True;
  Edtmat_num7.Enabled  := True;
  Edtmat_num8.Enabled  := True;
  Edtmat_num9.Enabled  := True;
  Edtmat_num10.Enabled := True;
  EdtQty1.Enabled      := True;
  EdtQty2.Enabled      := True;
  EdtQty3.Enabled      := True;
  EdtQty4.Enabled      := True;
  EdtQty5.Enabled      := True;
  EdtQty6.Enabled      := True;
  EdtQty7.Enabled      := True;
  EdtQty8.Enabled      := True;
  EdtQty9.Enabled      := True;
  EdtQty10.Enabled     := True;
end;

Procedure TFrmBill.InsertBillPromo;
var sql_text, prono : string;
begin
  IF FrmPROMOBILL.promo_no1 <> '' then
     begin
        prono    := FrmPROMOBILL.promo_no1;
        sql_text := 'INSERT INTO BILL_PROMO' + #13 +
                    '(BILLH_COMP_ID, BILLH_NO, SEQ_NO, PRO_NO)' + #13 +
                    'VALUES ( ''' + comp_id + ''', ''' + Bill_no + ''', ''1'',''' + prono + ''' )';
        FrmDataModule.ADOQuery1.Close;
        FrmDataModule.ADOQuery1.SQL.Clear;
        FrmDataModule.ADOQuery1.SQL.Add(sql_text);
        FrmDataModule.ADOQuery1.ExecSQL;
     end;

  IF FrmPROMOBILL.promo_no2 <> '' then
     begin
        prono    := FrmPROMOBILL.promo_no2;
        sql_text := 'INSERT INTO BILL_PROMO' + #13 +
                    '(BILLH_COMP_ID, BILLH_NO, SEQ_NO, PRO_NO)' + #13 +
                    'VALUES ( ''' + comp_id + ''', ''' + Bill_no + ''', ''2'',''' + prono + ''' )';
        FrmDataModule.ADOQuery1.Close;
        FrmDataModule.ADOQuery1.SQL.Clear;
        FrmDataModule.ADOQuery1.SQL.Add(sql_text);
        FrmDataModule.ADOQuery1.ExecSQL;
     end;

  IF FrmPROMOBILL.promo_no3 <> '' then
     begin
        prono    := FrmPROMOBILL.promo_no3;
        sql_text := 'INSERT INTO BILL_PROMO' + #13 +
                    '(BILLH_COMP_ID, BILLH_NO, SEQ_NO, PRO_NO)' + #13 +
                    'VALUES ( ''' + comp_id + ''', ''' + Bill_no + ''', ''3'',''' + prono + ''' )';
        FrmDataModule.ADOQuery1.Close;
        FrmDataModule.ADOQuery1.SQL.Clear;
        FrmDataModule.ADOQuery1.SQL.Add(sql_text);
        FrmDataModule.ADOQuery1.ExecSQL;
     end;

end;

procedure TFrmBill.Action8Execute(Sender: TObject);
begin
  Total_pay.Text  :=  '0';
  Chg_amt.Caption :=  '0';
  Total_pay.SetFocus;
end;

procedure TFrmBill.Action9Execute(Sender: TObject);
begin
  FrmDiscount.Visible := True;
  FrmDiscount.show;
end;

end.
