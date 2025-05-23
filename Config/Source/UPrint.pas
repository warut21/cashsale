unit UPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls,ShellAPI  ;

    { Private declarations }
    function  PrintDirectLPT1(Data : string): Boolean;
    function Generate_Print_Bill(comcode :string ; billno : string ;var msg_err : string ): boolean;

implementation

uses Udatamodule, UThai2;


function PrintDirectLPT1(Data : string): Boolean;
var
  LPTHandle : THandle; // Handle of the print file
  B : array [1..2048] of Char;
begin
  FillChar(B,SizeOf(B),0);   // this should be faster
  Move(Data[1],B[1],Length(Data)); // this should also increase speed.
  LPTHandle := FileOpen('LPT1', fmOpenWrite);
  Result := FileWrite(LPTHandle, B, SizeOf(B)) <> -1;
  FileClose(LPTHandle);
end;

function Generate_Print_Bill(comcode :string ; billno : string; var msg_err :string ) : boolean;
var fg_unit : string ;
    i , wline : integer;
    strsql , strline , stramt: string;
    price , qty , amt,totamt : Double	;
    p_result : boolean;
    strprint : string;

const maxline : shortint = 13 ;
      strf_line : string = '       '; //space 7 char
begin

  strprint := '';
  msg_err := '';
  with frmdatamodule.ADOQuery1 do
    begin
      close;
     sql.clear;
      strsql := 'SELECT * ' +#13#10 +
                '  FROM BILL_HEAD INNER JOIN BILL_DETAIL ON BILL_HEAD.BILLH_NO = BILL_DETAIL.BILLD_NO ' +
                '  AND  BILL_HEAD.BILLH_COMP_ID = BILL_DETAIL.BILLD_COMP_ID ' +#13#10 +
                '  WHERE BILL_HEAD.BILLH_COMP_ID = ''' + comcode + ''''  +
                '    AND BILL_HEAD.BILLH_NO      = ''' + billno  + '''' ;
     sql.Add(strsql);
      open;
    end;

  if FrmDatamodule.ADOQuery1.RecordCount <> 0 then
    begin
     with  frmdatamodule.ADOQuery1 do
        begin
          // header bill
         for i := 1 to 5 do  strprint := strprint +#13#10;
         strline := strf_line +
                        ThaiRight( formatdatetime('dd/mm/yyyy',fieldValues['BILLH_DATE']),16 ) +
                        thairight(fieldValues['BILLH_NO'],43) ;
           strprint := strprint + strline +#13#10;
         for i := 1 to 3 do  strprint := strprint +#13#10;

         // item bill
          wline   := 1;
          Repeat
            //**select unit of goods from table finish_goods
            frmdatamodule.ADOT_FINISH_GOODS.Active := false;
            frmdatamodule.ADOT_FINISH_GOODS.Filter := 'fg_id =''' + fieldvalues['BILLD_GOODS_ID'] + '''';
            frmdatamodule.ADOT_FINISH_GOODS.Filtered := true;
            frmdatamodule.ADOT_FINISH_GOODS.Active := true;
           if frmdatamodule.ADOT_FINISH_GOODS.RecordCount <> 0 then
              fg_unit := frmdatamodule.ADOT_FINISH_GOODS.FieldValues['FG_UNITS']
            else
              fg_unit := ' ';

            //**calculate amount  price
            amt := fieldvalues['BILLD_AMT'] ;
            qty := fieldvalues['BILLD_GOODS_NUM'];
            price := amt / qty;


            //assign line
            strline := strf_line + ' ' +
                       thaileft( inttostr(wline),3) + ' ' +
                       thaileft(fieldvalues['BILLD_GOODS_ID'],21)  +
                       thairight(formatcurr('#,##0.00',qty),7)   + ' ' +
                       thaimid(fg_unit,7) +
                       thairight(formatcurr('#,##0.00',price),8) + ' ' +
                       thairight(formatcurr('#,##0.00',amt),10) ;
            strprint := strprint + strline +#13#10;
            Next;
            wline := wline + 1;
          until eof ;

          //total amount of bill
          totamt := fieldvalues['BILLH_AMT'] ;
          for i := 1 to ( maxline - wline ) + 1 do  strprint := strprint +#13#10;
          stramt := ThaiMoney(totamt);
          if round(totamt) = totamt then stramt := stramt + 'ถ้วน' ;
          stramt  := '(' + stramt + ')';
          strline := strf_line + thairight(stramt,40) +
                     thairight(formatcurr('#,##0.00',totamt),20) +#13#10 ;
          strprint := strprint + strline +#13#10;

          totamt :=  fieldvalues['BILLH_AMT'] - fieldvalues['BILLH_AMT_VAT'] ;
          strline :=  strf_line + thairight(formatcurr('#,##0.00',totamt),60)  ;
          strprint := strprint + strline +#13#10;

          strline := strf_line + thairight('7%',47) +
                     thairight(formatcurr('#,##0.00',fieldvalues['BILLH_AMT_VAT']),13);
          strprint := strprint + strline +#13#10;


         for i := 1 to 7 do  strprint := strprint  +#13#10; //7 end page

         if   PrintDirectLPT1( strprint )  then p_result := true
         else
          begin
            p_result := false;
            msg_err :=  'ไม่สามารถทำการพิมพ์บิลได้' ;
          end;

  //      PrintDirectLPT1(#27#67#0#5 +memoprint.Text + #12);

        end;

   end //**if
  else
    begin
      p_result := false;
      msg_err := 'ไม่สามารถค้นหาข้อมูลที่จะทำการพิมพ์ได้';
    end;
  Generate_Print_Bill := p_result;

end;



end.
