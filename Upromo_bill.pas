unit Upromo_bill;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, StdCtrls, ComCtrls, ExtCtrls, Buttons;
type
  TFrmPROMOBILL = class(TForm)
    BvCompany: TBevel;
    LbFGId: TLabel;
    BtbOk: TBitBtn;
    StabrPROMO: TStatusBar;
    Panel2: TPanel;
    ProDsc01: TLabel;
    Label49: TLabel;
    Label1: TLabel;
    ProNo01: TComboBox;
    MatDsc11: TLabel;
    MatPrc11: TLabel;
    BILLNO: TEdit;
    ProQty01: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ProDsc02: TLabel;
    ProNo02: TComboBox;
    ProQty02: TEdit;
    Label11: TLabel;
    ProDsc03: TLabel;
    ProNo03: TComboBox;
    ProQty03: TEdit;
    Mat11: TLabel;
    Mat12: TLabel;
    MatDsc12: TLabel;
    MatPrc12: TLabel;
    Mat13: TLabel;
    MatDsc13: TLabel;
    MatPrc13: TLabel;
    Mat21: TLabel;
    MatDsc21: TLabel;
    MatPrc21: TLabel;
    Mat22: TLabel;
    Mat23: TLabel;
    MatDsc23: TLabel;
    MatDsc22: TLabel;
    MatPrc22: TLabel;
    MatPrc23: TLabel;
    Mat31: TLabel;
    MatDsc31: TLabel;
    MatPrc31: TLabel;
    Mat32: TLabel;
    Mat33: TLabel;
    MatDsc33: TLabel;
    MatDsc32: TLabel;
    MatPrc32: TLabel;
    MatPrc33: TLabel;
    Line11: TLabel;
    Line12: TLabel;
    Line13: TLabel;
    Line21: TLabel;
    Line22: TLabel;
    Line23: TLabel;
    Line31: TLabel;
    Line32: TLabel;
    Line33: TLabel;
    BtbExit: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure ProNo01Exit(Sender: TObject);
    procedure ProNo01Click(Sender: TObject);
    procedure ProNo02Exit(Sender: TObject);
    procedure ProNo03Exit(Sender: TObject);
    procedure ProQty01Exit(Sender: TObject);
    procedure ProQty02Exit(Sender: TObject);
    procedure ProQty03Exit(Sender: TObject);
    procedure BtbOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ProNo02Click(Sender: TObject);
    procedure ProNo03Click(Sender: TObject);
    procedure BtbExitClick(Sender: TObject);
  private
    { Private declarations }
    numrec, numallrec: variant;
    status : string;   {U=Update, I=Insert}
    proln,proln1,proln2,proln3, sql_text : string;   
    prono, matno, matname, matdsc1, matdsc2, matdsc3  : string;
    Pro_Qty1, Pro_Qty2, Pro_Qty3 : string;
    OPro_Qty1, OPro_Qty2, OPro_Qty3 : string;
    Opromo_no1, Opromo_no2, Opromo_no3 : string;
    procedure ClearData;
    procedure ClearMatData(ProQty :TEdit; ProDsc,Mat1,Mat2,Mat3,MatDsc1,MatDsc2,MatDsc3,MatPrc1,MatPrc2,MatPrc3,Line1,Line2,Line3 :TLabel);
    procedure SelectPromoNo;
    procedure SelectPromoData(ProMoNo :TComboBox; ProQty :TEdit; ProDsc,Mat1,Mat2,Mat3,MatDsc1,MatDsc2,MatDsc3,MatPrc1,MatPrc2,MatPrc3 :TLabel);
    procedure SelectMat;
    procedure SqlExe;
    procedure MoveMatToBill(ProQty: TEdit; Mat,MatPrc,line :TLabel);
    procedure CheckNextPromo(ProMoNo1, ProMoNo2 :TComboBox; ProQty1, ProQty2 :TEdit; line :integer);
    procedure MoveSpaceToBillALL;
    procedure CancelChange;

  public
    { Public declarations }
    totln, chkline, curline, cline, totline : integer;
    promo_no1, promo_no2, promo_no3 : string;
  end;

var
  FrmPROMOBILL: TFrmPROMOBILL;

implementation

{$R *.dfm}

uses Udatamodule, UThai2, UBill;

procedure TFrmPROMOBILL.FormCreate(Sender: TObject);
begin
  totline := 0;
  totln   := 0;
  cline   := 0;
  proln1    := '0';
  proln2    := '0';
  proln3    := '0';
  ClearData;
  ClearMatData(ProQty01,ProDsc01,Mat11,Mat12,Mat13,MatDsc11,MatDsc12,MatDsc13,MatPrc11,MatPrc12,MatPrc13,Line11,Line12,Line13);
  ClearMatData(ProQty02,ProDsc02,Mat21,Mat22,Mat23,MatDsc21,MatDsc22,MatDsc23,MatPrc21,MatPrc22,MatPrc23,Line21,Line22,Line23);
  ClearMatData(ProQty03,ProDsc03,Mat31,Mat32,Mat33,MatDsc31,MatDsc32,MatDsc33,MatPrc31,MatPrc32,MatPrc33,Line31,Line32,Line33);
  StabrPROMO.Panels[2].Text := ' กรุณาป้อนรหัสโปรโมชั่นที่ต้องการ';
  StabrPROMO.Width := 650;
  SelectPromoNo;
end;

procedure TFrmPROMOBILL.ClearData;
begin
  ProNo01.Text      := '';
  ProNo02.Text      := '';
  ProNo03.Text      := '';
  ProQty01.Text     := '';
  ProQty02.Text     := '';
  ProQty03.Text     := '';  
  ProNo01.Enabled   := True;
  ProNo02.Enabled   := False;
  ProNo03.Enabled   := False;
  ProQty01.Enabled  := False;
  ProQty02.Enabled  := False;
  ProQty03.Enabled  := False;
  StabrPROMO.Panels[1].Text := ' ';
  StabrPROMO.Panels[2].Text := ' ';
end;

procedure TFrmPROMOBILL.SelectPromoNo;
begin
  ProNo01.Items.Clear;
  ProNo02.Items.Clear;
  ProNo03.Items.Clear;
  sql_text := 'Select * From PROMO_HEAD';
  with FrmDatamodule.ADOQuery2 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sql_text);
    Open;
  end;
  FrmDatamodule.ADOQuery2.First;
  numrec    := FrmDatamodule.ADOQuery2.RecNo;
  numallrec := FrmDatamodule.ADOQuery2.RecordCount;
  if numallrec > 0 then
     begin
       while numrec <= numallrec do
          begin
            ProNo01.Items.Add(FrmDatamodule.ADOQuery2.FieldValues['PRO_NO']);
            ProNo02.Items.Add(FrmDatamodule.ADOQuery2.FieldValues['PRO_NO']);
            ProNo03.Items.Add(FrmDatamodule.ADOQuery2.FieldValues['PRO_NO']);
            FrmDatamodule.ADOQuery2.Next;
            numrec    := numrec + 1;
          end;
     end;
end;

procedure TFrmPROMOBILL.SqlExe;
begin
  with FrmDatamodule.ADOQuery4 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sql_text);
    ExecSQL;
  end;
end;

procedure TFrmPROMOBILL.SelectMat;
begin
  sql_text := 'Select * From FINISH_GOODS Where FG_ID = ''' + matno + ''' ';
  with FrmDatamodule.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sql_text);
    Open;
  end;
  if FrmDatamodule.ADOQuery1.RecordCount > 0 then
     matname  := FrmDataModule.Ck_null(FrmDatamodule.ADOQuery1.FieldValues['FG_DES'])
  else
     matname  := '';

end;

procedure TFrmPROMOBILL.SelectPromoData(ProMoNo :TComboBox; ProQty :TEdit; ProDsc,Mat1,Mat2,Mat3,MatDsc1,MatDsc2,MatDsc3,MatPrc1,MatPrc2,MatPrc3 :TLabel);
begin
  prono := Uppercase(Trim(ProMoNo.Text));
  if  prono <> ''  then
     begin
// Select Desc
        ProMoNo.Text := prono;
        sql_text := 'Select * From PROMO_HEAD Where PRO_NO = ''' + prono + ''' ';
        with FrmDatamodule.ADOQuery2 do
        begin
          Close;
          SQL.Clear;
          SQL.Add(sql_text);
          Open;
          First;
        end;
        if FrmDatamodule.ADOQuery2.RecordCount > 0 then
           begin
             ProDsc.Caption  := FrmDatamodule.ADOQuery2.FieldValues['PRO_DESC'];
             proln           := FrmDatamodule.ADOQuery2.FieldValues['PRO_FGNO'];
           end
        else
          begin
            MessageDlg('ไม่มีรหัสโปรโมชั่นที่ต้องการ', mtError , [mbok], 0);
            ProQty.Enabled    := False;
            ProMoNo.SetFocus;
          end;

// Select Detail
        sql_text := 'Select * From PROMO_DETAIL Where PRO_NO = ''' + prono + ''' ';
        with FrmDatamodule.ADOQuery2 do
        begin
          Close;
          SQL.Clear;
          SQL.Add(sql_text);
          Open;
          First;
        end;
        if FrmDatamodule.ADOQuery2.RecordCount > 0 then
           begin
             numrec := FrmDatamodule.ADOQuery2.RecNo;
             while numrec  <= proln do
                begin
                   matno := Uppercase(Trim(FrmDatamodule.ADOQuery2.FieldValues['PRO_FG_ID']));
                   SelectMat;
                   if FrmDatamodule.ADOQuery2.FieldValues['PRO_LN'] = 1 then
                      begin
                        mat1.Caption    :=  matno;
                        MatDsc1.Caption :=  matname;
                        MatPrc1.Caption :=  inttostr(FrmDatamodule.ADOQuery2.FieldValues['PRO_FG_PRICE']);
                      end
                   else if FrmDatamodule.ADOQuery2.FieldValues['PRO_LN'] = 2 then
                      begin
                        mat2.Caption    :=  matno;
                        MatDsc2.Caption :=  matname;
                        MatPrc2.Caption :=  inttostr(FrmDatamodule.ADOQuery2.FieldValues['PRO_FG_PRICE']);
                      end
                   else if FrmDatamodule.ADOQuery2.FieldValues['PRO_LN'] = 3 then
                      begin
                        mat3.Caption    :=  matno;
                        MatDsc3.Caption :=  matname;
                        MatPrc3.Caption :=  inttostr(FrmDatamodule.ADOQuery2.FieldValues['PRO_FG_PRICE']);
                      end;
                   FrmDatamodule.ADOQuery2.Next;
                   numrec := numrec + 1;
                end;
              if Proqty.Text  = '' then
                 Proqty.Text       :=  '1';
              Proqty.Enabled    :=  True;
              Proqty.SetFocus;
           end;
    end;
end;


procedure TFrmPROMOBILL.ProNo01Exit(Sender: TObject);
begin
  if Trim(ProNo01.Text) <> '' then
     begin
       if Promo_No1 <> Trim(ProNo01.Text) then
          begin
            ClearMatData(ProQty01,ProDsc01,Mat11,Mat12,Mat13,MatDsc11,MatDsc12,MatDsc13,MatPrc11,MatPrc12,MatPrc13,Line11,Line12,Line13);
            SelectPromoData(ProNo01,ProQty01,ProDsc01,Mat11,Mat12,Mat13,MatDsc11,MatDsc12,MatDsc13,MatPrc11,MatPrc12,MatPrc13);
            proln1  :=  proln;
            StabrPROMO.Panels[2].Text := ' ข้อมูลโปรโมชั่น ถูกต้อง';
          end;
     end
  else
     begin
        proln1 := '0';
        ClearMatData(ProQty01,ProDsc01,Mat11,Mat12,Mat13,MatDsc11,MatDsc12,MatDsc13,MatPrc11,MatPrc12,MatPrc13,Line11,Line12,Line13);
        StabrPROMO.Panels[2].Text := ' ';
        if Trim(ProNo02.Text) <> '' then
           CheckNextPromo(ProNo01, ProNo02, ProQty01, ProQty02, 1);
     end;
  ProMo_No1 := Trim(Prono01.Text);
end;

procedure TFrmPROMOBILL.ProNo01Click(Sender: TObject);
begin
  if promo_no1 <> Trim(ProNo01.Text) then
     ProNo01Exit(ProNo01);
end;

procedure TFrmPROMOBILL.ProNo02Exit(Sender: TObject);
begin
  if Trim(ProNo02.Text) <> '' then
    begin
       if Promo_No2 <> Trim(ProNo02.Text) then
          begin
            ClearMatData(ProQty02,ProDsc02,Mat21,Mat22,Mat23,MatDsc21,MatDsc22,MatDsc23,MatPrc21,MatPrc22,MatPrc23,Line21,Line22,Line23);
            SelectPromoData(ProNo02,ProQty02,ProDsc02,Mat21,Mat22,Mat23,MatDsc21,MatDsc22,MatDsc23,MatPrc21,MatPrc22,MatPrc23);
            proln2  :=  proln;
            StabrPROMO.Panels[2].Text := ' ข้อมูลโปรโมชั่น ถูกต้อง';
          end;
    end
  else
     begin
        proln2 := '0';
        ClearMatData(ProQty02,ProDsc02,Mat21,Mat22,Mat23,MatDsc21,MatDsc22,MatDsc23,MatPrc21,MatPrc22,MatPrc23,Line21,Line22,Line23);
        StabrPROMO.Panels[2].Text := ' ';
        if Trim(ProNo03.Text) <> '' then
           CheckNextPromo(ProNo02, ProNo03, ProQty02, ProQty03,2);
     end;
  ProMo_No2 := Trim(Prono02.Text);
end;

procedure TFrmPROMOBILL.ProNo03Exit(Sender: TObject);
begin
  if Trim(ProNo03.Text) <> '' then
    begin
       if Promo_No3 <> Trim(ProNo03.Text) then
          begin
            ClearMatData(ProQty03,ProDsc03,Mat31,Mat32,Mat33,MatDsc31,MatDsc32,MatDsc33,MatPrc31,MatPrc32,MatPrc33,Line31,Line32,Line33);
            SelectPromoData(ProNo03,ProQty03,ProDsc03,Mat31,Mat32,Mat33,MatDsc31,MatDsc32,MatDsc33,MatPrc31,MatPrc32,MatPrc33);
            proln3  :=  proln;
            StabrPROMO.Panels[2].Text := ' ข้อมูลโปรโมชั่น ถูกต้อง';
          end;
    end
  else
    begin
       proln3 := '0';
       ClearMatData(ProQty03,ProDsc03,Mat31,Mat32,Mat33,MatDsc31,MatDsc32,MatDsc33,MatPrc31,MatPrc32,MatPrc33,Line31,Line32,Line33);
       StabrPROMO.Panels[2].Text := ' กรุณาป้อนรหัสโปรโมชั่นที่ต้องการ';
    end;
  ProMo_No3 := Trim(Prono03.Text);
end;

procedure TFrmPROMOBILL.ProQty01Exit(Sender: TObject);
begin
  if trim(ProNo01.Text) <> '' then
     begin
      try
        ProQty01.Text  :=  FormatFloat('#0.00', StrToFloat(Trim(ProQty01.Text)));
        ProNo02.Enabled :=  True;
      except
        on E: EConvertError do
           begin
             Showmessage('กรุณาป้อนข้อมูลปริมาณเป็นตัวเลข');
             ProQty01.SetFocus;
           end;
      end;
     end
  else
    ProQty01.Text  :=  '0';
  Pro_Qty1 := Trim(ProQty01.Text);
end;

procedure TFrmPROMOBILL.ProQty02Exit(Sender: TObject);
begin
  if trim(ProNo02.Text) <> '' then
     begin
      try
        ProQty02.Text  :=  FormatFloat('#0.00', StrToFloat(Trim(ProQty02.Text)));
        ProNo03.Enabled :=  True;
      except
        on E: EConvertError do
           begin
             Showmessage('กรุณาป้อนข้อมูลปริมาณเป็นตัวเลข');
             ProQty02.SetFocus;
           end;
      end;
    end
  else
    ProQty02.Text  :=  '0';
  Pro_Qty2 := Trim(ProQty02.Text);

end;

procedure TFrmPROMOBILL.ProQty03Exit(Sender: TObject);
begin
  if trim(ProNo03.Text) <> '' then
     begin
      try
        ProQty03.Text  :=  FormatFloat('#0.00', StrToFloat(Trim(ProQty03.Text)));
      except
        on E: EConvertError do
           begin
             Showmessage('กรุณาป้อนข้อมูลปริมาณเป็นตัวเลข');
             ProQty03.SetFocus;
           end;
      end;
     end
  else
    ProQty03.Text  :=  '0';
  Pro_Qty3 := Trim(ProQty03.Text);

end;

procedure TFrmPROMOBILL.BtbOkClick(Sender: TObject);
begin
  totln   := strtoint(proln1) + strtoint(proln2) + strtoint(proln3);
  if ( totln + chkline ) > 10 then
     begin
       MessageDlg('มีรายการขาย มากกว่า 10 รายการ', mtError , [mbok], 0);
       ProNo01.SetFocus;
     end
  else
  begin
    cline   :=  curline;

    if totline  > 0 then
       begin
         MoveSpaceToBillALL;
         FrmBill.CheckLine;
         chkline := FrmBill.CHK_LINE;
         if FrmBill.CUR_LINE = 0 then
            FrmBill.CUR_LINE := FrmBill.CHK_LINE + 1;
         curline := FrmBill.CUR_LINE;
       end;
    cline   :=  curline;
    if Mat11.Caption <> '' then
       MoveMatToBill(ProQty01,Mat11,MatPrc11,line11);

    if Mat12.Caption <> '' then
       MoveMatToBill(ProQty01,Mat12,MatPrc12,line12);

    if Mat13.Caption <> '' then
       MoveMatToBill(ProQty01,Mat13,MatPrc13,line13);

    if Mat21.Caption <> '' then
       MoveMatToBill(ProQty02,Mat21,MatPrc21,line21);

    if Mat22.Caption <> '' then
       MoveMatToBill(ProQty02,Mat22,MatPrc22,line22);

    if Mat23.Caption <> '' then
       MoveMatToBill(ProQty02,Mat23,MatPrc23,line23);

    if Mat31.Caption <> '' then
       MoveMatToBill(ProQty03,Mat31,MatPrc31,line31);

    if Mat32.Caption <> '' then
       MoveMatToBill(ProQty03,Mat32,MatPrc32,line32);

    if Mat33.Caption <> '' then
       MoveMatToBill(ProQty03,Mat33,MatPrc33,line33);

    totline :=  totln;
    cline   :=  curline;
    FrmPROMOBILL.Hide;
  end;

end;

procedure TFrmPROMOBILL.MoveSpaceToBillALL;
var cnt : integer;
begin
  FrmBill.setenabled;
  cnt := 1;
  while cnt <= totline do
  begin
    case cline of
      1: begin
           FrmBill.Edtmat_num1.Text     := '';
           FrmBill.Edtmat_num1Exit(FrmBill.Edtmat_num1);
           FrmBill.PNO01.Caption        := '';
           FrmBill.EdtQty1.SetFocus;
       end;
      2: begin
           FrmBill.Edtmat_num2.Text     := '';
           FrmBill.Edtmat_num2Exit(FrmBill.Edtmat_num2);
           FrmBill.PNO02.Caption        := '';
           FrmBill.EdtQty2.SetFocus;
       end;
      3: begin
           FrmBill.Edtmat_num3.Text     := '';
           FrmBill.Edtmat_num3Exit(FrmBill.Edtmat_num3);
           FrmBill.PNO03.Caption        := '';
           FrmBill.EdtQty3.SetFocus;
       end;
      4: begin
           FrmBill.Edtmat_num4.Text     := '';
           FrmBill.Edtmat_num4Exit(FrmBill.Edtmat_num4);
           FrmBill.PNO04.Caption        := '';
           FrmBill.EdtQty4.SetFocus;
       end;
      5: begin
           FrmBill.Edtmat_num5.Text     := '';
           FrmBill.Edtmat_num5Exit(FrmBill.Edtmat_num5);
           FrmBill.PNO05.Caption        := '';
           FrmBill.EdtQty5.SetFocus;
       end;
      6: begin
           FrmBill.Edtmat_num6.Text     := '';
           FrmBill.Edtmat_num6Exit(FrmBill.Edtmat_num6);
           FrmBill.PNO06.Caption        := '';
           FrmBill.EdtQty6.SetFocus;
       end;
      7: begin
           FrmBill.Edtmat_num7.Text     := '';
           FrmBill.Edtmat_num7Exit(FrmBill.Edtmat_num7);
           FrmBill.PNO07.Caption        := '';
           FrmBill.EdtQty7.SetFocus;
       end;
      8: begin
           FrmBill.Edtmat_num8.Text     := '';
           FrmBill.Edtmat_num8Exit(FrmBill.Edtmat_num8);
           FrmBill.PNO08.Caption        := '';
           FrmBill.EdtQty8.SetFocus;
       end;
      9: begin
           FrmBill.Edtmat_num9.Text     := '';
           FrmBill.Edtmat_num9Exit(FrmBill.Edtmat_num9);
           FrmBill.PNO09.Caption        := '';
           FrmBill.EdtQty9.SetFocus;
       end;
      10: begin
           FrmBill.Edtmat_num10.Text     := '';
           FrmBill.Edtmat_num10Exit(FrmBill.Edtmat_num10);
           FrmBill.PNO10.Caption        := '';
           FrmBill.EdtQty10.SetFocus;
       end;
    end;
    cnt :=  cnt + 1;
  end;

end;

procedure TFrmPROMOBILL.MoveMatToBill(ProQty: TEdit; Mat,MatPrc,line :TLabel);
begin
  Line.Caption  := inttostr(cline);
  FrmBill.PromoMatPrc      := strtofloat(MatPrc.Caption);
  FrmBill.PromoStatus      := 'Y';
  case cline of
    1: begin
       FrmBill.Edtmat_num1.Enabled  := True;
       FrmBill.EdtQty1.Enabled      := True;
       FrmBill.Edtmat_num1.Text     := Mat.Caption;
       FrmBill.EdtQty1.Text         := ProQty.Text;
       FrmBill.Edtmat_num1Exit(FrmBill.Edtmat_num1);
       FrmBill.EdtQty1Exit(FrmBill.EdtQty1);
       FrmBill.Edtmat_num1.Enabled  := False;
       FrmBill.EdtQty1.Enabled      := False;
       FrmBill.PNO01.Caption        := 'P';
       if FrmBill.Edtmat_num2.Enabled = True then
          FrmBill.Edtmat_num2.SetFocus;
     end;
    2: begin
       FrmBill.Edtmat_num2.Enabled  := True;
       FrmBill.EdtQty2.Enabled      := True;
       FrmBill.Edtmat_num2.Text     := Mat.Caption;
       FrmBill.EdtQty2.Text         := ProQty.Text;
       FrmBill.Edtmat_num2Exit(FrmBill.Edtmat_num2);
       FrmBill.EdtQty1Exit(FrmBill.EdtQty2);
       FrmBill.Edtmat_num2.Enabled  := False;
       FrmBill.EdtQty2.Enabled      := False;
       FrmBill.PNO02.Caption        := 'P';
       if FrmBill.Edtmat_num3.Enabled = True then
          FrmBill.Edtmat_num3.SetFocus;
     end;
    3: begin
       FrmBill.Edtmat_num3.Enabled  := True;
       FrmBill.EdtQty3.Enabled      := True;
       FrmBill.Edtmat_num3.Text     := Mat.Caption;
       FrmBill.EdtQty3.Text         := ProQty.Text;
       FrmBill.Edtmat_num3Exit(FrmBill.Edtmat_num3);
       FrmBill.EdtQty1Exit(FrmBill.EdtQty3);
       FrmBill.Edtmat_num3.Enabled  := False;
       FrmBill.EdtQty3.Enabled      := False;
       FrmBill.PNO03.Caption        := 'P';
       if FrmBill.Edtmat_num4.Enabled = True then
          FrmBill.Edtmat_num4.SetFocus;
     end;
    4: begin
       FrmBill.Edtmat_num4.Enabled  := True;
       FrmBill.EdtQty4.Enabled      := True;
       FrmBill.Edtmat_num4.Text     := Mat.Caption;
       FrmBill.EdtQty4.Text         := ProQty.Text;
       FrmBill.Edtmat_num4Exit(FrmBill.Edtmat_num4);
       FrmBill.EdtQty1Exit(FrmBill.EdtQty4);
       FrmBill.Edtmat_num4.Enabled  := False;
       FrmBill.EdtQty4.Enabled      := False;
       FrmBill.PNO04.Caption        := 'P';
       if FrmBill.Edtmat_num5.Enabled = True then
          FrmBill.Edtmat_num5.SetFocus;
     end;
    5: begin
       FrmBill.Edtmat_num5.Enabled  := True;
       FrmBill.EdtQty5.Enabled      := True;
       FrmBill.Edtmat_num5.Text     := Mat.Caption;
       FrmBill.EdtQty5.Text         := ProQty.Text;
       FrmBill.Edtmat_num5Exit(FrmBill.Edtmat_num5);
       FrmBill.EdtQty1Exit(FrmBill.EdtQty5);
       FrmBill.Edtmat_num5.Enabled  := False;
       FrmBill.EdtQty5.Enabled      := False;
       FrmBill.PNO05.Caption        := 'P';
       if FrmBill.Edtmat_num6.Enabled = True then
          FrmBill.Edtmat_num6.SetFocus;
     end;
    6: begin
       FrmBill.Edtmat_num6.Enabled  := True;
       FrmBill.EdtQty6.Enabled      := True;
       FrmBill.Edtmat_num6.Text     := Mat.Caption;
       FrmBill.EdtQty6.Text         := ProQty.Text;
       FrmBill.Edtmat_num6Exit(FrmBill.Edtmat_num6);
       FrmBill.EdtQty1Exit(FrmBill.EdtQty6);
       FrmBill.Edtmat_num6.Enabled  := False;
       FrmBill.EdtQty6.Enabled      := False;
       FrmBill.PNO06.Caption        := 'P';
       if FrmBill.Edtmat_num7.Enabled = True then
          FrmBill.Edtmat_num7.SetFocus;
     end;
    7: begin
       FrmBill.Edtmat_num7.Enabled  := True;
       FrmBill.EdtQty7.Enabled      := True;
       FrmBill.Edtmat_num7.Text     := Mat.Caption;
       FrmBill.EdtQty7.Text         := ProQty.Text;
       FrmBill.Edtmat_num7Exit(FrmBill.Edtmat_num7);
       FrmBill.EdtQty1Exit(FrmBill.EdtQty7);
       FrmBill.Edtmat_num7.Enabled  := False;
       FrmBill.EdtQty7.Enabled      := False;
       FrmBill.PNO07.Caption        := 'P';
       if FrmBill.Edtmat_num8.Enabled = True then
          FrmBill.Edtmat_num8.SetFocus;
     end;
    8: begin
       FrmBill.Edtmat_num8.Enabled  := True;
       FrmBill.EdtQty8.Enabled      := True;
       FrmBill.Edtmat_num8.Text     := Mat.Caption;
       FrmBill.EdtQty8.Text         := ProQty.Text;
       FrmBill.Edtmat_num8Exit(FrmBill.Edtmat_num8);
       FrmBill.EdtQty1Exit(FrmBill.EdtQty8);
       FrmBill.Edtmat_num8.Enabled  := False;
       FrmBill.EdtQty8.Enabled      := False;
       FrmBill.PNO08.Caption        := 'P';
       if FrmBill.Edtmat_num9.Enabled = True then
          FrmBill.Edtmat_num9.SetFocus;
     end;
    9: begin
       FrmBill.Edtmat_num9.Enabled  := True;
       FrmBill.EdtQty9.Enabled      := True;
       FrmBill.Edtmat_num9.Text     := Mat.Caption;
       FrmBill.EdtQty9.Text         := ProQty.Text;
       FrmBill.Edtmat_num9Exit(FrmBill.Edtmat_num9);
       FrmBill.EdtQty1Exit(FrmBill.EdtQty9);
       FrmBill.Edtmat_num9.Enabled  := False;
       FrmBill.EdtQty9.Enabled      := False;
       FrmBill.PNO09.Caption        := 'P';
       if FrmBill.Edtmat_num10.Enabled = True then
          FrmBill.Edtmat_num10.SetFocus;
     end;
    10: begin
       FrmBill.Edtmat_num10.Enabled  := True;
       FrmBill.EdtQty10.Enabled      := True;
       FrmBill.Edtmat_num10.Text    := Mat.Caption;
       FrmBill.EdtQty10.Text        := ProQty.Text;
       FrmBill.Edtmat_num10Exit(FrmBill.Edtmat_num10);
       FrmBill.EdtQty1Exit(FrmBill.EdtQty10);
       FrmBill.Edtmat_num10.Enabled  := False;
       FrmBill.EdtQty10.Enabled      := False;
       FrmBill.PNO10.Caption         := 'P';
       if FrmBill.BtnSave.Enabled = True then
          FrmBill.BtnSave.SetFocus;
     end;
  end;
  cline := cline + 1;
  FrmBill.PromoMatPrc := 0;
  FrmBill.PromoStatus := 'N';
end;

procedure TFrmPROMOBILL.ClearMatData(ProQty :TEdit; ProDsc,Mat1,Mat2,Mat3,MatDsc1,MatDsc2,MatDsc3,MatPrc1,MatPrc2,MatPrc3,Line1,Line2,Line3 :TLabel);
begin
  ProQty.Text      :=  '';
  ProDsc.Caption   :=  '';
  Mat1.Caption     :=  '';
  Mat2.Caption     :=  '';
  Mat3.Caption     :=  '';
  MatDsc1.Caption  :=  '';
  MatDsc2.Caption  :=  '';
  MatDsc3.Caption  :=  '';
  MatPrc1.Caption  :=  '';
  MatPrc2.Caption  :=  '';
  MatPrc3.Caption  :=  '';
  Line1.Caption    :=  '';
  Line2.Caption    :=  '';
  Line3.Caption    :=  '';
end;

procedure TFrmPROMOBILL.FormShow(Sender: TObject);
begin
    totln      := 0;
    ProMo_No1  := Prono01.Text;
    ProMo_No2  := Prono02.Text;
    ProMo_No3  := Prono03.Text;
    Pro_Qty1   := ProQty01.Text;
    Pro_Qty2   := ProQty02.Text;
    Pro_Qty3   := ProQty03.Text;
    OProMo_No1 := Prono01.Text;
    OProMo_No2 := Prono02.Text;
    OProMo_No3 := Prono03.Text;
    OPro_Qty1  := ProQty01.Text;
    OPro_Qty2  := ProQty02.Text;
    OPro_Qty3  := ProQty03.Text;
end;

procedure TFrmPROMOBILL.ProNo02Click(Sender: TObject);
begin
  if promo_no2 <> Trim(ProNo02.Text) then
     ProNo02Exit(ProNo02);
end;

procedure TFrmPROMOBILL.ProNo03Click(Sender: TObject);
begin
  if promo_no3 <> Trim(ProNo03.Text) then
     ProNo03Exit(ProNo03);
end;

procedure TFrmPROMOBILL.CheckNextPromo(ProMoNo1, ProMoNo2 :TComboBox; ProQty1, ProQty2 :TEdit; Line :Integer);
begin
    ProMoNo1.Text :=  ProMoNo2.Text;
    ProMoNo2.Text :=  '';
    if Line = 1 then
       begin
        ProNo01Exit(ProNo01);
        ProQty1.Text  :=  ProQty2.Text;
        ProQty2.Text :=  '';
        ProNo02Exit(ProNo02);
       end
    else
       begin
        ProNo02Exit(ProNo02);
        ProQty1.Text  :=  ProQty2.Text;
        ProQty2.Text :=  '';
        ProNo03Exit(ProNo03);
       end;
end;



procedure TFrmPROMOBILL.BtbExitClick(Sender: TObject);
var reps: word;
begin
  if ( OProMo_No1 <> ProMo_No1 ) or
     ( OProMo_No2 <> ProMo_No2 ) or
     ( OProMo_No3 <> ProMo_No3 ) or
     ( OPro_Qty1  <> Pro_Qty1 ) or
     ( OPro_Qty2  <> Pro_Qty2 ) or
     ( OPro_Qty3  <> Pro_Qty3 ) then
     begin
      reps := MessageDlg('คุณต้องการยืนยันโปรโมชั่นก่อนหรือไม่', mtConfirmation, [mbYes, mbNo], 0);
      if reps = mrNo then
         begin
           CancelChange;
           FrmPROMOBILL.Hide;
         end
      else
         BtbOkClick(BtbOk);
     end
  else
    begin
      reps := MessageDlg('คุณต้องการออกจากรายการนี้ใช่หรือไม่', mtConfirmation, [mbYes, mbNo], 0);
      if reps = mrYes then   FrmPROMOBILL.Hide;
    end;
end;

procedure TFrmPROMOBILL.CancelChange;
begin
    ProNo01.Text  :=  OProMo_No1;
    ProNo02.Text  :=  OProMo_No2;
    ProNo03.Text  :=  OProMo_No3;
    ProQty01.Text :=  OPro_Qty1;
    ProQty02.Text :=  OPro_Qty2;
    ProQty03.Text :=  OPro_Qty3;
    ProNo01Exit(ProNo01);
    ProQty01Exit(ProQty01);
    ProNo02Exit(ProNo02);
    ProQty02Exit(ProQty02);
    ProNo03Exit(ProNo03);
    ProQty03Exit(ProQty03);
end;


end.
