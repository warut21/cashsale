unit Uendday;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFrmEndday = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    BtnOK: TButton;
    BtnCancel: TButton;
    procedure FormActivate(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
  private
    procedure updatedata;
    { Private declarations }
  public
    endfinish: boolean;
    { Public declarations }
  end;

var
  FrmEndday: TFrmEndday;

implementation

uses Udatamodule, Ubill;

{$R *.dfm}

procedure TFrmEndday.FormActivate(Sender: TObject);
begin
  BtnOK.SetFocus;
end;

procedure TFrmEndday.BtnCancelClick(Sender: TObject);
begin
  endfinish := false;
  Close;
end;

procedure TFrmEndday.BtnOKClick(Sender: TObject);
begin
  updatedata;
  close;
end;

procedure TFrmEndday.updatedata;
var
  sqls: string;
  Bill1, Bill2, Billc1, Billc2: integer;
  Amt1, Amt2, Amtc1, Amtc2: double;
begin
  sqls := 'Select * from Control where COMP_ID = ''' + FrmBill.EdtComp_id.Text + '''';
  with FrmDatamodule.ADOQuery0 do
  begin
    Close;
    SQL.Clear;
    sQL.Add(sqls);
    Open;
    Amt1 := FieldValues['ACCU_AMT'];
    Amt2 := FieldValues['TODAY_AMT'];
    Bill1 := FieldValues['ACCU_BILL'];
    Bill2 := FieldValues['TODAY_BILL'];
    Amtc1 := FieldValues['ACCU_AMT_C'];
    Amtc2 := FieldValues['TODAY_AMT_C'];
    Billc1 := FieldValues['ACCU_BILL_C'];
    Billc2 := FieldValues['TODAY_BILL_C'];
  end;
  with FrmDataModule.ADOT_CONTROL do
  begin
    Active := true;
    Edit;
    FieldbyName('COMP_ID').AsString := FrmBill.EdtComp_id.Text;
    FieldbyName('TRANSFERDATE').AsDateTime := FrmDatamodule.ADOQuery0.FieldValues['SALESDATE'];
    FieldbyName('ACCU_AMT').AsFloat := Amt1;// + Amt2;
    FieldbyName('ACCU_BILL').AsInteger := Bill1 + Bill2;
    FieldbyName('ACCU_AMT_C').AsFloat := Amtc1 + Amtc2;
    FieldbyName('ACCU_BILL_C').AsInteger := Billc1 + Billc2;
    FieldbyName('TODAY_AMT').AsFloat := 0.00;
    FieldbyName('TODAY_BILL').AsInteger := 0;
    FieldbyName('TODAY_AMT_C').AsFloat := 0.00;
    FieldbyName('TODAY_BILL_C').AsInteger := 0;


    Post;
    ShowMessage('ทำการยกยอด ณ สิ้นวันเรียบร้อยแล้ว');
    endfinish := true;
  end;

end;

end.
