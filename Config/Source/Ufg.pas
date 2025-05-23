unit Ufg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, StdCtrls, ComCtrls, ExtCtrls, Buttons;
  const status: array[0..6] of char = ('R','F','A','D','E','C','U');
  // R=Read,F=Find,A=Append,D=Delete,E=Edit,C=Commit,U=Update
type
  TFrmFG = class(TForm)
    BvCompany: TBevel;
    LbFGId: TLabel;
    LblGrpId: TLabel;
    LblUnitsId: TLabel;
    LblBarcode: TLabel;
    LblGrade: TLabel;
    LblDes: TLabel;
    LblWh: TLabel;
    EdFGId: TEdit;
    EdBarcode: TEdit;
    EdDes: TEdit;
    EdWh: TEdit;
    BtbOk: TBitBtn;
    BtbCancel: TBitBtn;
    BtbExit: TBitBtn;
    RdgrpStatus: TRadioGroup;
    RdbShow: TRadioButton;
    RdbInsert: TRadioButton;
    RdbDelete: TRadioButton;
    RdbUpdate: TRadioButton;
    StabrFG: TStatusBar;
    CbGrpId: TComboBox;
    ADOCmdFG: TADOCommand;
    ADODSFG: TADODataSet;
    ADODSPrdGrp: TADODataSet;
    ADOCmdPrdGrp: TADOCommand;
    EdPrice: TEdit;
    LblPrice: TLabel;
    LblCost: TLabel;
    EdCost: TEdit;
    CbUnitsId: TComboBox;
    EdGrade: TEdit;
    ADODSUnits: TADODataSet;
    ADOCmdUnits: TADOCommand;
    ADODSBillD: TADODataSet;
    ADOCmdBillD: TADOCommand;
    procedure FormCreate(Sender: TObject);
    procedure RdbShowClick(Sender: TObject);
    procedure RdbInsertClick(Sender: TObject);
    procedure RdbDeleteClick(Sender: TObject);
    procedure RdbUpdateClick(Sender: TObject);
    procedure BtbOkClick(Sender: TObject);
    procedure BtbCancelClick(Sender: TObject);
    procedure CbGrpIdDropDown(Sender: TObject);
    procedure CbUnitsIdDropDown(Sender: TObject);
    procedure BtbExitClick(Sender: TObject);
    procedure EdFGIdChange(Sender: TObject);
  private
    { Private declarations }
    numrec,numallrec : variant;
    old_id , load_id : string;
    chk : boolean;
    state : char;
    itmdata: array[1..9] of string;

  public
    { Public declarations }
  end;

var
    FrmFG: TFrmFG;

implementation

{$R *.dfm}

uses Udatamodule;

procedure TFrmFG.FormCreate(Sender: TObject);
begin
  StabrFG.Panels[0].Width := 15 ;
  StabrFG.Panels[1].Width := 285 ;
  RdbShow.Checked := True;
end;

procedure TFrmFG.RdbShowClick(Sender: TObject);
begin
  state := status[1];
  EdFGId.Enabled := True;
  CbGrpId.Enabled := False;
  CbUnitsId.Enabled := False;
  EdBarcode.Enabled := False;
  EdGrade.Enabled := False;
  EdDes.Enabled := False;
  EdWh.Enabled := False;
  EdPrice.Enabled := False;
  EdCost.Enabled := False;
  EdFGId.Text := '';
  CbGrpId.Text := '';
  CbUnitsId.Text := '';
  EdBarcode.Text := '';
  EdGrade.Text := '';
  EdDes.Text := '';
  EdWh.Text := '';
  EdPrice.Text := '';
  EdCost.Text := '';
  StabrFG.Panels[1].Text := ' ';
  StabrFG.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสสินค้าที่ต้องการจะค้นหา';
  BtbOk.Enabled := False;
  BtbCancel.Enabled := False;
end;

procedure TFrmFG.RdbInsertClick(Sender: TObject);
begin
  state := status[2];
  EdFGId.Text := '';
  CbGrpId.Text := '';
  CbUnitsId.Text := '';
  EdBarcode.Text := '';
  EdGrade.Text := '';
  EdDes.Text := '';
  EdWh.Text := '';
  EdPrice.Text := '';
  EdCost.Text := '';
  EdFGId.Enabled := True;
  EdFGId.SetFocus;
  CbGrpId.Enabled := True;
  CbUnitsId.Enabled := True;
  EdBarcode.Enabled := True;
  EdGrade.Enabled := True;
  EdDes.Enabled := True;
  EdWh.Enabled := True;
  EdPrice.Enabled := True;
  EdCost.Enabled := True;
  StabrFG.Panels[1].Text := '';
  StabrFG.Panels[2].Text := ' คำแนะนำ : เลื่อนโดยกด TAB แล้วเลือกปุ่ม OK เพื่อบันทึกข้อมูล';
  BtbOk.Enabled := True;
  BtbCancel.Enabled := True;
end;

procedure TFrmFG.RdbDeleteClick(Sender: TObject);
begin
  state := status[3];
  EdFGId.Text := '';
  CbGrpId.Text := '';
  CbUnitsId.Text := '';
  EdBarcode.Text := '';
  EdGrade.Text := '';
  EdDes.Text := '';
  EdWh.Text := '';
  EdPrice.Text := '';
  EdCost.Text := '';
  EdFGId.Enabled := True;
  EdFGId.SetFocus;
  CbGrpId.Enabled := False;
  CbUnitsId.Enabled := False;
  EdBarcode.Enabled := False;
  EdGrade.Enabled := False;
  EdDes.Enabled := False;
  EdWh.Enabled := False;
  EdPrice.Enabled := False;
  EdCost.Enabled := False;
  StabrFG.Panels[1].Text := '';
  StabrFG.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสสินค้าที่ต้องการจะลบ แล้วเลือกปุ่มOK';
  BtbOk.Enabled := True;
  BtbCancel.Enabled := True;
end;

procedure TFrmFG.RdbUpdateClick(Sender: TObject);
begin
  state := status[4];
  EdFGId.Text := '';
  CbGrpId.Text := '';
  CbUnitsId.Text := '';
  EdBarcode.Text := '';
  EdGrade.Text := '';
  EdDes.Text := '';
  EdWh.Text := '';
  EdPrice.Text := '';
  EdCost.Text := '';
  EdFGId.Enabled := True;
  EdFGId.SetFocus;
  CbGrpId.Enabled := False;
  CbUnitsId.Enabled := False;
  EdBarcode.Enabled := False;
  EdGrade.Enabled := False;
  EdDes.Enabled := False;
  EdWh.Enabled := False;
  EdPrice.Enabled := False;
  EdCost.Enabled := False;
  StabrFG.Panels[1].Text := '';
  StabrFG.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสสินค้าที่ต้องการจะแก้ไข แล้วเลือกปุ่ม OK';
  BtbOk.Enabled := True;
  BtbCancel.Enabled := True;
end;

procedure TFrmFG.BtbOkClick(Sender: TObject);
var
  count : integer;
begin
  count := 0;
  case state of
  'F':begin
        itmdata[1] := Uppercase(Trim(EdFGId.Text));
        with ADOCmdFG do begin
          CommandText := 'SELECT * FROM FINISH_GOODS '+
                         'WHERE FG_ID = :fgid ';
          CommandType := cmdText;
          Parameters.ParamByName('fgid').Value := itmdata[1];
          ADODSFG.Recordset := Execute;
        end;
        ADODSFG.First;
        numrec := ADODSFG.RecNo;
        numallrec := ADODSFG.RecordCount;
        if numallrec <> 0 then begin
          EdFGId.Text := ADODSFG.FieldValues['FG_ID'];
          CbGrpId.Text := ADODSFG.FieldValues['FG_GRP'];
          CbUnitsId.Text := ADODSFG.FieldValues['FG_UNITS'];
          EdBarcode.Text := ADODSFG.FieldValues['FG_BAR_CODE'];
          EdGrade.Text := ADODSFG.FieldValues['FG_GRADE'];
          EdDes.Text := ADODSFG.FieldValues['FG_DES'];
          EdWh.Text := ADODSFG.FieldValues['FG_WH'];
          EdPrice.Text := ADODSFG.FieldValues['FG_PRICE'];
          EdCost.Text := ADODSFG.FieldValues['FG_COST'];
          StabrFG.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ '+ InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrFG.Panels[2].Text := '';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end
        else begin
          EdFGId.Text := '';
          CbGrpId.Text := '';
          CbUnitsId.Text := '';
          EdBarcode.Text := '';
          EdGrade.Text := '';
          EdDes.Text := '';
          EdWh.Text := '';
          EdPrice.Text := '';
          EdCost.Text := '';
          EdFGId.SetFocus;
          numrec := 0;
          numallrec := ADODSFG.RecordCount;
          StabrFG.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการค้นหา';
          StabrFG.Panels[2].Text := '';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end;
      end;
  'A':begin
        try  // Check number input
          itmdata[8]  := FormatFloat('#0.00',StrToFloat(Trim(EdPrice.Text)));
          itmdata[9]  := FormatFloat('#0.00',StrToFloat(Trim(EdCost.Text)));
          if (StrToFloat(EdPrice.Text) >= 0) and (StrToFloat(EdCost.Text) >= 0) then begin
            //Get data from input screen
            itmdata[1] := Uppercase(Trim(EdFGId.Text));
            itmdata[2] := CbGrpId.Text;
            itmdata[3] := CbUnitsId.Text;
            itmdata[4] := EdBarcode.Text;
            itmdata[5] := EdGrade.Text;
            itmdata[6] := EdDes.Text;
            itmdata[7] := EdWh.Text;
            // Check primary key
            with ADOCmdFG do begin
              CommandText := 'SELECT * FROM FINISH_GOODS ';
              CommandType := cmdText;
              ADODSFG.Recordset := Execute;
            end;
            numallrec := ADODSFG.RecordCount;
            with ADOCmdFG do begin
              CommandText := 'SELECT * FROM FINISH_GOODS '+
                             'WHERE FG_ID = :fgid ';
              CommandType := cmdText;
              Parameters.ParamByName('fgid').Value := itmdata[1];
              ADODSFG.Recordset := Execute;
            end;
            chk := False;
            ADODSFG.First;
            numrec := ADODSFG.RecNo;

            for count := numrec to numallrec do
              if (itmdata[1] = ADODSFG.FieldValues['FG_ID']) then chk := True;
              ADODSFG.Next;

            if chk = True then begin
              StabrFG.Panels[1].Text := 'ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลรหัสบริษัทซ้ำ';
              StabrFG.Panels[2].Text := ' คำแนะนำ : กรุณากดปุ่มCancel แล้วบันทึกข้อมูลใหม่อีกครั้ง';
            end
            else begin
              // Check not null
              if (itmdata[1] <> '')and (itmdata[2] <> '')and (itmdata[3] <> '')and (itmdata[4] <> '')and (itmdata[5] <> '')and (itmdata[6] <> '')and (itmdata[7] <> '') and (itmdata[8] <> '') and (itmdata[9] <> '')then begin
                StabrFG.Panels[1].Text := ' บันทึกข้อมูลเรียบร้อยแล้ว';
                StabrFG.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้เลือกสถานะเป็นแสดงข้อมูล';
                with ADOCmdFG do begin
                  CommandText := 'INSERT INTO FINISH_GOODS (FG_ID, FG_GRP, FG_UNITS, FG_BAR_CODE, FG_GRADE, FG_DES, FG_WH, FG_PRICE, FG_COST)'+
                  'VALUES (:fgid , :fggrp , :units , :barcode , :grade , :des , :wh , :price , :cost)';
                  CommandType := cmdText;
                  Parameters.ParamByName('fgid').Value := itmdata[1];
                  Parameters.ParamByName('fggrp').Value := itmdata[2];
                  Parameters.ParamByName('units').Value := itmdata[3];
                  Parameters.ParamByName('barcode').Value := itmdata[4];
                  Parameters.ParamByName('grade').Value := itmdata[5];
                  Parameters.ParamByName('des').Value := itmdata[6];
                  Parameters.ParamByName('wh').Value := itmdata[7];
                  Parameters.ParamByName('price').Value := itmdata[8];
                  Parameters.ParamByName('cost').Value := itmdata[9];
                  Execute
                end;
                EdFGId.Text := '';     // Plus
                CbGrpId.Text := '';    // Plus
                CbUnitsId.Text := '';  // Plus
                EdBarcode.Text := '';  // Plus
                EdGrade.Text := '';    // Plus
                EdDes.Text := '';      // Plus
                EdWh.Text := '';       // Plus
                EdPrice.Text := '';    // Plus
                EdCost.Text := '';     // Plus
                EdFGId.SetFocus;       // Plus
              end
              else begin
              ShowMessage ('ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน'); // Plus2
              StabrFG.Panels[1].Text := 'ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน';
              StabrFG.Panels[2].Text := ' คำแนะนำ : กรุณากดปุ่มCancel แล้วบันทึกข้อมูลใหม่อีกครั้ง';
              end;
            end;
          end
          else begin
            ShowMessage('กรุณาป้อนข้อมูลราคาสินค้าและราคาต้นทุนเป็นตัวเลขที่มากกว่าศูนย์');
            EdPrice.Text := '';
            EdCost.Text := '';
            EdPrice.SetFocus;
          end;
        except
          on E :EConvertError do
          begin
            Showmessage('กรุณาป้อนข้อมูลราคาสินค้าและราคาต้นทุนเป็นตัวเลข');
            state := status[2];
            EdPrice.Text := '';
            EdCost.Text := '';
            EdPrice.SetFocus;
          end;
        end;
      end;
  'D':begin
        count := count + 1 ;
        itmdata[1] := Uppercase(Trim(EdFGId.Text));
        with ADOCmdFG do begin
          CommandText := 'SELECT * FROM FINISH_GOODS '+
                         'WHERE FG_ID = :fgid ';
          CommandType := cmdText;
          Parameters.ParamByName('fgid').Value := itmdata[1];
          ADODSFG.Recordset := Execute;
        end;
        ADODSFG.First;
        numrec := ADODSFG.RecNo;
        numallrec := ADODSFG.RecordCount;
        if numallrec <> 0 then begin
          EdFGId.Text := ADODSFG.FieldValues['FG_ID'];
          CbGrpId.Text := ADODSFG.FieldValues['FG_GRP'];
          CbUnitsId.Text := ADODSFG.FieldValues['FG_UNITS'];
          EdBarcode.Text := ADODSFG.FieldValues['FG_BAR_CODE'];
          EdGrade.Text := ADODSFG.FieldValues['FG_GRADE'];
          EdDes.Text := ADODSFG.FieldValues['FG_DES'];
          EdWh.Text := ADODSFG.FieldValues['FG_WH'];
          EdPrice.Text := ADODSFG.FieldValues['FG_PRICE'];
          EdCost.Text := ADODSFG.FieldValues['FG_COST'];
          StabrFG.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ '+ InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrFG.Panels[2].Text := ' คำแนะนำ : คุณแน่ใจที่จะลบข้อมูลหรือไม่ ถ้าใช่ให้กดปุ่ม OK อีกครั้งหนึ่ง';
          ShowMessage ('คุณแน่ใจที่จะลบข้อมูลหรือไม่ ถ้าใช่ให้กดปุ่ม OK ที่หน้าจอ อีกครั้งหนึ่ง');
          if count > 0 then begin
            state := status[5];
          end;
        end
        else begin
          EdFGId.Text := '';
          CbGrpId.Text := '';
          CbUnitsId.Text := '';
          EdBarcode.Text := '';
          EdGrade.Text := '';
          EdDes.Text := '';
          EdWh.Text := '';
          EdPrice.Text := '';
          EdCost.Text := '';
          EdFGId.SetFocus;
          numrec := 0;
          numallrec := ADODSFG.RecordCount;
          StabrFG.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการจะลบ';
          StabrFG.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการป้อนข้อมูลใหม่อีกครั้งให้กดปุ่ม Cancel';
          state := status[3];
        end;
      end;
  'C':begin
        with ADOCmdBillD do begin // Check delete foreign key reference from another table
          CommandText := 'SELECT * FROM BILL_DETAIL WHERE BILLD_GOODS_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSBillD.Recordset := Execute;
        end;
        numrec := ADODSBillD.RecordCount;
        if numrec > 0 then begin
          StabrFG.Panels[1].Text := ' ไม่สามารถลบข้อมูลได้เนื่องจากมีการนำข้อมูลนี้ไปใช้งานแล้ว';
          StabrFG.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการลบข้อมูลให้แจ้งผู้ดูแลฐานข้อมูล';
        end
        else begin
          with ADOCmdFG do begin
            CommandText := 'DELETE * FROM FINISH_GOODS '+
                           'WHERE FG_ID = :fgid ';
            CommandType := cmdText;
            Parameters.ParamByName('fgid').Value := itmdata[1];
            Execute;
          end;
          EdFGId.Text := '';
          CbGrpId.Text := '';
          CbUnitsId.Text := '';
          EdBarcode.Text := '';
          EdGrade.Text := '';
          EdDes.Text := '';
          EdWh.Text := '';
          EdPrice.Text := '';
          EdCost.Text := '';
          EdFGId.SetFocus;
          StabrFG.Panels[1].Text := ' ข้อมูลถูกลบออกจากฐานข้อมูลเรียบร้อยแล้ว';
          StabrFG.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้เลือกสถานะเป็นแสดงข้อมูล';
          state := status[3];
          end;
        end;
  'E':begin
        EdFGId.Enabled := False;
        count := count + 1 ;
        itmdata[1] := Uppercase(Trim(EdFGId.Text));
        old_id := itmdata[1];
        with ADOCmdFG do begin
          CommandText := 'SELECT * FROM FINISH_GOODS '+
                         'WHERE FG_ID = :fgid ';
          CommandType := cmdText;
          Parameters.ParamByName('fgid').Value := itmdata[1];
          ADODSFG.Recordset := Execute;
        end;
        ADODSFG.First;
        numrec := ADODSFG.RecNo;
        numallrec := ADODSFG.RecordCount;
        CbGrpId.Enabled := True;
        CbUnitsId.Enabled := True;
        EdBarcode.Enabled := True;
        EdGrade.Enabled := True;
        EdDes.Enabled := True;
        EdWh.Enabled := True;
        EdPrice.Enabled := True;
        EdCost.Enabled := True;
        if numallrec <> 0 then begin
          EdFGId.Text := ADODSFG.FieldValues['FG_ID'];
          CbGrpId.Text := ADODSFG.FieldValues['FG_GRP'];
          CbUnitsId.Text := ADODSFG.FieldValues['FG_UNITS'];
          EdBarcode.Text := ADODSFG.FieldValues['FG_BAR_CODE'];
          EdGrade.Text := ADODSFG.FieldValues['FG_GRADE'];
          EdDes.Text := ADODSFG.FieldValues['FG_DES'];
          EdWh.Text := ADODSFG.FieldValues['FG_WH'];
          EdPrice.Text := ADODSFG.FieldValues['FG_PRICE'];
          EdCost.Text := ADODSFG.FieldValues['FG_COST'];
          StabrFG.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ '+ InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrFG.Panels[2].Text := ' คำแนะนำ : เมื่อแก้ไขข้อมูลเสร็จเรียบร้อยแล้วให้กดปุ่มOK ';
          if count > 0 then begin
            state := status[6];
          end;
        end
        else begin
          EdFGId.Text := '';
          CbGrpId.Text := '';
          CbUnitsId.Text := '';
          EdBarcode.Text := '';
          EdGrade.Text := '';
          EdDes.Text := '';
          EdWh.Text := '';
          EdPrice.Text := '';
          EdCost.Text := '';
          EdFGId.Enabled := True;
          EdFGId.SetFocus;
          numrec := 0;
          numallrec := ADODSFG.RecordCount;
          StabrFG.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการจะแก้ไข';
          StabrFG.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการป้อนข้อมูลใหม่อีกครั้งให้กดปุ่ม Cancel';
          state := status[4];
        end;
      end;
  'U':begin
        try  // Check number input
          itmdata[8]  := formatfloat('#0.00',strtofloat(EdPrice.Text));
          itmdata[9]  := formatfloat('#0.00',strtofloat(EdCost.Text));
          if (StrToFloat(EdPrice.Text) >= 0) and (StrToFloat(EdCost.Text) >= 0) then begin
            //Get data from input screen
            EdFGId.Enabled := False;
            //itmdata[1] := Uppercase(Trim(EdFGId.Text));
            itmdata[2] := CbGrpId.Text;
            itmdata[3] := CbUnitsId.Text;
            itmdata[4] := EdBarcode.Text;
            itmdata[5] := EdGrade.Text;
            itmdata[6] := EdDes.Text;
            itmdata[7] := EdWh.Text;
            if (itmdata[1] <> '')and (itmdata[2] <> '')and (itmdata[3] <> '')and (itmdata[4] <> '')and (itmdata[5] <> '')and (itmdata[6] <> '')and (itmdata[7] <> '')and (itmdata[8] <> '') and (itmdata[9] <> '')then begin
              with ADOCmdFG do begin
              CommandText := 'UPDATE FINISH_GOODS '+
                             'SET '+ //FINISH_GOODS.FG_ID = :fgid,'+
                             'FINISH_GOODS.FG_GRP = :fggrp,'+
                             'FINISH_GOODS.FG_UNITS = :units,'+
                             'FINISH_GOODS.FG_BAR_CODE = :barcode,'+
                             'FINISH_GOODS.FG_GRADE = :grade,'+
                             'FINISH_GOODS.FG_DES = :des,'+
                             'FINISH_GOODS.FG_WH = :wh,'+
                             'FINISH_GOODS.FG_PRICE = :price,'+
                             'FINISH_GOODS.FG_COST = :cost '+
                             'WHERE (FINISH_GOODS.FG_ID = :id) ';
              CommandType := cmdText;
              //Parameters.ParamByName('fgid').Value := itmdata[1];
              Parameters.ParamByName('fggrp').Value := itmdata[2];
              Parameters.ParamByName('units').Value := itmdata[3];
              Parameters.ParamByName('barcode').Value := itmdata[4];
              Parameters.ParamByName('grade').Value := itmdata[5];
              Parameters.ParamByName('des').Value := itmdata[6];
              Parameters.ParamByName('wh').Value := itmdata[7];
              Parameters.ParamByName('price').Value := itmdata[8];
              Parameters.ParamByName('cost').Value := itmdata[9];
              Parameters.ParamByName('id').Value := old_id;
              Execute
              end;
              StabrFG.Panels[1].Text := ' ข้อมูลถูกแก้ไขกับฐานข้อมูลเรียบร้อยแล้ว';
              StabrFG.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้เลือกสถานะเป็นแสดงข้อมูล';
              EdFGId.Text := '';
              CbGrpId.Text := '';
              CbUnitsId.Text := '';
              EdBarcode.Text := '';
              EdGrade.Text := '';
              EdDes.Text := '';
              EdWh.Text := '';
              EdPrice.Text := '';
              EdCost.Text := '';
              EdFGId.Enabled := True;
              CbGrpId.Enabled := False;
              CbUnitsId.Enabled := False;
              EdBarcode.Enabled := False;
              EdGrade.Enabled := False;
              EdDes.Enabled := False;
              EdWh.Enabled := False;
              EdPrice.Enabled:= False;
              EdCost.Enabled := False;
              EdFGId.SetFocus;       // Plus
              state := status[4];
            end
            else begin
              ShowMessage ('ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน'); // Plus2
              StabrFG.Panels[1].Text := 'ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน';
              StabrFG.Panels[2].Text := ' คำแนะนำ : กรุณากดปุ่มCancel แล้วบันทึกข้อมูลใหม่อีกครั้ง';
              state := status[4];
            end;
          end
          else begin
            ShowMessage('กรุณาป้อนข้อมูลราคาสินค้าและราคาต้นทุนเป็นตัวเลขที่มากกว่าศูนย์');
            EdPrice.Text := '';
            EdCost.Text := '';
            EdPrice.SetFocus;
          end;
        except
          on E :EConvertError do
          begin
            Showmessage('กรุณาป้อนข้อมูลราคาสินค้าและราคาต้นทุนเป็นตัวเลข');
            state := status[2];
            EdPrice.Text := '';
            EdCost.Text := '';
            EdPrice.SetFocus;
          end;
        end;
      end;
  end;
end;

procedure TFrmFG.BtbCancelClick(Sender: TObject);
begin
  EdFGId.Enabled := True;
  case state of
  'F':begin
        EdFGId.Text := '';
        CbGrpId.Text := '';
        CbUnitsId.Text := '';
        EdBarcode.Text := '';
        EdGrade.Text := '';
        EdDes.Text := '';
        EdWh.Text := '';
        EdPrice.Text := '';
        EdCost.Text := '';
        EdFGId.SetFocus;
        numrec := 0;
        numallrec := 0;
        StabrFG.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ '+ InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
        StabrFG.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้กดปุ่มแว่นขยาย';
      end;
  'A':begin
        EdFGId.Text := '';
        CbGrpId.Text := '';
        CbUnitsId.Text := '';
        EdBarcode.Text := '';
        EdGrade.Text := '';
        EdDes.Text := '';
        EdWh.Text := '';
        EdPrice.Text := '';
        EdCost.Text := '';
        EdFGId.SetFocus;
        StabrFG.Panels[1].Text := '';
        StabrFG.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสบริษัทที่ต้องการจะค้นหา แล้วเลือกปุ่มOK';
      end;
  'D':begin
        EdFGId.Text := '';
        CbGrpId.Text := '';
        CbUnitsId.Text := '';
        EdBarcode.Text := '';
        EdGrade.Text := '';
        EdDes.Text := '';
        EdWh.Text := '';
        EdPrice.Text := '';
        EdCost.Text := '';
        EdFGId.SetFocus;
        StabrFG.Panels[1].Text := '';
        StabrFG.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสสินค้าที่ต้องการจะลบใหม่อีกครั้ง';
      end;
  'C':begin
        state := status[3]; //Plus
        EdFGId.Text := '';
        CbGrpId.Text := '';
        CbUnitsId.Text := '';
        EdBarcode.Text := '';
        EdGrade.Text := '';
        EdDes.Text := '';
        EdWh.Text := '';
        EdPrice.Text := '';
        EdCost.Text := '';
        EdFGId.SetFocus;
        StabrFG.Panels[1].Text := '';
        StabrFG.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสสินค้าที่ต้องการจะลบใหม่อีกครั้ง';
      end;
  'E':begin
        EdFGId.Text := '';
        CbGrpId.Text := '';
        CbUnitsId.Text := '';
        EdBarcode.Text := '';
        EdGrade.Text := '';
        EdDes.Text := '';
        EdWh.Text := '';
        EdPrice.Text := '';
        EdCost.Text := '';
        EdFGId.SetFocus;
        StabrFG.Panels[1].Text := '';
        StabrFG.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสสินค้าที่ต้องการจะแก้ไขใหม่อีกครั้ง';
      end;
  'U':begin
        state := status[4]; //Plus
        EdFGId.Text := '';
        CbGrpId.Text := '';
        CbUnitsId.Text := '';
        EdBarcode.Text := '';
        EdGrade.Text := '';
        EdDes.Text := '';
        EdWh.Text := '';
        EdPrice.Text := '';
        EdCost.Text := '';
        EdFGId.SetFocus;
        StabrFG.Panels[1].Text := '';
        StabrFG.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสสินค้าที่ต้องการจะแก้ไขใหม่อีกครั้ง';
      end;
  end;
end;

procedure TFrmFG.CbGrpIdDropDown(Sender: TObject);
var
  count : integer;
begin
  CbGrpId.Items.Clear;
  with ADODSPrdGrp do begin
    CommandType := cmdText;
    CommandText := 'SELECT * FROM PRODGROUP ';
    Open;
  end;
  ADODSPrdGrp.First;
  numrec := ADODSPrdGrp.RecNo;
  numallrec := ADODSPrdGrp.RecordCount;
  for count := numrec to numallrec do
  begin
    load_id := ADODSPrdGrp.FieldValues['GRP_ID'];
    CbGrpId.Items.Add(load_id);
    ADODSPrdGrp.Next;
  end;
end;

procedure TFrmFG.CbUnitsIdDropDown(Sender: TObject);
var
  count : integer;
begin
  CbUnitsId.Items.Clear;
  with ADODSUnits do begin
    CommandType := cmdText;
    CommandText := 'SELECT * FROM UNITS ';
    Open;
  end;
  ADODSUnits.First;
  numrec := ADODSUnits.RecNo;
  numallrec := ADODSUnits.RecordCount;
  for count := numrec to numallrec do
  begin
    load_id := ADODSUnits.FieldValues['UNITS_ID'];
    CbUnitsId.Items.Add(load_id);
    ADODSUnits.Next;
  end;
end;

procedure TFrmFG.BtbExitClick(Sender: TObject);
var reps : word;
begin
  reps := MessageDlg('คุณต้องการออกจากหน้าจอนี้ใช่หรือไม่', mtConfirmation, [mbYes, mbNo], 0);
  if reps = mrYes then close;
end;

procedure TFrmFG.EdFGIdChange(Sender: TObject);
begin
  case state of
  'F':begin
        itmdata[1] := Uppercase(Trim(EdFGId.Text));
        with ADOCmdFG do begin
          CommandText := 'SELECT * FROM FINISH_GOODS '+
                         'WHERE FG_ID = :fgid ';
          CommandType := cmdText;
          Parameters.ParamByName('fgid').Value := itmdata[1];
          ADODSFG.Recordset := Execute;
        end;
        ADODSFG.First;
        numrec := ADODSFG.RecNo;
        numallrec := ADODSFG.RecordCount;
        if numallrec <> 0 then begin
          EdFGId.Text := ADODSFG.FieldValues['FG_ID'];
          CbGrpId.Text := ADODSFG.FieldValues['FG_GRP'];
          CbUnitsId.Text := ADODSFG.FieldValues['FG_UNITS'];
          EdBarcode.Text := ADODSFG.FieldValues['FG_BAR_CODE'];
          EdGrade.Text := ADODSFG.FieldValues['FG_GRADE'];
          EdDes.Text := ADODSFG.FieldValues['FG_DES'];
          EdWh.Text := ADODSFG.FieldValues['FG_WH'];
          EdPrice.Text := ADODSFG.FieldValues['FG_PRICE'];
          EdCost.Text := ADODSFG.FieldValues['FG_COST'];
          StabrFG.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ '+ InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrFG.Panels[2].Text := ' ';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end
        else begin
          CbGrpId.Text := '';
          CbUnitsId.Text := '';
          EdBarcode.Text := '';
          EdGrade.Text := '';
          EdDes.Text := '';
          EdWh.Text := '';
          EdPrice.Text := '';
          EdCost.Text := '';
          EdFGId.SetFocus;
          numrec := 0;
          numallrec := ADODSFG.RecordCount;
          StabrFG.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการค้นหา';
          StabrFG.Panels[2].Text := ' ';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end;
      end;
  'A':begin
        itmdata[1] := Uppercase(Trim(EdFGId.Text));
        with ADOCmdFG do begin
          CommandText := 'SELECT * FROM FINISH_GOODS '+
                         'WHERE FG_ID = :fgid ';
          CommandType := cmdText;
          Parameters.ParamByName('fgid').Value := itmdata[1];
          ADODSFG.Recordset := Execute;
        end;
          ADODSFG.First;
          numrec := ADODSFG.RecNo;
          numallrec := ADODSFG.RecordCount;
        if numallrec <> 0 then begin
          EdFGId.Text := ADODSFG.FieldValues['FG_ID'];
          CbGrpId.Text := ADODSFG.FieldValues['FG_GRP'];
          CbUnitsId.Text := ADODSFG.FieldValues['FG_UNITS'];
          EdBarcode.Text := ADODSFG.FieldValues['FG_BAR_CODE'];
          EdGrade.Text := ADODSFG.FieldValues['FG_GRADE'];
          EdDes.Text := ADODSFG.FieldValues['FG_DES'];
          EdWh.Text := ADODSFG.FieldValues['FG_WH'];
          EdPrice.Text := ADODSFG.FieldValues['FG_PRICE'];
          EdCost.Text := ADODSFG.FieldValues['FG_COST'];
          StabrFG.Panels[1].Text := ' มีข้อมูลอยู่ในฐานข้อมูลอยู่แล้ว';
          StabrFG.Panels[2].Text := ' คำแนะนำ : กด Cancel เพื่อ Clear ข้อมูล';
          ShowMessage ('มีข้อมูลอยู่ในฐานข้อมูลอยู่แล้ว    กรุณาพิมพ์รหัสสินค้าใหม่อีกครั้ง');
        end
        else begin
          CbGrpId.Text := '';
          CbUnitsId.Text := '';
          EdBarcode.Text := '';
          EdGrade.Text := '';
          EdDes.Text := '';
          EdWh.Text := '';
          EdPrice.Text := '';
          EdCost.Text := '';
          numrec := 0;
          numallrec := ADODSFG.RecordCount;
        end;
      end;
  'D':begin
        itmdata[1] := Uppercase(Trim(EdFGId.Text));
        with ADOCmdFG do begin
          CommandText := 'SELECT * FROM FINISH_GOODS '+
                         'WHERE FG_ID = :fgid ';
          CommandType := cmdText;
          Parameters.ParamByName('fgid').Value := itmdata[1];
          ADODSFG.Recordset := Execute;
        end;
        ADODSFG.First;
        numrec := ADODSFG.RecNo;
        numallrec := ADODSFG.RecordCount;
        if numallrec <> 0 then begin
          EdFGId.Text := ADODSFG.FieldValues['FG_ID'];
          CbGrpId.Text := ADODSFG.FieldValues['FG_GRP'];
          CbUnitsId.Text := ADODSFG.FieldValues['FG_UNITS'];
          EdBarcode.Text := ADODSFG.FieldValues['FG_BAR_CODE'];
          EdGrade.Text := ADODSFG.FieldValues['FG_GRADE'];
          EdDes.Text := ADODSFG.FieldValues['FG_DES'];
          EdWh.Text := ADODSFG.FieldValues['FG_WH'];
          EdPrice.Text := ADODSFG.FieldValues['FG_PRICE'];
          EdCost.Text := ADODSFG.FieldValues['FG_COST'];
          StabrFG.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrFG.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ ลบข้อมูล';
        end
        else begin
          CbGrpId.Text := '';
          CbUnitsId.Text := '';
          EdBarcode.Text := '';
          EdGrade.Text := '';
          EdDes.Text := '';
          EdWh.Text := '';
          EdPrice.Text := '';
          EdCost.Text := '';
          numrec := 0;
          numallrec := ADODSFG.RecordCount;
        end;
      end;
  'C':begin
        CbGrpId.Enabled := False;
        CbUnitsId.Enabled := False;
        EdBarcode.Enabled := False;
        EdGrade.Enabled := False;
        EdDes.Enabled := False;
        EdWh.Enabled := False;
        EdPrice.Enabled := False;
        EdCost.Enabled := False;
        itmdata[1] := Uppercase(Trim(EdFGId.Text));
        with ADOCmdFG do begin
          CommandText := 'SELECT * FROM FINISH_GOODS '+
                         'WHERE FG_ID = :fgid ';
          CommandType := cmdText;
          Parameters.ParamByName('fgid').Value := itmdata[1];
          ADODSFG.Recordset := Execute;
        end;
        ADODSFG.First;
        numrec := ADODSFG.RecNo;
        numallrec := ADODSFG.RecordCount;
        if numallrec <> 0 then begin
          EdFGId.Text := ADODSFG.FieldValues['FG_ID'];
          CbGrpId.Text := ADODSFG.FieldValues['FG_GRP'];
          CbUnitsId.Text := ADODSFG.FieldValues['FG_UNITS'];
          EdBarcode.Text := ADODSFG.FieldValues['FG_BAR_CODE'];
          EdGrade.Text := ADODSFG.FieldValues['FG_GRADE'];
          EdDes.Text := ADODSFG.FieldValues['FG_DES'];
          EdWh.Text := ADODSFG.FieldValues['FG_WH'];
          EdPrice.Text := ADODSFG.FieldValues['FG_PRICE'];
          EdCost.Text := ADODSFG.FieldValues['FG_COST'];
          StabrFG.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrFG.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          EdFGId.Text := '';
          CbGrpId.Text := '';
          CbUnitsId.Text := '';
          EdBarcode.Text := '';
          EdGrade.Text := '';
          EdDes.Text := '';
          EdWh.Text := '';
          EdPrice.Text := '';
          EdCost.Text := '';
          numrec := 0;
          numallrec := ADODSFG.RecordCount;
        end;
      end;
  'E':begin
        CbGrpId.Enabled := False;
        CbUnitsId.Enabled := False;
        EdBarcode.Enabled := False;
        EdGrade.Enabled := False;
        EdDes.Enabled := False;
        EdWh.Enabled := False;
        EdPrice.Enabled := False;
        EdCost.Enabled := False;
        itmdata[1] := Uppercase(Trim(EdFGId.Text));
        with ADOCmdFG do begin
          CommandText := 'SELECT * FROM FINISH_GOODS '+
                         'WHERE FG_ID = :fgid ';
          CommandType := cmdText;
          Parameters.ParamByName('fgid').Value := itmdata[1];
          ADODSFG.Recordset := Execute;
        end;
        ADODSFG.First;
        numrec := ADODSFG.RecNo;
        numallrec := ADODSFG.RecordCount;
        if numallrec <> 0 then begin
          EdFGId.Text := ADODSFG.FieldValues['FG_ID'];
          CbGrpId.Text := ADODSFG.FieldValues['FG_GRP'];
          CbUnitsId.Text := ADODSFG.FieldValues['FG_UNITS'];
          EdBarcode.Text := ADODSFG.FieldValues['FG_BAR_CODE'];
          EdGrade.Text := ADODSFG.FieldValues['FG_GRADE'];
          EdDes.Text := ADODSFG.FieldValues['FG_DES'];
          EdWh.Text := ADODSFG.FieldValues['FG_WH'];
          EdPrice.Text := ADODSFG.FieldValues['FG_PRICE'];
          EdCost.Text := ADODSFG.FieldValues['FG_COST'];
          StabrFG.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrFG.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          CbGrpId.Text := '';
          CbUnitsId.Text := '';
          EdBarcode.Text := '';
          EdGrade.Text := '';
          EdDes.Text := '';
          EdWh.Text := '';
          EdPrice.Text := '';
          EdCost.Text := '';
          numrec := 0;
          numallrec := ADODSFG.RecordCount;
        end;
      end;
  'U':begin
        CbGrpId.Enabled := False;
        CbUnitsId.Enabled := False;
        EdBarcode.Enabled := False;
        EdGrade.Enabled := False;
        EdDes.Enabled := False;
        EdWh.Enabled := False;
        EdPrice.Enabled := False;
        EdCost.Enabled := False;
        itmdata[1] := Uppercase(Trim(EdFGId.Text));
        with ADOCmdFG do begin
          CommandText := 'SELECT * FROM FINISH_GOODS '+
                         'WHERE FG_ID = :fgid ';
          CommandType := cmdText;
          Parameters.ParamByName('fgid').Value := itmdata[1];
          ADODSFG.Recordset := Execute;
        end;
        ADODSFG.First;
        numrec := ADODSFG.RecNo;
        numallrec := ADODSFG.RecordCount;
        if numallrec <> 0 then begin
          EdFGId.Text := ADODSFG.FieldValues['FG_ID'];
          CbGrpId.Text := ADODSFG.FieldValues['FG_GRP'];
          CbUnitsId.Text := ADODSFG.FieldValues['FG_UNITS'];
          EdBarcode.Text := ADODSFG.FieldValues['FG_BAR_CODE'];
          EdGrade.Text := ADODSFG.FieldValues['FG_GRADE'];
          EdDes.Text := ADODSFG.FieldValues['FG_DES'];
          EdWh.Text := ADODSFG.FieldValues['FG_WH'];
          EdPrice.Text := ADODSFG.FieldValues['FG_PRICE'];
          EdCost.Text := ADODSFG.FieldValues['FG_COST'];
          StabrFG.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrFG.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          CbGrpId.Text := '';
          CbUnitsId.Text := '';
          EdBarcode.Text := '';
          EdGrade.Text := '';
          EdDes.Text := '';
          EdWh.Text := '';
          EdPrice.Text := '';
          EdCost.Text := '';
          numrec := 0;
          numallrec := ADODSFG.RecordCount;
        end;
      end;
  end;
end;

end.
