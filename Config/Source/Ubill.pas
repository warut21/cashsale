{**********************************************}
{     Author : Ms.Nattaporn Sittichartburana.  }
{     Created date : August 31, 2004.          }
{     Modified date :                          }
{     Modifier :                               }
{**********************************************}
unit Ubill;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, ActnList, XPStyleActnCtrls, ActnMan,
  Mask;

type
  TBillLine = Record
    Edtmat_num : string;
    Lblmat_num : string;
    Lblmat_des : string;
    Lblmat_price : string;
    EdtQty : string;
    Lblmat_unit : string;
    Lblamount : string;
  end;

  TBill_SQL = Record
    sql_billdet : string;
  end;

  TBill_Detail = Record
    comp_id : string;
    no : string;
    line : longint;
    goods_id : string;      //mat_num
    goods_prc : double;     //price
    goods_num : double;     //qty
    amt : double;
    amt_vat : double;
    status : string;
    load : string;
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
    procedure Action1Execute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure N15Click(Sender: TObject);
    procedure Edtmat_num1KeyPress(Sender: TObject; var Key: Char);
    procedure EdtCust_IDKeyPress(Sender: TObject; var Key: Char);
    procedure BtnClearClick(Sender: TObject);
    procedure Edtmat_num2KeyPress(Sender: TObject; var Key: Char);
    procedure Edtmat_num3KeyPress(Sender: TObject; var Key: Char);
    procedure Edtmat_num4KeyPress(Sender: TObject; var Key: Char);
    procedure Edtmat_num5KeyPress(Sender: TObject; var Key: Char);
    procedure Edtmat_num6KeyPress(Sender: TObject; var Key: Char);
    procedure Edtmat_num7KeyPress(Sender: TObject; var Key: Char);
    procedure Edtmat_num8KeyPress(Sender: TObject; var Key: Char);
    procedure Edtmat_num9KeyPress(Sender: TObject; var Key: Char);
    procedure EdtQty2KeyPress(Sender: TObject; var Key: Char);
    procedure EdtQty3KeyPress(Sender: TObject; var Key: Char);
    procedure EdtQty4KeyPress(Sender: TObject; var Key: Char);
    procedure EdtQty5KeyPress(Sender: TObject; var Key: Char);
    procedure EdtQty7KeyPress(Sender: TObject; var Key: Char);
    procedure EdtQty8KeyPress(Sender: TObject; var Key: Char);
    procedure EdtQty9KeyPress(Sender: TObject; var Key: Char);
    procedure EdtQty6KeyPress(Sender: TObject; var Key: Char);
    procedure Edtmat_num1Exit(Sender: TObject);
    procedure EdtCust_IDExit(Sender: TObject);
    procedure Edtmat_num2Exit(Sender: TObject);
    procedure EdtQty2Exit(Sender: TObject);
    procedure Edtmat_num3Exit(Sender: TObject);
    procedure Edtmat_num4Exit(Sender: TObject);
    procedure Edtmat_num5Exit(Sender: TObject);
    procedure Edtmat_num6Exit(Sender: TObject);
    procedure Edtmat_num7Exit(Sender: TObject);
    procedure Edtmat_num8Exit(Sender: TObject);
    procedure Edtmat_num9Exit(Sender: TObject);
    procedure Edtmat_num10Exit(Sender: TObject);
    procedure EdtQty3Exit(Sender: TObject);
    procedure EdtQty4Exit(Sender: TObject);
    procedure EdtQty5Exit(Sender: TObject);
    procedure EdtQty6Exit(Sender: TObject);
    procedure EdtQty7Exit(Sender: TObject);
    procedure EdtQty8Exit(Sender: TObject);
    procedure EdtQty9Exit(Sender: TObject);
    procedure EdtQty1Exit(Sender: TObject);
    procedure EdtQty10Exit(Sender: TObject);
    procedure EdtQty1KeyPress(Sender: TObject; var Key: Char);
    procedure EdtQty10KeyPress(Sender: TObject; var Key: Char);
    procedure Edtmat_num10KeyPress(Sender: TObject; var Key: Char);
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

  private
    { Private declarations }
    mat_num, mat_des, mat_unit, mat_barcode, mat_grp : string;
    mat_price : double;
    price, qty : string;
    bill_date, sales_id : string;
    netprice, vat, tot_amount : double;
    amount : double;
    chkgrp : string;
    {declar  array}
    line_arr : array[1..10] of TBillLine;
    sql_arr : array[1..10] of TBill_SQL;    
    billdetail_arr : array[1..10] of TBill_Detail;
    sql_tbillh, sql_tcontrol : string;
    have_sql_tbillh, have_sql_tbilldet, have_sql_tcontrol, have_sql_tcontrol_c : integer;
    {procedure declaration}
    procedure ShowDatamat(var mat_num, FG_DES,FG_UNITS, FG_BAR_CODE, FG_GRP : string; var FG_PRICE : double);
    procedure BtnSetEnable(n : integer);
    procedure CalAmount(price, qty : string ; var amount : double);
    procedure Caltotprice;
    procedure Read_Control;      // read table control for display data
    procedure moverecord(i,j:integer);
    procedure chkarr_data;
    procedure edttoarr;
    procedure arrtoedt;
    procedure arrtobilldet;
    procedure count_rec;
    procedure fillcharmat;
//    procedure totrec_same(b : TEdit; qty , amount : double));
  public
    { Public declarations }
    chkactive : string;
    comp_id : string;
    bill_load : string;
    msg_err : string;
    {procedure declaration}
    procedure SetEnable;  //set ennable of edit&label
    procedure Cleardata;  //Clear data in edit&label
    procedure endday;
    procedure process_data;
    procedure process_billhead;
    procedure process_billdet;
    procedure process_control;
    procedure chkvalue_arrtolbl(a : TLabel ; arr_value : string);
    procedure chkvalue_arrtoedt(b : TEdit ; arr_qty : string);
    procedure chkformatQty(a,b : TEdit; c, d: TLabel; line : integer);
end;

var
  FrmBill: TFrmBill;
  line_num : integer;
  status_bill,status_print, bill_no : string;
implementation

uses Udatamodule, Uconfig, Ulogon, UThai2, UPrint, Ukey_billno, Ureport1,
  Ureport2, Ureport3, Ureport4, Uendday, Uunit, Ufg, Ucompany, Ugrp,
  Usalesman, Ucust, PickDate, Uposload;

{$R *.dfm}

procedure TFrmBill.Action1Execute(Sender: TObject);
var reps : word;
begin
    if line_num > 0 then
      begin
        reps := MessageDlg('คุณต้องการบันทึก หรือพิมพ์บิลก่อนออกจากรายการนี้ใช่หรือไม่',mtConfirmation,[mbYes,mbNo],0);
        if reps = mrNo then
          begin
            //Close;
            //Application.Terminate;
            Panel1.Visible:=false;
          end;
      end
    else
      begin
        reps := MessageDlg('คุณต้องการออกจากรายการนี้ใช่หรือไม่',mtConfirmation,[mbYes,mbNo],0);
        if reps = mrYes then
          begin
            //Close;
            //Application.Terminate;
            Panel1.Visible:=false;
          end;
      end;

end;

procedure TFrmBill.Read_Control;     // read table control for display data
var sqls: string; bill_id: integer;
begin
  sqls := 'Select * From CONTROL Where COMP_ID = '''+Trim(EdtComp_id.Text)+''' ';
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
        LabelSum.Caption := formatfloat('#,##0.00',FrmDatamodule.ADOQuery1.FieldValues['TODAY_AMT']);
        LabelAcc.Caption := formatfloat('#,##0.00',FrmDatamodule.ADOQuery1.FieldValues['ACCU_AMT']);
        bill_id := strtoint(Copy(FrmDatamodule.ADOQuery1.FieldValues['CUR_BILL_NO'], 4, 5));
        bill_id := bill_id+1;
        LabelBill_No.Caption := Copy(FrmDatamodule.ADOQuery1.FieldValues['CUR_BILL_NO'], 1, 3) + ThaiRight('00000'+inttostr(bill_id),5);
      end;
end;

procedure TFrmBill.FormShow(Sender: TObject);
var sqls,day,day1 : string;
begin

 if FrmLogon.pass = false then FrmBill.Close
 else
    begin//start
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
    if day <> day1 then bill_date := Formatdatetime('DD/MM/YYYY',StrToDate(FrmLogon.DateSales.Text))
    else
    bill_date := Formatdatetime('DD/MM/EEEE',StrToDate(FrmLogon.DateSales.Text));
    sales_id := Trim(FrmLogon.EdtSales_id.Text);

    LabelDate.Caption:= FrmLogon.DateSales.Text;
    LabelComp_name.Caption:= FrmLogon.LabelComp_name.Caption;
    LabelSales_id.Caption := sales_id;

    sqls := 'Select SALES_NAME From SALESMAN Where COMP_ID = '''+Trim(frmlogon.EdtComp_id.Text)+''' ' +
            'And SALES_ID = '''+TRIM(frmlogon.EdtSales_id.Text)+''' ';
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
    Cleardata;             //Clear data in edit&label  //set line_num = 0
    SetEnable;             //set ennable of edit&label
    EdtComp_id.Text := frmlogon.EdtComp_id.Text;
    Read_Control;           // read table control for display data
    Panel1.Visible:=false;
    FrmLogon.Free;
    end;//stop
end;

procedure TFrmBill.SetEnable;
begin
  EdtCust_ID.Enabled := true;
  BtnSave.Enabled := false;
  BtnPrint.Enabled := false;
  Edtmat_num1.Enabled := true;
  Edtmat_num2.Enabled := false;
  Edtmat_num3.Enabled := false;
  Edtmat_num4.Enabled := false;
  Edtmat_num5.Enabled := false;
  Edtmat_num6.Enabled := false;
  Edtmat_num7.Enabled := false;
  Edtmat_num8.Enabled := false;
  Edtmat_num9.Enabled := false;
  Edtmat_num10.Enabled := false;
  EdtQty1.Enabled := false;
  EdtQty2.Enabled := false;
  EdtQty3.Enabled := false;
  EdtQty4.Enabled := false;
  EdtQty5.Enabled := false;
  EdtQty6.Enabled := false;
  EdtQty7.Enabled := false;
  EdtQty8.Enabled := false;
  EdtQty9.Enabled := false;
  EdtQty10.Enabled := false;
end;

procedure TFrmBill.FormKeyPress(Sender: TObject; var Key: Char);
begin

  if key = #13 then
   begin
       selectnext(activecontrol,true,true);
       key:=#0;
   end;
end;

Procedure TfrmBill.ShowDatamat(var mat_num, FG_DES, FG_UNITS, FG_BAR_CODE, FG_GRP: string;var FG_PRICE : double);
var sqls : string;
begin
  sqls := 'Select * From FINISH_GOODS Where FG_ID = '''+mat_num+''' OR FG_BAR_CODE = '''+mat_barcode+''' ';
  with FrmDatamodule.ADOQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add(sqls);
      Open;
    end;
  if FrmDatamodule.ADOQuery1.RecordCount > 0 then
    begin
      FG_DES:= FrmDatamodule.ADOQuery1.FieldValues['FG_DES'];
      FG_UNITS:= FrmDatamodule.ADOQuery1.FieldValues['FG_UNITS'];
      FG_PRICE:= FrmDatamodule.ADOQuery1.FieldValues['FG_PRICE'];
      FG_BAR_CODE := FrmDatamodule.ADOQuery1.FieldValues['FG_BAR_CODE'];
      FG_GRP := FrmDatamodule.ADOQuery1.FieldValues['FG_GRP'];
      mat_num := FrmDatamodule.ADOQuery1.FieldValues['FG_ID'];
    end
  else
    Showmessage('รหัสไม่ถูกต้องกรุณาใส่อีกครั้ง');
end;

procedure TFrmBill.N15Click(Sender: TObject);
var
  sqls,day,day1 : string;
  d1,d2,d3:TDateTime;
  chked:integer;
  reps : word;
begin
    Read_Control;
    chked:=0;
    sqls := 'SELECT * FROM CONTROL Where COMP_ID ='''+EdtComp_id.Text+'''';
    with FrmDatamodule.ADOQuery1 do
      begin
      Close;
      SQL.Clear;
      SQL.Add(sqls);
      Open;
      day := fieldvalues['SALESDATE'];
      day1 := fieldvalues['TRANSFERDATE'];
      end;
    d1:=StrToDate(day);
    d2:=StrToDate(day1);
    d3:=StrToDate(bill_date);
    if (d1 <> d2) AND (d3 <> d1) then  chked:=1;  //ยังไม่ได้ยกยอด
    if (d1 = d2) AND (d3 <= d2) then  chked:=2;   //ยกยอดไปแล้วทำการขายในวันนั้นไม่ได้
    case chked of
      0: begin
         Panel1.Visible:=true;
         Edtmat_num1.SetFocus;
         end;
      1: begin
         reps := MessageDlg('!!!! ยังไม่ได้ทำการยกยอด ณ สิ้นวัน !!!!'+#13+'คุณต้องการทำการยกยอด ณ สิ้นวัน ใช่หรือไม่',mtConfirmation,[mbYes,mbNo],0);
         if reps = mrYes then
            begin
            endday;
            if FrmEndday.endfinish then Panel1.Visible:=true;
            Read_Control;
            end;
         end;
      2: showmessage('!!!! ไม่สามารถทำรายการขายในวันที่'+LabelDate.Caption+'ได้เนื่องจากมีการยกยอด ณ สิ้นวันไปแล้ว !!!!');
    end;
end;

procedure TFrmBill.Edtmat_num1KeyPress(Sender: TObject; var Key: Char);
begin
  BtnSetEnable(0);
  EdtQty1.Enabled := true;
  if key = #13 then
    begin
      key := #0;
      BtnSetEnable(1);
      EdtQty1.SetFocus;
//      EdtQty1.Text := '1';
    end;
end;

procedure TFrmBill.EdtCust_IDKeyPress(Sender: TObject; var Key: Char);
begin
//  Edtmat_num1.Enabled := true;
  If key = #13 then
    begin
      key := #0;
      Edtmat_num1.SetFocus;
    end;
end;

procedure TFrmBill.BtnClearClick(Sender: TObject);
begin
  Cleardata;
  SetEnable;  //set ennable of edit&label
  Edtmat_num1.SetFocus;
end;

procedure TFrmBill.Cleardata;
begin
  line_num := 0;
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
  LblNetprice.Caption := '0';
  LblVat.Caption := '0';
  LblTot_amount.Caption := '0';
  chkgrp:='';
  Edtmat_num1.SetFocus;
  end;

procedure TFrmBill.BtnSetEnable(n : integer);
begin
  if n = 1 then
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

procedure TFrmBill.Edtmat_num2KeyPress(Sender: TObject; var Key: Char);
begin
  BtnSetEnable(0);
  EdtQty2.Enabled := true;
  If key = #13 then
    begin
      key := #0;
      BtnSetEnable(1); 
      EdtQty2.SetFocus;
//      EdtQty2.Text := '1';
    end;
end;

procedure TFrmBill.Edtmat_num3KeyPress(Sender: TObject; var Key: Char);
begin
  BtnSetEnable(0);
  EdtQty3.Enabled := true;
  If key = #13 then
    begin
      key := #0;
      BtnSetEnable(1);
      EdtQty3.SetFocus;
//      EdtQty3.Text := '1';
    end;
end;

procedure TFrmBill.Edtmat_num4KeyPress(Sender: TObject; var Key: Char);
begin
  BtnSetEnable(0);
  EdtQty4.Enabled := true;
  If key = #13 then
    begin
      key := #0;
      BtnSetEnable(1);
      EdtQty4.SetFocus;
//      EdtQty4.Text := '1';
    end;
end;

procedure TFrmBill.Edtmat_num5KeyPress(Sender: TObject; var Key: Char);
begin
  BtnSetEnable(0);
  EdtQty5.Enabled := true;
  If key = #13 then
    begin
      key := #0;
      BtnSetEnable(1);
      EdtQty5.SetFocus;
//      EdtQty5.Text := '1';
    end;
end;

procedure TFrmBill.Edtmat_num6KeyPress(Sender: TObject; var Key: Char);
begin
  BtnSetEnable(0);
  EdtQty6.Enabled := true;
  If key = #13 then
    begin
      key := #0;
      BtnSetEnable(1);      
      EdtQty6.SetFocus;
//      EdtQty6.Text := '1';
    end;
end;

procedure TFrmBill.Edtmat_num7KeyPress(Sender: TObject; var Key: Char);
begin
  BtnSetEnable(0);
  EdtQty7.Enabled := true;
  If key = #13 then
    begin
      key := #0;
      BtnSetEnable(1);      
      EdtQty7.SetFocus;
//      EdtQty7.Text := '1';
    end;
end;

procedure TFrmBill.Edtmat_num8KeyPress(Sender: TObject; var Key: Char);
begin
  BtnSetEnable(0);
  EdtQty8.Enabled := true;
  If key = #13 then
    begin
      key := #0;
      BtnSetEnable(1);      
      EdtQty8.SetFocus;
//      EdtQty8.Text := '1';
    end;
end;

procedure TFrmBill.Edtmat_num9KeyPress(Sender: TObject; var Key: Char);
begin
  BtnSetEnable(0);
  EdtQty9.Enabled := true;
  If key = #13 then
    begin
      key := #0;
      BtnSetEnable(1);
      EdtQty9.SetFocus;
//      EdtQty9.Text := '1';
    end;
end;

procedure TFrmBill.EdtQty2KeyPress(Sender: TObject; var Key: Char);
begin
  Edtmat_num3.Enabled := true;
  If key = #13 then
    begin
      key := #0;
      Edtmat_num3.SetFocus;
    end;
end;

procedure TFrmBill.EdtQty3KeyPress(Sender: TObject; var Key: Char);
begin
  Edtmat_num4.Enabled := true;
  If key = #13 then
    begin
      key := #0;
      Edtmat_num4.SetFocus;
    end;
end;

procedure TFrmBill.EdtQty4KeyPress(Sender: TObject; var Key: Char);
begin
  Edtmat_num5.Enabled := true;
  If key = #13 then
    begin
      key := #0;
      Edtmat_num5.SetFocus;
    end;
end;

procedure TFrmBill.EdtQty5KeyPress(Sender: TObject; var Key: Char);
begin
  Edtmat_num6.Enabled := true;
  If key = #13 then
    begin
      key := #0;
      Edtmat_num6.SetFocus;
    end;
end;

procedure TFrmBill.EdtQty7KeyPress(Sender: TObject; var Key: Char);
begin
  Edtmat_num8.Enabled := true;
  If key = #13 then
    begin
      key := #0;
      Edtmat_num8.SetFocus;
    end;
end;

procedure TFrmBill.EdtQty8KeyPress(Sender: TObject; var Key: Char);
begin
  Edtmat_num9.Enabled := true;
  If key = #13 then
    begin
      key := #0;
      Edtmat_num9.SetFocus;
    end;
end;

procedure TFrmBill.EdtQty9KeyPress(Sender: TObject; var Key: Char);
begin
  Edtmat_num10.Enabled := true;
  If key = #13 then
    begin
      key := #0;
      Edtmat_num10.SetFocus;
    end;
end;

procedure TFrmBill.EdtQty6KeyPress(Sender: TObject; var Key: Char);
begin
  Edtmat_num7.Enabled := true;
  If key = #13 then
    begin
      key := #0;
      Edtmat_num7.SetFocus;
    end;
end;


procedure TFrmBill.CalAmount(price, qty : string; var amount : double);  //calculate amount
begin
  amount := strtofloat(qty)*strtofloat(price);
//  line_num := line_num+1;
end;

function PrintDirectLPT1(Data : string): Boolean;
var
  LPTHandle : THandle; // Handle of the print file
  B : array [1..1024] of Char;
begin
  FillChar(B,SizeOf(B),0);   // this should be faster
  Move(Data[1],B[1],Length(Data)); // this should also increase speed.
  LPTHandle := FileOpen('LPT1', fmOpenWrite);
  Result := FileWrite(LPTHandle, B, SizeOf(B)) <> -1;
  FileClose(LPTHandle);
end;



procedure TFrmBill.Edtmat_num1Exit(Sender: TObject);
begin

  if Trim(Edtmat_num1.Text) = '' then
    begin
//      line_num := line_num-1;
      EdtQty1.Clear;
      Lblmat_num1.Caption := '';
      Lblmat_des1.Caption := '';
      Lblmat_unit1.Caption := '';
      Lblmat_price1.Caption := '';
      LblAmount1.Caption := '';
      chkarr_data;
    end
  else
    begin

      mat_num := Trim(Edtmat_num1.Text);
      fillcharmat;
      mat_barcode := Trim(Edtmat_num1.Text);
      ShowDatamat(mat_num, mat_des, mat_unit, mat_barcode, mat_grp, mat_price);
      if FrmDatamodule.ADOQuery1.RecordCount = 0 then
        begin
          Edtmat_num1.SetFocus;
        end
      else
        begin
          if (mat_grp <> chkgrp) and (chkgrp <> '') then
            begin
            ShowMessage('สินค้าที่ขายต้องเป็นแผนกเดียวกันเท่านั้น');
            Edtmat_num1.Clear;
            Edtmat_num1.SetFocus;
            end
          else
            begin
            Edtmat_num1.Text := mat_barcode;
            Lblmat_num1.Caption := mat_num;
            Lblmat_des1.Caption := mat_des;
            Lblmat_unit1.Caption := mat_unit;
            Lblmat_price1.Caption := formatfloat('#,##0.00', mat_price);
            chkgrp := mat_grp;
            end;
        end;
    end;

    Caltotprice;
end;

procedure TFrmBill.EdtCust_IDExit(Sender: TObject);
var
  sqls:string;
begin
//  Edtmat_num1.Enabled := true;
  if Trim(EdtCust_ID.Text) = '' then
    begin
      Showmessage('กรุณาใส่รหัสลูกค้า');
      EdtCust_ID.SetFocus;
    end
  else
    begin
      sqls := 'Select CUST_NAME From CUSTOMER Where CUST_ID = '''+Trim(EdtCUST_ID.Text)+''' ';
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
          LabelCust_name.Caption:= FrmDatamodule.ADOQuery1.FieldValues['CUST_NAME'];
          EdtCust_ID.Enabled := false;
        end;
    end;
end;

procedure TFrmBill.fillcharmat;
begin
      if (Copy(mat_num, 1, 1) ='l') or (Copy(mat_num, 1, 1) ='L') then
        begin
          mat_num := 'F' + mat_num;
        end
      else if (Copy(mat_num, 1, 1) <> 'f') and (Copy(mat_num, 1, 1) ='F') and (Copy(mat_num, 1, 1) ='g') and (Copy(mat_num, 1, 1) ='G') then
        begin
          mat_num := 'FMN' + mat_num;
        end;
end;

procedure TFrmBill.Edtmat_num2Exit(Sender: TObject);
begin
  if Trim(Edtmat_num2.Text) = '' then
    begin
//      line_num := line_num-1;
      EdtQty2.Clear;
      Lblmat_num2.Caption := '';
      Lblmat_des2.Caption := '';
      Lblmat_unit2.Caption := '';
      Lblmat_price2.Caption := '';
      LblAmount2.Caption := '';
      chkarr_data;
    end
  else
    begin
      mat_num := Trim(Edtmat_num2.Text);
      fillcharmat;
      mat_barcode := Trim(Edtmat_num2.Text);
      ShowDatamat(mat_num, mat_des, mat_unit, mat_barcode, mat_grp, mat_price);
      if FrmDatamodule.ADOQuery1.RecordCount = 0 then
        begin
          Edtmat_num2.SetFocus;
        end
      else
        //***
        begin
        if (mat_grp <> chkgrp) and (chkgrp <> '') then
            begin
            ShowMessage('สินค้าที่ขายต้องเป็นแผนกเดียวกันเท่านั้น');
            Edtmat_num2.Clear;
            Edtmat_num2.SetFocus;
            end
        else
            begin
            Edtmat_num2.Text := mat_barcode;
            Lblmat_num2.Caption := mat_num;
            Lblmat_des2.Caption := mat_des;
            Lblmat_unit2.Caption := mat_unit;
            Lblmat_price2.Caption := formatfloat('#,##0.00', mat_price);
            chkgrp := mat_grp;
            end;
        end;
    end;

    Caltotprice;
end;

procedure TFrmBill.EdtQty2Exit(Sender: TObject);
begin
  chkformatQty(EdtQty2, Edtmat_num2, Lblmat_price2 ,Lblamount2, 2);
end;

procedure TFrmBill.Edtmat_num3Exit(Sender: TObject);
begin
  if Trim(Edtmat_num3.Text) = '' then
    begin
//      line_num := line_num-1;
      EdtQty3.Clear;
      Lblmat_num3.Caption := '';
      Lblmat_des3.Caption := '';
      Lblmat_unit3.Caption := '';
      Lblmat_price3.Caption := '';
      LblAmount3.Caption := '';
      chkarr_data;
    end
  else
    begin
      mat_num := Trim(Edtmat_num3.Text);
      fillcharmat;      
      mat_barcode := Trim(Edtmat_num3.Text);
      ShowDatamat(mat_num, mat_des, mat_unit, mat_barcode, mat_grp, mat_price);
      if FrmDatamodule.ADOQuery1.RecordCount = 0 then
        begin
          Edtmat_num3.SetFocus;
        end
      else
        begin
          if (mat_grp <> chkgrp) and (chkgrp <> '') then
            begin
            ShowMessage('สินค้าที่ขายต้องเป็นแผนกเดียวกันเท่านั้น');
            Edtmat_num3.Clear;
            Edtmat_num3.SetFocus;
            end
          else
            begin
            Edtmat_num3.Text := mat_barcode;
            Lblmat_num3.Caption := mat_num;
            Lblmat_des3.Caption := mat_des;
            Lblmat_unit3.Caption := mat_unit;
            Lblmat_price3.Caption := formatfloat('#,##0.00', mat_price);
            chkgrp := mat_grp;
            end;
        end;
    end;

    Caltotprice;
end;

procedure TFrmBill.Edtmat_num4Exit(Sender: TObject);
begin
  if Trim(Edtmat_num4.Text) = '' then
    begin
//      line_num := line_num-1;
      EdtQty4.Clear;
      Lblmat_num4.Caption := '';
      Lblmat_des4.Caption := '';
      Lblmat_unit4.Caption := '';
      Lblmat_price4.Caption := '';
      LblAmount4.Caption := '';
      chkarr_data;
    end
  else
    begin
      mat_num := Trim(Edtmat_num4.Text);
      fillcharmat;      
      mat_barcode := Trim(Edtmat_num4.Text);
      ShowDatamat(mat_num, mat_des, mat_unit, mat_barcode, mat_grp, mat_price);
      if FrmDatamodule.ADOQuery1.RecordCount = 0 then
        begin
          Edtmat_num4.SetFocus;
        end
      else
        begin
          if (mat_grp <> chkgrp) and (chkgrp <> '') then
            begin
            ShowMessage('สินค้าที่ขายต้องเป็นแผนกเดียวกันเท่านั้น');
            Edtmat_num4.Clear;
            Edtmat_num4.SetFocus;
            end
          else
            begin
            Edtmat_num4.Text := mat_barcode;
            Lblmat_num4.Caption := mat_num;
            Lblmat_des4.Caption := mat_des;
            Lblmat_unit4.Caption := mat_unit;
            Lblmat_price4.Caption := formatfloat('#,##0.00', mat_price);
            chkgrp := mat_grp;
            end;
        end;
    end;

    Caltotprice;     
end;

procedure TFrmBill.Edtmat_num5Exit(Sender: TObject);
begin
  if Trim(Edtmat_num5.Text) = '' then
    begin
//      line_num := line_num-1;
      EdtQty5.Clear;
      Lblmat_num5.Caption := '';
      Lblmat_des5.Caption := '';
      Lblmat_unit5.Caption := '';
      Lblmat_price5.Caption := '';
      LblAmount5.Caption := '';
      chkarr_data;
    end
  else
    begin
      mat_num := Trim(Edtmat_num5.Text);
      fillcharmat;      
      mat_barcode := Trim(Edtmat_num5.Text);
      ShowDatamat(mat_num, mat_des, mat_unit, mat_barcode, mat_grp, mat_price);
      if FrmDatamodule.ADOQuery1.RecordCount = 0 then
        begin
          Edtmat_num5.SetFocus;
        end
      else
        begin
          if (mat_grp <> chkgrp) and (chkgrp <> '') then
            begin
            ShowMessage('สินค้าที่ขายต้องเป็นแผนกเดียวกันเท่านั้น');
            Edtmat_num5.Clear;
            Edtmat_num5.SetFocus;
            end
          else
            begin
            Edtmat_num5.Text := mat_barcode;
            Lblmat_num5.Caption := mat_num;
            Lblmat_des5.Caption := mat_des;
            Lblmat_unit5.Caption := mat_unit;
            Lblmat_price5.Caption := formatfloat('#,##0.00', mat_price);
            chkgrp := mat_grp;
            end;
        end;
    end;

    Caltotprice;     
end;

procedure TFrmBill.Edtmat_num6Exit(Sender: TObject);
begin
  if Trim(Edtmat_num6.Text) = '' then
    begin
//      line_num := line_num-1;
      EdtQty6.Clear;
      Lblmat_num6.Caption := '';
      Lblmat_des6.Caption := '';
      Lblmat_unit6.Caption := '';
      Lblmat_price6.Caption := '';
      LblAmount6.Caption := '';
      chkarr_data;
    end
  else
    begin
      mat_num := Trim(Edtmat_num6.Text);
      fillcharmat;      
      mat_barcode := Trim(Edtmat_num6.Text);
      ShowDatamat(mat_num, mat_des, mat_unit, mat_barcode, mat_grp, mat_price);
      if FrmDatamodule.ADOQuery1.RecordCount = 0 then
        begin
          Edtmat_num6.SetFocus;
        end
      else
        begin
          if (mat_grp <> chkgrp) and (chkgrp <> '') then
            begin
            ShowMessage('สินค้าที่ขายต้องเป็นแผนกเดียวกันเท่านั้น');
            Edtmat_num6.Clear;
            Edtmat_num6.SetFocus;
            end
          else
            begin
            Edtmat_num6.Text := mat_barcode;
            Lblmat_num6.Caption := mat_num;
            Lblmat_des6.Caption := mat_des;
            Lblmat_unit6.Caption := mat_unit;
            Lblmat_price6.Caption := formatfloat('#,##0.00', mat_price);
            chkgrp := mat_grp;
            end;
        end;
    end;

    Caltotprice;     
end;

procedure TFrmBill.Edtmat_num7Exit(Sender: TObject);
begin
  if Trim(Edtmat_num7.Text) = '' then
    begin
//      line_num := line_num-1;
      EdtQty7.Clear;
      Lblmat_num7.Caption := '';
      Lblmat_des7.Caption := '';
      Lblmat_unit7.Caption := '';
      Lblmat_price7.Caption := '';
      LblAmount7.Caption := '';
      chkarr_data;
    end
  else
    begin
      mat_num := Trim(Edtmat_num7.Text);
      fillcharmat;      
      mat_barcode := Trim(Edtmat_num7.Text);
      ShowDatamat(mat_num, mat_des, mat_unit, mat_barcode, mat_grp, mat_price);
      if FrmDatamodule.ADOQuery1.RecordCount = 0 then
        begin
          Edtmat_num7.SetFocus;
        end
      else
        begin
          if (mat_grp <> chkgrp) and (chkgrp <> '') then
            begin
            ShowMessage('สินค้าที่ขายต้องเป็นแผนกเดียวกันเท่านั้น');
            Edtmat_num7.Clear;
            Edtmat_num7.SetFocus;
            end
          else
            begin
            Edtmat_num7.Text := mat_barcode;
            Lblmat_num7.Caption := mat_num;
            Lblmat_des7.Caption := mat_des;
            Lblmat_unit7.Caption := mat_unit;
            Lblmat_price7.Caption := formatfloat('#,##0.00', mat_price);
            chkgrp := mat_grp;
            end;
        end;
    end;

    Caltotprice;
end;

procedure TFrmBill.Edtmat_num8Exit(Sender: TObject);
begin
  if Trim(Edtmat_num8.Text) = '' then
    begin
//      line_num := line_num-1;
      EdtQty8.Clear;
      Lblmat_num8.Caption := '';
      Lblmat_des8.Caption := '';
      Lblmat_unit8.Caption := '';
      Lblmat_price8.Caption := '';
      LblAmount8.Caption := '';
      chkarr_data;
    end
  else
    begin
      mat_num := Trim(Edtmat_num8.Text);
      fillcharmat;      
      mat_barcode := Trim(Edtmat_num8.Text);
      ShowDatamat(mat_num, mat_des, mat_unit, mat_barcode, mat_grp, mat_price);
      if FrmDatamodule.ADOQuery1.RecordCount = 0 then
        begin
          Edtmat_num8.SetFocus;
        end
      else
        begin
          if (mat_grp <> chkgrp) and (chkgrp <> '') then
            begin
            ShowMessage('สินค้าที่ขายต้องเป็นแผนกเดียวกันเท่านั้น');
            Edtmat_num8.Clear;
            Edtmat_num8.SetFocus;
            end
          else
            begin
            Edtmat_num8.Text := mat_barcode;
            Lblmat_num8.Caption := mat_num;
            Lblmat_des8.Caption := mat_des;
            Lblmat_unit8.Caption := mat_unit;
            Lblmat_price8.Caption := formatfloat('#,##0.00', mat_price);
            chkgrp := mat_grp;
            end;
        end;
    end;

    Caltotprice;
end;

procedure TFrmBill.Edtmat_num9Exit(Sender: TObject);
begin
  if Trim(Edtmat_num9.Text) = '' then
    begin
//      line_num := line_num-1;
      EdtQty9.Clear;
      Lblmat_num9.Caption := '';
      Lblmat_des9.Caption := '';
      Lblmat_unit9.Caption := '';
      Lblmat_price9.Caption := '';
      LblAmount9.Caption := '';
      chkarr_data;
    end
  else
    begin
      mat_num := Trim(Edtmat_num9.Text);
      fillcharmat;      
      mat_barcode := Trim(Edtmat_num9.Text);
      ShowDatamat(mat_num, mat_des, mat_unit, mat_barcode, mat_grp, mat_price);
      if FrmDatamodule.ADOQuery1.RecordCount = 0 then
        begin
          Edtmat_num9.SetFocus;
        end
      else
        begin
          if (mat_grp <> chkgrp) and (chkgrp <> '') then
            begin
            ShowMessage('สินค้าที่ขายต้องเป็นแผนกเดียวกันเท่านั้น');
            Edtmat_num9.Clear;
            Edtmat_num9.SetFocus;
            end
          else
            begin
            Edtmat_num9.Text := mat_barcode;
            Lblmat_num9.Caption := mat_num;
            Lblmat_des9.Caption := mat_des;
            Lblmat_unit9.Caption := mat_unit;
            Lblmat_price9.Caption := formatfloat('#,##0.00', mat_price);
            chkgrp := mat_grp;
            end;
        end;
    end;

    Caltotprice;
end;

procedure TFrmBill.Edtmat_num10Exit(Sender: TObject);
begin
  if Trim(Edtmat_num10.Text) = '' then
    begin
//      line_num := line_num-1;
      EdtQty10.Clear;
      Lblmat_num10.Caption := '';
      Lblmat_des10.Caption := '';
      Lblmat_unit10.Caption := '';
      Lblmat_price10.Caption := '';
      LblAmount10.Caption := '';
      chkarr_data;
    end
  else
    begin
      mat_num := Trim(Edtmat_num10.Text);
      fillcharmat;      
      mat_barcode := Trim(Edtmat_num10.Text);
      ShowDatamat(mat_num, mat_des, mat_unit, mat_barcode, mat_grp, mat_price);
      if FrmDatamodule.ADOQuery1.RecordCount = 0 then
        begin
          Edtmat_num10.SetFocus;
        end
      else
        begin
          if (mat_grp <> chkgrp) and (chkgrp <> '') then
            begin
            ShowMessage('สินค้าที่ขายต้องเป็นแผนกเดียวกันเท่านั้น');
            Edtmat_num10.Clear;
            Edtmat_num10.SetFocus;
            end
          else
            begin
            Edtmat_num10.Text := mat_barcode;
            Lblmat_num10.Caption := mat_num;
            Lblmat_des10.Caption := mat_des;
            Lblmat_unit10.Caption := mat_unit;
            Lblmat_price10.Caption := formatfloat('#,##0.00', mat_price);
            chkgrp := mat_grp;
            end;
        end;
    end;

    Caltotprice;
end;

procedure TFrmBill.EdtQty3Exit(Sender: TObject);
begin
  chkformatQty(EdtQty3, Edtmat_num3, Lblmat_price3 ,Lblamount3, 3);
end;

procedure TFrmBill.EdtQty4Exit(Sender: TObject);
begin
  chkformatQty(EdtQty4, Edtmat_num4, Lblmat_price4 ,Lblamount4, 4);
end;

procedure TFrmBill.EdtQty5Exit(Sender: TObject);
begin
  chkformatQty(EdtQty5, Edtmat_num5, Lblmat_price5 ,Lblamount5, 5);
end;

procedure TFrmBill.EdtQty6Exit(Sender: TObject);
begin
  chkformatQty(EdtQty6, Edtmat_num6, Lblmat_price6 ,Lblamount6, 6);
end;

procedure TFrmBill.EdtQty7Exit(Sender: TObject);
begin
  chkformatQty(EdtQty7, Edtmat_num7, Lblmat_price7 ,Lblamount7, 7);
end;

procedure TFrmBill.EdtQty8Exit(Sender: TObject);
begin
  chkformatQty(EdtQty8, Edtmat_num8, Lblmat_price8 ,Lblamount8, 8);
end;

procedure TFrmBill.EdtQty9Exit(Sender: TObject);
begin
  chkformatQty(EdtQty9, Edtmat_num9, Lblmat_price9 ,Lblamount9, 9);
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

  vat := tot_amount*(7/107);
  netprice := tot_amount-vat;
  LblNetprice.Caption := formatfloat('#,##0.00', netprice);
  LblVat.Caption := formatfloat('#,##0.00', vat);
  LblTot_amount.Caption := formatfloat('#,##0.00', tot_amount);
end;

procedure TFrmBill.EdtQty1Exit(Sender: TObject);
begin
  chkformatQty(EdtQty1, Edtmat_num1, Lblmat_price1 , Lblamount1, 1);
end;

procedure TFrmBill.EdtQty10Exit(Sender: TObject);
begin
  chkformatQty(EdtQty10, Edtmat_num10, Lblmat_price10, Lblamount10, 10);
end;

procedure TFrmBill.EdtQty1KeyPress(Sender: TObject; var Key: Char);
begin
  Edtmat_num2.Enabled := true;
  If key = #13 then
    begin
      key := #0;
      Edtmat_num2.SetFocus;
    end;
end;

procedure TFrmBill.EdtQty10KeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
    begin
      key := #0;
      BtnSave.Enabled:=true;
      BtnSave.SetFocus;
    end;
end;


procedure TFrmBill.Edtmat_num10KeyPress(Sender: TObject; var Key: Char);
begin
  BtnSetEnable(0);
  EdtQty10.Enabled := true;
  If key = #13 then
    begin
      key := #0;
      BtnSetEnable(1);
      EdtQty10.SetFocus;
//      EdtQty10.Text := '1';
    end;
end;

procedure TFrmBill.Action2Execute(Sender: TObject);
begin
  if BtnPrint.Enabled = true then
    begin
      bill_no := Trim(LabelBill_No.Caption);
      status_bill := 'A';
      status_print := '0';
      process_data;         //save data in table BILL_HEAD
      if generate_print_bill(comp_id,bill_no,msg_err) = true then
        begin
          status_print := '1';
          process_data;       //save data in table BILL_HEAD ch status print =1
        end
      else
        begin
          MessageDlg(msg_err, mtError	,[mbok],0);
        end;
    end;
end;

procedure TFrmBill.process_billhead;
var cust_id :string;
    amt, vats : string;
begin
  cust_id := Trim(EdtCust_id.Text);
  amt := formatfloat('#0.00' , strtofloat(LblTot_amount.Caption));
  vats := formatfloat('#0.00' , vat);

  if (status_bill = 'A') then
    begin
    //update table BILL_HEAD
      if (FrmDatamodule.ADOQuery2.RecordCount = 0) then
        begin
          sql_tbillh := 'INSERT INTO BILL_HEAD' +#13+
                        '(BILLH_COMP_ID, BILLH_NO, BILLH_DATE, BILLH_CUST_ID, BILLH_SALES_ID, BILLH_FG_GRP, BILLH_NUM, BILLH_AMT, BILLH_AMT_VAT, BILLH_STATUS, BILLH_PRINT, BILLH_LOAD )' +
                        'VALUES ('''+comp_id+''', '''+bill_no+''', DateValue('''+bill_date+'''), '''+cust_id+''', '''+sales_id+''', '''+chkgrp+''','''+intTostr(line_num)+''', '''+amt+''', '''+vats+''', '''+status_bill+''', '''+status_print+''', '''+bill_load+''')';
          have_sql_tbillh := 1;
        end
      else
        begin
          if  status_print <> FrmDatamodule.ADOQuery2.FieldValues['BILLH_PRINT'] then
            begin
              sql_tbillh := 'UPDATE BILL_HEAD '+
                            'SET BILLH_PRINT = '''+status_print+''' '+
                           'WHERE BILLH_COMP_ID = '''+comp_id+''' and BILLH_NO = '''+bill_no+''' ' ;
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
              Showmessage('เลขที่บิล '''+bill_no+''' ได้ถูก CANCEL เรียบร้อยแล้ว');
            end
          else
            begin
              sql_tbillh := 'UPDATE BILL_HEAD' +#13+
                            'SET BILLH_STATUS = ''C'''  +#13+
                            'WHERE BILLH_COMP_ID = '''+comp_id+''' and BILLH_NO = '''+bill_no+''' ' ;
          have_sql_tbillh := 1;

            end;
        end;
    end;
end;

procedure TFrmBill.process_control;
var //sql_update : string;
    today_bill : longint;
    today_amt : double;
    today_bill_c : longint;
    today_amt_c : double;
    amt : double;
begin
  if (FrmDatamodule.ADOQuery5.RecordCount > 0) then
    begin
    //update table CONTROL
      if (status_bill = 'A') then
        begin
          amt := strtofloat(formatfloat('#0.00' , strtofloat(LblTot_amount.Caption)));
          today_bill := FrmDatamodule.ADOQuery5.FieldValues['TODAY_BILL']+1;
          today_amt := FrmDatamodule.ADOQuery5.FieldValues['TODAY_AMT']+amt;
          sql_tcontrol := 'UPDATE CONTROL' +#13+
                        'SET CUR_BILL_NO = '''+bill_no+''',TODAY_BILL = '''+inttostr(today_bill)+''',TODAY_AMT = '''+floattostr(today_amt)+''', SALESDATE = '''+bill_date+'''  ' +
                        'WHERE COMP_ID = '''+comp_id+''' ' ;
        end  //end status_bill = 'A'
      else   //status_bill = 'C'
        begin
          amt := strtofloat(formatfloat('#0.00' , FrmDatamodule.ADOQuery2.FieldValues['BILLH_AMT']));
          today_bill_c := FrmDatamodule.ADOQuery5.FieldValues['TODAY_BILL_C']+1;
          today_amt_c := FrmDatamodule.ADOQuery5.FieldValues['TODAY_AMT_C']+amt;
          today_bill := FrmDatamodule.ADOQuery5.FieldValues['TODAY_BILL']-1;
          today_amt := FrmDatamodule.ADOQuery5.FieldValues['TODAY_AMT']-amt;

          sql_tcontrol := 'UPDATE CONTROL'+
                          ' SET TODAY_BILL_C = '''+inttostr(today_bill_c)+''', TODAY_AMT_C = '''+floattostr(today_amt_c)+''' '+
                          ', TODAY_BILL = '''+inttostr(today_bill)+''', TODAY_AMT = '''+floattostr(today_amt)+''' '+
                        'WHERE COMP_ID = '''+comp_id+''' ' ;

          have_sql_tcontrol_c := 1;

        end; // status_bill ='C'

      have_sql_tcontrol := 1;

    end; // FrmDatamodule.ADOQuery5.RecordCount > 0
end;


procedure TFrmBill.process_billdet;
var sql_billd : string;
    i : integer;
begin

  for i := 1 to line_num do
    begin
      if (status_bill = 'A') then
        begin
        //insert table BILL_DETAIL
          sql_arr[i].sql_billdet := 'INSERT INTO BILL_DETAIL' +#13+
                        '(BILLD_COMP_ID, BILLD_NO, BILLD_LINE, BILLD_GOODS_ID, BILLD_GOODS_PRC, BILLD_GOODS_NUM, BILLD_AMT, BILLD_AMT_VAT, BILLD_STATUS, BILLD_LOAD)' +#13+
                        'VALUES ('''+comp_id+''', '''+bill_no+''', '''+inttostr(i)+''', '''+billdetail_arr[i].goods_id+''', '''+floattostr(billdetail_arr[i].goods_prc)+''', '''+floattostr(billdetail_arr[i].goods_num)+''', '''+floattostr(billdetail_arr[i].amt)+''', '''+floattostr(billdetail_arr[i].amt_vat)+''', '''+billdetail_arr[i].status+''', '''+billdetail_arr[i].load+''' )' ;
          if i = line_num then
            have_sql_tbilldet := 1;

        end // status = 'A'
      else if (status_bill = 'C') then
        begin
          sql_billd := 'Select * From BILL_DETAIL Where BILLD_COMP_ID = '''+comp_id+''' and BILLD_NO = '''+bill_no+''' and BILLD_LINE = '+inttostr(i)  ;
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
                  Showmessage('เลขที่บิล '''+bill_no+''' ได้ถูก CANCEL เรียบร้อยแล้ว');
                end
              else
                begin
                  sql_arr[i].sql_billdet := 'UPDATE BILL_DETAIL SET BILLD_STATUS = '''+status_bill+''' '+
                                            'WHERE BILLD_COMP_ID = '''+comp_id+''' and BILLD_NO = '''+bill_no+''' and BILLD_LINE = '+inttostr(i) ;
                  if i = line_num then
                    have_sql_tbilldet := 1;

                end;
            end;    //end  FrmDatamodule.ADOQuery3.RecordCount > 0

        end;    //end status == 'c'
    end;  //end loop for
end;

procedure TFrmBill.Action3Execute(Sender: TObject);
//var msg_err : string;
//    bill_no : string;
begin
  if BtnSave.Enabled = true then
    begin
      bill_no := Trim(LabelBill_No.Caption);
      status_bill := 'A';
      status_print := '0';
      process_data;         //save data in table BILL_HEAD
    end;
end;

procedure TFrmBill.Action5Execute(Sender: TObject);
begin
  chkactive := 'cancel' ;
  FrmKeybillno := TFrmKeybillno.create(Application);
  FrmKeybillno.Label1.Caption := 'รายการ CANCEL'  ;
  FrmKeybillno.ShowModal;
  FrmKeybillno.Free;
end;

procedure TFrmBill.Action4Execute(Sender: TObject);
begin
  chkactive := 'reprint' ;
  FrmKeybillno := TFrmKeybillno.create(Application);
  FrmKeybillno.Label1.Caption := 'รายการ REPRINT'  ;
  FrmKeybillno.ShowModal;
  FrmKeybillno.Free;
end;

procedure TFrmBill.process_data;
var Level, i : integer;
    sql_billh : string;
    sql_control : string;
begin
  have_sql_tbillh := 0;
  have_sql_tbilldet := 0;
  have_sql_tcontrol := 0;
  have_sql_tcontrol_c := 0;

  count_rec;
  sql_billh := 'Select * From BILL_HEAD Where BILLH_COMP_ID = '''+comp_id+''' and BILLH_NO = '''+bill_no+''' ' ;
  with FrmDatamodule.ADOQuery2 do
    begin
      Close;
      SQL.Clear;
      SQL.Add(sql_billh);
      Open;
    end;

  arrtobilldet;    //get value to array billdetail

  sql_control := 'Select * From CONTROL Where COMP_ID = '''+comp_id+''' ' ;
  with FrmDatamodule.ADOQuery5 do
    begin
      Close;
      SQL.Clear;
      SQL.Add(sql_control);
      Open;
    end;

  Process_billhead;
  Process_billdet; //update table BILL_DETAIL
  Process_control;


  Level := FrmDataModule.ADOConnection.BeginTrans;
  try
    if have_sql_tbillh = 1 then
      begin
        with FrmDatamodule.ADOQuery1 do
          begin
            Close;
            SQL.Clear;
            SQL.Add(sql_tbillh);
            ExecSQL;
          end;
      end;

  if status_print = '0' then
    begin
      if have_sql_tbilldet = 1 then
        begin
          for i := 1 to line_num do
            begin
            with FrmDatamodule.ADOQuery1 do
              begin
                Close;
                SQL.Clear;
                SQL.Add(sql_arr[i].sql_billdet);
                ExecSQL;
              end;
            end;
        end;
      if have_sql_tcontrol = 1 then
        begin
          with FrmDatamodule.ADOQuery1 do
            begin
              Close;
              SQL.Clear;
              SQL.Add(sql_tcontrol);
              ExecSQL;
            end;
        end;

    end;
    have_sql_tbillh := 0;
    have_sql_tbilldet := 0;
    have_sql_tcontrol := 0;
    have_sql_tcontrol_c := 0;
    FrmDataModule.ADOConnection.CommitTrans;

    Read_Control;
    Cleardata;             //Clear data in edit&label
    SetEnable;             //set ennable of edit&label

  except
    on E:Exception do
    begin
      FrmDataModule.ADOConnection.RollbackTrans;
      Showmessage('test rollback no commit');
    end;
  end;
end;

procedure TFrmBill.chkarr_data;
var i,j : integer;
begin
  edttoarr;
  for i := 1 to 9 do
    begin
      if line_arr[i].Edtmat_num = '' then
        begin
          j := i+1;
          while j <= 10 do
            begin
              if line_arr[j].Edtmat_num <> '' then
                begin
                  moverecord(i, j);
                  j := 11;
                end;
              j:= j+1;
            end;
        end;
    end;

  count_rec;
  arrtoedt;
  if line_num = 0 then BtnSetEnable(0);
end;

procedure TFrmBill.count_rec;
var i : integer;
begin
  line_num := 0;
  for i:=1 to 10 do
    begin
      if line_arr[i].Edtmat_num <> '' then
        line_num := line_num+1;
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

  Edtmat_num2.Text := line_arr[2].Edtmat_num;
  Lblmat_num2.Caption := line_arr[2].Lblmat_num;
  Lblmat_des2.Caption := line_arr[2].Lblmat_des;
  chkvalue_arrtolbl(Lblmat_price2, line_arr[2].Lblmat_price);
  chkvalue_arrtolbl(Lblamount2, line_arr[2].Lblamount);
  chkvalue_arrtoedt(EdtQty2, line_arr[2].EdtQty);
  Lblmat_unit2.Caption := line_arr[2].Lblmat_unit;

  Edtmat_num3.Text := line_arr[3].Edtmat_num;
  Lblmat_num3.Caption := line_arr[3].Lblmat_num;
  Lblmat_des3.Caption := line_arr[3].Lblmat_des;
  chkvalue_arrtolbl(Lblmat_price3, line_arr[3].Lblmat_price);
  chkvalue_arrtolbl(Lblamount3, line_arr[3].Lblamount);
  chkvalue_arrtoedt(EdtQty3, line_arr[3].EdtQty);
  Lblmat_unit3.Caption := line_arr[3].Lblmat_unit;

  Edtmat_num4.Text := line_arr[4].Edtmat_num;
  Lblmat_num4.Caption := line_arr[4].Lblmat_num;
  Lblmat_des4.Caption := line_arr[4].Lblmat_des;
  chkvalue_arrtolbl(Lblmat_price4, line_arr[4].Lblmat_price);
  chkvalue_arrtolbl(Lblamount4, line_arr[4].Lblamount);
  chkvalue_arrtoedt(EdtQty4, line_arr[4].EdtQty);
  Lblmat_unit4.Caption := line_arr[4].Lblmat_unit;

  Edtmat_num5.Text := line_arr[5].Edtmat_num;
  Lblmat_num5.Caption := line_arr[5].Lblmat_num;
  Lblmat_des5.Caption := line_arr[5].Lblmat_des;
  chkvalue_arrtolbl(Lblmat_price5, line_arr[5].Lblmat_price);
  chkvalue_arrtolbl(Lblamount5, line_arr[5].Lblamount);
  chkvalue_arrtoedt(EdtQty5, line_arr[5].EdtQty);
  Lblmat_unit5.Caption := line_arr[5].Lblmat_unit;

  Edtmat_num6.Text := line_arr[6].Edtmat_num;
  Lblmat_num6.Caption := line_arr[6].Lblmat_num;
  Lblmat_des6.Caption := line_arr[6].Lblmat_des;
  chkvalue_arrtolbl(Lblmat_price6, line_arr[6].Lblmat_price);
  chkvalue_arrtolbl(Lblamount6, line_arr[6].Lblamount);
  chkvalue_arrtoedt(EdtQty6, line_arr[6].EdtQty);
  Lblmat_unit6.Caption := line_arr[6].Lblmat_unit;

  Edtmat_num7.Text := line_arr[7].Edtmat_num;
  Lblmat_num7.Caption := line_arr[7].Lblmat_num;
  Lblmat_des7.Caption := line_arr[7].Lblmat_des;
  chkvalue_arrtolbl(Lblmat_price7, line_arr[7].Lblmat_price);
  chkvalue_arrtolbl(Lblamount7, line_arr[7].Lblamount);
  chkvalue_arrtoedt(EdtQty7, line_arr[7].EdtQty);
  Lblmat_unit7.Caption := line_arr[7].Lblmat_unit;

  Edtmat_num8.Text := line_arr[8].Edtmat_num;
  Lblmat_num8.Caption := line_arr[8].Lblmat_num;
  Lblmat_des8.Caption := line_arr[8].Lblmat_des;
  chkvalue_arrtolbl(Lblmat_price8, line_arr[8].Lblmat_price);
  chkvalue_arrtolbl(Lblamount8, line_arr[8].Lblamount);
  chkvalue_arrtoedt(EdtQty8, line_arr[8].EdtQty);
  Lblmat_unit8.Caption := line_arr[8].Lblmat_unit;

  Edtmat_num9.Text := line_arr[9].Edtmat_num;
  Lblmat_num9.Caption := line_arr[9].Lblmat_num;
  Lblmat_des9.Caption := line_arr[9].Lblmat_des;
  chkvalue_arrtolbl(Lblmat_price9, line_arr[9].Lblmat_price);
  chkvalue_arrtolbl(Lblamount9, line_arr[9].Lblamount);
  chkvalue_arrtoedt(EdtQty9, line_arr[9].EdtQty);
  Lblmat_unit9.Caption := line_arr[9].Lblmat_unit;

  Edtmat_num10.Text := line_arr[10].Edtmat_num;
  Lblmat_num10.Caption := line_arr[10].Lblmat_num;
  Lblmat_des10.Caption := line_arr[10].Lblmat_des;
  chkvalue_arrtolbl(Lblmat_price10, line_arr[10].Lblmat_price);
  chkvalue_arrtolbl(Lblamount10, line_arr[10].Lblamount);
  chkvalue_arrtoedt(EdtQty10, line_arr[10].EdtQty);
  Lblmat_unit10.Caption := line_arr[10].Lblmat_unit;

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

  line_arr[2].Edtmat_num := Edtmat_num2.Text;
  line_arr[2].Lblmat_num := Lblmat_num2.Caption;
  line_arr[2].Lblmat_des := Lblmat_des2.Caption;
  line_arr[2].Lblmat_price := Trim(Rem_comma(Lblmat_price2.Caption));
  line_arr[2].EdtQty := Trim(Rem_comma(EdtQty2.Text));
  line_arr[2].Lblmat_unit := Lblmat_unit2.Caption;
  line_arr[2].Lblamount := Trim(Rem_comma(Lblamount2.Caption));

  line_arr[3].Edtmat_num := Edtmat_num3.Text;
  line_arr[3].Lblmat_num := Lblmat_num3.Caption;
  line_arr[3].Lblmat_des := Lblmat_des3.Caption;
  line_arr[3].Lblmat_price := Trim(Rem_comma(Lblmat_price3.Caption));
  line_arr[3].EdtQty := Trim(Rem_comma(EdtQty3.Text));
  line_arr[3].Lblmat_unit := Lblmat_unit3.Caption;
  line_arr[3].Lblamount := Trim(Rem_comma(Lblamount3.Caption));

  line_arr[4].Edtmat_num := Edtmat_num4.Text;
  line_arr[4].Lblmat_num := Lblmat_num4.Caption;
  line_arr[4].Lblmat_des := Lblmat_des4.Caption;
  line_arr[4].Lblmat_price := Trim(Rem_comma(Lblmat_price4.Caption));
  line_arr[4].EdtQty := Trim(Rem_comma(EdtQty4.Text));
  line_arr[4].Lblmat_unit := Lblmat_unit4.Caption;
  line_arr[4].Lblamount := Trim(Rem_comma(Lblamount4.Caption));

  line_arr[5].Edtmat_num := Edtmat_num5.Text;
  line_arr[5].Lblmat_num := Lblmat_num5.Caption;
  line_arr[5].Lblmat_des := Lblmat_des5.Caption;
  line_arr[5].Lblmat_price := Trim(Rem_comma(Lblmat_price5.Caption));
  line_arr[5].EdtQty := EdtQty5.Text;
  line_arr[5].Lblmat_unit := Trim(Rem_comma(Lblmat_unit5.Caption));
  line_arr[5].Lblamount := Trim(Rem_comma(Lblamount5.Caption));

  line_arr[6].Edtmat_num := Edtmat_num6.Text;
  line_arr[6].Lblmat_num := Lblmat_num6.Caption;
  line_arr[6].Lblmat_des := Lblmat_des6.Caption;
  line_arr[6].Lblmat_price := Trim(Rem_comma(Lblmat_price6.Caption));
  line_arr[6].EdtQty := Trim(Rem_comma(EdtQty6.Text));
  line_arr[6].Lblmat_unit := Lblmat_unit6.Caption;
  line_arr[6].Lblamount := Trim(Rem_comma(Lblamount6.Caption));

  line_arr[7].Edtmat_num := Edtmat_num7.Text;
  line_arr[7].Lblmat_num := Lblmat_num7.Caption;
  line_arr[7].Lblmat_des := Lblmat_des7.Caption;
  line_arr[7].Lblmat_price := Trim(Rem_comma(Lblmat_price7.Caption));
  line_arr[7].EdtQty := Trim(Rem_comma(EdtQty7.Text));
  line_arr[7].Lblmat_unit := Lblmat_unit7.Caption;
  line_arr[7].Lblamount := Trim(Rem_comma(Lblamount7.Caption));

  line_arr[8].Edtmat_num := Edtmat_num8.Text;
  line_arr[8].Lblmat_num := Lblmat_num8.Caption;
  line_arr[8].Lblmat_des := Lblmat_des8.Caption;
  line_arr[8].Lblmat_price := Trim(Rem_comma(Lblmat_price8.Caption));
  line_arr[8].EdtQty := Trim(Rem_comma(EdtQty8.Text));
  line_arr[8].Lblmat_unit := Lblmat_unit8.Caption;
  line_arr[8].Lblamount := Trim(Rem_comma(Lblamount8.Caption));

  line_arr[9].Edtmat_num := Edtmat_num9.Text;
  line_arr[9].Lblmat_num := Lblmat_num9.Caption;
  line_arr[9].Lblmat_des := Lblmat_des9.Caption;
  line_arr[9].Lblmat_price := Trim(Rem_comma(Lblmat_price9.Caption));
  line_arr[9].EdtQty := Trim(Rem_comma(EdtQty9.Text));
  line_arr[9].Lblmat_unit := Lblmat_unit9.Caption;
  line_arr[9].Lblamount := Trim(Rem_comma(Lblamount9.Caption));

  line_arr[10].Edtmat_num := Edtmat_num10.Text;
  line_arr[10].Lblmat_num := Lblmat_num10.Caption;
  line_arr[10].Lblmat_des := Lblmat_des10.Caption;
  line_arr[10].Lblmat_price := Trim(Rem_comma(Lblmat_price10.Caption));
  line_arr[10].EdtQty := Trim(Rem_comma(EdtQty10.Text));
  line_arr[10].Lblmat_unit := Lblmat_unit10.Caption;
  line_arr[10].Lblamount := Trim(Rem_comma(Lblamount10.Caption));
end;

procedure TFrmBill.moverecord( i, j : integer);
begin
  line_arr[i] := line_arr[j];
  line_arr[j].Edtmat_num := '';
  line_arr[j].Lblmat_num := '';
  line_arr[j].Lblmat_des := '';
  line_arr[j].Lblmat_price := '';
  line_arr[j].EdtQty := '';
  line_arr[j].Lblmat_unit := '';
  line_arr[j].LblAmount := '' ;
end;

procedure TFrmBill.chkformatQty(a, b : TEdit; c, d : TLabel; line : integer);
var i, j :integer;
    chkkeyqty : boolean;
begin
  if Trim(a.Text) <> '' then
    begin
      if Trim(b.Text) <> '' then
        begin
          chkkeyqty := false;
          try
            a.Text := formatfloat('#0.00',strtofloat(a.Text));
            chkkeyqty := true;
          except
          on E: EConvertError do
            begin
              Showmessage('ใส่ปริมาณไม่ถูกต้องกรุณาใส่ใหม่');
              a.SetFocus;
            end;
          end;

        if chkkeyqty = true  then
        begin
          j := length(a.Text);
          for i := 1 to j do
            begin
              if (Copy(a.Text, i, 1) <> '1') AND
                 (Copy(a.Text, i, 1) <> '2') AND
                 (Copy(a.Text, i, 1) <> '3') AND
                 (Copy(a.Text, i, 1) <> '4') AND
                 (Copy(a.Text, i, 1) <> '5') AND
                 (Copy(a.Text, i, 1) <> '6') AND
                 (Copy(a.Text, i, 1) <> '7') AND
                 (Copy(a.Text, i, 1) <> '8') AND
                 (Copy(a.Text, i, 1) <> '9') AND
                 (Copy(a.Text, i, 1) <> '0') AND
                 (Copy(a.Text, i, 1) <> '.') then
                begin
                  Showmessage('ใส่ปริมาณไม่ถูกต้องกรุณาใส่ใหม่');
                  a.SetFocus;
//                  chkkeyqty := false;
                end;
            end;

              if strtofloat(a.Text) <= 0 then
                begin
                  Showmessage('ใส่ปริมาณไม่ถูกต้องกรุณาใส่ใหม่');
                  a.SetFocus;
                end
              else
                begin
                  price := c.Caption;
                  qty   := Trim(a.Text);
                  CalAmount(price, qty, amount);  //calculate amount
                  d.Caption := formatfloat('#0.00',amount);
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

procedure TFrmBill.chkvalue_arrtolbl(a : TLabel; arr_value : string);
begin
  if arr_value = '' then
    begin
      a.Caption := '';
    end
  else
    a.Caption := formatfloat('#,##0.00',strtofloat((arr_value)));
end;

procedure TFrmBill.chkvalue_arrtoedt(b : TEdit; arr_qty : string);
begin
  if arr_qty = '' then
    begin
      b.Text := '';
    end
  else
    b.Text := formatfloat('#,##0.00',strtofloat(arr_qty));
end;

procedure TFrmBill.arrtobilldet;
var i : integer;
    vat : double;
begin
  for i := 1 to line_num do
    begin
      billdetail_arr[i].comp_id := comp_id;
      billdetail_arr[i].no := bill_no;
      billdetail_arr[i].line := i;
      billdetail_arr[i].goods_id := line_arr[i].Lblmat_num;      //mat_num
      billdetail_arr[i].goods_prc := strtofloat(line_arr[i].Lblmat_price);   //price
      billdetail_arr[i].goods_num := strtofloat(line_arr[i].EdtQty);        //qty
      billdetail_arr[i].amt := strtofloat(line_arr[i].Lblamount);           //amount
      vat := (7/107)*(strtofloat(formatfloat('#0.00',strtofloat(line_arr[i].Lblamount))));
      billdetail_arr[i].amt_vat := strtofloat(formatfloat('#0.00',vat));    //vat
      billdetail_arr[i].status := status_bill;                 //status of bill
      billdetail_arr[i].load := bill_load;                //status load with sap
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
    Panel1.Visible:=false;
end;

procedure TFrmBill.endday;
var
  sqls,day,day1 : string;
begin
    sqls := 'SELECT * FROM CONTROL Where COMP_ID ='''+FrmBill.EdtComp_id.Text+'''';
    with FrmDatamodule.ADOQuery1 do
      begin
      Close;
      SQL.Clear;
      SQL.Add(sqls);
      Open;
      day := fieldvalues['SALESDATE'];
      day1 := fieldvalues['TRANSFERDATE'];
      end;
    if day = day1 then ShowMessage('มีการยกยอด ณ สิ้นวันไปแล้ว ไม่สามารถทำการยกยอดได้อีก')
    else
      begin
      ShowMessage('กรุณาทำการสำรองแฟ้มข้อมูลก่อนยกยอด ณ สิ้นวัน');
      SaveDialog1.Filename := FormatDateTime('YYMMDD',now)+'billcash.mdb';
      if SaveDialog1.Execute then
        begin
        if FileExists(SaveDialog1.Filename ) then
          if MessageDlg('Overwrite ' + SaveDialog1.FileName + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
          then deletefile(SaveDialog1.Filename);

        Frmdatamodule.ADOConnection.Close;
        copyFile(pchar('C:\CashSales\Database\billcash.mdb'),pchar(SaveDialog1.Filename),False);
        Frmdatamodule.ADOConnection.Open;
        end;
      FrmEndday := TFrmEndday.create(Application);
      FrmEndday.showModal;
      FrmEndday.Free;
      end;
end;

procedure TFrmBill.FormCreate(Sender: TObject);
begin
    ShortDateFormat:='DD/MM/YYYY';
    BrDateForm := TBrDateForm.create(Application);
    FrmLogon := TFrmLogon.create(Application);
    FrmLogon.ShowModal;
end;

procedure TFrmBill.N9Click(Sender: TObject);
begin
    FrmUnit := TFrmUnit.create(Application);
    FrmUnit.showModal;
    FrmUnit.Free;
end;

procedure TFrmBill.N10Click(Sender: TObject);
begin
    FrmFG := TFrmFG.create(Application);
    FrmFG.showModal;
    FrmFG.Free;
end;

procedure TFrmBill.N11Click(Sender: TObject);
begin
    FrmCompany := TFrmCompany.create(Application);
    FrmCompany.showModal;
    FrmCompany.Free;
end;

procedure TFrmBill.N12Click(Sender: TObject);
begin
    FrmPrdGrp := TFrmPrdGrp.create(Application);
    FrmPrdGrp.showModal;
    FrmPrdGrp.Free;
end;

procedure TFrmBill.N13Click(Sender: TObject);
begin
    FrmSalesman := TFrmSalesman.create(Application);
    FrmSalesman.showModal;
    FrmSalesman.Free;
end;

procedure TFrmBill.N14Click(Sender: TObject);
begin
    FrmCust := TFrmCust.create(Application);
    FrmCust.showModal;
    FrmCust.Free;
end;

procedure TFrmBill.N2Click(Sender: TObject);
begin
    FrmLoadtxt := TFrmLoadtxt.create(Application);
    FrmLoadtxt.showModal;
    FrmLoadtxt.Free;
end;

procedure TFrmBill.N3Click(Sender: TObject);
begin
  SaveDialog1.Filename := FormatDateTime('YYMMDD',now)+'billcash.mdb';
  if SaveDialog1.Execute then
  begin
    if FileExists(SaveDialog1.Filename ) then
      if MessageDlg('Overwrite ' + SaveDialog1.FileName + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
      then deletefile(SaveDialog1.Filename);

    Frmdatamodule.ADOConnection.Close;
    copyFile(pchar('C:\CashSales\Database\billcash.mdb'),pchar(SaveDialog1.Filename),False);
    Frmdatamodule.ADOConnection.Open;
    ShowMessage('ทำการสำรองแฟ้มข้อมูลเรียบร้อยแล้ว');
  end;
end;

procedure TFrmBill.N4Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Frmdatamodule.ADOConnection.Close;
    if MessageDlg('คุณต้องการทีจะทำการเรียกคืนแฟ้ม ' + OpenDialog1.FileName + 'ใช่หรือไม่?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
      then begin
            copyFile(pchar(OpenDialog1.Filename),pchar('C:\CashSales\Database\billcash.mdb'),False);
            ShowMessage('ทำการเรียกคืนแฟ้มข้อมูลเรียบร้อยแล้ว');
           end;
    Frmdatamodule.ADOConnection.Open;
  end;
  Read_Control;
end;

procedure TFrmBill.N8Click(Sender: TObject);
var reps : word;
begin
        reps := MessageDlg('คุณต้องการออกจากระบบใช่หรือไม่',mtConfirmation,[mbYes,mbNo],0);
        if reps = mrYes then
          begin
            Close;
            Application.Terminate;
          end;

end;

end.

