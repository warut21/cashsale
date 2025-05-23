unit Uconfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, Mask, Buttons, ComCtrls;

type
  TFrmConfig = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Edit3: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit8: TEdit;
    Edit7: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Label11: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    SpdBtn: TSpeedButton;
    Edt_Date: TEdit;
    Lbls: TLabel;
    Lble: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edt_DateKeyPress(Sender: TObject; var Key: Char);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure Edit6KeyPress(Sender: TObject; var Key: Char);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure Edit8KeyPress(Sender: TObject; var Key: Char);
    procedure Edit9KeyPress(Sender: TObject; var Key: Char);
    procedure Edit10KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2Enter(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit3Enter(Sender: TObject);
    procedure Edit5Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure SpdBtnClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
  private
    procedure Showdata;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConfig: TFrmConfig;

implementation

uses Udatamodule, Upassconfig, PickDate;

{$R *.dfm}

procedure TFrmConfig.FormCreate(Sender: TObject);
begin
      ShortDateFormat:='DD/MM/YYYY';
      FrmPassconfig := TFrmPassconfig.create(Application);
      FrmPassconfig.ShowModal;
end;

procedure TFrmConfig.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
    Bitbtn2.Enabled:=true;
    If key = #13 then
      begin
      key := #0;
      Edit2.SetFocus;
      end;
end;

procedure TFrmConfig.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
    If key = #13 then
      begin
      key := #0;
      Edit3.SetFocus;
      end;
end;

procedure TFrmConfig.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
    If key = #13 then
      begin
      key := #0;
      Edt_Date.SetFocus;
      end;
end;

procedure TFrmConfig.Edt_DateKeyPress(Sender: TObject; var Key: Char);
begin
    If key = #13 then
      begin
      key := #0;
      Edit5.SetFocus;
      end;
end;

procedure TFrmConfig.Edit5KeyPress(Sender: TObject; var Key: Char);
begin
    If key = #13 then
      begin
      key := #0;
      Edit6.SetFocus;
      end;
end;

procedure TFrmConfig.Edit6KeyPress(Sender: TObject; var Key: Char);
begin
    If key = #13 then
      begin
      key := #0;
      Edit7.SetFocus;
      end;
end;

procedure TFrmConfig.Edit7KeyPress(Sender: TObject; var Key: Char);
begin
    If key = #13 then
      begin
      key := #0;
      Edit8.SetFocus;
      end;
end;

procedure TFrmConfig.Edit8KeyPress(Sender: TObject; var Key: Char);
begin
    If key = #13 then
      begin
      key := #0;
      Edit9.SetFocus;
      end;
end;

procedure TFrmConfig.Edit9KeyPress(Sender: TObject; var Key: Char);
begin
    If key = #13 then
      begin
      key := #0;
      Edit10.SetFocus;
      end;
end;

procedure TFrmConfig.Edit10KeyPress(Sender: TObject; var Key: Char);
begin
    If key = #13 then
      begin
      key := #0;
      Bitbtn2.SetFocus;
      end;
end;

procedure TFrmConfig.Edit2Enter(Sender: TObject);
var
  sqls :string;
begin
      if Edit1.Text = '' then
        begin
        Showmessage('กรุณาใส่รหัสบริษัท');
        Edit1.SetFocus;
        end
      else
        begin
        sqls := 'Select COMP_NAME'+#13#10+'From COMPANY'+#13#10+
                'Where COMP_ID = '''+Edit1.Text+''' ';
        with FrmDatamodule.ADOQuery1 do
        begin
        Close;
        SQL.Clear;
        SQL.Add(sqls);
        Open;
        end;
        if FrmDatamodule.ADOQuery1.RecordCount = 0 then
          begin
            Showmessage('รหัสบริษัทไม่ถูกต้อง หรืออาจจะยังไม่มีรหัสนี้ในฐานข้อมูล');
            Edit1.SetFocus;
          end
        else
          Label11.Caption:= FrmDatamodule.ADOQuery1.FieldValues['COMP_NAME'];
        end;
end;

procedure TFrmConfig.BitBtn2Click(Sender: TObject);
var
  sqls,day,day1,date,date1 :string;
  reps :word;
begin
  if (Edit2.Text = '') or (Edit3.Text = '') then    ShowMessage('กรุณาใส่ข้อมูลให้ครบถ้วน')
  else
    begin
      sqls := 'Select *'+#13#10+'From CONTROL'+#13#10+
              'Where COMP_ID = '''+Edit1.Text+''' ';
      FrmDatamodule.ADOQuery1.Close;
      FrmDatamodule.ADOQuery1.SQL.Clear;
      FrmDatamodule.ADOQuery1.SQL.Add(sqls);
      FrmDatamodule.ADOQuery1.Open;

      sqls := 'SELECT * FROM PROGRAMER';
      FrmDatamodule.ADOQuery0.Close;
      FrmDatamodule.ADOQuery0.SQL.Clear;
      FrmDatamodule.ADOQuery0.SQL.Add(sqls);
      FrmDatamodule.ADOQuery0.Open;
      day := FrmDatamodule.ADOQuery0.fieldvalues['date'];
      day1 := FrmDatamodule.ADOQuery0.fieldvalues['create_date'];
      {
      if day <> day1 then
        begin
        date:= Formatdatetime('DD/MM/YYYY',StrToDate(Edt_Date.Text));
        date1:= Formatdatetime('DD/MM/YYYY',StrToDate(Edt_Date.Text)-1);
        end
      else  }
        begin
        date:= Formatdatetime('DD/MM/EEEE',StrToDate(Edt_Date.Text));
        date1:= Formatdatetime('DD/MM/EEEE',StrToDate(Edt_Date.Text)-1);
        end;

      if FrmDatamodule.ADOQuery1.RecordCount = 0 then
          begin
          sqls := 'INSERT INTO CONTROL VALUES ('''+Edit1.Text+''', '''+Edit2.Text+''', '''+Edit3.Text+
                  ''', '''+date+''', '''+date1+''', '''+date1+''', '''+Edit8.Text+''', '''+Edit7.Text+
                  ''', ''0'', ''0'', '''+Edit10.Text+''', '''+Edit9.Text+''', ''0'', ''0'', '''+Edit3.Text+Edit5.Text+''', '''+Edit3.Text+Edit6.Text+''')';
          with FrmDatamodule.ADOQuery2 do
          begin
          Close;
          SQL.Clear;
          SQL.Add(sqls);
          SQL.SaveToFile('c:\sql.txt'); 
          ExecSQL;
          end;
          ShowMessage('บันทึกข้อมูลเรีบยร้อยแล้ว');
          Bitbtn2.Enabled:=false;
          Bitbtn1.SetFocus;
          end
      else
        begin
        reps := MessageDlg('คุณต้องการแก้ไขข้อมูลที่ทำการบันทึกไว้ก่อนหน้านี้แล้วใช่หรือไม่',mtConfirmation,[mbYes,mbNo],0);
        if reps = MrYes then
          begin
            sqls := 'UPDATE CONTROL SET PC_ID ='''+Edit2.Text+''', PC_NAME ='''+Edit3.Text+
                  ''', STDATE ='''+date+''', SALESDATE ='''+date1+''', TRANSFERDATE ='''+date1+''', ACCU_AMT ='''+Edit8.Text+''', ACCU_BILL ='''+Edit7.Text+
                  ''', TODAY_AMT =''0'', TODAY_BILL =''0'', ACCU_AMT_C ='''+Edit10.Text+''', ACCU_BILL_C ='''+Edit9.Text+''', TODAY_AMT_C =''0'', TODAY_BILL_C =''0'', START_BILL_NO ='''+
                  Edit3.Text+Edit5.Text+''', CUR_BILL_NO ='''+Edit3.Text+Edit6.Text+'''';
          with FrmDatamodule.ADOQuery2 do
          begin
          Close;
          SQL.Clear;
          SQL.Add(sqls);
          ExecSQL;
          end;
            ShowMessage('แก้ไขข้อมูลเรีบยร้อยแล้ว');
            Bitbtn2.Enabled:=false;
            Bitbtn1.SetFocus;
          end
        else
          Bitbtn2.Enabled:=false;
          Bitbtn1.SetFocus;
        end;
    end;

end;

procedure TFrmConfig.Edit3Enter(Sender: TObject);
begin
      if (Edit1.Text = '') and (Edit2.Text = '') then
        begin
        Showmessage('กรุณาใส่รหัสบริษัท และ หมายเลขเครื่อง');
        Edit1.SetFocus;
        end
      else
        if (Edit2.Text = '') then
          begin
          Showmessage('กรุณาใส่หมายเลขเครื่อง');
          Edit2.SetFocus;
          end;
end;

procedure TFrmConfig.Edit5Enter(Sender: TObject);
begin
      if Edit1.Text = '' then
        begin
        Showmessage('กรุณาใส่รหัสบริษัท');
        Edit1.SetFocus;
        end;
      if Edit2.Text = '' then
        begin
        Showmessage('กรุณาใส่หมายเลขเครื่อง');
        Edit2.SetFocus;
        end;
      if Edit3.Text = '' then
        begin
        Showmessage('กรุณาใส่ชื่อเครื่อง');
        Edit3.SetFocus;
        end;
end;

procedure TFrmConfig.Edit1Exit(Sender: TObject);
var
  sqls:string;
begin
    sqls:='select * From CONTROL Where COMP_ID ='''+Edit1.Text+'''';
    with FrmDatamodule.ADOQuery0 do
    begin
      Close;
      SQL.Clear;
      SQL.Add(sqls);
      Open;
    end;
    if FrmDatamodule.ADOQuery0.RecordCount <> 0 then Showdata;
end;

procedure TFrmConfig.Showdata;
var
    sbill,ebill:string;
begin
    with FrmDatamodule.ADOQuery0 do
    begin
    Edit2.Text:=FieldValues['PC_ID'];
    Edit3.Text:=FieldValues['PC_NAME'];
    Lbls.Caption:=Edit3.Text;
    Lble.Caption:=Edit3.Text;
    Edt_Date.Text:=FormatDatetime('DD/MM/YYYY',FieldValues['STDATE']);
    sbill:=FieldValues['START_BILL_NO'];
    Edit5.Text:=copy(sbill,4,5);
    ebill:=FieldValues['CUR_BILL_NO'];
    Edit6.Text:=copy(sbill,4,5);
    Edit7.Text:=FieldValues['ACCU_BILL'];
    Edit8.Text:=FieldValues['ACCU_AMT'];
    Edit9.Text:=FieldValues['ACCU_BILL_C'];
    Edit10.Text:=FieldValues['ACCU_AMT_C'];
    end;
end;

procedure TFrmConfig.SpdBtnClick(Sender: TObject);
begin
  BrDateForm.Date := Now ; 	{ start with current date }
  if BrDateForm.ShowModal = mrOk then
  begin
    Edt_Date.text := FormatDatetime('DD/MM/YYYY',BrDateForm.Date);
    Edit5.SetFocus;
  end;
end;

procedure TFrmConfig.Edit1Change(Sender: TObject);
begin
    Edit2.Clear;
    Edit3.Clear;
    Edit5.Text:='00000';
    Edit6.Text:='00000';
    Edit7.Text:='0';
    Edit8.Text:='0.00';
    Edit9.Text:='0';
    Edit10.Text:='0.00';
    Label11.Caption:='';
end;

procedure TFrmConfig.FormShow(Sender: TObject);
begin
      if FrmPassconfig.pass = false then FrmConfig.Close;
      FrmPassconfig.Free;
      Edt_Date.Text:=Formatdatetime('DD/MM/YYYY',now);
end;

procedure TFrmConfig.Edit3Exit(Sender: TObject);
begin
    Lbls.Caption:=Edit3.Text;
    Lble.Caption:=Edit3.Text;
end;

end.
