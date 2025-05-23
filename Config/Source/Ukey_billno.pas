unit Ukey_billno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type

  TBill_Det = Record
    comp_id : string;
    no : string;
    line : longint;
    goods_id : string;      //mat_num
    goods_prc : double;     //price
    goods_num : double;     //qty
    amt : double;
    units : string;
    barcode : string;
    des : string;
  end;

  TKeyBill = Record
    Edtmat_num : string;
    Lblmat_num : string;
    Lblmat_des : string;
    Lblmat_price : string;
    EdtQty : string;
    Lblmat_unit : string;
    Lblamount : string;
  end;

  TFrmKeybillno = class(TForm)
    Label4: TLabel;
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
    LabelBill_No: TLabel;
    EdtKeybillno: TEdit;
    Label6: TLabel;
    EdtCust_ID: TEdit;
    LabelCust_name: TLabel;
    BtnOk: TButton;
    BtnCancel: TButton;
    procedure EdtKeybillnoKeyPress(Sender: TObject; var Key: Char);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdtKeybillnoExit(Sender: TObject);
  private
    { Private declarations }
    bill_num : string;
    line_number : integer;
    {declar  array}
    billdet_arr : array[1..10] of TBill_Det;

    { Procedure declarations }
    procedure Cleardata2;  //Clear data in edit&label
    procedure ReadDataShow;
    procedure ShowData;

  public
    { Public declarations }
  end;

var
  FrmKeybillno: TFrmKeybillno;

implementation

uses Ubill, Udatamodule, UThai2, UPrint;

{$R *.dfm}

procedure TFrmKeybillno.EdtKeybillnoKeyPress(Sender: TObject;
  var Key: Char);
begin
  If key = #13 then
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
var reps : word;
begin
  if (FrmDatamodule.ADOQuery1.RecordCount > 0) and (FrmDatamodule.ADOQuery1.FieldValues['BILLH_STATUS'] = 'C') then
    begin
      ShowMessage('บิลเลขที่ '+Trim(EdtKeybillno.Text)+'ได้ถูก Cancel ไปแล้ว');
      EdtKeybillno.SetFocus;
      //close;
    end

  else if FrmBill.chkactive = 'cancel' then
    begin
      reps := MessageDlg('คุณต้องการ CANCEL บิลเลขที่ '''+bill_num+''' ใช่หรือไม่',mtConfirmation,[mbYes,mbNo],0);
      if reps = mrYes then
        begin
          status_bill := 'C';
          status_print := '0';
          bill_no := bill_num;
          FrmBill.process_data;
        end;
    end
  else
    begin
      reps := MessageDlg('คุณต้องการพิมพ์บิลเลขที่ '''+bill_num+''' ใช่หรือไม่',mtConfirmation,[mbYes,mbNo],0);
      if reps = mrYes then
        begin
          if generate_print_bill(FrmBill.comp_id,bill_num,FrmBill.msg_err) = true then
            begin
              status_bill := 'A';
              status_print := '1';
              bill_no := bill_num;
              FrmBill.process_data;       //save data in table BILL_HEAD ch status print =1
            end;
        end;
    end;

  Close;
end;

procedure TFrmKeybillno.FormShow(Sender: TObject);
begin
    EdtKeybillno.Clear;
    EdtKeybillno.SetFocus;
    LabelAcc.Caption := FrmBill.LabelAcc.Caption;
    Labelpc_id.Caption := FrmBill.Labelpc_id.Caption;
    Labelsales_id.Caption := FrmBill.Labelsales_id.Caption;
    LabelSales_name.Caption := FrmBill.LabelSales_name.Caption;
    LabelSum.Caption := FrmBill.LabelSum.Caption;
    ClearData2;
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
  LblNetprice.Caption := '0';
  LblVat.Caption := '0';
  LblTot_amount.Caption := '0';
end;

procedure TFrmKeybillno.EdtKeybillnoExit(Sender: TObject);
var sqls_billh : string;
    j : integer;
begin
  sqls_billh := 'Select * From BILL_HEAD Where BILLH_COMP_ID = '''+FrmBill.comp_id+''' and BILLH_NO = '''+Trim(Edtkeybillno.Text)+''' ' ;
  with FrmDatamodule.ADOQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add(sqls_billh);
      Open;
    end;

  if (FrmDatamodule.ADOQuery1.RecordCount = 0) then
    begin
      Showmessage('ใส่เลขที่เอกสารไม่ถูกต้องกรุณาใส่ใหม่');
      EdtKeybillno.SetFocus;      
    end

  else
    begin
      bill_num := Trim(EdtKeybillno.Text);
      line_number := FrmDatamodule.ADOQuery1.FieldValues['BILLH_NUM'];
      for j := 1 to 10 do
      begin
        billdet_arr[j].comp_id := '';
        billdet_arr[j].no := '';
        billdet_arr[j].line := strtoint('');
        billdet_arr[j].goods_id := '';
        billdet_arr[j].goods_prc := strtofloat('');
        billdet_arr[j].goods_num := strtofloat('');
        billdet_arr[j].amt := strtofloat('');
        billdet_arr[j].units := '';
        billdet_arr[j].barcode := '';
        billdet_arr[j].des := '';
      end;
      ReadDataShow;
      ShowData;
    end;
end;


procedure TFrmKeybillno.ReadDataShow;
var i : integer;
    sqls_billdet : string;
    sqls_fg : string;
begin
  for i := 1 to line_number do
    begin
      sqls_billdet := 'Select * From BILL_DETAIL Where BILLD_COMP_ID = '''+FrmBill.comp_id+''' and BILLD_NO = '''+bill_num+''' and BILLD_LINE = '''+inttostr(i)+'''' ;
      with FrmDatamodule.ADOQuery3 do
        begin
          Close;
          SQL.Clear;
          SQL.Add(sqls_billdet);
          Open;
        end;

      if (FrmDatamodule.ADOQuery3.RecordCount > 0) then
        begin
          sqls_fg := 'Select * From FINISH_GOODS Where FG_ID = '''+FrmDatamodule.ADOQuery3.FieldValues['BILLD_GOODS_ID']+''' ' ;
          with FrmDatamodule.ADOQuery2 do
            begin
              Close;
              SQL.Clear;
              SQL.Add(sqls_fg);
              Open;
            end;

          billdet_arr[i].comp_id := FrmDatamodule.ADOQuery3.FieldValues['BILLD_COMP_ID'];
          billdet_arr[i].no := FrmDatamodule.ADOQuery3.FieldValues['BILLD_NO'];
          billdet_arr[i].line := FrmDatamodule.ADOQuery3.FieldValues['BILLD_LINE'];
          billdet_arr[i].goods_id := FrmDatamodule.ADOQuery3.FieldValues['BILLD_GOODS_ID'];      //mat_num
          billdet_arr[i].goods_prc := FrmDatamodule.ADOQuery3.FieldValues['BILLD_GOODS_PRC'];   //price
          billdet_arr[i].goods_num := FrmDatamodule.ADOQuery3.FieldValues['BILLD_GOODS_NUM'];;        //qty
          billdet_arr[i].amt := FrmDatamodule.ADOQuery3.FieldValues['BILLD_GOODS_AMT'];           //amount
          if (FrmDatamodule.ADOQuery2.RecordCount > 0) then
            begin
              billdet_arr[i].units := FrmDatamodule.ADOQuery2.FieldValues['FG_UNITS'];
              billdet_arr[i].barcode := FrmDatamodule.ADOQuery2.FieldValues['FG_BAR_CODE'];
              billdet_arr[i].des := FrmDatamodule.ADOQuery2.FieldValues['FG_DES'];
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

  EdtQty1.Text := formatcurr('#,##0.00',billdet_arr[1].goods_num);
  EdtQty2.Text := formatcurr('#,##0.00',billdet_arr[2].goods_num);
  EdtQty3.Text := formatcurr('#,##0.00',billdet_arr[3].goods_num);
  EdtQty4.Text := formatcurr('#,##0.00',billdet_arr[4].goods_num);
  EdtQty5.Text := formatcurr('#,##0.00',billdet_arr[5].goods_num);
  EdtQty6.Text := formatcurr('#,##0.00',billdet_arr[6].goods_num);
  EdtQty7.Text := formatcurr('#,##0.00',billdet_arr[7].goods_num);
  EdtQty8.Text := formatcurr('#,##0.00',billdet_arr[8].goods_num);
  EdtQty9.Text := formatcurr('#,##0.00',billdet_arr[9].goods_num);
  EdtQty10.Text := formatcurr('#,##0.00',billdet_arr[10].goods_num);

  Lblamount1.Caption := formatcurr('#,##0.00',billdet_arr[1].amt);
  Lblamount2.Caption := formatcurr('#,##0.00',billdet_arr[2].amt);
  Lblamount3.Caption := formatcurr('#,##0.00',billdet_arr[3].amt);
  Lblamount4.Caption := formatcurr('#,##0.00',billdet_arr[4].amt);
  Lblamount5.Caption := formatcurr('#,##0.00',billdet_arr[5].amt);
  Lblamount6.Caption := formatcurr('#,##0.00',billdet_arr[6].amt);
  Lblamount7.Caption := formatcurr('#,##0.00',billdet_arr[7].amt);
  Lblamount8.Caption := formatcurr('#,##0.00',billdet_arr[8].amt);
  Lblamount9.Caption := formatcurr('#,##0.00',billdet_arr[9].amt);
  Lblamount10.Caption := formatcurr('#,##0.00',billdet_arr[10].amt);

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

  Lblmat_price1.Caption := formatcurr('#,##0.00',billdet_arr[1].goods_prc);
  Lblmat_price2.Caption := formatcurr('#,##0.00',billdet_arr[2].goods_prc);
  Lblmat_price3.Caption := formatcurr('#,##0.00',billdet_arr[3].goods_prc);
  Lblmat_price4.Caption := formatcurr('#,##0.00',billdet_arr[4].goods_prc);
  Lblmat_price5.Caption := formatcurr('#,##0.00',billdet_arr[5].goods_prc);
  Lblmat_price6.Caption := formatcurr('#,##0.00',billdet_arr[6].goods_prc);
  Lblmat_price7.Caption := formatcurr('#,##0.00',billdet_arr[7].goods_prc);
  Lblmat_price8.Caption := formatcurr('#,##0.00',billdet_arr[8].goods_prc);
  Lblmat_price9.Caption := formatcurr('#,##0.00',billdet_arr[9].goods_prc);
  Lblmat_price10.Caption := formatcurr('#,##0.00',billdet_arr[10].goods_prc);

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
end;

end.





