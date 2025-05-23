unit Uconfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, Mask, Buttons, ComCtrls,adodb;

type
  TFrmConfig = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Label5: TLabel;
    Edit3: TEdit;
    Edit5: TEdit;
    Label11: TLabel;
    BitBtn2: TBitBtn;
    Lbls: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2Enter(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit3Enter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConfig: TFrmConfig;

implementation

uses Udatamodule, Upassconfig, UThai2;

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
      Edit3.SetFocus;
      end;
end;

procedure TFrmConfig.Edit3KeyPress(Sender: TObject; var Key: Char);
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
  sqls,day,day1,date,date1,pcid :string;
  reps :word;
begin
      sqls := 'SELECT * FROM PROGRAMER';
      FrmDatamodule.ADOQuery0.Close;
      FrmDatamodule.ADOQuery0.SQL.Clear;
      FrmDatamodule.ADOQuery0.SQL.Add(sqls);
      FrmDatamodule.ADOQuery0.Open;
      day := FrmDatamodule.ADOQuery0.fieldvalues['date'];
      day1 := FrmDatamodule.ADOQuery0.fieldvalues['create_date'];

      if day <> day1 then
        begin
        date:= Formatdatetime('DD/MM/YYYY',now);
        date1:= Formatdatetime('DD/MM/YYYY',now-1);
        end
      else
        begin
        date:= Formatdatetime('DD/MM/EEEE',now);
        date1:= Formatdatetime('DD/MM/EEEE',now-1);
        end;
      pcid := Copy(Edit1.Text+'0',1,4)+'00000'+Copy(Edit3.Text,Length(Edit3.Text),Length(Edit3.Text));
      reps := MessageDlg('คุณต้องการล้างข้อมูลใช่หรือไม่',mtConfirmation,[mbYes,mbNo],0);
      if reps = MrYes then
        begin
          sqls := 'UPDATE CONTROL SET PC_ID ='''+pcid+''', PC_NAME ='''+Edit3.Text+
                'X'', STDATE ='''+date+''', SALESDATE ='''+date1+''', TRANSFERDATE ='''+date1+''', ACCU_AMT =''0'', ACCU_BILL =''0'''+
                ', TODAY_AMT =''0'', TODAY_BILL =''0'', ACCU_AMT_C =''0'', ACCU_BILL_C =''0'', TODAY_AMT_C =''0'', TODAY_BILL_C =''0'', START_BILL_NO ='''+Edit3.Text+'X'+Edit5.Text+''''+
                ', CUR_BILL_NO ='''+Edit3.Text+'X'+Edit5.Text+'''';
          with FrmDatamodule.ADOQuery2 do
          begin
          Close;
          SQL.Clear;
          SQL.Add(sqls);
          ExecSQL;
          end;
          sqls := 'DELETE FROM BILL_DETAIL';
          with FrmDatamodule.ADOQuery3 do
          begin
          Close;
          SQL.Clear;
          SQL.Add(sqls);
          ExecSQL;
          end;

          sqls := 'DELETE FROM BILL_HEAD';
          with FrmDatamodule.ADOQuery3 do
          begin
          Close;
          SQL.Clear;
          SQL.Add(sqls);
          ExecSQL;
          end;

          sqls := 'DELETE FROM BILL_PROMO';
          with FrmDatamodule.ADOQuery3 do
          begin
          Close;
          SQL.Clear;
          SQL.Add(sqls);
          ExecSQL;
          end;

          ShowMessage('ทำการล้างข้อมูลเรีบยร้อยแล้ว');
          Application.Terminate;
        end
      else
        Bitbtn2.SetFocus;

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
end;

procedure TFrmConfig.FormShow(Sender: TObject);
begin
      if FrmPassconfig.pass = false then FrmConfig.Close;
      FrmPassconfig.Free;
end;

procedure TFrmConfig.Edit3Exit(Sender: TObject);
begin
    Lbls.Caption:=Edit3.Text+'X';
end;

procedure TFrmConfig.Edit3Enter(Sender: TObject);
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

end.
