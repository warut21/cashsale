unit Uposload;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons;

type
  TFrmLoadtxt = class(TForm)
    MemoHead: TMemo;
    MemoDet: TMemo;
    SaveDialog2: TSaveDialog;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    BtnLoad: TButton;
    BtnClose: TButton;
    Label1: TLabel;
    Label2: TLabel;
    DateSales: TEdit;
    SpdBtn: TSpeedButton;
    Label3: TLabel;
    procedure BtnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnLoadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpdBtnClick(Sender: TObject);
  private
    { Private declarations }
    procedure trn;
  public
    { Public declarations }
  end;

var
  FrmLoadtxt: TFrmLoadtxt;

implementation

uses Udatamodule, Uload, Ubill, PickDate;

{$R *.dfm}

procedure TFrmLoadtxt.BtnLoadClick(Sender: TObject);
var
  sqls, day, day1: string;
begin
  sqls := 'SELECT * FROM CONTROL Where COMP_ID =''' + FrmBill.EdtComp_id.Text + '''';
  with FrmDatamodule.ADOQuery0 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sqls);
    Open;
    day := fieldvalues['SALESDATE'];
    day1 := fieldvalues['TRANSFERDATE'];
  end;
  if day = day1 then trn
  else
  begin
    ShowMessage('ไม่สามารถทำการโหลดข้อมูลได้' + #13 + 'เนื่องจากยังไม่ได้ทำการยกยอดสิ้น ณ วัน');
    BtnClose.SetFocus;
    FrmLoadtxt.Close;
  end;

end;

procedure TFrmLoadtxt.BtnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TFrmLoadtxt.FormShow(Sender: TObject);
begin
  Label1.Visible := False;
end;

procedure TFrmLoadtxt.trn;
var
  sqls, txt1, txt2: string;
  i, len, Level: integer;
  S_date : string;
begin

  MemoHead.Clear;
  MemoDet.Clear;
  i := 1;

  S_Date := Formatdatetime('YYYY/MM/DD', StrTodate(DateSales.Text));
  sqls := 'Select BILLH_NO From BILL_HEAD '+#13#10+
          'Where (BILLH_COMP_ID =''' +  FrmBill.EdtComp_id.Text + ''' ) '+#13#10+
          ' and (BILLH_LOAD = ''0''  )'+#13#10+
          ' and (BILLH_DATE = #' + S_DATE + '# ) '+#13#10+
          ' Order by BILLH_NO'

  ;
  FrmDataModule.SQL_Q(FrmDataModule.ADOQuery0,sqls,FrmDatamodule.App_Sql+'trn1.txt');

  if FrmDataModule.ADOQuery0.RecordCount = 0 then
  begin
    ShowMessage('ไม่สามารถทำการโหลดข้อมูลได้เนื่องจากมีการโหลดข้อมูลไปแล้ว');
    BtnClose.SetFocus;
    BtnLoad.Enabled := false;
  end
  else
      //*****
  begin
    SaveDialog2.Filename := 'POS';
    if SaveDialog2.Execute then
    begin
      if FileExists(SaveDialog2.Filename) {then
            if MessageDlg('Overwrite ' + SaveDialog2.FileName + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
            }then deletefile(SaveDialog2.Filename);
      ProgressBar1.Position := 0;
      with FrmDataModule.ADOQuery0 do
      begin
        First;
        while not eof do
        begin
          MemoHead.Lines.Add(LoadHead(FrmBill.EdtComp_id.Text, FieldValues['BILLH_NO']));

          S_Date := Formatdatetime('YYYY/MM/DD', StrTodate(DateSales.Text));
          sqls := 'Select BILLD_NO,BILLD_LINE From BILL_DETAIL Where BILLD_COMP_ID =''' + FrmBill.EdtComp_id.Text +
            ''' And BILLD_NO = ''' + FrmDataModule.ADOQuery0.FieldValues['BILLH_NO'] + ''' And BILLD_LOAD = ''0''' +
//            ' and (BILLH_DATE = #' + S_DATE + '# ) '+#13#10+
            ' Order By BILLD_COMP_ID,BILLD_NO,BILLD_LINE';

          FrmDataModule.SQL_Q(FrmDataModule.ADOQuery1,sqls,FrmDatamodule.App_Sql+'trn2.txt');

          with FrmDataModule.ADOQuery1 do
          begin
            while not eof do
            begin
              MemoDet.Lines.Add(LoadDet(FrmBill.EdtComp_id.Text, FieldValues['BILLD_NO'], FieldValues['BILLD_LINE']));
              next;
            end;
          end;
          Next;
          ProgressBar1.Position := round(i * 100 / (RecordCount) / 2);
          i := i + 1;
        end;
      end;

      MemoHead.Lines.SaveToFile('C:\CashSales\Database\POSHEAD.txt');
      MemoDet.Lines.SaveToFile('C:\CashSales\Database\POSDET.txt');
        //*****
      Level := FrmDataModule.ADOConnection.BeginTrans;
      try

        with FrmDataModule.ADOQuery0 do
        begin
          First;
          while not eof do
          begin
            sqls := 'Update BILL_HEAD Set BILLH_LOAD = ''1'' Where BILLH_COMP_ID = ''' + FrmBill.EdtComp_id.Text +
              ''' And BILLH_NO = ''' + FrmDataModule.ADOQuery0.FieldValues['BILLH_NO'] + '''';

            FrmDataModule.EXE_SQL(FrmDataModule.ADOQuery2 ,sqls,FrmDatamodule.App_Sql+'trn_U1.txt');

            sqls := 'Update BILL_DETAIL Set BILLD_LOAD = ''1'' Where BILLD_COMP_ID = ''' + FrmBill.EdtComp_id.Text +
              ''' And BILLD_NO = ''' + FrmDataModule.ADOQuery0.FieldValues['BILLH_NO'] + '''';

            FrmDataModule.EXE_SQL(FrmDataModule.ADOQuery3 ,sqls,FrmDatamodule.App_Sql+'trn_U2.txt');

            Next;
            ProgressBar1.Position := round(i * 100 / (RecordCount) / 2);
            i := i + 1;
          end;
        end;
        FrmDataModule.ADOConnection.CommitTrans;
        Label1.Visible := true;
      except
        on E: Exception do
        begin
          FrmDataModule.ADOConnection.RollbackTrans;
          Showmessage('ไม่สามารถโหลดข้อมูลได้ กรุณาลองใหม่อีกครั้ง');
        end;
      end; //end try
        //*****
    end;
    len := length(SaveDialog2.Filename);
    txt1 := Copy(SaveDialog2.Filename, 1, len - 4) + 'HEAD.txt';
    txt2 := Copy(SaveDialog2.Filename, 1, len - 4) + 'DET.txt';
    copyFile(pchar('C:\CashSales\Database\POSHEAD.txt'), pchar(txt1), False);
    copyFile(pchar('C:\CashSales\Database\POSDET.txt'), pchar(txt2), False);
    BtnClose.SetFocus;
    BtnLoad.Enabled := false;
  end;
end;

procedure TFrmLoadtxt.FormCreate(Sender: TObject);
begin
  DateSales.Text := FormatDatetime('DD/MM/YYYY', now);
end;

procedure TFrmLoadtxt.SpdBtnClick(Sender: TObject);
begin
  BrDateForm.Date := Now; { start with current date }
  if BrDateForm.ShowModal = mrOk then
  begin
    Datesales.text := FormatDatetime('DD/MM/YYYY', BrDateForm.Date);
  end;
end;

end.
