unit Ugrp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ADODB, DB, ComCtrls;
  const status: array[0..6] of char = ('R','F','A','D','E','C','U');
  // R=Read,F=Find,A=Append,D=Delete,E=Edit,C=Commit,U=Update

type
  TFrmPrdGrp = class(TForm)
    RdgrpStatus: TRadioGroup;
    RdbShow: TRadioButton;
    RdbInsert: TRadioButton;
    RdbDelete: TRadioButton;
    RdbUpdate: TRadioButton;
    EdPrdGrpId: TEdit;
    LblPrdGrpId: TLabel;
    LblGrpNameT: TLabel;
    EdGrpNameT: TEdit;
    LblGrpNameE: TLabel;
    EdGrpNameE: TEdit;
    ADODSPrdGrp: TADODataSet;
    ADOCmdPrdGrp: TADOCommand;
    BtbOk: TBitBtn;
    BtbCancel: TBitBtn;
    BtbExit: TBitBtn;
    BvCompany: TBevel;
    StabrPrdGrp: TStatusBar;
    ADOCmdFG: TADOCommand;
    ADODSFG: TADODataSet;
    procedure FormCreate(Sender: TObject);
    procedure RdbShowClick(Sender: TObject);
    procedure RdbInsertClick(Sender: TObject);
    procedure RdbDeleteClick(Sender: TObject);
    procedure RdbUpdateClick(Sender: TObject);
    procedure BtbOkClick(Sender: TObject);
    procedure BtbCancelClick(Sender: TObject);
    procedure BtbExitClick(Sender: TObject);
    procedure EdPrdGrpIdChange(Sender: TObject);
  private
    { Private declarations }
    numrec,numallrec : variant;
    old_id : string;
    chk : boolean;
    state : char;
    itmdata: array[1..3] of string;
  public
    { Public declarations }
  end;

var
  FrmPrdGrp: TFrmPrdGrp;


implementation

uses Udatamodule;

{$R *.dfm}


procedure TFrmPrdGrp.FormCreate(Sender: TObject);
begin
  StabrPrdGrp.Panels[0].Width := 15 ;
  StabrPrdGrp.Panels[1].Width := 285 ;
  RdbShow.Checked := True;
end;

procedure TFrmPrdGrp.RdbShowClick(Sender: TObject);
begin
  state := status[1];
  EdPrdGrpId.Enabled := True;
  EdGrpNameT.Enabled := False;
  EdGrpNameE.Enabled := False;
  EdPrdGrpId.Text := '';
  EdGrpNameT.Text := '';
  EdGrpNameE.Text := '';
  StabrPrdGrp.Panels[1].Text := ' ';
  StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสหน่วยนับที่ต้องการจะค้นหา';
  BtbOk.Enabled := False;
  BtbCancel.Enabled := False;
end;

procedure TFrmPrdGrp.RdbInsertClick(Sender: TObject);
begin
  state := status[2];
  EdPrdGrpId.Text := '';
  EdGrpNameT.Text := '';
  EdGrpNameE.Text := '';
  EdPrdGrpId.Enabled := True;
  EdPrdGrpId.SetFocus;
  EdGrpNameT.Enabled := True;
  EdGrpNameE.Enabled := True;
  StabrPrdGrp.Panels[1].Text := '';
  StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : เลื่อนโดยกด TAB แล้วเลือกปุ่ม OK เพื่อบันทึกข้อมูล';
  BtbOk.Enabled := True;
  BtbCancel.Enabled := True;
end;

procedure TFrmPrdGrp.RdbDeleteClick(Sender: TObject);
begin
  state := status[3];
  EdPrdGrpId.Text := '';
  EdGrpNameT.Text := '';
  EdGrpNameE.Text := '';
  EdPrdGrpId.Enabled := True;
  EdPrdGrpId.SetFocus;
  EdGrpNameT.Enabled := False;
  EdGrpNameE.Enabled := False;
  StabrPrdGrp.Panels[1].Text := '';
  StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสกลุ่มสินค้าที่ต้องการจะลบ แล้วเลือกปุ่มOK';
  BtbOk.Enabled := True;
  BtbCancel.Enabled := True;
end;

procedure TFrmPrdGrp.RdbUpdateClick(Sender: TObject);
begin
  state := status[4];
  EdPrdGrpId.Text := '';
  EdGrpNameT.Text := '';
  EdGrpNameE.Text := '';
  EdPrdGrpId.Enabled := True;
  EdPrdGrpId.SetFocus;
  EdGrpNameT.Enabled := False;
  EdGrpNameE.Enabled := False;
  StabrPrdGrp.Panels[1].Text := '';
  StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสกลุ่มสินค้าที่ต้องการจะแก้ไข แล้วเลือกปุ่ม OK';
  BtbOk.Enabled := True;
  BtbCancel.Enabled := True;
end;

procedure TFrmPrdGrp.BtbOkClick(Sender: TObject);
var
  count : integer;
begin
  count := 0;
  case state of
  'F':begin
        itmdata[1] := Uppercase(Trim(EdPrdGrpId.Text));
        with ADOCmdPrdGrp do begin
          CommandText := 'SELECT * FROM PRODGROUP WHERE GRP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSPrdGrp.Recordset := Execute;
        end;
        ADODSPrdGrp.First;
        numrec := ADODSPrdGrp.RecNo;
        numallrec := ADODSPrdGrp.RecordCount;
        if numallrec <> 0 then begin
          EdPrdGrpId.Text := ADODSPrdGrp.FieldValues['GRP_ID'];
          EdGrpNameT.Text := ADODSPrdGrp.FieldValues['GRP_NT'];
          EdGrpNameE.Text := ADODSPrdGrp.FieldValues['GRP_NE'];
          StabrPrdGrp.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ '+ InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrPrdGrp.Panels[2].Text := '';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end
        else begin
          EdPrdGrpId.Text := '';
          EdGrpNameT.Text := '';
          EdGrpNameE.Text:= '';
          EdPrdGrpId.SetFocus;
          numrec := 0;
          numallrec := ADODSPrdGrp.RecordCount;
          StabrPrdGrp.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการค้นหา';
          StabrPrdGrp.Panels[2].Text := '';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end;
      end;
  'A':begin
        //Get data from input screen
        itmdata[1] := Uppercase(Trim(EdPrdGrpId.Text));
        itmdata[2] := EdGrpNameT.Text;
        itmdata[3] := EdGrpNameE.Text;
        // Check primary key
        with ADOCmdPrdGrp do begin
          CommandText := 'SELECT * FROM PRODGROUP';
          CommandType := cmdText;
          ADODSPrdGrp.Recordset := Execute;
        end;
        numallrec := ADODSPrdGrp.RecordCount;
        with ADOCmdPrdGrp do begin
          CommandText := 'SELECT * FROM PRODGROUP WHERE GRP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSPrdGrp.Recordset := Execute;
        end;
        chk := False;
        ADODSPrdGrp.First;
        numrec := ADODSPrdGrp.RecNo;

        for count := numrec to numallrec do
          if itmdata[1] = ADODSPrdGrp.FieldValues['GRP_ID'] then chk := True;
          ADODSPrdGrp.Next;

        if chk = True then begin
          StabrPrdGrp.Panels[1].Text := 'ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลรหัสกลุ่มสินค้าซ้ำ';
          StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : กรุณากดปุ่มCancel แล้วบันทึกข้อมูลใหม่อีกครั้ง';
        end
        else begin
          // Check not null
          if (itmdata[1] <> '')and (itmdata[2] <> '')and (itmdata[3] <> '') then begin
            StabrPrdGrp.Panels[1].Text := ' บันทึกข้อมูลเรียบร้อยแล้ว';
            StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้เลือกสถานะเป็นแสดงข้อมูล';
            with ADOCmdPrdGrp do begin
              CommandText := 'INSERT INTO PRODGROUP (GRP_ID, GRP_NT, GRP_NE)'+
                             'VALUES (:newid, :newgrpnt, :newgrpne)';
              CommandType := cmdText;
              Parameters.ParamByName('newid').Value := itmdata[1];
              Parameters.ParamByName('newgrpnt').Value := itmdata[2];
              Parameters.ParamByName('newgrpne').Value := itmdata[3];
              Execute
            end;
          EdPrdGrpId.Text := '';
          EdGrpNameT.Text := '';
          EdGrpNameE.Text:= '';
          EdPrdGrpId.SetFocus;
          end
          else begin
            ShowMessage ('ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน'); // Plus2
            StabrPrdGrp.Panels[1].Text := 'ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน';
            StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : กรุณากดปุ่มCancel แล้วบันทึกข้อมูลใหม่อีกครั้ง';
          end;
        end;
      end;
  'D':begin
        count := count + 1 ;
        itmdata[1] := Uppercase(Trim(EdPrdGrpId.Text));
        with ADOCmdPrdGrp do begin
          CommandText := 'SELECT * FROM PRODGROUP WHERE GRP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSPrdGrp.Recordset := Execute;
        end;
        ADODSPrdGrp.First;
        numrec := ADODSPrdGrp.RecNo;
        numallrec := ADODSPrdGrp.RecordCount;
        if numallrec <> 0 then begin
          EdPrdGrpId.Text := ADODSPrdGrp.FieldValues['GRP_ID'];
          EdGrpNameT.Text := ADODSPrdGrp.FieldValues['GRP_NT'];
          EdGrpNameE.Text := ADODSPrdGrp.FieldValues['GRP_NE'];
          StabrPrdGrp.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ '+ InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : คุณแน่ใจที่จะลบข้อมูลหรือไม่ ถ้าใช่ให้กดปุ่ม OK อีกครั้งหนึ่ง';
          ShowMessage ('คุณแน่ใจที่จะลบข้อมูลหรือไม่ ถ้าใช่ให้กดปุ่ม OK ที่หน้าจอ อีกครั้งหนึ่ง');
          if count > 0 then begin
            state := status[5];
          end;
        end
        else begin
          EdPrdGrpId.Text := '';
          EdGrpNameT.Text := '';
          EdGrpNameE.Text := '';
          EdPrdGrpId.SetFocus;
          numrec := 0;
          numallrec := ADODSPrdGrp.RecordCount;
          StabrPrdGrp.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการจะลบ';
          StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการป้อนข้อมูลใหม่อีกครั้งให้กดปุ่ม Cancel';
          state := status[3];
        end;
      end;
  'C':begin
        with ADOCmdFG do begin // Check delete foreign key reference from another table
          CommandText := 'SELECT * FROM FINISH_GOODS WHERE FG_GRP = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSFG.Recordset := Execute;
        end;
        numrec := ADODSFG.RecordCount;
        if numrec > 0 then begin
          StabrPrdGrp.Panels[1].Text := ' ไม่สามารถลบข้อมูลได้เนื่องจากมีการนำข้อมูลนี้ไปใช้งานแล้ว';
          StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการลบข้อมูลให้แจ้งผู้ดูแลฐานข้อมูล';
        end
        else begin
          with ADOCmdPrdGrp do begin
            CommandText := 'DELETE * FROM PRODGROUP WHERE GRP_ID = :id';
            CommandType := cmdText;
            Parameters.ParamByName('id').Value := itmdata[1];
            Execute;
          end;
          EdPrdGrpId.Text := '';
          EdGrpNameT.Text := '';
          EdGrpNameE.Text := '';
          StabrPrdGrp.Panels[1].Text := ' ข้อมูลถูกลบออกจากฐานข้อมูลเรียบร้อยแล้ว';
          StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้เลือกสถานะเป็นแสดงข้อมูล';
          state := status[3];
        end;
      end;
  'E':begin
        EdPrdGrpId.Enabled := False;
        count := count + 1 ;
        itmdata[1] := Uppercase(Trim(EdPrdGrpId.Text));
        old_id := itmdata[1];
        with ADOCmdPrdGrp do begin
          CommandText := 'SELECT * FROM PRODGROUP WHERE GRP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSPrdGrp.Recordset := Execute;
        end;
        ADODSPrdGrp.First;
        numrec := ADODSPrdGrp.RecNo;
        numallrec := ADODSPrdGrp.RecordCount;
        EdGrpNameT.Enabled := True;
        EdGrpNameE.Enabled := True;
        if numallrec <> 0 then begin
          EdPrdGrpId.Text := ADODSPrdGrp.FieldValues['GRP_ID'];
          EdGrpNameT.Text := ADODSPrdGrp.FieldValues['GRP_NT'];
          EdGrpNameE.Text := ADODSPrdGrp.FieldValues['GRP_NE'];
          StabrPrdGrp.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ '+ InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : เมื่อแก้ไขข้อมูลเสร็จเรียบร้อยแล้วให้กดปุ่มOK ';
          if count > 0 then begin
            state := status[6];
          end;
        end
        else begin
          EdPrdGrpId.Text := '';
          EdGrpNameT.Text:= '';
          EdGrpNameE.Text := '';
          EdPrdGrpId.Enabled := True;
          EdPrdGrpId.SetFocus;
          numrec := 0;
          numallrec := ADODSPrdGrp.RecordCount;
          StabrPrdGrp.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการจะแก้ไข';
          StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการป้อนข้อมูลใหม่อีกครั้งให้กดปุ่ม Cancel';
          state := status[4];
        end;
      end;
  'U':begin
        //itmdata[1] := Uppercase(Trim(EdPrdGrpId.Text));
        itmdata[2] := EdGrpNameT.Text;
        itmdata[3] := EdGrpNameE.Text;
        if (itmdata[1] <> '')and (itmdata[2] <> '')and (itmdata[3] <> '') then begin
          with ADOCmdPrdGrp do begin
          CommandText := 'UPDATE PRODGROUP ' +
                         'SET '+ //PRODGROUP.GRP_ID = :edid, '+
                         'PRODGROUP.GRP_NT = :edgrpnt, '+
                         'PRODGROUP.GRP_NE = :edgrpne '+
                         'WHERE (PRODGROUP.GRP_ID = :id)';
          CommandType := cmdText;
          //Parameters.ParamByName('edid').Value := itmdata[1];
          Parameters.ParamByName('edgrpnt').Value := itmdata[2];
          Parameters.ParamByName('edgrpne').Value := itmdata[3];
          Parameters.ParamByName('id').Value := old_id;
          Execute
          end;
          StabrPrdGrp.Panels[1].Text := ' ข้อมูลถูกแก้ไขกับฐานข้อมูลเรียบร้อยแล้ว';
          StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้เลือกสถานะเป็นแสดงข้อมูล';
          EdPrdGrpId.Text := '';     // Plus
          EdGrpNameT.Text := '';   // Plus
          EdGrpNameE.Text := '';    // Plus
          EdPrdGrpId.Enabled := True;   // Plus
          EdGrpNameT.Enabled := False;  // Plus
          EdGrpNameE.Enabled := False;  // Plus
          EdPrdGrpId.SetFocus;  // Plus
          state := status[4];
        end
        else begin
          ShowMessage ('ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน'); // Plus2
          StabrPrdGrp.Panels[1].Text := 'ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน';
          StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : กรุณากดปุ่มCancel แล้วบันทึกข้อมูลใหม่อีกครั้ง';
          state := status[4];
        end;
        //EdPrdGrpId.Enabled := False;
      end;
  end;
end;


procedure TFrmPrdGrp.BtbCancelClick(Sender: TObject);
begin
  EdPrdGrpId.Enabled := True;
  case state of
  'F':begin
        EdPrdGrpId.Text := '';
        EdGrpNameT.Text := '';
        EdGrpNameE.Text := '';
        EdPrdGrpId.SetFocus;
        numrec := 0;
        numallrec := 0;
        StabrPrdGrp.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ '+ InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
        StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้กดปุ่มแว่นขยาย';
      end;
  'A':begin
        EdPrdGrpId.Text := '';
        EdGrpNameT.Text := '';
        EdGrpNameE.Text := '';
        EdPrdGrpId.SetFocus;
        StabrPrdGrp.Panels[1].Text := '';
        StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสกลุ่มสินค้าที่ต้องการจะค้นหา แล้วเลือกปุ่มOK';
      end;
  'D':begin
        EdPrdGrpId.Text := '';
        EdGrpNameT.Text := '';
        EdGrpNameE.Text := '';
        EdPrdGrpId.SetFocus;
        StabrPrdGrp.Panels[1].Text := '';
        StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสกลุ่มสินค้าที่ต้องการจะลบใหม่อีกครั้ง';
      end;
  'C':begin
        state := status[3]; //Plus
        EdPrdGrpId.Text := '';
        EdGrpNameT.Text := '';
        EdGrpNameE.Text := '';
        EdPrdGrpId.SetFocus;
        StabrPrdGrp.Panels[1].Text := '';
        StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสกลุ่มสินค้าที่ต้องการจะลบใหม่อีกครั้ง';
      end;
  'E':begin
        EdPrdGrpId.Text := '';
        EdGrpNameT.Text := '';
        EdGrpNameE.Text := '';
        EdPrdGrpId.SetFocus;
        StabrPrdGrp.Panels[1].Text := '';
        StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสกลุ่มสินค้าที่ต้องการจะแก้ไขใหม่อีกครั้ง';
      end;
  'U':begin
        state := status[4]; //Plus
        EdPrdGrpId.Text := '';
        EdGrpNameT.Text := '';
        EdGrpNameE.Text := '';
        EdPrdGrpId.SetFocus;
        StabrPrdGrp.Panels[1].Text := '';
        StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสกลุ่มสินค้าที่ต้องการจะแก้ไขใหม่อีกครั้ง';
      end;
  end;
end;



procedure TFrmPrdGrp.BtbExitClick(Sender: TObject);
var reps : word;
begin
  reps := MessageDlg('คุณต้องการออกจากหน้าจอนี้ใช่หรือไม่', mtConfirmation, [mbYes, mbNo], 0);
  if reps = mrYes then close;
end;



procedure TFrmPrdGrp.EdPrdGrpIdChange(Sender: TObject);
begin
  case state of
  'F':begin
        itmdata[1] := Uppercase(Trim(EdPrdGrpId.Text));
        with ADOCmdPrdGrp do begin
          CommandText := 'SELECT * FROM PRODGROUP WHERE GRP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSPrdGrp.Recordset := Execute;
        end;
        ADODSPrdGrp.First;
        numrec := ADODSPrdGrp.RecNo;
        numallrec := ADODSPrdGrp.RecordCount;
        if numallrec <> 0 then begin
          EdPrdGrpId.Text := ADODSPrdGrp.FieldValues['GRP_ID'];
          EdGrpNameT.Text := ADODSPrdGrp.FieldValues['GRP_NT'];
          EdGrpNameE.Text := ADODSPrdGrp.FieldValues['GRP_NE'];
          StabrPrdGrp.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ '+ InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrPrdGrp.Panels[2].Text := '';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end
        else begin
          EdGrpNameT.Text := '';
          EdGrpNameE.Text:= '';
          EdPrdGrpId.SetFocus;
          numrec := 0;
          numallrec := ADODSPrdGrp.RecordCount;
          StabrPrdGrp.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการค้นหา';
          StabrPrdGrp.Panels[2].Text := '';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end;
      end;
  'A':begin
        itmdata[1] := Uppercase(Trim(EdPrdGrpId.Text));
        with ADOCmdPrdGrp do begin
          CommandText := 'SELECT * FROM PRODGROUP WHERE GRP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSPrdGrp.Recordset := Execute;
        end;
        ADODSPrdGrp.First;
        numrec := ADODSPrdGrp.RecNo;
        numallrec := ADODSPrdGrp.RecordCount;
        if numallrec <> 0 then begin
          EdPrdGrpId.Text := ADODSPrdGrp.FieldValues['GRP_ID'];
          EdGrpNameT.Text := ADODSPrdGrp.FieldValues['GRP_NT'];
          EdGrpNameE.Text := ADODSPrdGrp.FieldValues['GRP_NE'];
          StabrPrdGrp.Panels[1].Text := ' มีข้อมูลอยู่ในฐานข้อมูลอยู่แล้ว';
          StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : กด Cancel เพื่อ Clear ข้อมูล';
          ShowMessage ('มีข้อมูลอยู่ในฐานข้อมูลอยู่แล้ว    กรุณาพิมพ์รหัสกลุ่มสินค้าใหม่อีกครั้ง');
        end
        else begin
          EdGrpNameT.Text := '';
          EdGrpNameE.Text := '';
          numrec := 0;
          numallrec := ADODSPrdGrp.RecordCount;
        end;
      end;
  'D':begin
        itmdata[1] := Uppercase(Trim(EdPrdGrpId.Text));
        with ADOCmdPrdGrp do begin
          CommandText := 'SELECT * FROM PRODGROUP WHERE GRP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSPrdGrp.Recordset := Execute;
        end;
        ADODSPrdGrp.First;
        numrec := ADODSPrdGrp.RecNo;
        numallrec := ADODSPrdGrp.RecordCount;
        if numallrec <> 0 then begin
          EdPrdGrpId.Text := ADODSPrdGrp.FieldValues['GRP_ID'];
          EdGrpNameT.Text := ADODSPrdGrp.FieldValues['GRP_NT'];
          EdGrpNameE.Text := ADODSPrdGrp.FieldValues['GRP_NE'];
          StabrPrdGrp.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ ลบข้อมูล';
        end
        else begin
          EdGrpNameT.Text := '';
          EdGrpNameE.Text := '';
          numrec := 0;
          numallrec := ADODSPrdGrp.RecordCount;
        end;
      end;
  'C':begin
        EdGrpNameT.Enabled := False;
        EdGrpNameE.Enabled := False;
        itmdata[1] := Uppercase(Trim(EdPrdGrpId.Text));
        with ADOCmdPrdGrp do begin
          CommandText := 'SELECT * FROM PRODGROUP WHERE GRP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSPrdGrp.Recordset := Execute;
        end;
        ADODSPrdGrp.First;
        numrec := ADODSPrdGrp.RecNo;
        numallrec := ADODSPrdGrp.RecordCount;
        if numallrec <> 0 then begin
          EdPrdGrpId.Text := ADODSPrdGrp.FieldValues['GRP_ID'];
          EdGrpNameT.Text := ADODSPrdGrp.FieldValues['GRP_NT'];
          EdGrpNameE.Text := ADODSPrdGrp.FieldValues['GRP_NE'];
          StabrPrdGrp.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          EdGrpNameT.Text := '';
          EdGrpNameE.Text := '';
          numrec := 0;
          numallrec := ADODSPrdGrp.RecordCount;
        end;
      end;
  'E':begin
        EdGrpNameT.Enabled := False;
        EdGrpNameE.Enabled := False;
        itmdata[1] := Uppercase(Trim(EdPrdGrpId.Text));
        with ADOCmdPrdGrp do begin
          CommandText := 'SELECT * FROM PRODGROUP WHERE GRP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSPrdGrp.Recordset := Execute;
        end;
        ADODSPrdGrp.First;
        numrec := ADODSPrdGrp.RecNo;
        numallrec := ADODSPrdGrp.RecordCount;
        if numallrec <> 0 then begin
          EdPrdGrpId.Text := ADODSPrdGrp.FieldValues['GRP_ID'];
          EdGrpNameT.Text := ADODSPrdGrp.FieldValues['GRP_NT'];
          EdGrpNameE.Text := ADODSPrdGrp.FieldValues['GRP_NE'];
          StabrPrdGrp.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          EdGrpNameT.Text := '';
          EdGrpNameE.Text := '';
          numrec := 0;
          numallrec := ADODSPrdGrp.RecordCount;
        end;
      end;
  'U':begin
        EdGrpNameT.Enabled := False;
        EdGrpNameE.Enabled := False;
        itmdata[1] := Uppercase(Trim(EdPrdGrpId.Text));
        with ADOCmdPrdGrp do begin
          CommandText := 'SELECT * FROM PRODGROUP WHERE GRP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSPrdGrp.Recordset := Execute;
        end;
        ADODSPrdGrp.First;
        numrec := ADODSPrdGrp.RecNo;
        numallrec := ADODSPrdGrp.RecordCount;
        if numallrec <> 0 then begin
          EdPrdGrpId.Text := ADODSPrdGrp.FieldValues['GRP_ID'];
          EdGrpNameT.Text := ADODSPrdGrp.FieldValues['GRP_NT'];
          EdGrpNameE.Text := ADODSPrdGrp.FieldValues['GRP_NE'];
          StabrPrdGrp.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrPrdGrp.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          EdGrpNameT.Text := '';
          EdGrpNameE.Text := '';
          numrec := 0;
          numallrec := ADODSPrdGrp.RecordCount;
        end;
      end;
  end;
end;

end.
