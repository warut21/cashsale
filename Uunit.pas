unit Uunit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons, ADODB, DB;
const status: array[0..6] of char = ('R', 'F', 'A', 'D', 'E', 'C', 'U');
  // R=Read,F=Find,A=Append,D=Delete,E=Edit,C=Commit,U=Update

type
  TFrmUnit = class(TForm)
    RdgrpStatus: TRadioGroup;
    RdbShow: TRadioButton;
    RdbInsert: TRadioButton;
    RdbDelete: TRadioButton;
    RdbUpdate: TRadioButton;
    EdUnitId: TEdit;
    LblUnitId: TLabel;
    LblUnitName: TLabel;
    EdUnitName: TEdit;
    ADODSUnit: TADODataSet;
    ADOCmdUnit: TADOCommand;
    BtbOk: TBitBtn;
    BtbCancel: TBitBtn;
    BtbExit: TBitBtn;
    BvCompany: TBevel;
    StabrUnit: TStatusBar;
    ADOCmdFG: TADOCommand;
    ADODSFG: TADODataSet;
    procedure FormCreate(Sender: TObject);
    procedure RdbInsertClick(Sender: TObject);
    procedure RdbDeleteClick(Sender: TObject);
    procedure RdbUpdateClick(Sender: TObject);
    procedure BtbOkClick(Sender: TObject);
    procedure BtbCancelClick(Sender: TObject);
    procedure RdbShowClick(Sender: TObject);
    procedure BtbExitClick(Sender: TObject);
    procedure EdUnitIdChange(Sender: TObject);
  private
    { Private declarations }
    numrec, numallrec: variant;
    old_id: string;
    chk: boolean;
    state: char;
    itmdata: array[1..2] of string;
  public
    { Public declarations }
  end;

var
  FrmUnit: TFrmUnit;


implementation

{$R *.dfm}

uses Udatamodule;

procedure TFrmUnit.FormCreate(Sender: TObject);
begin
  StabrUnit.Panels[0].Width := 15;
  StabrUnit.Panels[1].Width := 285;
  RdbShow.Checked := True;
end;

procedure TFrmUnit.RdbShowClick(Sender: TObject);
begin
  state := status[1];
  EdUnitId.Enabled := True;
  EdUnitName.Enabled := False;
  EdUnitId.Text := '';
  EdUnitName.Text := '';
  StabrUnit.Panels[1].Text := '';
  StabrUnit.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสหน่วยนับที่ต้องการจะค้นหา';
  BtbOk.Enabled := False;
  BtbCancel.Enabled := False;
end;

procedure TFrmUnit.RdbInsertClick(Sender: TObject);
begin
  state := status[2];
  EdUnitId.Text := '';
  EdUnitName.Text := '';
  EdUnitId.Enabled := True;
  EdUnitId.SetFocus;
  EdUnitName.Enabled := True;
  StabrUnit.Panels[1].Text := '';
  StabrUnit.Panels[2].Text := ' คำแนะนำ : เลื่อนโดยกด TAB แล้วเลือกปุ่ม OK เพื่อบันทึกข้อมูล';
  BtbOk.Enabled := True;
  BtbCancel.Enabled := True;
end;

procedure TFrmUnit.RdbDeleteClick(Sender: TObject);
begin
  state := status[3];
  EdUnitId.Text := '';
  EdUnitName.Text := '';
  EdUnitId.Enabled := True;
  EdUnitId.SetFocus;
  EdUnitName.Enabled := False;
  StabrUnit.Panels[1].Text := '';
  StabrUnit.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสหน่วยนับที่ต้องการจะลบ แล้วเลือกปุ่มOK';
  BtbOk.Enabled := True;
  BtbCancel.Enabled := True;
end;

procedure TFrmUnit.RdbUpdateClick(Sender: TObject);
begin
  state := status[4];
  EdUnitId.Text := '';
  EdUnitName.Text := '';
  EdUnitId.Enabled := True;
  EdUnitId.SetFocus;
  EdUnitName.Enabled := False;
  StabrUnit.Panels[1].Text := '';
  StabrUnit.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสหน่วยนับที่ต้องการจะแก้ไข แล้วเลือกปุ่ม OK';
  BtbOk.Enabled := True;
  BtbCancel.Enabled := True;
end;


procedure TFrmUnit.BtbOkClick(Sender: TObject);
var
  count: integer;
begin
  count := 0;
  case state of
    'F': begin
        itmdata[1] := Uppercase(Trim(EdUnitId.Text));
        with ADOCmdUnit do begin
          CommandText := 'SELECT * FROM UNITS WHERE UNITS_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSUnit.Recordset := Execute;
        end;
        ADODSUnit.First;
        numrec := ADODSUnit.RecNo;
        numallrec := ADODSUnit.RecordCount;
        if numallrec <> 0 then begin
          EdUnitId.Text := ADODSUnit.FieldValues['UNITS_ID'];
          EdUnitName.Text := ADODSUnit.FieldValues['UNITS_NAME'];
          StabrUnit.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ ' + InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrUnit.Panels[2].Text := '';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end
        else begin
          EdUnitId.Text := '';
          EdUnitName.Text := '';
          EdUnitId.SetFocus;
          numrec := 0;
          numallrec := ADODSUnit.RecordCount;
          StabrUnit.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการค้นหา';
          StabrUnit.Panels[2].Text := '';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end;
      end;
    'A': begin
        //Get data from input screen
        itmdata[1] := Uppercase(Trim(EdUnitId.Text));
        itmdata[2] := EdUnitName.Text;
        // Check primary key
        with ADOCmdUnit do begin
          CommandText := 'SELECT * FROM UNITS';
          CommandType := cmdText;
          ADODSUnit.Recordset := Execute;
        end;
        numallrec := ADODSUnit.RecordCount;
        with ADOCmdUnit do begin
          CommandText := 'SELECT * FROM UNITS WHERE UNITS_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSUnit.Recordset := Execute;
        end;
        chk := False;
        ADODSUnit.First;
        numrec := ADODSUnit.RecNo;

        for count := numrec to numallrec do
          if itmdata[1] = ADODSUnit.FieldValues['UNITS_ID'] then chk := True;
        ADODSUnit.Next;

        if chk = True then begin
          StabrUnit.Panels[1].Text := 'ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลรหัสกลุ่มสินค้าซ้ำ';
          StabrUnit.Panels[2].Text := ' คำแนะนำ : กรุณากดปุ่มCancel แล้วบันทึกข้อมูลใหม่อีกครั้ง';
        end
        else begin
          // Check not null
          if (itmdata[1] <> '') and (itmdata[2] <> '') then begin
            StabrUnit.Panels[1].Text := ' บันทึกข้อมูลเรียบร้อยแล้ว';
            StabrUnit.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้เลือกสถานะเป็นแสดงข้อมูล';
            with ADOCmdUnit do begin
              CommandText := 'INSERT INTO UNITS (UNITS_ID, UNITS_NAME)' +
                'VALUES (:newid, :newname)';
              CommandType := cmdText;
              Parameters.ParamByName('newid').Value := itmdata[1];
              Parameters.ParamByName('newname').Value := itmdata[2];
              Execute
            end;
            EdUnitId.Text := '';
            EdUnitName.Text := '';
            EdUnitId.SetFocus;
          end
          else begin
            ShowMessage('ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน'); // Plus2
            StabrUnit.Panels[1].Text := 'ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน';
            StabrUnit.Panels[2].Text := ' คำแนะนำ : กรุณากดปุ่มCancel แล้วบันทึกข้อมูลใหม่อีกครั้ง';
          end;
        end;
      end;
    'D': begin
        count := count + 1;
        itmdata[1] := Uppercase(Trim(EdUnitId.Text));
        with ADOCmdUnit do begin
          CommandText := 'SELECT * FROM UNITS WHERE UNITS_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSUnit.Recordset := Execute;
        end;
        ADODSUnit.First;
        numrec := ADODSUnit.RecNo;
        numallrec := ADODSUnit.RecordCount;
        if numallrec <> 0 then begin
          EdUnitId.Text := ADODSUnit.FieldValues['UNITS_ID'];
          EdUnitName.Text := ADODSUnit.FieldValues['UNITS_NAME'];
          StabrUnit.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ ' + InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrUnit.Panels[2].Text := ' คำแนะนำ : คุณแน่ใจที่จะลบข้อมูลหรือไม่ ถ้าใช่ให้กดปุ่ม OK อีกครั้งหนึ่ง';
          ShowMessage('คุณแน่ใจที่จะลบข้อมูลหรือไม่ ถ้าใช่ให้กดปุ่ม OK ที่หน้าจอ อีกครั้งหนึ่ง');
          if count > 0 then begin
            state := status[5];
          end;
        end
        else begin
          EdUnitId.Text := '';
          EdUnitName.Text := '';
          EdUnitId.SetFocus;
          numrec := 0;
          numallrec := ADODSUnit.RecordCount;
          StabrUnit.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการจะลบ';
          StabrUnit.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการป้อนข้อมูลใหม่อีกครั้งให้กดปุ่ม Cancel';
          state := status[3];
        end;
      end;
    'C': begin
        with ADOCmdFG do begin // Check delete foreign key reference from another table
          CommandText := 'SELECT * FROM FINISH_GOODS WHERE FG_UNITS = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSFG.Recordset := Execute;
        end;
        numrec := ADODSFG.RecordCount;
        if numrec > 0 then begin
          StabrUnit.Panels[1].Text := ' ไม่สามารถลบข้อมูลได้เนื่องจากมีการนำข้อมูลนี้ไปใช้งานแล้ว';
          StabrUnit.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการลบข้อมูลให้แจ้งผู้ดูแลฐานข้อมูล';
        end
        else begin
          with ADOCmdUnit do begin
            CommandText := 'DELETE * FROM UNITS WHERE UNITS_ID = :id';
            CommandType := cmdText;
            Parameters.ParamByName('id').Value := itmdata[1];
            Execute;
          end;
          EdUnitId.Text := '';
          EdUnitName.Text := '';
          StabrUnit.Panels[1].Text := ' ข้อมูลถูกลบออกจากฐานข้อมูลเรียบร้อยแล้ว';
          StabrUnit.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้เลือกสถานะเป็นแสดงข้อมูล';
          state := status[3];
        end;
      end;
    'E': begin
        EdUnitId.Enabled := False;
        count := count + 1;
        itmdata[1] := Uppercase(Trim(EdUnitId.Text));
        old_id := itmdata[1];
        with ADOCmdUnit do begin
          CommandText := 'SELECT * FROM UNITS WHERE UNITS_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSUnit.Recordset := Execute;
        end;
        ADODSUnit.First;
        numrec := ADODSUnit.RecNo;
        numallrec := ADODSUnit.RecordCount;
        EdUnitName.Enabled := True;
        if numallrec <> 0 then begin
          EdUnitId.Text := ADODSUnit.FieldValues['UNITS_ID'];
          EdUnitName.Text := ADODSUnit.FieldValues['UNITS_NAME'];
          StabrUnit.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ ' + InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrUnit.Panels[2].Text := ' คำแนะนำ : เมื่อแก้ไขข้อมูลเสร็จเรียบร้อยแล้วให้กดปุ่มOK ';
          if count > 0 then begin
            state := status[6];
          end;
        end
        else begin
          EdUnitId.Text := '';
          EdUnitName.Text := '';
          EdUnitId.Enabled := True;
          EdUnitId.SetFocus;
          numrec := 0;
          numallrec := ADODSUnit.RecordCount;
          StabrUnit.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการจะแก้ไข';
          StabrUnit.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการป้อนข้อมูลใหม่อีกครั้งให้กดปุ่ม Cancel';
          state := status[4];
        end;
      end;
    'U': begin
      //itmdata[1] := Uppercase(Trim(EdUnitId.Text));
        itmdata[2] := EdUnitName.Text;
        if (itmdata[1] <> '') and (itmdata[2] <> '') then begin
          with ADOCmdUnit do begin
            CommandText := 'UPDATE UNITS ' +
              'SET ' + //UNITS.UNITS_ID = :edid,'+
              'UNITS.UNITS_NAME = :edname ' +
              'WHERE (UNITS.UNITS_ID = :id) ';
            CommandType := cmdText;
            //Parameters.ParamByName('edid').Value := itmdata[1];
            Parameters.ParamByName('edname').Value := itmdata[2];
            Parameters.ParamByName('id').Value := old_id;
            Execute
          end;
          StabrUnit.Panels[1].Text := ' ข้อมูลถูกแก้ไขกับฐานข้อมูลเรียบร้อยแล้ว';
          StabrUnit.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้เลือกสถานะเป็นแสดงข้อมูล';
          EdUnitId.Text := '';
          EdUnitName.Text := '';
          EdUnitId.Enabled := True;
          EdUnitName.Enabled := False;
          EdUnitId.SetFocus;
          state := status[4];
        end
        else begin
          ShowMessage('ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน'); // Plus2
          StabrUnit.Panels[1].Text := 'ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน';
          StabrUnit.Panels[2].Text := ' คำแนะนำ : กรุณากดปุ่มCancel แล้วบันทึกข้อมูลใหม่อีกครั้ง';
          state := status[4];
        end;
      end;
  end;
end;

procedure TFrmUnit.BtbCancelClick(Sender: TObject);
begin
  EdUnitId.Enabled := True;
  case state of
    'F': begin
        EdUnitId.Text := '';
        EdUnitName.Text := '';
        EdUnitId.SetFocus;
        numrec := 0;
        numallrec := 0;
        StabrUnit.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ ' + InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
        StabrUnit.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้กดปุ่มแว่นขยาย';
      end;
    'A': begin
        EdUnitId.Text := '';
        EdUnitName.Text := '';
        EdUnitId.SetFocus;
        StabrUnit.Panels[1].Text := '';
        StabrUnit.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสหน่วยนับที่ต้องการจะค้นหา แล้วเลือกปุ่มOK';
      end;
    'D': begin
        EdUnitId.Text := '';
        EdUnitName.Text := '';
        EdUnitId.SetFocus;
        StabrUnit.Panels[1].Text := '';
        StabrUnit.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสหน่วยนับที่ต้องการจะลบใหม่อีกครั้ง';
      end;
    'C': begin
        state := status[3];
        EdUnitId.Text := '';
        EdUnitName.Text := '';
        EdUnitId.SetFocus;
        StabrUnit.Panels[1].Text := '';
        StabrUnit.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสหน่วยนับที่ต้องการจะลบใหม่อีกครั้ง';
      end;
    'E': begin
        EdUnitId.Text := '';
        EdUnitName.Text := '';
        EdUnitId.SetFocus;
        StabrUnit.Panels[1].Text := '';
        StabrUnit.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสหน่วยนับที่ต้องการจะแก้ไขใหม่อีกครั้ง';
      end;
    'U': begin
        state := status[4];
        EdUnitId.Text := '';
        EdUnitName.Text := '';
        EdUnitId.SetFocus;
        StabrUnit.Panels[1].Text := '';
        StabrUnit.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสหน่วยนับที่ต้องการจะแก้ไขใหม่อีกครั้ง';
      end;
  end;
end;


procedure TFrmUnit.BtbExitClick(Sender: TObject);
var reps: word;
begin
  reps := MessageDlg('คุณต้องการออกจากหน้าจอนี้ใช่หรือไม่', mtConfirmation, [mbYes, mbNo], 0);
  if reps = mrYes then close;
end;


procedure TFrmUnit.EdUnitIdChange(Sender: TObject);
begin
  case state of
    'F': begin
        itmdata[1] := Uppercase(Trim(EdUnitId.Text));
        with ADOCmdUnit do begin
          CommandText := 'SELECT * FROM UNITS WHERE UNITS_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSUnit.Recordset := Execute;
        end;
        ADODSUnit.First;
        numrec := ADODSUnit.RecNo;
        numallrec := ADODSUnit.RecordCount;
        if numallrec <> 0 then begin
          EdUnitId.Text := ADODSUnit.FieldValues['UNITS_ID'];
          EdUnitName.Text := ADODSUnit.FieldValues['UNITS_NAME'];
          StabrUnit.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ ' + InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrUnit.Panels[2].Text := ' ';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end
        else begin
          EdUnitName.Text := '';
          numrec := 0;
          numallrec := ADODSUnit.RecordCount;
          StabrUnit.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการค้นหา';
          StabrUnit.Panels[2].Text := ' คำแนะนำ : พิมพ์ข้อมูลยังไม่ถูกต้อง';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end;
      end;
    'A': begin
        itmdata[1] := Uppercase(Trim(EdUnitId.Text));
        with ADOCmdUnit do begin
          CommandText := 'SELECT * FROM UNITS WHERE UNITS_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSUnit.Recordset := Execute;
        end;
        ADODSUnit.First;
        numrec := ADODSUnit.RecNo;
        numallrec := ADODSUnit.RecordCount;
        if numallrec <> 0 then begin
          EdUnitId.Text := ADODSUnit.FieldValues['UNITS_ID'];
          EdUnitName.Text := ADODSUnit.FieldValues['UNITS_NAME'];
          StabrUnit.Panels[1].Text := ' มีข้อมูลอยู่ในฐานข้อมูลอยู่แล้ว';
          StabrUnit.Panels[2].Text := ' คำแนะนำ : กด Cancel เพื่อ Clear ข้อมูล';
          ShowMessage('มีข้อมูลอยู่ในฐานข้อมูลอยู่แล้ว    กรุณาพิมพ์รหัสหน่วยนับใหม่อีกครั้ง');
        end
        else begin
          EdUnitName.Text := '';
          numrec := 0;
          numallrec := ADODSUnit.RecordCount;
        end;
      end;
    'D': begin
        itmdata[1] := Uppercase(Trim(EdUnitId.Text));
        with ADOCmdUnit do begin
          CommandText := 'SELECT * FROM UNITS WHERE UNITS_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSUnit.Recordset := Execute;
        end;
        ADODSUnit.First;
        numrec := ADODSUnit.RecNo;
        numallrec := ADODSUnit.RecordCount;
        if numallrec <> 0 then begin
          EdUnitId.Text := ADODSUnit.FieldValues['UNITS_ID'];
          EdUnitName.Text := ADODSUnit.FieldValues['UNITS_NAME'];
          StabrUnit.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrUnit.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ ลบข้อมูล';
        end
        else begin
          EdUnitName.Text := '';
          numrec := 0;
          numallrec := ADODSUnit.RecordCount;
        end;
      end;
    'C': begin
        EdUnitName.Enabled := False;
        itmdata[1] := Uppercase(Trim(EdUnitId.Text));
        with ADOCmdUnit do begin
          CommandText := 'SELECT * FROM UNITS WHERE UNITS_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSUnit.Recordset := Execute;
        end;
        ADODSUnit.First;
        numrec := ADODSUnit.RecNo;
        numallrec := ADODSUnit.RecordCount;
        if numallrec <> 0 then begin
          EdUnitId.Text := ADODSUnit.FieldValues['UNITS_ID'];
          EdUnitName.Text := ADODSUnit.FieldValues['UNITS_NAME'];
          StabrUnit.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrUnit.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          EdUnitName.Text := '';
          numrec := 0;
          numallrec := ADODSUnit.RecordCount;
        end;
      end;
    'E': begin
        EdUnitName.Enabled := False;
        itmdata[1] := Uppercase(Trim(EdUnitId.Text));
        with ADOCmdUnit do begin
          CommandText := 'SELECT * FROM UNITS WHERE UNITS_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSUnit.Recordset := Execute;
        end;
        ADODSUnit.First;
        numrec := ADODSUnit.RecNo;
        numallrec := ADODSUnit.RecordCount;
        if numallrec <> 0 then begin
          EdUnitId.Text := ADODSUnit.FieldValues['UNITS_ID'];
          EdUnitName.Text := ADODSUnit.FieldValues['UNITS_NAME'];
          StabrUnit.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrUnit.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          EdUnitName.Text := '';
          numrec := 0;
          numallrec := ADODSUnit.RecordCount;
        end;
      end;
    'U': begin
        EdUnitName.Enabled := False;
        itmdata[1] := Uppercase(Trim(EdUnitId.Text));
        with ADOCmdUnit do begin
          CommandText := 'SELECT * FROM UNITS WHERE UNITS_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSUnit.Recordset := Execute;
        end;
        ADODSUnit.First;
        numrec := ADODSUnit.RecNo;
        numallrec := ADODSUnit.RecordCount;
        if numallrec <> 0 then begin
          EdUnitId.Text := ADODSUnit.FieldValues['UNITS_ID'];
          EdUnitName.Text := ADODSUnit.FieldValues['UNITS_NAME'];
          StabrUnit.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrUnit.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          EdUnitName.Text := '';
          numrec := 0;
          numallrec := ADODSUnit.RecordCount;
        end;
      end;

  end;
end;

end.
