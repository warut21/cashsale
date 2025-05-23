unit Ureport1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DBCtrls, Grids, DBGrids, ShellAPI, Buttons;
const
  tab1: string = '        ';
  tab2: string = '          ';
  lines: string = '        =================================================================================================================================';
type
  TFrmReport1 = class(TForm)
    MemoReport: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Group_id: TDBLookupComboBox;
    BtnShow: TButton;
    BtnPrint: TButton;
    Label3: TLabel;
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
    S_date: string;
    PageNo: integer;
    procedure ReadData;
    procedure WriteHead;
    procedure Selectdata;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmReport1: TFrmReport1;

implementation

uses Udatamodule, UThai2, PickDate, Ubill;

{$R *.dfm}

procedure TFrmReport1.BtnShowClick(Sender: TObject);
begin
  MemoReport.Clear;
  if Group_id.Text = '' then
  begin
    ShowMessage('กรุณาเลือกแผนกสินค้า');
    Group_id.SetFocus;
  end
  else
  begin
    Selectdata;
    BtnPrint.Enabled := true;
    PageNo := 1;
    WriteHead;
    ReadData;
    BtnPrint.SetFocus;
  end;
end;

procedure TFrmReport1.FormActivate(Sender: TObject);
var
  sqls: string;
begin
  FrmDatamodule.ADOT_PRODGROUP.Active := true;
  MemoReport.Clear;
  BtnShow.Enabled := false;
  BtnPrint.Enabled := false;
  Edit_1.Text := FrmBill.LabelDate.Caption; //Formatdatetime('DD/MM/YYYY',now);
  S_Date := Formatdatetime('YYYY/MM/DD', StrTodate(Edit_1.Text));

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
end;

procedure TFrmReport1.WriteHead;
var
  strline: string;
begin
  strline := tab1 + 'วันที่ : ' + FormatDateTime('dd/mm/yyyy', now) + Thaimid(FrmBill.LabelComp_name.Caption, 101) +
    'หน้า : ' + ThaiRight(IntToStr(PageNo), 4);
  PageNo := PageNo + 1;
  MemoReport.Lines.Add(strline);
  MemoReport.Lines.Add(' ');
  strline := tab1 + 'เวลา : ' + FormatDateTime('hh:nn:ss ', now) + Thaimid('รายงานสรุปการขาย ประจำวันที่ : ' + Edit_1.Text +
    ' ประจำเครื่อง : ' + ThaiLeft(Label6.Caption, 3), 101);
  MemoReport.Lines.Add(strline);
  strline := tab1 + tab1 + tab1 + Thaimid('แผนกสินค้า : ' + ThaiRight(Group_id.Text, 3), 101);
  MemoReport.Lines.Add(strline);
  MemoReport.Lines.Add(lines);
  strline := tab2 + Thaimid('รหัสสินค้า       ', 20) + ThaiRight('ราคาขาย', 10) + ThaiRight('ปริมาณขายสะสม', 23) + ThaiRight('ยอดขายสะสม', 23) + ThaiRight('ปริมาณขายวันนี้', 23) + ThaiRight('ยอดขายวันนี้', 23);
  MemoReport.Lines.Add(strline);
  MemoReport.Lines.Add(lines);
  MemoReport.Lines.Add(' ');
end;

procedure TFrmReport1.Selectdata;
var
  day, day1, sqls, date: string;
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
     { if day <> day1 then date:= Formatdatetime('DD/MM/YYYY',StrToDate(Edit1.Text))
      else
        date:= Formatdatetime('DD/MM/EEEE',StrToDate(Edit1.Text));
      }
  sqls := 'SELECT BILL_HEAD.BILLH_COMP_ID, ' +
    'FINISH_GOODS.FG_GRP, BILL_DETAIL.BILLD_GOODS_ID, BILL_DETAIL.BILLD_GOODS_PRC, ' +
    'Sum(BILL_DETAIL.BILLD_GOODS_NUM) AS SumNum, Sum(BILL_DETAIL.BILLD_AMT) AS SumAmt ' +
    'FROM FINISH_GOODS,BILL_HEAD,BILL_DETAIL ' +
    'WHERE BILL_HEAD.BILLH_NO = BILL_DETAIL.BILLD_NO AND BILL_HEAD.BILLH_COMP_ID = BILL_DETAIL.BILLD_COMP_ID AND FINISH_GOODS.FG_ID = BILL_DETAIL.BILLD_GOODS_ID ' +
    'AND BILL_HEAD.BILLH_COMP_ID = ''' + FrmBill.EdtComp_id.Text + ''' AND BILL_DETAIL.BILLD_STATUS = ''A'' AND FINISH_GOODS.FG_GRP = ''' + Group_id.Text + ''' ' +
    'AND BILL_HEAD.BILLH_DATE = #' + S_DATE + '# ' +
    'GROUP BY BILL_HEAD.BILLH_COMP_ID, FINISH_GOODS.FG_GRP, BILL_DETAIL.BILLD_GOODS_ID, BILL_DETAIL.BILLD_GOODS_PRC ' +
    'ORDER BY BILL_HEAD.BILLH_COMP_ID, FINISH_GOODS.FG_GRP, BILL_DETAIL.BILLD_GOODS_ID, BILL_DETAIL.BILLD_GOODS_PRC ';
  with FrmDatamodule.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sqls);
    Open;
  end;
  sqls := 'SELECT BILL_HEAD.BILLH_COMP_ID, BILL_HEAD.BILLH_DATE,' +
    'FINISH_GOODS.FG_GRP, BILL_DETAIL.BILLD_GOODS_ID, BILL_DETAIL.BILLD_GOODS_PRC, ' +
    'Sum(BILL_DETAIL.BILLD_GOODS_NUM) AS SumNum, Sum(BILL_DETAIL.BILLD_AMT) AS SumAmt ' +
    'FROM FINISH_GOODS,BILL_HEAD,BILL_DETAIL ' +
    'WHERE BILL_HEAD.BILLH_NO = BILL_DETAIL.BILLD_NO AND BILL_HEAD.BILLH_COMP_ID = BILL_DETAIL.BILLD_COMP_ID AND FINISH_GOODS.FG_ID = BILL_DETAIL.BILLD_GOODS_ID ' +
    'AND BILL_HEAD.BILLH_COMP_ID = ''' + FrmBill.EdtComp_id.Text + ''' AND BILL_DETAIL.BILLD_STATUS = ''A'' ' +
    'AND FINISH_GOODS.FG_GRP = ''' + Group_id.Text + ''' AND BILL_HEAD.BILLH_DATE = #' + S_DATE + '# ' +
    'GROUP BY BILL_HEAD.BILLH_COMP_ID, BILL_HEAD.BILLH_DATE,FINISH_GOODS.FG_GRP, BILL_DETAIL.BILLD_GOODS_ID, BILL_DETAIL.BILLD_GOODS_PRC ' +
    'ORDER BY BILL_HEAD.BILLH_COMP_ID, FINISH_GOODS.FG_GRP, BILL_DETAIL.BILLD_GOODS_ID, BILL_DETAIL.BILLD_GOODS_PRC ';
      //Memo1.Lines.Add('atapon0'+#13#10);
      //Memo1.Lines.Add('atapon01'+#13#10);
  with FrmDatamodule.ADOQuery2 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sqls);
    Open;
  end;


end;

procedure TFrmReport1.ReadData;
var
  strline: string;
  wline: integer;
  sum1, sum2, sum3, sum4: double;
begin
  sum1 := 0;
  sum2 := 0;
  sum3 := 0;
  sum4 := 0;
  wline := 1;
  with frmdatamodule.ADOQuery1 do
  begin
    if FrmDatamodule.ADOQuery1.RecordCount <> 0 then
    begin
      while not eof do
      begin
          //assign line sum
        strline := tab2 + thaileft('   ' + fieldvalues['BILLD_GOODS_ID'], 20) +
          thairight(formatcurr('#,##0.00', fieldvalues['BILLD_GOODS_PRC']), 10) +
          thairight(formatcurr('#,##0.00', fieldvalues['SumNum']), 23) +
          thairight(formatcurr('#,##0.00', fieldvalues['SumAmt']), 23);
        sum1 := sum1 + fieldvalues['SumNum'];
        sum2 := sum2 + fieldvalues['SumAmt'];
          //assign line today
        if (FrmDatamodule.ADOQuery2.FieldValues['BILLD_GOODS_ID'] = fieldvalues['BILLD_GOODS_ID'])
          and (FrmDatamodule.ADOQuery2.FieldValues['BILLD_GOODS_PRC'] = fieldvalues['BILLD_GOODS_PRC']) then
        begin
          strline := strline + thairight(formatcurr('#,##0.00', FrmDatamodule.ADOQuery2.fieldvalues['SumNum']), 23) +
            thairight(formatcurr('#,##0.00', FrmDatamodule.ADOQuery2.fieldvalues['SumAmt']), 23);
          sum3 := sum3 + FrmDatamodule.ADOQuery2.fieldvalues['SumNum'];
          sum4 := sum4 + FrmDatamodule.ADOQuery2.fieldvalues['SumAmt'];
          FrmDatamodule.ADOQuery2.Next;
        end
        else
        begin
          strline := strline + thairight(formatcurr('#,##0.00', 0), 23) +
            thairight(formatcurr('#,##0.00', 0), 23);
          sum3 := sum3 + 0;
          sum4 := sum4 + 0;
        end;
        if (wline mod 29) = 0 then
        begin
          MemoReport.Lines.Add(' ');
          MemoReport.Lines.Add(' ');
          WriteHead;
        end;
        MemoReport.lines.add(strline);
        MemoReport.lines.add(' ');
        wline := wline + 1;
        Next;
      end; //end while
      if (wline mod 29) = 0 then
      begin
        MemoReport.Lines.Add(' ');
        MemoReport.Lines.Add(' ');
        WriteHead;
      end;
      MemoReport.Lines.Add(lines);
      strline := tab2 + Thaimid('รวมรายการทั้งหมด :  ', 20) + ThaiRight(IntToStr(wline - 1), 8) + thairight(formatcurr('#,##0.00', sum1), 25) +
        thairight(formatcurr('#,##0.00', sum2), 23) + thairight(formatcurr('#,##0.00', sum3), 23) + thairight(formatcurr('#,##0.00', sum4), 23);
      MemoReport.Lines.Add(strline);
      MemoReport.Lines.Add(lines);
    end //end then
    else
    begin
      strline := tab1 + tab1 + tab1 + thaimid('ไม่มีข้อมูลรายการขายในแผนกสินค้านี้', 101);
      MemoReport.Lines.Add(strline);
    end; //end else
  end; //end with
end;

procedure TFrmReport1.DateTimePicker1Change(Sender: TObject);
begin
  MemoReport.Clear;
end;

procedure TFrmReport1.Group_idClick(Sender: TObject);
begin
  MemoReport.Clear;
  BtnShow.Enabled := true;
  BtnPrint.Enabled := false;
  BtnShow.SetFocus;
end;

procedure TFrmReport1.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmReport1.BtnPrintClick(Sender: TObject);
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

procedure TFrmReport1.Edit_1Change(Sender: TObject);
begin
  MemoReport.Clear;
end;

procedure TFrmReport1.SpdBtnClick(Sender: TObject);
begin
  BrDateForm.Date := Now; { start with current date }
  if BrDateForm.ShowModal = mrOk then
  begin
    Edit_1.text := FormatDatetime('DD/MM/YYYY', BrDateForm.Date);
    S_DATE := FormatDatetime('YYYY/MM/DD', BrDateForm.Date);
    Group_id.SetFocus;
  end;
end;

procedure TFrmReport1.Edit_1Exit(Sender: TObject);
begin
  S_DATE := FormatDatetime('YYYY/MM/DD', StrToDate(Edit_1.text));
end;

end.
