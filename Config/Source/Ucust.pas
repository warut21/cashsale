unit Ucust;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, ComCtrls, StdCtrls, Buttons, ExtCtrls;
  const status: array[0..6] of char = ('R','F','A','D','E','C','U');
  // R=Read,F=Find,A=Append,D=Delete,E=Edit,C=Commit,U=Update

type
  TFrmCust = class(TForm)
    BvCompany: TBevel;
    LblCustId: TLabel;
    LblCustName: TLabel;
    RdgrpStatus: TRadioGroup;
    RdbShow: TRadioButton;
    RdbInsert: TRadioButton;
    RdbDelete: TRadioButton;
    RdbUpdate: TRadioButton;
    EdCustId: TEdit;
    EdCustName: TEdit;
    BtbOk: TBitBtn;
    BtbCancel: TBitBtn;
    BtbExit: TBitBtn;
    StabrCust: TStatusBar;
    ADODSCust: TADODataSet;
    ADOCmdCust: TADOCommand;
    ADOCmdBillH: TADOCommand;
    ADODSBillH: TADODataSet;
    procedure FormCreate(Sender: TObject);
    procedure RdbShowClick(Sender: TObject);
    procedure RdbInsertClick(Sender: TObject);
    procedure RdbDeleteClick(Sender: TObject);
    procedure RdbUpdateClick(Sender: TObject);
    procedure BtbOkClick(Sender: TObject);
    procedure BtbCancelClick(Sender: TObject);
    procedure BtbExitClick(Sender: TObject);
    procedure EdCustIdChange(Sender: TObject);
  private
    { Private declarations }
    numrec,numallrec : variant;
    old_id : string;
    chk : boolean;
    state : char;
    itmdata: array[1..2] of string;
  public
    { Public declarations }
  end;

var
  FrmCust: TFrmCust;

implementation

{$R *.dfm}

uses Udatamodule;

procedure TFrmCust.FormCreate(Sender: TObject);
begin
  StabrCust.Panels[0].Width := 15 ;
  StabrCust.Panels[1].Width := 285 ;
  RdbShow.Checked := True;
end;

procedure TFrmCust.RdbShowClick(Sender: TObject);
begin
  state := status[1];
  EdCustId.Enabled := True;
  EdCustName.Enabled := False;
  EdCustId.Text := '';
  EdCustName.Text := '';
  StabrCust.Panels[1].Text := ' ';
  StabrCust.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสหน่วยนับที่ต้องการจะค้นหา';
  BtbOk.Enabled := False;
  BtbCancel.Enabled := False;
end;

procedure TFrmCust.RdbInsertClick(Sender: TObject);
begin
  state := status[2];
  EdCustId.Text := '';
  EdCustName.Text := '';
  EdCustId.Enabled := True;
  EdCustId.SetFocus;
  EdCustName.Enabled := True;
  StabrCust.Panels[1].Text := '';
  StabrCust.Panels[2].Text := ' คำแนะนำ : เลื่อนโดยกด TAB แล้วเลือกปุ่ม OK เพื่อบันทึกข้อมูล';
  BtbOk.Enabled := True;
  BtbCancel.Enabled := True;
end;

procedure TFrmCust.RdbDeleteClick(Sender: TObject);
begin
  state := status[3];
  EdCustId.Text := '';
  EdCustName.Text := '';
  EdCustId.Enabled := True;
  EdCustId.SetFocus;
  EdCustName.Enabled := False;
  StabrCust.Panels[1].Text := '';
  StabrCust.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสลูกค้าที่ต้องการจะลบ แล้วเลือกปุ่มOK';
  BtbOk.Enabled := True;
  BtbCancel.Enabled := True;
end;

procedure TFrmCust.RdbUpdateClick(Sender: TObject);
begin
  state := status[4];
  EdCustId.Text := '';
  EdCustName.Text := '';
  EdCustId.Enabled := True;
  EdCustId.SetFocus;
  EdCustName.Enabled := False;
  StabrCust.Panels[1].Text := '';
  StabrCust.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสลูกค้าที่ต้องการจะแก้ไข แล้วเลือกปุ่ม OK';
  BtbOk.Enabled := True;
  BtbCancel.Enabled := True;
end;

procedure TFrmCust.BtbOkClick(Sender: TObject);
var
  count : integer;
begin
  count := 0;
  case state of
  'F':begin
        itmdata[1] := Uppercase(Trim(EdCustId.Text));
        with ADOCmdCust do begin
          CommandText := 'SELECT * FROM CUSTOMER WHERE CUST_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSCust.Recordset := Execute;
        end;
        ADODSCust.First;
        numrec := ADODSCust.RecNo;
        numallrec := ADODSCust.RecordCount;
        if numallrec <> 0 then begin
          EdCustId.Text := ADODSCust.FieldValues['CUST_ID'];
          EdCustName.Text := ADODSCust.FieldValues['CUST_NAME'];
          StabrCust.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ '+ InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrCust.Panels[2].Text := ' ';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end
        else begin
          EdCustId.Text := '';
          EdCustName.Text := '';
          EdCustId.SetFocus;
          numrec := 0;
          numallrec := ADODSCust.RecordCount;
          StabrCust.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการค้นหา';
          StabrCust.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้กดปุ่มแว่นขยาย';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end;
      end;
  'A':begin
        //Get data from input screen
        itmdata[1] := Uppercase(Trim(EdCustId.Text));
        itmdata[2] := EdCustName.Text;
        // Check primary key
        with ADOCmdCust do begin
          CommandText := 'SELECT * FROM CUSTOMER';
          CommandType := cmdText;
          ADODSCust.Recordset := Execute;
        end;
        numallrec := ADODSCust.RecordCount;
        with ADOCmdCust do begin
          CommandText := 'SELECT * FROM CUSTOMER WHERE CUST_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSCust.Recordset := Execute;
        end;
        chk := False;
        ADODSCust.First;
        numrec := ADODSCust.RecNo;

        for count := numrec to numallrec do
          if itmdata[1] = ADODSCust.FieldValues['CUST_ID'] then chk := True;
          ADODSCust.Next;

        if chk = True then begin
          StabrCust.Panels[1].Text := 'ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลรหัสกลุ่มสินค้าซ้ำ';
          StabrCust.Panels[2].Text := ' คำแนะนำ : กรุณากดปุ่มCancel แล้วบันทึกข้อมูลใหม่อีกครั้ง';
        end
        else begin
        // Check not null
          if (itmdata[1] <> '')and (itmdata[2] <> '') then begin
            StabrCust.Panels[1].Text := ' บันทึกข้อมูลเรียบร้อยแล้ว';
            StabrCust.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้เลือกสถานะเป็นแสดงข้อมูล';
            with ADOCmdCust do begin
              CommandText := 'INSERT INTO CUSTOMER (CUST_ID, CUST_NAME)'+
              'VALUES (:newid, :newname)';
              CommandType := cmdText;
              Parameters.ParamByName('newid').Value := itmdata[1];
              Parameters.ParamByName('newname').Value := itmdata[2];
              Execute
            end;
            EdCustId.Text := '';     // Plus
            EdCustName.Text := '';   // Plus
            EdcustId.SetFocus;       // Plus
          end
          else begin
            ShowMessage ('ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน'); // Plus2
            StabrCust.Panels[1].Text := 'ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน';
            StabrCust.Panels[2].Text := ' คำแนะนำ : กรุณากดปุ่มCancel แล้วบันทึกข้อมูลใหม่อีกครั้ง';
          end;
        end;
      end;
  'D':begin
        count := count + 1 ;
        itmdata[1] := Uppercase(Trim(EdCustId.Text));
        with ADOCmdCust do begin
          CommandText := 'SELECT * FROM CUSTOMER WHERE CUST_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSCust.Recordset := Execute;
        end;
        ADODSCust.First;
        numrec := ADODSCust.RecNo;
        numallrec := ADODSCust.RecordCount;
        if numallrec <> 0 then begin
          EdCustId.Text := ADODSCust.FieldValues['CUST_ID'];
          EdCustName.Text := ADODSCust.FieldValues['CUST_NAME'];
          StabrCust.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ '+ InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrCust.Panels[2].Text := ' คำแนะนำ : คุณแน่ใจที่จะลบข้อมูลหรือไม่ ถ้าใช่ให้กดปุ่ม OK อีกครั้งหนึ่ง';
          ShowMessage ('คุณแน่ใจที่จะลบข้อมูลหรือไม่ ถ้าใช่ให้กดปุ่ม OK ที่หน้าจอ อีกครั้งหนึ่ง');
            if count > 0 then begin
              state := status[5];
            end;
        end
        else begin
          EdCustId.Text := '';
          EdCustName.Text := '';
          EdCustId.SetFocus;
          numrec := 0;
          numallrec := ADODSCust.RecordCount;
          StabrCust.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการจะลบ';
          StabrCust.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการป้อนข้อมูลใหม่อีกครั้งให้กดปุ่ม Cancel';
          state := status[3];
        end;
      end;
  'C':begin
        with ADOCmdBillH do begin // Check delete foreign key reference from another table
          CommandText := 'SELECT * FROM BILL_HEAD WHERE BILLH_CUST_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSBillH.Recordset := Execute;
        end;
        numrec := ADODSBillH.RecordCount;
        if numrec > 0 then begin
          StabrCust.Panels[1].Text := ' ไม่สามารถลบข้อมูลได้เนื่องจากมีการนำข้อมูลนี้ไปใช้งานแล้ว';
          StabrCust.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการลบข้อมูลให้แจ้งผู้ดูแลฐานข้อมูล';
        end
        else begin
          with ADOCmdCust do begin
            CommandText := 'DELETE * FROM CUSTOMER WHERE CUST_ID = :id';
            CommandType := cmdText;
            Parameters.ParamByName('id').Value := itmdata[1];
            Execute;
          end;
          EdCustId.Text := '';
          EdCustName.Text := '';
          StabrCust.Panels[1].Text := ' ข้อมูลถูกลบออกจากฐานข้อมูลเรียบร้อยแล้ว';
          StabrCust.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้เลือกสถานะเป็นแสดงข้อมูล';
          state := status[3];
        end;
      end;
  'E':begin
        EdCustId.Enabled := False;
        count := count + 1 ;
        itmdata[1] := Uppercase(Trim(EdCustId.Text));
        old_id := itmdata[1];
        with ADOCmdCust do begin
          CommandText := 'SELECT * FROM CUSTOMER WHERE CUST_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSCust.Recordset := Execute;
        end;
        ADODSCust.First;
        numrec := ADODSCust.RecNo;
        numallrec := ADODSCust.RecordCount;
        EdCustName.Enabled := True;
        if numallrec <> 0 then begin
          EdCustId.Text := ADODSCust.FieldValues['CUST_ID'];
          EdCustName.Text := ADODSCust.FieldValues['CUST_NAME'];
          StabrCust.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ '+ InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrCust.Panels[2].Text := ' คำแนะนำ : เมื่อแก้ไขข้อมูลเสร็จเรียบร้อยแล้วให้กดปุ่มOK ';
          if count > 0 then begin
            state := status[6];
          end;
        end
        else begin
          EdCustId.Text := '';
          EdCustName.Text:= '';
          EdCustId.Enabled := True;
          EdCustId.SetFocus;
          numrec := 0;
          numallrec := ADODSCust.RecordCount;
          StabrCust.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการจะแก้ไข';
          StabrCust.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการป้อนข้อมูลใหม่อีกครั้งให้กดปุ่ม Cancel';
          state := status[4];
        end;
      end;
  'U':begin
        //itmdata[1] := Uppercase(Trim(EdCustId.Text));
        itmdata[2] := EdCustName.Text;
        if (itmdata[1] <> '')and (itmdata[2] <> '') then begin
          with ADOCmdCust do begin
          CommandText := 'UPDATE CUSTOMER '+
                         'SET '+// CUSTOMER.CUST_ID = :edid,'+
                         'CUSTOMER.CUST_NAME = :edname '+
                         'WHERE (CUSTOMER.CUST_ID = :id) ';
          CommandType := cmdText;
          //Parameters.ParamByName('edid').Value := itmdata[1];
          Parameters.ParamByName('edname').Value := itmdata[2];
          Parameters.ParamByName('id').Value := old_id;
          Execute
          end;
        StabrCust.Panels[1].Text := ' ข้อมูลถูกแก้ไขกับฐานข้อมูลเรียบร้อยแล้ว';
        StabrCust.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้เลือกสถานะเป็นแสดงข้อมูล';
        EdCustId.Text := '';     // Plus
        EdcustName.Text := '';   // Plus
        EdCustId.Enabled := True;   // Plus
        EdCustName.Enabled := False;  // Plus
        EdCustId.SetFocus;  // Plus
        state := status[4];
        end
        else begin
          ShowMessage ('ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน'); // Plus2
          StabrCust.Panels[1].Text := 'ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน';
          StabrCust.Panels[2].Text := ' คำแนะนำ : กรุณากดปุ่มCancel แล้วบันทึกข้อมูลใหม่อีกครั้ง';
          state := status[4];
        end;
      end;
  end;
end;


procedure TFrmCust.BtbCancelClick(Sender: TObject);
begin
  EdCustId.Enabled := True;
  case state of
  'F':begin
        EdCustId.Text := '';
        EdCustName.Text := '';
        EdCustId.SetFocus;
        numrec := 0;
        numallrec := 0;
        StabrCust.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ '+ InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
        StabrCust.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้กดปุ่มแว่นขยาย';
      end;
  'A':begin
        EdCustId.Text := '';
        EdCustName.Text := '';
        EdCustId.SetFocus;
        StabrCust.Panels[1].Text := '';
        StabrCust.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสลูกค้าที่ต้องการจะค้นหา แล้วเลือกปุ่มOK';
      end;
  'D':begin
        EdCustId.Text := '';
        EdCustName.Text := '';
        EdCustId.SetFocus;
        StabrCust.Panels[1].Text := '';
        StabrCust.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสลูกค้าที่ต้องการจะลบใหม่อีกครั้ง';
      end;
  'C':begin
        state := status[3]; //Plus
        EdCustId.Text := '';
        EdCustName.Text := '';
        EdCustId.SetFocus;
        StabrCust.Panels[1].Text := '';
        StabrCust.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสลูกค้าที่ต้องการจะลบใหม่อีกครั้ง';
      end;
  'E':begin
        EdCustId.Text := '';
        EdCustName.Text := '';
        EdCustId.SetFocus;
        StabrCust.Panels[1].Text := '';
        StabrCust.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสลูกค้าที่ต้องการจะแก้ไขใหม่อีกครั้ง';
      end;
  'U':begin
        state := status[4]; //Plus
        EdCustId.Text := '';
        EdCustName.Text := '';
        EdCustId.SetFocus;
        StabrCust.Panels[1].Text := '';
        StabrCust.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสลูกค้าที่ต้องการจะแก้ไขใหม่อีกครั้ง';
      end;
  end;
end;



procedure TFrmCust.BtbExitClick(Sender: TObject);
var reps : word;
begin
  reps := MessageDlg('คุณต้องการออกจากหน้าจอนี้ใช่หรือไม่', mtConfirmation, [mbYes, mbNo], 0);
  if reps = mrYes then close;
end;


procedure TFrmCust.EdCustIdChange(Sender: TObject);
begin
  case state of
  'F':begin
        itmdata[1] := Uppercase(Trim(EdCustId.Text));
        with ADOCmdCust do begin
          CommandText := 'SELECT * FROM CUSTOMER WHERE CUST_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSCust.Recordset := Execute;
        end;
        ADODSCust.First;
        numrec := ADODSCust.RecNo;
        numallrec := ADODSCust.RecordCount;
        if numallrec <> 0 then begin
          EdCustId.Text := ADODSCust.FieldValues['CUST_ID'];
          EdCustName.Text := ADODSCust.FieldValues['CUST_NAME'];
          StabrCust.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ '+ InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrCust.Panels[2].Text := '';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end
        else begin
          EdCustName.Text := '';
//          EdCustId.SetFocus;
          numrec := 0;
          numallrec := ADODSCust.RecordCount;
          StabrCust.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการค้นหา';
          StabrCust.Panels[2].Text := '';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end;
      end;
  'A':begin
        itmdata[1] := Uppercase(Trim(EdCustId.Text));
        with ADOCmdCust do begin
          CommandText := 'SELECT * FROM CUSTOMER WHERE CUST_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSCust.Recordset := Execute;
        end;
        ADODSCust.First;
        numrec := ADODSCust.RecNo;
        numallrec := ADODSCust.RecordCount;
        if numallrec <> 0 then begin
          EdCustId.Text := ADODSCust.FieldValues['CUST_ID'];
          EdCustName.Text := ADODSCust.FieldValues['CUST_NAME'];
          StabrCust.Panels[1].Text := ' มีข้อมูลอยู่ในฐานข้อมูลอยู่แล้ว';
          StabrCust.Panels[2].Text := ' คำแนะนำ : กด Cancel เพื่อ Clear ข้อมูล';
          ShowMessage ('มีข้อมูลอยู่ในฐานข้อมูลอยู่แล้ว    กรุณาพิมพ์รหัสลูกค้าใหม่อีกครั้ง');
        end
        else begin
          EdCustName.Text := '';
          numrec := 0;
          numallrec := ADODSCust.RecordCount;
        end;
      end;
  'D':begin
        itmdata[1] := Uppercase(Trim(EdCustId.Text));
        with ADOCmdCust do begin
          CommandText := 'SELECT * FROM CUSTOMER WHERE CUST_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSCust.Recordset := Execute;
        end;
        ADODSCust.First;
        numrec := ADODSCust.RecNo;
        numallrec := ADODSCust.RecordCount;
        if numallrec <> 0 then begin
          EdCustId.Text := ADODSCust.FieldValues['CUST_ID'];
          EdCustName.Text := ADODSCust.FieldValues['CUST_NAME'];
          StabrCust.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrCust.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ ลบข้อมูล';
        end
        else begin
          EdCustName.Text := '';
          numrec := 0;
          numallrec := ADODSCust.RecordCount;
        end;
      end;
  'C':begin
        EdCustName.Enabled := False;
        itmdata[1] := Uppercase(Trim(EdCustId.Text));
        with ADOCmdCust do begin
          CommandText := 'SELECT * FROM CUSTOMER WHERE CUST_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSCust.Recordset := Execute;
        end;
        ADODSCust.First;
        numrec := ADODSCust.RecNo;
        numallrec := ADODSCust.RecordCount;
        if numallrec <> 0 then begin
          EdCustId.Text := ADODSCust.FieldValues['CUST_ID'];
          EdCustName.Text := ADODSCust.FieldValues['CUST_NAME'];
          StabrCust.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrCust.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          EdCustName.Text := '';
          numrec := 0;
          numallrec := ADODSCust.RecordCount;
        end;
      end;
  'E':begin
        EdCustName.Enabled := False;
        itmdata[1] := Uppercase(Trim(EdCustId.Text));
        with ADOCmdCust do begin
          CommandText := 'SELECT * FROM CUSTOMER WHERE CUST_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSCust.Recordset := Execute;
        end;
        ADODSCust.First;
        numrec := ADODSCust.RecNo;
        numallrec := ADODSCust.RecordCount;
        if numallrec <> 0 then begin
          EdCustId.Text := ADODSCust.FieldValues['CUST_ID'];
          EdCustName.Text := ADODSCust.FieldValues['CUST_NAME'];
          StabrCust.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrCust.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          EdCustName.Text:= '';
          numrec := 0;
          numallrec := ADODSCust.RecordCount;
        end;
      end;
  'U':begin
        EdCustId.Enabled := False;
        itmdata[1] := Uppercase(Trim(EdCustId.Text));
        with ADOCmdCust do begin
          CommandText := 'SELECT * FROM CUSTOMER WHERE CUST_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSCust.Recordset := Execute;
        end;
        ADODSCust.First;
        numrec := ADODSCust.RecNo;
        numallrec := ADODSCust.RecordCount;
        if numallrec <> 0 then begin
          EdCustId.Text := ADODSCust.FieldValues['CUST_ID'];
          EdCustName.Text := ADODSCust.FieldValues['CUST_NAME'];
          StabrCust.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrCust.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          EdCustName.Text:= '';
          numrec := 0;
          numallrec := ADODSCust.RecordCount;
        end;
      end;




  end;
end;

end.
