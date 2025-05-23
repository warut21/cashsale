unit Ureport3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DBCtrls, Grids, DBGrids,ShellAPI, Buttons;
Const
     tab1 : String = '        ';
     tab2 : String = '          ';
     lines : string = '        ==============================================================================================';
type
  TFrmReport3 = class(TForm)
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
    SpdBtn: TSpeedButton;
    SpdBtn1: TSpeedButton;
    procedure BtnShowClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Group_idClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure BtnPrintClick(Sender: TObject);
    procedure SpdBtnClick(Sender: TObject);
    procedure SpdBtn1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
  private
    PageNo : integer;
    procedure ReadData;
    procedure WriteHead;
    procedure Selectdata;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmReport3: TFrmReport3;

implementation

uses Udatamodule, UThai2, PickDate, Ubill;

{$R *.dfm}

procedure TFrmReport3.BtnShowClick(Sender: TObject);

begin
    if Edit2.Text < Edit1.Text then
      begin
      ShowMessage('ใส่ข้อมูลวันที่ไม่ถูกต้องกรุณาใส่ใหม่');
      end
    else
      begin
      MemoReport.Clear;
      BtnPrint.Enabled:=true;
      Selectdata;
      PageNo := 1;
      WriteHead;
      ReadData;
      BtnPrint.SetFocus;
      end;
end;

procedure TFrmReport3.FormActivate(Sender: TObject);
var
  sqls:string;
begin
      MemoReport.Clear;
      BtnPrint.Enabled:=false;
      Edit1.Text:= Formatdatetime('DD/MM/YYYY',now);
      Edit2.Text:= Formatdatetime('DD/MM/YYYY',now);
      LabelComp.Caption:= FrmBill.LabelComp_name.Caption;
      sqls := 'Select PC_NAME From CONTROL Where COMP_ID = '''+FrmBill.EdtComp_id.Text+'''';
      with FrmDatamodule.ADOQuery1 do
        begin
        Close;
        SQL.Clear;
        SQL.Add(sqls);
        Open;
        Label6.Caption:= copy(FieldValues['PC_NAME'],1,2);
        Close;
        end;
      BtnShow.SetFocus;
end;

procedure TFrmReport3.WriteHead;
var
  strline:string;
begin
    strline := tab1+'วันที่ : '+FormatDateTime('dd/mm/yyyy',now)+Thaimid(FrmBill.LabelComp_name.Caption,66)+
                'หน้า : '+ThaiRight(IntToStr(PageNo),4);
    PageNo := PageNo+1;
    MemoReport.Lines.Add(strline);
    MemoReport.Lines.Add(' ');
    strline := tab1+'เวลา : '+FormatDateTime('hh:nn:ss ',now)+Thaimid('รายงานการขาย ประจำวันที่ : '+Formatdatetime('DD/MM/YYYY',StrToDate(Edit1.Text))+' ถึงวันที่ '+Formatdatetime('DD/MM/YYYY',StrToDate(Edit2.Text)),66);
    MemoReport.Lines.Add(strline);
    strline := tab1+Thaimid('ประจำเครื่อง : '+Label6.Caption,98);
    MemoReport.Lines.Add(strline);
    MemoReport.Lines.Add(lines);
    strline := tab1+ThaiRight('วันเดือนปี',10)+ThaiRight('เลขที่เอกสาร',15)+ThaiRight('รหัสลูกค้า',11)+ThaiRight('ยอดขายสุทธิ',14)+
                ThaiRight('VAT',15)+ThaiRight('ยอดขาย',15);
    MemoReport.Lines.Add(strline);
    MemoReport.Lines.Add(lines);
    MemoReport.Lines.Add(' ');
end;

procedure TFrmReport3.Selectdata;
var
  sqls,day1,day :string;
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
        sqls := 'SELECT BILLH_COMP_ID,BILLH_NO,BILLH_DATE,BILLH_CUST_ID,BILLH_AMT,BILLH_AMT_VAT, (BILLH_AMT-BILLH_AMT_VAT)AS AMT '+
              'FROM BILL_HEAD '+
              'WHERE BILLH_COMP_ID = '''+FrmBill.EdtComp_id.Text+
              ''' AND BILLH_STATUS = ''A'' AND BILLH_DATE >= DateValue('''+Formatdatetime('DD/MM/YYYY',StrToDate(Edit1.Text))+''') AND BILLH_DATE <= DateValue('''+Formatdatetime('DD/MM/YYYY',StrToDate(Edit2.Text))+''')' +
              'GROUP BY BILLH_COMP_ID, BILLH_NO,BILLH_DATE,BILLH_CUST_ID,BILLH_AMT,BILLH_AMT_VAT '+
              'ORDER BY BILLH_COMP_ID, BILLH_NO,BILLH_DATE,BILLH_CUST_ID,BILLH_AMT,BILLH_AMT_VAT '
        else
        sqls := 'SELECT BILLH_COMP_ID,BILLH_NO,BILLH_DATE,BILLH_CUST_ID,BILLH_AMT,BILLH_AMT_VAT, (BILLH_AMT-BILLH_AMT_VAT)AS AMT '+
              'FROM BILL_HEAD '+
              'WHERE BILLH_COMP_ID = '''+FrmBill.EdtComp_id.Text+
              ''' AND BILLH_STATUS = ''A'' AND BILLH_DATE >= DateValue('''+Formatdatetime('DD/MM/EEEE',StrToDate(Edit1.Text))+''') AND BILLH_DATE <= DateValue('''+Formatdatetime('DD/MM/EEEE',StrToDate(Edit2.Text))+''')' +
              'GROUP BY BILLH_COMP_ID, BILLH_NO,BILLH_DATE,BILLH_CUST_ID,BILLH_AMT,BILLH_AMT_VAT '+
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

procedure TFrmReport3.ReadData;
var
  strline:string;
  wline :integer;
  sum1,sum2,sum3 :double;
begin
    sum1:=0;
    sum2:=0;
    sum3:=0;
    wline:=1;
    {*****}
    with frmdatamodule.ADOQuery0 do
    begin
      if frmdatamodule.ADOQuery0.RecordCount = 0 then
         begin
         strline := Thaimid('ไม่มีข้อมูลที่ต้องการแสดง',100);
         MemoReport.Lines.Add(strline);
         end
      else
        begin
         While not eof do
         begin
          strline := tab2+Thairight(FormatDatetime('DD/MM/YYYY',Fieldvalues['BILLH_DATE']),10)+Thairight(Fieldvalues['BILLH_NO'],13)+
                     Thairight(Fieldvalues['BILLH_CUST_ID'],10)+Thairight(formatcurr('#,##0.00',Fieldvalues['AMT']),15)+
                     Thairight(formatcurr('#,##0.00',Fieldvalues['BILLH_AMT_VAT']),15)+Thairight(formatcurr('#,##0.00',Fieldvalues['BILLH_AMT']),15);
          MemoReport.Lines.Add(strline);
          MemoReport.Lines.Add(' ');
          sum1:=sum1+Fieldvalues['AMT'];
          sum2:=sum2+Fieldvalues['BILLH_AMT_VAT'];
          sum3:=sum3+Fieldvalues['BILLH_AMT'];
          wline := wline+1;
          if (wline mod 29) = 0 then
            begin
            MemoReport.Lines.Add(' ');
            MemoReport.Lines.Add(' ');
            WriteHead;
            end;
          Next;
         end;//end while
         if (wline mod 29) = 0 then
          begin
          MemoReport.Lines.Add(' ');
          MemoReport.Lines.Add(' ');
          WriteHead;
          end;
          MemoReport.Lines.Add(lines);
          strline := tab1+ThaiLeft(' จำนวนรายการทั้งหมด :  ',22)+thaileft(formatcurr('#,##0',wline-1),13)+
                  thairight(formatcurr('#,##0.00',sum1),15)+thairight(formatcurr('#,##0.00',sum2),15)+
                  thairight(formatcurr('#,##0.00',sum3),15);
          MemoReport.Lines.Add(strline);
          MemoReport.Lines.Add(lines);
        end;//end else
    end; //end with
    {*****}
end;

procedure TFrmReport3.Group_idClick(Sender: TObject);
begin
    MemoReport.Clear;
end;

procedure TFrmReport3.BtnCloseClick(Sender: TObject);
begin
    Close;
end;

procedure TFrmReport3.BtnPrintClick(Sender: TObject);
var PD,PP,PF : Pchar;
    Tmp_dir,Bat_file :string;
begin
  MemoReport.Lines.SaveToFile('c:\CashSales\Report.txt');
  Tmp_dir := 'c:\CashSales\';
  Bat_file := 'c:\CashSales\Print1.bat';
  PD:=Pchar(TMP_DIR);
  PP:=Nil;
  PF:=Pchar(Bat_file);
  // uses ShellAPI
  if PF <> nil then ShellExecute(handle,'open',PF,PP,PD,SW_HIDE);
  BtnClose.SetFocus;
end;

procedure TFrmReport3.SpdBtnClick(Sender: TObject);
begin
  BrDateForm.Date := Now ; 	{ start with current date }
  if BrDateForm.ShowModal = mrOk then
  begin
    Edit1.text := FormatDatetime('DD/MM/YYYY',BrDateForm.Date);
    BtnShow.SetFocus;
  end;
end;

procedure TFrmReport3.SpdBtn1Click(Sender: TObject);
begin
  BrDateForm.Date := Now ; 	{ start with current date }
  if BrDateForm.ShowModal = mrOk then
  begin
    Edit2.text := FormatDatetime('DD/MM/YYYY',BrDateForm.Date);
    BtnShow.SetFocus;
  end;
end;

procedure TFrmReport3.Edit1Change(Sender: TObject);
begin
    MemoReport.Clear;
    BtnPrint.Enabled:=false;
end;

procedure TFrmReport3.Edit2Change(Sender: TObject);
begin
    MemoReport.Clear;
    BtnPrint.Enabled:=false;
end;

end.
