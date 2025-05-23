unit Uload;

interface
uses Sysutils;

function LoadHead(Comp_id, Bill_no: string): string;
function LoadDet(Comp_id, Bill_no, Bill_line: string): string;

implementation

uses Udatamodule, UThai2;

function LoadHead(Comp_id, Bill_no: string): string;
var
  sqls, text, buf: string;

begin
  sqls := 'Select * From BILL_HEAD Where BILLH_COMP_ID =''' + Comp_id + ''' And BILLH_NO =''' + Bill_no + '''' +
    ' Order By BILLH_COMP_ID,BILLH_NO';
  with FrmDataModule.ADOQuery5 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sqls);
    Open;
    text := FieldValues['BILLH_NO'];
    buf := Formatdatetime('DD/MM/YYYY', FieldValues['BILLH_DATE']);
    text := text + copy(buf, 1, 2) + copy(buf, 4, 2) + copy(buf, 9, 2);
    buf := '00000000' + FieldValues['BILLH_CUST_ID'];
    text := text + ThaiRight(buf, 8);
    buf := '000' + formatcurr('###0', FieldValues['BILLH_NUM']);
    text := text + ThaiRight(buf, 3);
    buf := '0000000000' + formatcurr('###0', (FieldValues['BILLH_AMT'] - FieldValues['BILLH_AMT_VAT']) * 100);
    text := text + ThaiRight(buf, 10);
    buf := '0000000000' + formatcurr('###0', FieldValues['BILLH_AMT_VAT'] * 100);
    text := text + ThaiRight(buf, 10);
    text := text + FieldValues['BILLH_STATUS'];
    buf := '00000' + formatcurr('###0', FieldValues['BILLH_DISCOUNT'] * 100);
    text := text + ThaiRight(buf, 5);    
    LoadHead := text;
  end;
end;

function LoadDet(Comp_id, Bill_no, Bill_line: string): string;
var
  sqls, text, buf: string;

begin
  sqls := 'Select * From BILL_DETAIL,FINISH_GOODS Where BILL_DETAIL.BILLD_GOODS_ID = FINISH_GOODS.FG_ID '
    + 'And BILLD_COMP_ID =''' + Comp_id + ''' And BILLD_NO =''' + Bill_no + ''' And BILLD_LINE = ' + Bill_line
    + ' Order By BILLD_COMP_ID,BILLD_NO,BILLD_LINE';
  with FrmDataModule.ADOQuery4 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sqls);
    Open;
    text := FieldValues['BILLD_NO'];
    buf := '00' + formatcurr('###0', FieldValues['BILLD_LINE']);
    text := text + ThaiRight(buf, 2);
    buf := FieldValues['BILLD_GOODS_ID'] + '                 ';
    text := text + ThaiLeft(buf, 18);
    text := text + FieldValues['FG_GRADE'];
    buf := FieldValues['FG_UNITS'] + '   ';
    text := text + ThaiLeft(buf, 2);
    buf := '0000000000' + formatcurr('###0', FieldValues['BILLD_GOODS_PRC'] * 100);
    text := text + ThaiRight(buf, 10);
    buf := '000000' + formatcurr('###0', FieldValues['BILLD_GOODS_NUM'] * 100);
    text := text + ThaiRight(buf, 6);
    buf := '0000000000' + formatcurr('###0', (FieldValues['BILLD_AMT'] - FieldValues['BILLD_AMT_VAT']) * 100);
    text := text + ThaiRight(buf, 10);
    buf := '0000000000' + formatcurr('###0', FieldValues['BILLD_AMT_VAT'] * 100);
    text := text + ThaiRight(buf, 10) + FieldValues['FG_GRP'] + FieldValues['FG_WH'];
    LoadDet := text;
  end;

end;

end.
