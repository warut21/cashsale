unit Upromo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, StdCtrls, ComCtrls, ExtCtrls, Buttons;
type
  TFrmPROMO = class(TForm)
    BvCompany: TBevel;
    LbFGId: TLabel;
    BtbOk: TBitBtn;
    BtbCancel: TBitBtn;
    BtbExit: TBitBtn;
    StabrPROMO: TStatusBar;
    Panel2: TPanel;
    FGDES01: TLabel;
    FGDES02: TLabel;
    FGDES03: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label9: TLabel;
    FGPRC01: TEdit;
    FGPRC02: TEdit;
    FGPRC03: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    FGID01: TComboBox;
    FGID02: TComboBox;
    FGID03: TComboBox;
    PromoNo: TComboBox;
    PromoDesc: TEdit;
    BtbDelete: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BtbExitClick(Sender: TObject);
    procedure FGPRC01Exit(Sender: TObject);
    procedure FGPRC02Exit(Sender: TObject);
    procedure FGPRC03Exit(Sender: TObject);
    procedure PromoNoExit(Sender: TObject);
    procedure FGID01Exit(Sender: TObject);
    procedure FGID02Exit(Sender: TObject);
    procedure FGID03Exit(Sender: TObject);
    procedure PromoDescExit(Sender: TObject);
    procedure FGID01Click(Sender: TObject);
    procedure FGID02Click(Sender: TObject);
    procedure FGID03Click(Sender: TObject);
    procedure BtbCancelClick(Sender: TObject);
    procedure BtbDeleteClick(Sender: TObject);
    procedure BtbOkClick(Sender: TObject);
    procedure PromoNoClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    numrec, numallrec: variant;
    status, proln, sql_text : string;   {U=Update, I=Insert}
    prono, old_promo, matno : string;
    mat01, mat02, mat03 : string;
    procedure SelectPromoNo;
    procedure SelectPromoData;
    procedure ClearData;
    procedure SelectFGID;
    procedure ShowMat(line:integer; var mat_num : string);
    procedure SqlExe;
    procedure CheckNextFGID(FGID1, FGID2 :Tcombobox; FGPRC1, FGPRC2 :Tedit);

  public
    { Public declarations }
  end;

var
  FrmPROMO: TFrmPROMO;

implementation

{$R *.dfm}

uses Udatamodule, UThai2;

procedure TFrmPROMO.FormCreate(Sender: TObject);
begin
  ClearData;
  StabrPROMO.Panels[2].Text := ' กรุณาป้อนรหัสโปรโมชั่นที่ต้องการ';
  StabrPROMO.Width := 620;
  SelectPromoNo;
  SelectFGID;
end;

procedure TFrmPROMO.SqlExe;
begin
  with FrmDatamodule.ADOQuery4 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sql_text);
    ExecSQL;
  end;
end;

procedure TFrmPROMO.SelectPromoNo;
begin
  PromoNo.Items.Clear;
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
            PromoNo.Items.Add(FrmDatamodule.ADOQuery2.FieldValues['PRO_NO']);
            FrmDatamodule.ADOQuery2.Next;
            numrec    := numrec + 1;
          end;
     end;
end;

procedure TFrmPROMO.SelectFGID;
begin
  FGID01.Items.Clear;
  FGID02.Items.Clear;
  FGID03.Items.Clear;
  sql_text := 'Select * From FINISH_GOODS';
  with FrmDatamodule.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sql_text);
    Open;
  end;
  FrmDatamodule.ADOQuery1.First;
  numrec    := FrmDatamodule.ADOQuery1.RecNo;
  numallrec := FrmDatamodule.ADOQuery1.RecordCount;
  while numrec <= numallrec do
    begin
      FGID01.Items.Add(FrmDatamodule.ADOQuery1.FieldValues['FG_ID']);
      FGID02.Items.Add(FrmDatamodule.ADOQuery1.FieldValues['FG_ID']);
      FGID03.Items.Add(FrmDatamodule.ADOQuery1.FieldValues['FG_ID']);
      FrmDatamodule.ADOQuery1.Next;
      numrec    := numrec + 1;
    end;

end;
procedure TFrmPROMO.ClearData;
begin
  PromoDesc.Text    := '';
  FGID01.Text       := '';
  FGID02.Text       := '';
  FGID03.Text       := '';
  FGDES01.Caption   := '';
  FGDES02.Caption   := '';
  FGDES03.Caption   := '';
  FGPRC01.Text      := '';
  FGPRC02.Text      := '';
  FGPRC03.Text      := '';
  FGID01.Enabled    := False;
  FGID02.Enabled    := False;
  FGID03.Enabled    := False;
  FGPRC01.Enabled   := False;
  FGPRC02.Enabled   := False;
  FGPRC03.Enabled   := False;
  BtbOk.Enabled     := False;
  BtbDelete.Enabled := False;
  StabrPROMO.Panels[1].Text := ' ';
  StabrPROMO.Panels[2].Text := ' ';
end;

procedure TFrmPROMO.BtbExitClick(Sender: TObject);
var reps: word;
begin
  reps := MessageDlg('คุณต้องการออกจากหน้าจอนี้ใช่หรือไม่', mtConfirmation, [mbYes, mbNo], 0);
  if reps = mrYes then close;
end;

procedure TFrmPROMO.ShowMat(line: integer; var mat_num : string);
begin
  sql_text := 'Select * From FINISH_GOODS Where FG_ID = ''' + mat_num + ''' ';
  with FrmDatamodule.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(sql_text);
    Open;
  end;
  if FrmDatamodule.ADOQuery1.RecordCount > 0 then
  begin
    if line = 1 then
       begin
         FGDES01.Caption := FrmDataModule.Ck_null(FrmDatamodule.ADOQuery1.FieldValues['FG_DES']);
         FGPRC01.Text    := FrmDatamodule.ADOQuery1.FieldValues['FG_PRICE'];
       end;

    if line = 2 then
       begin
         FGDES02.Caption := FrmDataModule.Ck_null(FrmDatamodule.ADOQuery1.FieldValues['FG_DES']);
         FGPRC02.Text    := FrmDatamodule.ADOQuery1.FieldValues['FG_PRICE'];
       end;

    if line = 3 then
       begin
         FGDES03.Caption := FrmDataModule.Ck_null(FrmDatamodule.ADOQuery1.FieldValues['FG_DES']);
         FGPRC03.Text    := FrmDatamodule.ADOQuery1.FieldValues['FG_PRICE'];
       end;
  end
  else
  begin
    MessageDlg('ไม่มีรหัสสินค้าที่ต้องการ', mtError , [mbok], 0);
    if line = 1 then
      begin
        FGDES01.Caption := '';
        FGPRC01.Text    := '';
        FGID01.SetFocus;
      end;
    if line = 2 then
      begin
        FGDES02.Caption := '';
        FGPRC02.Text    := '';
        FGID02.SetFocus;
      end;
    if line = 3 then
      begin
        FGDES03.Caption := '';
        FGPRC03.Text    := '';
        FGID03.SetFocus;
      end;
  end;
end;

procedure TFrmPROMO.FGPRC03Exit(Sender: TObject);
begin
  if FGID03.Text  <> '' then
     begin
      try
        FGPRC03.Text  :=  FormatFloat('#0.00', StrToFloat(Trim(FGPRC03.Text)));
      except
        on E: EConvertError do
           begin
             Showmessage('กรุณาป้อนข้อมูลราคาสินค้าเป็นตัวเลข');
             FGPRC03.SetFocus;
           end;
      end;
     end;
end;


procedure TFrmPROMO.FGPRC02Exit(Sender: TObject);
begin
  if FGID02.Text  <> '' then
     begin
      try
        FGPRC02.Text  :=  FormatFloat('#0.00', StrToFloat(Trim(FGPRC02.Text)));
      except
        on E: EConvertError do
           begin
             Showmessage('กรุณาป้อนข้อมูลราคาสินค้าเป็นตัวเลข');
             FGPRC02.SetFocus;
           end;
      end;
     end;
end;

procedure TFrmPROMO.FGPRC01Exit(Sender: TObject);
begin
  if FGID01.Text  <> '' then
     begin
      try
        FGPRC01.Text  :=  FormatFloat('#0.00', StrToFloat(Trim(FGPRC01.Text)));
      except
        on E: EConvertError do
           begin
             Showmessage('กรุณาป้อนข้อมูลราคาสินค้าเป็นตัวเลข');
             FGPRC01.SetFocus;
           end;
      end;
     end;
end;

procedure TFrmPROMO.SelectProMoData;
begin
  ClearData;
  prono := Uppercase(Trim(PromoNo.Text));
  if prono <> '' then
     begin
// Select Desc
        PromoNo.Text := prono;
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
             status             := 'U';
             PromoDesc.Text     := FrmDatamodule.ADOQuery2.FieldValues['PRO_DESC'];
             PromoDesc.Enabled  :=  True;
             proln              := FrmDatamodule.ADOQuery2.FieldValues['PRO_FGNO'];
           end
        else
          begin
            status            := 'I';
            FGID01.Enabled    := True;
            FGPRC01.Enabled   := True;
            PromoDesc.Enabled := True;
            BtbOk.Enabled     := True;
            PromoDesc.SetFocus;
          end;

// Select Detail
   if status = 'U' then
      begin
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
                   if FrmDatamodule.ADOQuery2.FieldValues['PRO_LN'] = 1 then
                      begin
                         FGID01.Text      :=  FrmDatamodule.ADOQuery2.FieldValues['PRO_FG_ID'];
                         matno := Uppercase(Trim(FGID01.Text));
                         ShowMat(1,matno);
                         FGPRC01.Text     :=  FrmDatamodule.ADOQuery2.FieldValues['PRO_FG_PRICE'];
                         FGID01.Enabled   :=  True;
                         FGPRC01.Enabled  :=  True;
//                         FGID01Exit(FGID01);
                      end
                   else if FrmDatamodule.ADOQuery2.FieldValues['PRO_LN'] = 2 then
                      begin
                         FGID02.Text      :=  FrmDatamodule.ADOQuery2.FieldValues['PRO_FG_ID'];
                         matno := Uppercase(Trim(FGID02.Text));
                         ShowMat(2,matno);
                         FGPRC02.Text     :=  FrmDatamodule.ADOQuery2.FieldValues['PRO_FG_PRICE'];
                         FGID02.Enabled   :=  True;
                         FGPRC02.Enabled  :=  True;
//                         FGID02Exit(FGID02);
                      end
                   else if FrmDatamodule.ADOQuery2.FieldValues['PRO_LN'] = 3 then
                      begin
                         FGID03.Text      :=  FrmDatamodule.ADOQuery2.FieldValues['PRO_FG_ID'];
                         matno := Uppercase(Trim(FGID03.Text));
                         ShowMat(3,matno);
                         FGPRC03.Text     :=  FrmDatamodule.ADOQuery2.FieldValues['PRO_FG_PRICE'];
                         FGID03.Enabled   :=  True;
                         FGPRC03.Enabled  :=  True;
//                         FGID03Exit(FGID03);
                      end;
                   FrmDatamodule.ADOQuery2.Next;
                   numrec := numrec + 1;
                end;
              BtbOk.Enabled     :=  True;
              BtbDelete.Enabled :=  True;
           end;
        end;
    end;
end;


procedure TFrmPROMO.PromoNoExit(Sender: TObject);
begin
  if Trim(PromoNo.Text) <> old_promo then
     begin
      if Trim(PromoNo.Text) <> '' then
         SelectPromoData
      else
         begin
            ClearData;
            StabrPROMO.Panels[2].Text := ' กรุณาป้อนรหัสโปรโมชั่นที่ต้องการ';
         end;
     end;
  old_promo := Trim(PromoNo.Text);
end;

procedure TFrmPROMO.FGID01Exit(Sender: TObject);
begin
  matno := Uppercase(Trim(FGID01.Text));
  FGID01.Text := matno;
  if matno <> '' then
     begin
      ShowMat(1,matno);
      FGID02.Enabled  :=  True;
      FGPRC02.Enabled :=  True;
     end
  else
     begin
      FGDES01.Caption := '';
      FGPRC01.Text    := '';
      if Trim(FGID02.Text) <> '' then
         CheckNextFGID(FGID01, FGID02, FGPRC01, FGPRC02);
     end;
  mat01 := Uppercase(Trim(FGID01.Text));
end;

procedure TFrmPROMO.CheckNextFGID(FGID1, FGID2 :Tcombobox; FGPRC1, FGPRC2 :Tedit);
begin
    FGID1.Text  :=  FGID2.Text;
    FGPRC1.Text :=  FGPRC2.Text;
    FGID2.Text :=  '';
    FGID01Exit(FGID01);
    FGID02Exit(FGID02);
    FGID03Exit(FGID03);
end;

procedure TFrmPROMO.FGID02Exit(Sender: TObject);
begin
  matno := Uppercase(Trim(FGID02.Text));
  FGID02.Text := matno;
  if matno <> '' then
     begin
      ShowMat(2,matno);
      FGID03.Enabled  :=  True;
      FGPRC03.Enabled :=  True;
     end
  else
     begin
      FGDES02.Caption := '';
      FGPRC02.Text    := '';
      if Trim(FGID03.Text) <> '' then
         CheckNextFGID(FGID02, FGID03, FGPRC02, FGPRC03);
     end;
  mat02 := Uppercase(Trim(FGID02.Text));
end;

procedure TFrmPROMO.FGID03Exit(Sender: TObject);
begin
  matno := Uppercase(Trim(FGID03.Text));
  FGID03.Text := matno;
  if matno <> '' then
     ShowMat(3,matno)
  else
     begin
      FGDES03.Caption := '';
      FGPRC03.Text    := '';
     end;
  mat03 := Uppercase(Trim(FGID03.Text));
end;

procedure TFrmPROMO.PromoDescExit(Sender: TObject);
begin
  if ( trim(PromoNo.Text) <> '' ) and  ( trim(PromoDesc.Text) = '' ) then
      MessageDlg('กรุณาใส่รายละเอียด โปรโมชั่น ', mtError , [mbok], 0);
end;

procedure TFrmPROMO.FGID01Click(Sender: TObject);
begin
  if mat01 <> Uppercase(Trim(FGID01.Text)) then
     FGID01Exit(FGID01);
end;

procedure TFrmPROMO.FGID02Click(Sender: TObject);
begin
  if mat02 <> Uppercase(Trim(FGID02.Text)) then
     FGID02Exit(FGID02);
end;

procedure TFrmPROMO.FGID03Click(Sender: TObject);
begin
  if mat03 <> Uppercase(Trim(FGID03.Text)) then
     FGID03Exit(FGID03);
end;

procedure TFrmPROMO.BtbCancelClick(Sender: TObject);
var reps : word;
begin
  reps := MessageDlg('คุณต้องการยกเลิกข้อมูลที่คีย์ ไช่หรือไม', mtConfirmation, [mbYes, mbNo], 0);
  if reps = mrYes then
      begin
        ClearData;
        PromoNo.text  :=  '';
        PromoNo.SetFocus;
      end;
end;

procedure TFrmPROMO.BtbDeleteClick(Sender: TObject);
var pro_no :string;
    reps: word;
begin
  reps := MessageDlg('คุณต้องการลบข้อมูลไช่หรือไม่', mtConfirmation, [mbYes, mbNo], 0);
  if reps = mrYes then
     begin
      pro_no := PromoNo.Text;
      sql_text := 'DELETE * FROM PROMO_DETAIL WHERE PRO_NO = ''' +pro_no+ ''' ';
      SqlExe;

      sql_text := 'DELETE * FROM PROMO_HEAD WHERE PRO_NO = ''' +pro_no+ ''' ';
      SqlExe;

      ClearData;
      SelectPromoNo;
      PromoNo.Text := '';
      PromoNo.SetFocus;
      StabrPROMO.Panels[2].Text := ' ข้อมูลถูกลบออกจากฐานข้อมูลเรียบร้อยแล้ว';

     end;

end;

procedure TFrmPROMO.BtbOkClick(Sender: TObject);
var pro_no, fgno, price : string;
    reps : word;
begin
  reps := MessageDlg('คุณต้องการบันทึกข้อมูล ไช่หรือไม', mtConfirmation, [mbYes, mbNo], 0);
  if reps = mrYes then
     begin
        if ( FGID01.Text <> '' ) and ( trim(PromoDesc.Text) <> '' )  then
           begin
              if FGID03.Text <> '' then
                 fgno := '3'
              else if FGID02.Text <> '' then
                 fgno := '2'
              else
                 fgno := '1';

              pro_no := PromoNo.Text;
              if status = 'U' then
                 begin
                    sql_text  := 'UPDATE PROMO_HEAD' +  #13 +
                                 'SET PRO_DESC = ''' + PromoDesc.Text + ''' ,' + #13 +
                                 'PRO_FGNO     = ''' + fgno + ''' ' + #13 +
                                 'WHERE PRO_NO = ''' + pro_no + ''' ';
                    SqlExe;

                    price := formatfloat('#0.00', strtofloat(Rem_comma(FGPRC01.Text)));
                    sql_text  := 'UPDATE PROMO_DETAIL' + #13 +
                                 'SET PRO_FG_ID = ''' + FGID01.Text + ''' ,' + #13 +
                                 'PRO_FG_PRICE  = ''' + price + ''' ' + #13 +
                                 'WHERE PRO_NO  = ''' + pro_no + ''' ' + #13 +
                                 'AND   PRO_LN  = ''1'' ';
                    SqlExe;

                    IF fgno = '2'  then
                       begin
                          if fgno <= proln  then
                             begin
                               price := formatfloat('#0.00', strtofloat(Rem_comma(FGPRC02.Text)));
                               sql_text  := 'UPDATE PROMO_DETAIL'  + #13 +
                                            'SET PRO_FG_ID = ''' + FGID02.Text + ''' ,' + #13 +
                                            'PRO_FG_PRICE  = ''' + price + ''' ' + #13 +
                                            'WHERE PRO_NO  = ''' + pro_no + ''' ' + #13 +
                                            'AND   PRO_LN  = ''2'' ';
                              SqlExe;
                             end
                        else
                             begin
                               sql_text := 'INSERT INTO PROMO_DETAIL' + #13 +
                                           '(PRO_NO, PRO_LN, PRO_FG_ID, PRO_FG_PRICE)' + #13 +
                                           'VALUES ( ''' + pro_no + ''', ''2'' , ''' + FGID02.Text + ''', ''' + price + ''' )';
                               SqlExe;
                             end;
                       end;

                    IF fgno = '3'  then
                       begin
                        price := formatfloat('#0.00', strtofloat(Rem_comma(FGPRC03.Text)));
                        if fgno = proln  then
                           begin
                             sql_text := 'UPDATE PROMO_DETAIL' + #13 +
                                         'SET PRO_FG_ID = ''' + FGID03.Text + ''', ' + #13 +
                                         'PRO_FG_PRICE  = ''' + price + ''' ' + #13 +
                                         'WHERE PRO_NO  = ''' + pro_no + ''' ' + #13 +
                                         'AND   PRO_LN  = ''3'' ';
                             SqlExe;
                           end
                        else
                           begin
                             sql_text := 'INSERT INTO PROMO_DETAIL' + #13 +
                                         '(PRO_NO, PRO_LN, PRO_FG_ID, PRO_FG_PRICE)' + #13 +
                                         'VALUES ( ''' + pro_no + ''', ''3'' , ''' + FGID03.Text + ''', ''' + price + ''' )';
                             SqlExe;
                           end;
                      end;

                      if ( proln = '3' ) and ( fgno < '3' ) then
                         begin
                           sql_text := 'DELETE * FROM PROMO_DETAIL WHERE PRO_NO = ''' +pro_no+ ''' AND   PRO_LN  = ''3'' ';
                           SqlExe;
                         end;
                      if ( ( proln = '3' ) and ( fgno < '2' ) ) or ( ( proln = '2' ) and ( fgno = '1' ) ) then
                         begin
                           sql_text := 'DELETE * FROM PROMO_DETAIL WHERE PRO_NO = ''' +pro_no+ ''' AND   PRO_LN  = ''2'' ';
                           SqlExe;
                         end;


                    PromoNo.SetFocus;
                    StabrPROMO.Panels[2].Text := ' แก้ไขข้อมูลโปรโมชั่นเรียบร้อยแล้ว';
                 end
              else
              if status = 'I' then
              begin
                    sql_text  := 'INSERT INTO PROMO_HEAD (PRO_NO, PRO_DESC, PRO_FGNO)' +
                            'VALUES ( ''' + pro_no + ''', ''' + PromoDesc.Text + ''', ''' + FGNO + ''' )';
                    SqlExe;

                    price     := formatfloat('#0.00', strtofloat(Rem_comma(FGPRC01.Text)));
                    sql_text  := 'INSERT INTO PROMO_DETAIL' + #13 +
                                 '(PRO_NO, PRO_LN, PRO_FG_ID, PRO_FG_PRICE)' + #13 +
                                 'VALUES (''' + pro_no + ''', ''1'' , ''' + FGID01.Text + ''', ''' + price + ''' )';
                    SqlExe;

                    IF FGID02.Text <> '' then
                       begin
                        price     := formatfloat('#0.00', strtofloat(Rem_comma(FGPRC02.Text)));
                        sql_text  := 'INSERT INTO PROMO_DETAIL' + #13 +
                                     '(PRO_NO, PRO_LN, PRO_FG_ID, PRO_FG_PRICE)' + #13 +
                                     'VALUES ( ''' + pro_no + ''', ''2'' , ''' + FGID02.Text + ''', ''' + price + ''' ) ';
                        SqlExe;
                    end;

                    IF FGID03.Text <> '' then
                       begin
                        price := formatfloat('#0.00', strtofloat(Rem_comma(FGPRC03.Text)));
                        sql_text  := 'INSERT INTO PROMO_DETAIL' + #13 +
                                     '(PRO_NO, PRO_LN, PRO_FG_ID, PRO_FG_PRICE)' + #13 +
                                     'VALUES ( ''' + pro_no + ''', ''3'' , ''' + FGID03.Text + ''', ''' + price + ''' )';
                        SqlExe;
                       end;
                    PromoNo.SetFocus;
                    SelectPromoNo;
                    BtbDelete.Enabled := True;
                    StabrPROMO.Panels[2].Text := ' เพิ่มข้อมูลโปรโมชั่นเรียบร้อยแล้ว';
                    status := 'U';
             end;
          end
          else
            MessageDlg('กรุณา กรอกรหัสสินค้าอย่างน้อย 1 รายการ', mtError , [mbok], 0);
     end;
end;

procedure TFrmPROMO.PromoNoClick(Sender: TObject);
begin
  if Trim(PromoNo.Text) <> old_promo then
     PromoNoExit(PromoNo);
end;

procedure TFrmPROMO.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in [#13,#39]  then
  begin
    SelectNext(ActiveControl, True, True);
    Key := #0;
  end;

end;

end.
