unit Ulogon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask, DBCtrls, ComCtrls, Buttons;

type
  TFrmLogon = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EdtSales_id: TEdit;
    EdtSales_pass: TEdit;
    Panel2: TPanel;
    Button2: TButton;
    EdtComp_id: TEdit;
    LabelComp_name: TLabel;
    Panel3: TPanel;
    btt_logon: TButton;
    Label3: TLabel;
    Label6: TLabel;
    DateSales: TEdit;
    SpdBtn: TSpeedButton;
    procedure Button2Click(Sender: TObject);
    procedure btt_logonClick(Sender: TObject);
    procedure EdtComp_idKeyPress(Sender: TObject; var Key: Char);
    procedure EdtSales_idKeyPress(Sender: TObject; var Key: Char);
    procedure EdtSales_passKeyPress(Sender: TObject; var Key: Char);
    procedure EdtSales_idEnter(Sender: TObject);
    procedure EdtSales_passEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpdBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    numpass: integer;
    is_first_run : boolean;
    procedure run_with_param;
    { Private declarations }
  public
    { Public declarations }
    pass, endday: boolean;
  end;

var
  FrmLogon: TFrmLogon;
  Mutex: integer;

implementation

uses Udatamodule, Ubill, PickDate, Uendday;

{$R *.dfm}

procedure TFrmLogon.Button2Click(Sender: TObject);
begin
  pass := false;
  Close;
end;

  function Convdatetoeng(const date_ent: string): string;
  var dd, yy: string;
  begin
    dd := copy(date_ent, 1, length(date_ent) - 4);
    yy := inttostr(strtoint(copy(date_ent, length(date_ent) - 3, 4)) - 543);
    convdatetoeng := dd + yy;
  end;

  procedure Chk_tran;
  var
    sqls: string;
    day, day1: Tdatetime;
  begin
    sqls := 'SELECT * FROM CONTROL Where COMP_ID =''' + FrmLogon.EdtComp_id.text + '''';

    with FrmDatamodule.ADOQuery0 do
    begin
      Close;
      SQL.Clear;
      SQL.Add(sqls);
      Open;
    //  if recordcount > 0 then
      begin
        day := StrToDate(FrmLogon.DateSales.Text);
        day1 := StrTodate(Convdatetoeng(Fieldvalues['TRANSFERDATE']));

        if day <= day1 then
        begin
          ShowMessage('มีการยกยอดสิ้นวันแล้ว   กรุณาตรวจสอบวันที่ขายสินค้าใหม่' + #13#10 +
            'วันที่ขาย (พ.ศ.)  :' + formatdatetime('DD/MM/EEEE', day) + #13#10 +
            'วันที่ยกยอด (พ.ศ.):' + formatdatetime('DD/MM/EEEE', day1)

            );

        {BtnClose.SetFocus;
        FrmLoadtxt.Close;}
        end;
      end;
    end;
  end;

procedure TFrmLogon.btt_logonClick(Sender: TObject);
var
  sqls, day, day1: string;        
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
{
      if day <> day1 then date:= Formatdatetime('DD/MM/YYYY',StrToDate(DateSales.Text))
      else
        date:= Formatdatetime('DD/MM/EEEE',StrToDate(DateSales.Text));
 }
  sqls := 'Select SALES_PASS From SALESMAN Where COMP_ID = ''' + Trim(EdtComp_id.Text) + ''' And SALES_ID = ''' + Trim(EdtSales_id.Text) + ''' ';
  with FrmDatamodule.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sqls);
    Open;
  end;

  if FrmDataModule.ADOQuery1.RecordCount = 0 then
  begin
    showmessage('ข้อมูลไม่ถูกต้อง กรุณาใส่ข้อมูลใหม่');
    EdtSales_id.SetFocus;
  end
  else
  begin
    if trim(EdtSales_pass.Text) = trim(FrmDatamodule.ADOQuery1.FieldValues['SALES_PASS']) then
    begin
      pass := true;
      close;
    end
    else
    begin
      showmessage('รหัสผ่านไม่ถูกต้อง กรุณาใส่รหัสใหม่');
      if numpass = 3 then close;
      numpass := numpass + 1;
      EdtSales_pass.SetFocus;
    end;
  end;
  chk_tran;
end;


procedure TFrmLogon.EdtComp_idKeyPress(Sender: TObject; var Key: Char);
begin
  LabelComp_name.Caption := '';
  if key = #13 then
  begin
    key := #0;
    EdtSales_id.SetFocus;
  end;
end;

procedure TFrmLogon.EdtSales_idKeyPress(Sender: TObject; var Key: Char);
begin
  EdtSales_pass.Clear;
  if key = #13 then
  begin
    key := #0;
    EdtSales_pass.SetFocus;
  end;
end;

procedure TFrmLogon.EdtSales_passKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    btt_logon.SetFocus;
  end;
end;

procedure TFrmLogon.EdtSales_idEnter(Sender: TObject);
var
  sqls: string;
begin
  if Trim(EdtComp_id.Text) = '' then
  begin
    Showmessage('กรุณาใส่รหัสบริษัท');
    EdtComp_id.SetFocus;
  end
  else
  begin
    sqls := 'Select COMP_NAME From COMPANY Where COMP_ID = ''' + Trim(EdtComp_id.Text) + ''' ';
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
      EdtComp_id.SetFocus;
    end
    else
      LabelComp_name.Caption := FrmDatamodule.ADOQuery1.FieldValues['COMP_NAME'];
  end;

end;

procedure TFrmLogon.EdtSales_passEnter(Sender: TObject);
var sqls: string;
begin
  if (Trim(EdtComp_id.Text) = '') and (Trim(EdtSales_id.Text) = '') then
  begin
    Showmessage('กรุณาใส่รหัสบริษัท และ รหัสพนักงานขาย');
    EdtComp_id.SetFocus;
  end
  else if (Trim(EdtSales_id.Text) = '') then
  begin
    Showmessage('กรุณาใส่รหัสพนักงานขาย');
    EdtSales_id.SetFocus;
  end
  else
  begin
    sqls := 'Select SALES_ID From SALESMAN Where COMP_ID = ''' + Trim(EdtComp_id.Text) + '''  and SALES_ID = ''' + Trim(EdtSales_id.Text) + ''' ';
    with FrmDatamodule.ADOQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add(sqls);
      Open;
    end;
    if FrmDatamodule.ADOQuery1.RecordCount = 0 then
    begin
      Showmessage('ใส่รหัสพนักงานไม่ถูกต้อง หรืออาจจะยังไม่มีรหัสนี้ในฐานข้อมูล');
      EdtSales_id.SetFocus;
    end;
  end;
end;

procedure TFrmLogon.FormCreate(Sender: TObject);
begin
  is_first_run := True;
  pass := false;
  endday := false;
  numpass := 1;
  ShortDateFormat := 'dd/mm/yyyy';
  DateSales.Text := FormatDatetime('DD/MM/YYYY', now);
{
  if FormatdateTime('DD/MM/EEEE', StrtoDate('01/01/2000')) <> '01/01/2543' then
  begin
    showmessage('Regional ไม่ได้ Set เป็น Thai');
   application.Terminate;
  end;
} 
  FrmDataModule.App_dir := ExtractFilePath(Application.EXEName);
  FrmDataModule.App_sql := FrmDataModule.App_dir + 'SQL\';

  if not DirectoryExists(FrmDataModule.App_sql) then MkDir(FrmDataModule.app_sql);
end;

procedure TFrmLogon.SpdBtnClick(Sender: TObject);
begin
  BrDateForm.Date := Now; { start with current date }
  if BrDateForm.ShowModal = mrOk then
  begin
    Datesales.text := FormatDatetime('DD/MM/YYYY', BrDateForm.Date);
  end;
end;


procedure TFrmLogon.FormActivate(Sender: TObject);
begin
  FrmLogon.Caption := 'เข้าสู่ระบบ POS '+ CK_Version;
  if (ParamCount > 1)and is_first_run then
  begin
    run_with_param;
    is_first_run := False;
  end;
end;

procedure TFrmLogon.run_with_param;
var  i : integer;
     S_P :array[1..6] of string;
begin
  for i := 1 to (ParamCount) do
  begin
    {if LowerCase(ParamStr(i)) = 'beep' then
      Beep(10000,1000)
    else if (LowerCase(ParamStr(i)) = 'exit' then
      Application.Terminate;}
    S_P[i] := (ParamStr(i));
   // showmessage(S_P[i]);
  end;

  EdtComp_id.text := S_P[1];

  EdtSales_idEnter(self);
  EdtSales_id.text := S_P[2];

  EdtSales_passEnter(self);
  EdtSales_pass.text := S_P[3];

 // FrmLogon.Button1Click(Sender: TObject);

  if btt_logon.Enabled then
  begin
    btt_logon.SetFocus;
    btt_logonClick(Self);
  end;
end;



initialization

  Mutex := CreateMutEx(nil, True, 'MyMutEx');
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    MessageDlg('This Program already exists in memory check in system tray', mtError, [mbOK], 0);
    Halt;
  end;

finalization
  if Mutex <> 0 then
    CloseHandle(Mutex);

end.
