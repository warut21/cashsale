unit Ureport2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DBCtrls, Grids, DBGrids, ShellAPI, Buttons;
const
  tab1: string = '';
  tab2: string = '  ';
  lines: string = '=======================================================================================================================';
type
  TFrmReport2 = class(TForm)
    MemoReport: TMemo;
    Label1: TLabel;
    BtnShow: TButton;
    BtnPrint: TButton;
    LabelComp: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    BtnClose: TButton;
    Edit_1: TEdit;
    SpdBtn: TSpeedButton;
    procedure BtnShowClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure Group_idClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure BtnPrintClick(Sender: TObject);
    procedure Edit_1Change(Sender: TObject);
    procedure SpdBtnClick(Sender: TObject);
    procedure Edit_1Exit(Sender: TObject);
  private
    S_DATE: string;
    PageNo: integer;
    procedure ReadData;
    procedure WriteHead;
    procedure Selectdata;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmReport2: TFrmReport2;

implementation

uses Udatamodule, UThai2, PickDate, Ubill;

{$R *.dfm}

procedure TFrmReport2.BtnShowClick(Sender: TObject);

begin
  PageNo := 1;
  BtnPrint.Enabled := true;
  MemoReport.Clear;
  Selectdata;
  WriteHead;
  ReadData;
end;

procedure TFrmReport2.FormActivate(Sender: TObject);
var
  sqls: string;
begin
  PageNo := 1;
  MemoReport.Clear;
  Edit_1.Text := FrmBill.LabelDate.Caption;
  S_date := Formatdatetime('YYYY/MM/DD', StrtoDate(Edit_1.Text));
  LabelComp.Caption := FrmBill.LabelComp_name.Caption;
  sqls := 'Select PC_NAME From CONTROL Where COMP_ID = ''' + FrmBill.EdtComp_id.Text + '''';
  with FrmDatamodule.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sqls);
    Open;
    Label6.Caption := copy(FieldValues['PC_NAME'], 1, 2);
    Close;
  end;
  BtnPrint.Enabled := true;
  MemoReport.Clear;
  Selectdata;
  WriteHead;
  ReadData;
  BtnPrint.SetFocus;
end;

procedure TFrmReport2.WriteHead;
var
  strline: string;
begin
  strline := tab1 + 'วันที่ : ' + FormatDateTime('dd/mm/yyyy', now) + Thaimid(FrmBill.LabelComp_name.Caption, 91) +
    'หน้า : ' + ThaiRight(IntToStr(PageNo), 4);
  PageNo := PageNo + 1;
  MemoReport.Lines.Add(strline);
  MemoReport.Lines.Add(' ');
  strline := tab1 + 'เวลา : ' + FormatDateTime('hh:nn:ss ', now) + Thaimid('รายงานยอดขาย ประจำวันที่ : ' + Edit_1.Text +
    ' ประจำเครื่อง : ' + ThaiLeft(Label6.Caption, 3), 101);
  MemoReport.Lines.Add(strline);
  MemoReport.Lines.Add(' ');
  MemoReport.Lines.Add(lines);
  strline := tab2 + tab2 + '       ยอดขายวันปัจจุบัน         ยอดcancelวันปัจจุบัน               ยอดขายสะสม          ยอดCancelสะสม';
  MemoReport.Lines.Add(strline);
    //MemoReport.Lines.Add(tab2+tab1+'------------------------------------------------------------------------------');
  strline := tab1 + ThaiLeft('แผนก', 5) + ThaiRight('ปริมาณ', 8) + ThaiRight('จำนวนเงิน', 15) + ThaiRight('ใบ', 6) +
    ThaiRight('จำนวนเงิน', 17) + ThaiRight('ปริมาณ', 14) + ThaiRight('จำนวนเงิน', 15) + ThaiRight('ใบ', 6) + ThaiRight('จำนวนเงิน', 17);
  MemoReport.Lines.Add(strline);
  MemoReport.Lines.Add(lines);
  MemoReport.Lines.Add(' ');
end;

procedure TFrmReport2.Selectdata;
var
  sqls, day, day1, date: string;
begin
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
{      if day <> day1 then  date:= Formatdatetime('DD/MM/YYYY',StrToDate(Edit1.Text))

      else
         date := Formatdatetime('DD/MM/EEEE',StrToDate(Edit1.Text));
 }
  sqls := 'SELECT * ' +
    'FROM PRODGROUP ' +
    'ORDER BY GRP_ID ';
  with FrmDatamodule.ADOQuery0 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sqls);
    Open;
  end;
  sqls := 'SELECT BILL_HEAD.BILLH_COMP_ID, ' +
    'FINISH_GOODS.FG_GRP, Sum(BILL_DETAIL.BILLD_GOODS_NUM) AS SumNum, Sum(BILL_DETAIL.BILLD_AMT) AS SumAmt ' +
    'FROM FINISH_GOODS,BILL_HEAD,BILL_DETAIL ' +
    'WHERE BILL_HEAD.BILLH_NO = BILL_DETAIL.BILLD_NO ' +
    ' AND BILL_HEAD.BILLH_COMP_ID = BILL_DETAIL.BILLD_COMP_ID ' +
    ' AND FINISH_GOODS.FG_ID = BILL_DETAIL.BILLD_GOODS_ID ' +
    ' AND BILL_HEAD.BILLH_COMP_ID = ''' + FrmBill.EdtComp_id.Text + ''' AND BILL_HEAD.BILLH_STATUS = ''A'' ' +
    ' AND BILL_HEAD.BILLH_DATE <= #' + S_DATE + '# ' +
    'GROUP BY BILL_HEAD.BILLH_COMP_ID, FINISH_GOODS.FG_GRP ' +
    'ORDER BY BILL_HEAD.BILLH_COMP_ID, FINISH_GOODS.FG_GRP ';
  with FrmDatamodule.ADOQuery3 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sqls);
    Open;
  end;
  sqls := 'SELECT BILLH_COMP_ID,BILLH_FG_GRP, ' +
    'Count(BILLH_NO) AS SumBill, Sum(BILLH_AMT) AS SumAmtCancel ' +
    'FROM BILL_HEAD ' +
    'WHERE BILLH_COMP_ID = ''' + FrmBill.EdtComp_id.Text + ''' AND BILLH_STATUS = ''C'' ' +
    'AND BILLH_DATE <= #' + S_Date + '# ' +
    'GROUP BY BILLH_COMP_ID, BILLH_FG_GRP ' +
    'ORDER BY BILLH_COMP_ID, BILLH_FG_GRP ';
  with FrmDatamodule.ADOQuery4 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sqls);
    Open;
  end;
  sqls := 'SELECT BILL_HEAD.BILLH_COMP_ID, ' +
    'FINISH_GOODS.FG_GRP, Sum(BILL_DETAIL.BILLD_GOODS_NUM) AS SumNum, Sum(BILL_DETAIL.BILLD_AMT) AS SumAmt ' +
    'FROM FINISH_GOODS,BILL_HEAD,BILL_DETAIL ' +
    'WHERE BILL_HEAD.BILLH_NO = BILL_DETAIL.BILLD_NO AND BILL_HEAD.BILLH_COMP_ID = BILL_DETAIL.BILLD_COMP_ID AND FINISH_GOODS.FG_ID = BILL_DETAIL.BILLD_GOODS_ID ' +
    'AND BILL_HEAD.BILLH_COMP_ID = ''' + FrmBill.EdtComp_id.Text + ''' AND BILL_HEAD.BILLH_STATUS = ''A'' ' +
    'AND BILL_HEAD.BILLH_DATE = #' + S_date + '# ' +
    'GROUP BY BILL_HEAD.BILLH_COMP_ID, FINISH_GOODS.FG_GRP ' +
    'ORDER BY BILL_HEAD.BILLH_COMP_ID, FINISH_GOODS.FG_GRP ';
  with FrmDatamodule.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sqls);
    Open;
  end;
  sqls := 'SELECT BILLH_COMP_ID,BILLH_FG_GRP, ' +
    'Count(BILLH_NO) AS SumBill, Sum(BILLH_AMT) AS SumAmtCancel ' +
    'FROM BILL_HEAD ' +
    'WHERE BILLH_COMP_ID = ''' + FrmBill.EdtComp_id.Text + ''' AND BILLH_STATUS = ''C'' ' +
    'AND BILLH_DATE = #' + S_date + '# ' +
    'GROUP BY BILLH_COMP_ID, BILLH_FG_GRP ' +
    'ORDER BY BILLH_COMP_ID, BILLH_FG_GRP ';
  with FrmDatamodule.ADOQuery2 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sqls);
//        SQL.SaveToFile('c:\ADOQuery2.txt') ;
    Open;
  end;
end;

procedure TFrmReport2.ReadData;
var
  strline: string;
  wline: integer;
  sum1, sum2, sum3, sum4, sum5, sum6, sum7, sum8: double;
begin
  sum1 := 0;
  sum2 := 0;
  sum3 := 0;
  sum4 := 0;
  sum5 := 0;
  sum6 := 0;
  sum7 := 0;
  sum8 := 0;
  wline := 1;
    {*****}
  with frmdatamodule.ADOQuery0 do
  begin
    while not eof do
    begin
          //assign line sum
      if (fieldvalues['GRP_ID'] <> FrmDatamodule.ADOQuery3.FieldValues['FG_GRP']) and (fieldvalues['GRP_ID'] <> FrmDatamodule.ADOQuery4.FieldValues['BILLH_FG_GRP']) then
      begin
        Next;
        Continue;
      end;
      strline := tab2 + thaiLeft(fieldvalues['GRP_ID'], 3);
      if (FrmDatamodule.ADOQuery1.FieldValues['FG_GRP'] = fieldvalues['GRP_ID']) then
      begin
        strline := strline + thairight(formatcurr('#,##0.00', FrmDatamodule.ADOQuery1.fieldvalues['SumNum']), 8) +
          thairight(formatcurr('#,##0.00', FrmDatamodule.ADOQuery1.fieldvalues['SumAmt']), 15);
        sum1 := sum1 + FrmDatamodule.ADOQuery1.fieldvalues['SumNum'];
        sum2 := sum2 + FrmDatamodule.ADOQuery1.fieldvalues['SumAmt'];
        FrmDatamodule.ADOQuery1.Next;
      end
      else
      begin
        strline := strline + thairight(formatcurr('#,##0', 0), 8) +
          thairight(formatcurr('#,##0.00', 0), 15);
        sum1 := sum1 + 0;
        sum2 := sum2 + 0;
      end;
      if (FrmDatamodule.ADOQuery2.FieldValues['BILLH_FG_GRP'] = fieldvalues['GRP_ID']) then
      begin
        strline := strline + thairight(formatcurr('#,##0', FrmDatamodule.ADOQuery2.fieldvalues['SumBill']), 6) +
          thairight(formatcurr('#,##0.00', FrmDatamodule.ADOQuery2.fieldvalues['SumAmtCanCel']), 17);
        sum3 := sum3 + FrmDatamodule.ADOQuery2.fieldvalues['SumBill'];
        sum4 := sum4 + FrmDatamodule.ADOQuery2.fieldvalues['SumAmtCancel'];
        FrmDatamodule.ADOQuery2.Next;
      end
      else
      begin
        strline := strline + thairight(formatcurr('#,##0', 0), 6) +
          thairight(formatcurr('#,##0.00', 0), 17);
        sum3 := sum3 + 0;
        sum4 := sum4 + 0;
      end;
          //assign line today
      if (FrmDatamodule.ADOQuery3.FieldValues['FG_GRP'] = fieldvalues['GRP_ID']) then
      begin
        strline := strline + thairight(formatcurr('#,##0.00', FrmDatamodule.ADOQuery3.fieldvalues['SumNum']), 14) +
          thairight(formatcurr('#,##0.00', FrmDatamodule.ADOQuery3.fieldvalues['SumAmt']), 15);
        sum5 := sum5 + FrmDatamodule.ADOQuery3.fieldvalues['SumNum'];
        sum6 := sum6 + FrmDatamodule.ADOQuery3.fieldvalues['SumAmt'];
        FrmDatamodule.ADOQuery3.Next;
      end
      else
      begin
        strline := strline + thairight(formatcurr('#,##0.00', 0), 14) +
          thairight(formatcurr('#,##0.00', 0), 15);
        sum5 := sum5 + 0;
        sum6 := sum6 + 0;
      end;
      if (FrmDatamodule.ADOQuery4.FieldValues['BILLH_FG_GRP'] = fieldvalues['GRP_ID']) then
      begin
        strline := strline + thairight(formatcurr('#,##0', FrmDatamodule.ADOQuery4.fieldvalues['SumBill']), 6) +
          thairight(formatcurr('#,##0.00', FrmDatamodule.ADOQuery4.fieldvalues['SumAmtCancel']), 17);
        sum7 := sum7 + FrmDatamodule.ADOQuery4.fieldvalues['SumBill'];
        sum8 := sum8 + FrmDatamodule.ADOQuery4.fieldvalues['SumAmtCancel'];
        FrmDatamodule.ADOQuery4.Next;
      end
      else
      begin
        strline := strline + thairight(formatcurr('#,##0', 0), 6) +
          thairight(formatcurr('#,##0.00', 0), 17);
        sum7 := sum7 + 0;
        sum8 := sum8 + 0;
      end;
      if (wline mod 28) = 0 then
      begin
        MemoReport.Lines.Add(' ');
        MemoReport.Lines.Add(' ');
        MemoReport.Lines.Add(' ');
        WriteHead;
      end;
      MemoReport.lines.add(strline);
      MemoReport.lines.add(' ');
      wline := wline + 1;
      Next;
    end; //end while
        //sumary line
    if (wline mod 28) = 0 then
    begin
      MemoReport.Lines.Add(' ');
      MemoReport.Lines.Add(' ');
      MemoReport.Lines.Add(' ');
      WriteHead;
    end;
    MemoReport.Lines.Add(lines);
    strline := tab1 + ThaiLeft(' รวม ', 5) + thairight(formatcurr('#,##0.00', sum1), 8) +
      thairight(formatcurr('#,##0.00', sum2), 15) + thairight(formatcurr('#,##0', sum3), 6) +
      thairight(formatcurr('#,##0.00', sum4), 17) + thairight(formatcurr('#,##0.00', sum5), 14) +
      thairight(formatcurr('#,##0.00', sum6), 15) + thairight(formatcurr('#,##0', sum7), 6) +
      thairight(formatcurr('#,##0.00', sum8), 17);
    MemoReport.Lines.Add(strline);
    MemoReport.Lines.Add(lines);
  end; //end with
    {*****}
end;

procedure TFrmReport2.DateTimePicker1Change(Sender: TObject);
begin
  MemoReport.Clear;
end;

procedure TFrmReport2.Group_idClick(Sender: TObject);
begin
  MemoReport.Clear;
end;

procedure TFrmReport2.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmReport2.BtnPrintClick(Sender: TObject);
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

procedure TFrmReport2.Edit_1Change(Sender: TObject);
begin
  MemoReport.Clear;
  BtnPrint.Enabled := false;
  BtnShow.Enabled := true;

end;

procedure TFrmReport2.SpdBtnClick(Sender: TObject);
begin
  BrDateForm.Date := Now; { start with current date }
  if BrDateForm.ShowModal = mrOk then
  begin
    Edit_1.text := FormatDatetime('DD/MM/YYYY', BrDateForm.Date);
    S_DATE := FormatDatetime('YYYY/MM/DD', BrDateForm.Date);
    BtnShow.Enabled := true;
    BtnShow.SetFocus;
  end;
end;

procedure TFrmReport2.Edit_1Exit(Sender: TObject);
begin
  S_DATE := FormatDatetime('YYYY/MM/DD', StrToDate(Edit_1.text));
end;

end.
