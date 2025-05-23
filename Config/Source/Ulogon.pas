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
    Button1: TButton;
    Label3: TLabel;
    Label6: TLabel;
    DateSales: TEdit;
    SpdBtn: TSpeedButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EdtComp_idKeyPress(Sender: TObject; var Key: Char);
    procedure EdtSales_idKeyPress(Sender: TObject; var Key: Char);
    procedure EdtSales_passKeyPress(Sender: TObject; var Key: Char);
    procedure EdtSales_idEnter(Sender: TObject);
    procedure EdtSales_passEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SpdBtnClick(Sender: TObject);
  private
    numpass:integer;
    { Private declarations }
  public
    { Public declarations }
    pass,endday : boolean;
  end;

var
  FrmLogon: TFrmLogon;

implementation

uses Udatamodule, Ubill, PickDate, Uendday;

{$R *.dfm}

procedure TFrmLogon.Button2Click(Sender: TObject);
begin
    pass:=false;
    Close;
end;

procedure TFrmLogon.Button1Click(Sender: TObject);
var
  sqls,day,day1,date : string;
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
      if day <> day1 then date:= Formatdatetime('DD/MM/YYYY',StrToDate(DateSales.Text))
      else
        date:= Formatdatetime('DD/MM/EEEE',StrToDate(DateSales.Text));

      sqls := 'Select SALES_PASS From SALESMAN Where COMP_ID = '''+Trim(EdtComp_id.Text)+''' And SALES_ID = '''+Trim(EdtSales_id.Text)+''' ';
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
        if EdtSales_pass.Text = FrmDatamodule.ADOQuery1.FieldValues['SALES_PASS'] then
          begin
          pass:=true;
          close;
          end
        else
          begin
          showmessage('รหัสผ่านไม่ถูกต้อง กรุณาใส่รหัสใหม่');
          if numpass = 3 then close;
          numpass:=numpass+1;
          EdtSales_pass.SetFocus;
          end;
        end;
end;

procedure TFrmLogon.EdtComp_idKeyPress(Sender: TObject; var Key: Char);
begin
    LabelComp_name.Caption:='';
    If key = #13 then
      begin
      key := #0;
      EdtSales_id.SetFocus;
      end;
end;

procedure TFrmLogon.EdtSales_idKeyPress(Sender: TObject; var Key: Char);
begin
    EdtSales_pass.Clear;
    If key = #13 then
      begin
      key := #0;
      EdtSales_pass.SetFocus;
      end;
end;

procedure TFrmLogon.EdtSales_passKeyPress(Sender: TObject; var Key: Char);
begin
    If key = #13 then
      begin
      key := #0;
      Button1.SetFocus;
      end;
end;

procedure TFrmLogon.EdtSales_idEnter(Sender: TObject);
var
  sqls:string;
begin
      if Trim(EdtComp_id.Text) = '' then
        begin
        Showmessage('กรุณาใส่รหัสบริษัท');
        EdtComp_id.SetFocus;
        end
      else
        begin
        sqls := 'Select COMP_NAME From COMPANY Where COMP_ID = '''+Trim(EdtComp_id.Text)+''' ';
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
            LabelComp_name.Caption:= FrmDatamodule.ADOQuery1.FieldValues['COMP_NAME'];
        end;

end;

procedure TFrmLogon.EdtSales_passEnter(Sender: TObject);
var sqls : string;
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
          sqls := 'Select SALES_ID From SALESMAN Where COMP_ID = '''+Trim(EdtComp_id.Text)+'''  and SALES_ID = '''+Trim(EdtSales_id.Text)+''' ';
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
    pass := false;
    endday:=false;
    numpass:=1;
    ShortDateFormat:='dd/mm/yyyy';
    DateSales.Text := FormatDatetime('DD/MM/YYYY',now);
end;

procedure TFrmLogon.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13then
   begin
       selectnext(activecontrol,true,true);
       key:=#0;
   end;
end;

procedure TFrmLogon.SpdBtnClick(Sender: TObject);
begin
  BrDateForm.Date := Now ; 	{ start with current date }
  if BrDateForm.ShowModal = mrOk then
  begin
    Datesales.text := FormatDatetime('DD/MM/YYYY',BrDateForm.Date);
  end;
end;

end.
