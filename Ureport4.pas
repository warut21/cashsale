unit Ureport4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DBCtrls, Grids, DBGrids, ShellAPI, Buttons;
const
  tab1: string = '        ';
  tab2: string = '          ';
  lines: string = '        ==================================================================================================================';
type
  TFrmReport4 = class(TForm)
    MemoReport: TMemo;
    Label1: TLabel;
    BtnShow: TButton;
    BtnPrint: TButton;
    LabelComp: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    BtnClose: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Lbls: TLabel;
    Lble: TLabel;
    Button1: TButton;
    procedure BtnShowClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Group_idClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure BtnPrintClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2Enter(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    PageNo: integer;
    procedure ReadData;
    procedure WriteHead;
    procedure Selectdata;

    { Private declarations }
  public
//    procedure Set_BE_EN(PBegin,PEnd : string);
    { Public declarations }
  end;

var
  FrmReport4: TFrmReport4;

implementation

uses Udatamodule, UThai2, PickDate, UPrint, Ubill, UQRprint;

{$R *.dfm}

{procedure TFrmReport4.Set_BE_EN(PBegin,PEnd : string);
begin
  Edit1.text := PBegin;
  Edit2.text := PEnd;
end;}

procedure TFrmReport4.BtnShowClick(Sender: TObject);

begin

  if Edit2.Text < Edit1.Text then
  begin
    ShowMessage('เลขที่บิลสุดท้ายต้องมากกว่าหรือเท่ากับเลขที่บิลเริ่มต้น');
    Edit2.SetFocus;
  end
  else
  begin
    MemoReport.Clear;
    BtnPrint.Enabled := true;
    if Edit2.Text = '' then Edit2.Text := Edit1.Text;
    Selectdata;
    PageNo := 1;
    WriteHead;
    ReadData;
    BtnPrint.SetFocus;
  end;
end;

procedure TFrmReport4.FormActivate(Sender: TObject);
var
  sqls: string;

  procedure get_data;
  var
    Be_bill,En_bill :string;
    i_bill : integer;
  begin
    sqls := 'Select PC_NAME,TODAY_BILL,TODAY_BILL_C,CUR_BILL_NO From CONTROL Where COMP_ID = ''' + FrmBill.EdtComp_id.Text + '''';
    with FrmDatamodule.ADOQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add(sqls);
      Open;
      Label6.Caption := copy(FieldValues['PC_NAME'], 1, 2);
      Lbls.Caption := FieldValues['PC_NAME'];
      Lble.Caption := FieldValues['PC_NAME'];
      En_bill :=  FieldValues['CUR_BILL_NO'];
      i_bill := copy(En_bill,4,5) - (FieldValues['TODAY_BILL']+FieldValues['TODAY_BILL_C']);
      Be_bill := Copy(En_bill, 1, 3) + ThaiRight('00000' + inttostr(i_bill), 5);
      Edit1.text := copy(Be_bill,4,length(Be_bill));
      Edit2.text := copy(En_bill,4,length(En_bill));
      Close;
    end;
  end;

begin
  MemoReport.Clear;
  BtnShow.Enabled := false;
  BtnPrint.Enabled := false;
  LabelComp.Caption := FrmBill.LabelComp_name.Caption;
  get_data;
  Edit1.SetFocus;
end;

procedure TFrmReport4.WriteHead;
var
  strline: string;
begin
  strline := tab1 + 'วันที่ : ' + FormatDateTime('dd/mm/yyyy', now) + Thaimid(FrmBill.LabelComp_name.Caption, 86) +
    'หน้า : ' + ThaiRight(IntToStr(PageNo), 4);
  PageNo := PageNo + 1;
  MemoReport.Lines.Add(strline);
  MemoReport.Lines.Add(' ');
  strline := tab1 + 'เวลา : ' + FormatDateTime('hh:nn:ss ', now) + Thaimid('รายงานใบ INVOICE รวม', 86);
  MemoReport.Lines.Add(strline);
  strline := tab1 + Thaimid('ประจำเครื่อง : ' + Label6.Caption, 118);
  MemoReport.Lines.Add(strline);
  MemoReport.Lines.Add(lines);
  strline := tab1 + ThaiRight('วันเดือนปี', 10) + ThaiRight('เลขที่เอกสาร', 19) + ThaiRight('รหัสลูกค้า', 15) + ThaiRight('ยอดขายสุทธิ', 18) +
    ThaiRight('VAT', 19) + ThaiRight('ยอดขาย', 19);
  MemoReport.Lines.Add(strline);
  MemoReport.Lines.Add(lines);
  MemoReport.Lines.Add(' ');
end;

procedure TFrmReport4.Selectdata;
var
  sqls, day1, day: string;
begin
  sqls := 'SELECT * FROM PROGRAMER';
  with FrmDatamodule.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sqls);
    Open;
    day := fieldvalues['date'];
    day1 := fieldvalues['create_date'];
    if day <> day1 then
      sqls := 'SELECT BILLH_COMP_ID,BILLH_NO,BILLH_DATE,BILLH_CUST_ID,BILLH_AMT,BILLH_AMT_VAT, (BILLH_AMT-BILLH_AMT_VAT)AS AMT ' +
        'FROM BILL_HEAD ' +
        'WHERE BILLH_COMP_ID = ''' + FrmBill.EdtComp_id.Text +
        ''' AND BILLH_STATUS = ''A'' ' +
        'AND BILLH_NO >= ''' + Lbls.Caption + Edit1.Text + ''' AND BILLH_NO <= ''' + Lbls.Caption + Edit2.Text + '''' +
        'GROUP BY BILLH_COMP_ID, BILLH_NO,BILLH_DATE,BILLH_CUST_ID,BILLH_AMT,BILLH_AMT_VAT ' +
        'ORDER BY BILLH_COMP_ID, BILLH_NO,BILLH_DATE,BILLH_CUST_ID,BILLH_AMT,BILLH_AMT_VAT '
    else
      sqls := 'SELECT BILLH_COMP_ID,BILLH_NO,BILLH_DATE,BILLH_CUST_ID,BILLH_AMT,BILLH_AMT_VAT, (BILLH_AMT-BILLH_AMT_VAT)AS AMT ' +
        'FROM BILL_HEAD ' +
        'WHERE BILLH_COMP_ID = ''' + FrmBill.EdtComp_id.Text +
        ''' AND BILLH_STATUS = ''A'' ' +
        'AND BILLH_No >= ''' + Lbls.Caption + Edit1.Text + ''' AND BILLH_NO <= ''' + Lbls.Caption + Edit2.Text + '''' +
        'GROUP BY BILLH_COMP_ID, BILLH_NO,BILLH_DATE,BILLH_CUST_ID,BILLH_AMT,BILLH_AMT_VAT ' +
        'ORDER BY BILLH_COMP_ID, BILLH_NO,BILLH_DATE,BILLH_CUST_ID,BILLH_AMT,BILLH_AMT_VAT ';
  end;
  with FrmDatamodule.ADOQuery0 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sqls);
    Open;
  end;
end;

procedure TFrmReport4.ReadData;
var
  strline: string;
  wline: integer;
  sum1, sum2, sum3: double;
begin
  sum1 := 0;
  sum2 := 0;
  sum3 := 0;
  wline := 1;
    {*****}
  with frmdatamodule.ADOQuery0 do
  begin
    if frmdatamodule.ADOQuery0.RecordCount = 0 then
    begin
      ShowMessage('ไม่พบเลขที่บิลที่ต้องการแสดง' + #13 + 'ข้อมูลที่ใส่อาจไม่ถูกต้อง กรุณาตรวจสอบ');
      strline := Thaimid('ไม่พบข้อมูลที่ต้องการแสดง', 120);
      MemoReport.Lines.Add(strline);
    end
    else
    begin
      while not eof do
      begin
        strline := tab2 + Thairight(FormatDatetime('DD/MM/YYYY', Fieldvalues['BILLH_DATE']), 10) + Thairight(Fieldvalues['BILLH_NO'], 17) +
          Thairight(Fieldvalues['BILLH_CUST_ID'], 14) + Thairight(formatcurr('#,##0.00', Fieldvalues['AMT']), 19) +
          Thairight(formatcurr('#,##0.00', Fieldvalues['BILLH_AMT_VAT']), 19) + Thairight(formatcurr('#,##0.00', Fieldvalues['BILLH_AMT']), 19);
        MemoReport.Lines.Add(strline);
        MemoReport.Lines.Add(' ');
        sum1 := sum1 + Fieldvalues['AMT'];
        sum2 := sum2 + Fieldvalues['BILLH_AMT_VAT'];
        sum3 := sum3 + Fieldvalues['BILLH_AMT'];
        wline := wline + 1;
        if (wline mod 29) = 0 then
        begin
          MemoReport.Lines.Add(' ');
          MemoReport.Lines.Add(' ');
          WriteHead;
        end;
        Next;
      end; //end while
      if (wline mod 29) = 0 then
      begin
        MemoReport.Lines.Add(' ');
        MemoReport.Lines.Add(' ');
        WriteHead;
      end;
      MemoReport.Lines.Add(lines);
      strline := tab1 + ThaiLeft(' จำนวนรายการทั้งหมด :  ', 22) + thaileft(formatcurr('#,##0', wline - 1), 21) +
        thairight(formatcurr('#,##0.00', sum1), 19) + thairight(formatcurr('#,##0.00', sum2), 19) +
        thairight(formatcurr('#,##0.00', sum3), 19);
      MemoReport.Lines.Add(strline);
      MemoReport.Lines.Add(lines);
    end; //end else
  end; //end with
    {*****}
end;

procedure TFrmReport4.Group_idClick(Sender: TObject);
begin
  MemoReport.Clear;
end;

procedure TFrmReport4.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmReport4.BtnPrintClick(Sender: TObject);
var
  msg_err: string;
  strsql: string;
begin
  with frmdatamodule.ADOQuery0 do
  begin
    First;
    while not eof do
    begin

      with frmdatamodule.ADOQuery1 do
      begin
       close;
       sql.clear;
       strsql := 'SELECT * ' + #13#10 +
         '  FROM BILL_HEAD INNER JOIN BILL_DETAIL ON BILL_HEAD.BILLH_NO = BILL_DETAIL.BILLD_NO ' +
         '  AND  BILL_HEAD.BILLH_COMP_ID = BILL_DETAIL.BILLD_COMP_ID ' + #13#10 +
         '  WHERE BILL_HEAD.BILLH_COMP_ID = ''' + frmdatamodule.ADOQuery0.FieldValues['BILLH_COMP_ID'] + '''' +
         '    AND BILL_HEAD.BILLH_NO      = ''' + frmdatamodule.ADOQuery0.FieldValues['BILLH_NO'] + '''';
       sql.Add(strsql);
       open;
     end;
       QRForm.QRExpr1.Expression   := FrmDataModule.ADOQuery1.FieldValues['BILLH_AMT'] -
                               FrmDataModule.ADOQuery1.FieldValues['BILLH_AMT_VAT'];

       if FrmDatamodule.ADOQuery1.RecordCount <> 0 then
       begin
         QRForm.QuickRep1.Print;
         next;
       end
       else
       begin
         ShowMessage('ไม่สามารถทำการพิมพ์บิลเลขที ่' + FieldValues['BILLH_NO'] + ' ได้');
         Next;
       end;
     end;
(*
      if Generate_Print_Bill(FieldValues['BILLH_COMP_ID'], FieldValues['BILLH_NO'], msg_err) then Next
      else
      begin
        ShowMessage('ไม่สามารถทำการพิมพ์บิลเลขที ่' + FieldValues['BILLH_NO'] + ' ได้');
        Next;
      end;
    end;
*)
  end;
  BtnClose.SetFocus;
end;


procedure TFrmReport4.Edit1Change(Sender: TObject);
begin
  MemoReport.Clear;
  if length(Edit1.Text) = 0 then BtnShow.Enabled := false
  else
    BtnShow.Enabled := true;
end;

procedure TFrmReport4.Edit2Change(Sender: TObject);
begin
  MemoReport.Clear;
end;

procedure TFrmReport4.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    Edit2.SetFocus;
  end;
end;

procedure TFrmReport4.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    BtnShow.SetFocus;
  end;
end;

procedure TFrmReport4.Edit2Enter(Sender: TObject);
begin
  if Edit1.Text = '' then
  begin
    ShowMessage('กรุณาใส่เลขที่บิลเริ่มต้น');
    Edit1.SetFocus;
  end
  else if Edit2.Text = '' then
  begin
    Edit2.Text := Edit1.Text;
    Edit2.SelectAll;
  end
  else Edit2.SelectAll;
end;

procedure TFrmReport4.Button1Click(Sender: TObject);
var PD, PP, PF: Pchar;
  Tmp_dir, Bat_file: string;
begin
  MemoReport.Lines.SaveToFile('c:\CashSales\Report.txt');
  Tmp_dir := 'c:\CashSales\';
  Bat_file := 'c:\CashSales\Print1.bat';
  PD := Pchar(TMP_DIR);
  PP := nil;
  PF := Pchar(Bat_file);
  // uses ShellAPI
  if PF <> nil then ShellExecute(handle, 'open', PF, PP, PD, SW_HIDE);
  BtnClose.SetFocus;
end;

end.
