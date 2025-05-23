unit Udiscount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, StdCtrls, ComCtrls, ExtCtrls, Buttons;
type
  TFrmDiscount = class(TForm)
    BvCompany: TBevel;
    LbFGId: TLabel;
    StabrPROMO: TStatusBar;
    disc: TEdit;
    Label1: TLabel;
    BtbOk: TBitBtn;
    procedure discExit(Sender: TObject);
    procedure BtbOkClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    status : string;
  public
    { Public declarations }

  end;

var
  FrmDiscount: TFrmDiscount;

implementation

{$R *.dfm}

uses Udatamodule, UThai2, UBill;


procedure TFrmDiscount.discExit(Sender: TObject);
begin
  status := 'Y';
  if disc.Text  <> '' then
     begin
      try
        disc.Text  :=  FormatFloat('#0.00', StrToFloat(Trim(disc.Text)));
      except
        on E: EConvertError do
           begin
             Showmessage('กรุณาป้อนข้อมูลเป็นตัวเลข');
             status := 'N';
             disc.SetFocus;
           end;
      end;
      if StrToFloat(Trim(disc.Text)) > 100 then
         begin
           Showmessage('กรุณาป้อนข้อมูล ไม่เกิน 100.00 เท่านั้น');
           status := 'N';
           disc.SetFocus;
         end;
     end;

end;

procedure TFrmDiscount.BtbOkClick(Sender: TObject);
var DValue : double;
begin
  discExit(disc);
  if status = 'N' then
     disc.SetFocus
  else
      begin
        FrmBill.LblDiscount.Caption :=   disc.Text;
        FrmBill.Caltotprice;
        FrmDiscount.Hide;
      end;
end;

procedure TFrmDiscount.FormActivate(Sender: TObject);
begin
  if FrmBill.LblDiscount.Caption = '0.00' then
     disc.Text := '0.00'
  else
     disc.Text := FrmBill.LblDiscount.Caption;
  disc.SetFocus;
end;

end.
