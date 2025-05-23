unit Usalesman;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ADODB, DB, ComCtrls, ExtCtrls, Buttons, Mask, DBCtrls;
const status: array[0..6] of char = ('R', 'F', 'A', 'D', 'E', 'C', 'U');
  // R=Read,F=Find,A=Append,D=Delete,E=Edit,C=Commit,U=Update
type
  TFrmSalesman = class(TForm)
    BvCompany: TBevel;
    LblComId: TLabel;
    LblSalesId: TLabel;
    LblSalesPass: TLabel;
    LblSalesName: TLabel;
    LblRole: TLabel;
    LblRegDate: TLabel;
    LblExpDate: TLabel;
    EdSalesId: TEdit;
    EdSalesPass: TEdit;
    EdSalesName: TEdit;
    EdRegDate: TEdit;
    EdExpDate: TEdit;
    BtbOk: TBitBtn;
    BtbCancel: TBitBtn;
    BtbExit: TBitBtn;
    RdgrpStatus: TRadioGroup;
    RdbShow: TRadioButton;
    RdbInsert: TRadioButton;
    RdbDelete: TRadioButton;
    RdbUpdate: TRadioButton;
    StabrSalesman: TStatusBar;
    ADODSSalesman: TADODataSet;
    ADOCmdSalesman: TADOCommand;
    CbComId: TComboBox;
    SBRegDate: TSpeedButton;
    SBExpDate: TSpeedButton;
    CbRole: TComboBox;
    ADOCmdCompany: TADOCommand;
    ADODSCompany: TADODataSet;
    ADODSBillHcid: TADODataSet;
    ADOCmdBillHcid: TADOCommand;
    ADOCmdBillHsid: TADOCommand;
    ADODSBillHsid: TADODataSet;
    procedure FormCreate(Sender: TObject);
    procedure RdbShowClick(Sender: TObject);
    procedure RdbInsertClick(Sender: TObject);
    procedure RdbDeleteClick(Sender: TObject);
    procedure RdbUpdateClick(Sender: TObject);
    procedure BtbOkClick(Sender: TObject);
    procedure BtbCancelClick(Sender: TObject);
    procedure SBRegDateClick(Sender: TObject);
    procedure SBExpDateClick(Sender: TObject);
    procedure CbComIdDropDown(Sender: TObject);
    procedure BtbExitClick(Sender: TObject);
    procedure CbComIdChange(Sender: TObject);
    procedure EdSalesIdChange(Sender: TObject);

  private
    { Private declarations }
    numrec, numallrec, numrec2: variant;
    load_id, old_cid, old_sid: string;
    chk: boolean;
    state: char;
    itmdata: array[1..7] of string;
  public
    { Public declarations }
  end;

var
  FrmSalesman: TFrmSalesman;

implementation

{$R *.dfm}

uses Udatamodule, PickDate;


procedure TFrmSalesman.FormCreate(Sender: TObject);
begin
  StabrSalesman.Panels[0].Width := 15;
  StabrSalesman.Panels[1].Width := 285;
  RdbShow.Checked := True;
end;

procedure TFrmSalesman.RdbShowClick(Sender: TObject);
begin
  state := status[1];
  CbComId.Enabled := True;
  EdSalesId.Enabled := True;
  EdSalesPass.Enabled := False;
  EdSalesName.Enabled := False;
  CbRole.Enabled := False;
  EdRegDate.Enabled := False;
  EdExpDate.Enabled := False;
  CbComId.Text := '';
  EdSalesId.Text := '';
  EdSalesPass.Text := '';
  EdSalesName.Text := '';
  CbRole.Text := '';
  EdRegDate.Text := '';
  EdExpDate.Text := '';
  StabrSalesman.Panels[1].Text := ' ';
  StabrSalesman.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสหน่วยนับที่ต้องการจะค้นหา';
  BtbOk.Enabled := False;
  BtbCancel.Enabled := False;
  SBRegDate.Enabled := False;
  SBExpDate.Enabled := False;
end;

procedure TFrmSalesman.RdbInsertClick(Sender: TObject);
begin
  state := status[2];
  CbComId.Text := '';
  EdSalesId.Text := '';
  EdSalesPass.Text := '';
  EdSalesName.Text := '';
  CbRole.Text := '';
  EdRegDate.Text := '';
  EdExpDate.Text := '';
  CbComId.Enabled := True;
  EdSalesId.Enabled := True;
  CbComId.SetFocus;
  EdSalesPass.Enabled := True;
  EdSalesName.Enabled := True;
  CbRole.Enabled := True;
  EdRegDate.Enabled := True;
  EdExpDate.Enabled := True;
  StabrSalesman.Panels[1].Text := '';
  StabrSalesman.Panels[2].Text := ' คำแนะนำ : เลื่อนโดยกด TAB แล้วเลือกปุ่ม OK เพื่อบันทึกข้อมูล';
  BtbOk.Enabled := True;
  BtbCancel.Enabled := True;
  SBRegDate.Enabled := True;
  SBExpDate.Enabled := True;
end;

procedure TFrmSalesman.RdbDeleteClick(Sender: TObject);
begin
  state := status[3];
  CbComId.Text := '';
  EdSalesId.Text := '';
  EdSalesPass.Text := '';
  EdSalesName.Text := '';
  CbRole.Text := '';
  EdRegDate.Text := '';
  EdExpDate.Text := '';
  CbComId.Enabled := True;
  EdSalesId.Enabled := True;
  CbComId.SetFocus;
  EdSalesPass.Enabled := False;
  EdSalesName.Enabled := False;
  CbRole.Enabled := False;
  EdRegDate.Enabled := False;
  EdExpDate.Enabled := False;
  StabrSalesman.Panels[1].Text := '';
  StabrSalesman.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสบริษัทและพนักงานที่ต้องการจะลบ แล้วเลือกปุ่มOK';
  BtbOk.Enabled := True;
  BtbCancel.Enabled := True;
  SBRegDate.Enabled := False;
  SBExpDate.Enabled := False;
end;

procedure TFrmSalesman.RdbUpdateClick(Sender: TObject);
begin
  state := status[4];
  CbComId.Text := '';
  EdSalesId.Text := '';
  EdSalesPass.Text := '';
  EdSalesName.Text := '';
  CbRole.Text := '';
  EdRegDate.Text := '';
  EdExpDate.Text := '';
  CbComId.Enabled := True;
  EdSalesId.Enabled := True;
  CbComId.SetFocus;
  EdSalesPass.Enabled := False;
  EdSalesName.Enabled := False;
  CbRole.Enabled := False;
  EdRegDate.Enabled := False;
  EdExpDate.Enabled := False;
  StabrSalesman.Panels[1].Text := '';
  StabrSalesman.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสบริษัทและพนักงานที่ต้องการจะแก้ไข แล้วเลือกปุ่ม OK';
  BtbOk.Enabled := True;
  BtbCancel.Enabled := True;
  SBRegDate.Enabled := True;
  SBExpDate.Enabled := True;
end;

procedure TFrmSalesman.BtbOkClick(Sender: TObject);
var
  count: integer;
begin
  count := 0;
  case state of
    'F': begin
        itmdata[1] := Uppercase(Trim(CbComId.Text));
        itmdata[2] := Uppercase(Trim(EdSalesId.Text));
        with ADOCmdSalesman do begin
          CommandText := 'SELECT * FROM SALESMAN ' +
            'WHERE COMP_ID = :cid ' +
            'AND SALES_ID = :sid ';
          CommandType := cmdText;
          Parameters.ParamByName('cid').Value := itmdata[1];
          Parameters.ParamByName('sid').Value := itmdata[2];
          ADODSSalesman.Recordset := Execute;
        end;
        ADODSSalesman.First;
        numrec := ADODSSalesman.RecNo;
        numallrec := ADODSSalesman.RecordCount;
        if numallrec <> 0 then begin
          CbComId.Text := ADODSSalesman.FieldValues['COMP_ID'];
          EdSalesId.Text := ADODSSalesman.FieldValues['SALES_ID'];
          EdSalesPass.Text := ADODSSalesman.FieldValues['SALES_PASS'];
          EdSalesName.Text := ADODSSalesman.FieldValues['SALES_NAME'];
          CbRole.Text := ADODSSalesman.FieldValues['ROLE'];
          EdRegDate.Text := ADODSSalesman.FieldValues['REG_DATE'];
          EdExpDate.Text := ADODSSalesman.FieldValues['EXP_DATE'];
          StabrSalesman.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ ' + InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrSalesman.Panels[2].Text := '';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end
        else begin
          CbComId.Text := '';
          EdSalesId.Text := '';
          EdSalesPass.Text := '';
          EdSalesName.Text := '';
          CbRole.Text := '';
          EdRegDate.Text := '';
          EdExpDate.Text := '';
          CbComId.SetFocus;
          numrec := 0;
          numallrec := ADODSSalesman.RecordCount;
          StabrSalesman.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการค้นหา';
          StabrSalesman.Panels[2].Text := '';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end;
      end;
    'A': begin
        //Get data from input screen
        itmdata[1] := Uppercase(Trim(CbComId.Text));
        itmdata[2] := Uppercase(Trim(EdSalesId.Text));
        itmdata[3] := EdSalesPass.Text;
        itmdata[4] := EdSalesName.Text;
        itmdata[5] := Copy(CbRole.Text, 1, 1);
        itmdata[6] := EdRegDate.Text;
        itmdata[7] := EdExpDate.Text;
        // Check primary key
        with ADOCmdSalesman do begin
          CommandText := 'SELECT * FROM SALESMAN';
          CommandType := cmdText;
          ADODSSalesman.Recordset := Execute;
        end;
        numallrec := ADODSSalesman.RecordCount;
        with ADOCmdSalesman do begin
          CommandText := 'SELECT * FROM SALESMAN ' +
            'WHERE COMP_ID = :cid ' +
            'AND SALES_ID = :sid ';
          CommandType := cmdText;
          Parameters.ParamByName('cid').Value := itmdata[1];
          Parameters.ParamByName('sid').Value := itmdata[2];
          ADODSSalesman.Recordset := Execute;
        end;
        chk := False;
        ADODSSalesman.First;
        numrec := ADODSSalesman.RecNo;

        for count := numrec to numallrec do
          if (itmdata[1] = ADODSSalesman.FieldValues['COMP_ID']) and (itmdata[2] = ADODSSalesman.FieldValues['SALES_ID']) then chk := True;
        ADODSSalesman.Next;

        if chk = True then begin
          StabrSalesman.Panels[1].Text := 'ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลรหัสบริษัทซ้ำ';
          StabrSalesman.Panels[2].Text := ' คำแนะนำ : กรุณากดปุ่มCancel แล้วบันทึกข้อมูลใหม่อีกครั้ง';
        end
        else begin
          // Check not null
          if (itmdata[1] <> '') and (itmdata[2] <> '') and (itmdata[3] <> '') and (itmdata[4] <> '') and (itmdata[5] <> '') and (itmdata[6] <> '') and (itmdata[7] <> '') then begin
            StabrSalesman.Panels[1].Text := ' บันทึกข้อมูลเรียบร้อยแล้ว';
            StabrSalesman.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้เลือกสถานะเป็นแสดงข้อมูล';
            with ADOCmdSalesman do begin
              CommandText := 'INSERT INTO SALESMAN (COMP_ID, SALES_ID, SALES_PASS, SALES_NAME, ROLE, REG_DATE, EXP_DATE)' +
                'VALUES (:cid , :sid , :spass , :sname , :role , :regdate , :expdate)';
              CommandType := cmdText;
              Parameters.ParamByName('cid').Value := itmdata[1];
              Parameters.ParamByName('sid').Value := itmdata[2];
              Parameters.ParamByName('spass').Value := itmdata[3];
              Parameters.ParamByName('sname').Value := itmdata[4];
              Parameters.ParamByName('role').Value := itmdata[5];
              Parameters.ParamByName('regdate').Value := itmdata[6];
              Parameters.ParamByName('expdate').Value := itmdata[7];
              Execute
            end;
            CbComId.Text := '';
            EdSalesId.Text := '';
            EdSalesPass.Text := '';
            EdSalesName.Text := '';
            CbRole.Text := '';
            EdRegDate.Text := '';
            EdExpDate.Text := '';
            CbComId.SetFocus;
          end
          else begin
            ShowMessage('ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน'); // Plus2
            StabrSalesman.Panels[1].Text := 'ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน';
            StabrSalesman.Panels[2].Text := ' คำแนะนำ : กรุณากดปุ่มCancel แล้วบันทึกข้อมูลใหม่อีกครั้ง';
          end;
        end;
      end;
    'D': begin
        count := count + 1;
        itmdata[1] := Uppercase(Trim(CbComId.Text));
        itmdata[2] := Uppercase(Trim(EdSalesId.Text));
        with ADOCmdSalesman do begin
          CommandText := 'SELECT * FROM SALESMAN ' +
            'WHERE COMP_ID = :cid ' +
            'AND SALES_ID = :sid ';
          CommandType := cmdText;
          Parameters.ParamByName('cid').Value := itmdata[1];
          Parameters.ParamByName('sid').Value := itmdata[2];
          ADODSSalesman.Recordset := Execute;
        end;
        ADODSSalesman.First;
        numrec := ADODSSalesman.RecNo;
        numallrec := ADODSSalesman.RecordCount;
        if numallrec <> 0 then begin
          CbComId.Text := ADODSSalesman.FieldValues['COMP_ID'];
          EdSalesId.Text := ADODSSalesman.FieldValues['SALES_ID'];
          EdSalesPass.Text := ADODSSalesman.FieldValues['SALES_PASS'];
          EdSalesName.Text := ADODSSalesman.FieldValues['SALES_NAME'];
          CbRole.Text := ADODSSalesman.FieldValues['ROLE'];
          EdRegDate.Text := ADODSSalesman.FieldValues['REG_DATE'];
          EdExpDate.Text := ADODSSalesman.FieldValues['EXP_DATE'];
          StabrSalesman.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ ' + InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrSalesman.Panels[2].Text := ' คำแนะนำ : คุณแน่ใจที่จะลบข้อมูลหรือไม่ ถ้าใช่ให้กดปุ่ม OK อีกครั้งหนึ่ง';
          ShowMessage('คุณแน่ใจที่จะลบข้อมูลหรือไม่ ถ้าใช่ให้กดปุ่ม OK ที่หน้าจอ อีกครั้งหนึ่ง');
          if count > 0 then begin
            state := status[5];
          end;
        end
        else begin
          CbComId.Text := '';
          EdSalesId.Text := '';
          EdSalesPass.Text := '';
          EdSalesName.Text := '';
          CbRole.Text := '';
          EdRegDate.Text := '';
          EdExpDate.Text := '';
          CbComId.SetFocus;
          numrec := 0;
          numallrec := ADODSSalesman.RecordCount;
          StabrSalesman.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการจะลบ';
          StabrSalesman.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการป้อนข้อมูลใหม่อีกครั้งให้กดปุ่ม Cancel';
          state := status[3];
        end;
      end;
    'C': begin
        with ADOCmdBillHcid do begin // Check delete foreign key reference from another table
          CommandText := 'SELECT * FROM BILL_HEAD WHERE BILLH_COMP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSBillHcid.Recordset := Execute;
        end;
        numrec := ADODSBillHcid.RecordCount;
        {if numrec > 0 then begin
          StabrSalesman.Panels[1].Text := ' ไม่สามารถลบข้อมูลได้เนื่องจากมีการนำข้อมูลนี้ไปใช้งานแล้ว';
          StabrSalesman.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการลบข้อมูลให้แจ้งผู้ดูแลฐานข้อมูล';
        end
        else begin
          numrec := 0;
          with ADOCmdBillHsid do begin // Check delete foreign key reference from another table
            CommandText := 'SELECT * FROM BILL_HEAD WHERE BILLH_SALES_ID = :id';
            CommandType := cmdText;
            Parameters.ParamByName('id').Value := itmdata[2];
            ADODSBillHsid.Recordset := Execute;
          end;
          numrec := ADODSBillHsid.RecordCount;}

        with ADOCmdBillHsid do begin // Check delete foreign key reference from another table
          CommandText := 'SELECT * FROM BILL_HEAD WHERE BILLH_SALES_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[2];
          ADODSBillHsid.Recordset := Execute;
        end;
        numrec2 := ADODSBillHsid.RecordCount;

        if (numrec > 0) and (numrec2 > 0) then begin
          StabrSalesman.Panels[1].Text := ' ไม่สามารถลบข้อมูลได้เนื่องจากมีการนำข้อมูลนี้ไปใช้งานแล้ว';
          StabrSalesman.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการลบข้อมูลให้แจ้งผู้ดูแลฐานข้อมูล';
        end
        else begin
          with ADOCmdSalesman do begin
            CommandText := 'DELETE * FROM SALESMAN ' +
              'WHERE COMP_ID = :cid ' +
              'AND SALES_ID = :sid ';
            CommandType := cmdText;
            Parameters.ParamByName('cid').Value := itmdata[1];
            Parameters.ParamByName('sid').Value := itmdata[2];
            Execute;
          end;
          CbComId.Text := '';
          EdSalesId.Text := '';
          EdSalesPass.Text := '';
          EdSalesName.Text := '';
          CbRole.Text := '';
          EdRegDate.Text := '';
          EdExpDate.Text := '';
          CbComId.SetFocus;
          StabrSalesman.Panels[1].Text := ' ข้อมูลถูกลบออกจากฐานข้อมูลเรียบร้อยแล้ว';
          StabrSalesman.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้เลือกสถานะเป็นแสดงข้อมูล';
          state := status[3];
        end;
        {end;}
      end;
    'E': begin
        CbComId.Enabled := False;
        EdSalesId.Enabled := False;
        count := count + 1;
        itmdata[1] := Uppercase(Trim(CbComId.Text));
        itmdata[2] := Uppercase(Trim(EdSalesId.Text));
        old_cid := itmdata[1];
        old_sid := itmdata[2];
        with ADOCmdSalesman do begin
          CommandText := 'SELECT * FROM SALESMAN ' +
            'WHERE COMP_ID = :cid ' +
            'AND SALES_ID = :sid ';
          CommandType := cmdText;
          Parameters.ParamByName('cid').Value := itmdata[1];
          Parameters.ParamByName('sid').Value := itmdata[2];
          ADODSSalesman.Recordset := Execute;
        end;
        ADODSSalesman.First;
        numrec := ADODSSalesman.RecNo;
        numallrec := ADODSSalesman.RecordCount;
          //CbComId.Enabled := False;
          //EdSalesId.Enabled := True;
        EdSalesPass.Enabled := True;
        EdSalesName.Enabled := True;
        CbRole.Enabled := True;
        EdRegDate.Enabled := True;
        EdExpDate.Enabled := True;
        if numallrec <> 0 then begin
          CbComId.Text := ADODSSalesman.FieldValues['COMP_ID'];
          EdSalesId.Text := ADODSSalesman.FieldValues['SALES_ID'];
          EdSalesPass.Text := ADODSSalesman.FieldValues['SALES_PASS'];
          EdSalesName.Text := ADODSSalesman.FieldValues['SALES_NAME'];
          CbRole.Text := ADODSSalesman.FieldValues['ROLE'];
          EdRegDate.Text := ADODSSalesman.FieldValues['REG_DATE'];
          EdExpDate.Text := ADODSSalesman.FieldValues['EXP_DATE'];
          StabrSalesman.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ ' + InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrSalesman.Panels[2].Text := ' คำแนะนำ : เมื่อแก้ไขข้อมูลเสร็จเรียบร้อยแล้วให้กดปุ่มOK ';
          if count > 0 then begin
            state := status[6];
          end;
        end
        else begin
          CbComId.Text := '';
          EdSalesId.Text := '';
          EdSalesPass.Text := '';
          EdSalesName.Text := '';
          CbRole.Text := '';
          EdRegDate.Text := '';
          EdExpDate.Text := '';
          CbComId.Enabled := True;
          EdSalesId.Enabled := True;
          CbComId.SetFocus;
          numrec := 0;
          numallrec := ADODSSalesman.RecordCount;
          StabrSalesman.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการจะแก้ไข';
          StabrSalesman.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการป้อนข้อมูลใหม่อีกครั้งให้กดปุ่ม Cancel';
          state := status[4];
        end;
      end;
    'U': begin
        //itmdata[1] := Uppercase(Trim(CbComId.Text));
        //itmdata[2] := Uppercase(Trim(EdSalesId.Text));
        itmdata[3] := EdSalesPass.Text;
        itmdata[4] := EdSalesName.Text;
        itmdata[5] := Copy(CbRole.Text, 1, 1);
        itmdata[6] := EdRegDate.Text;
        itmdata[7] := EdExpDate.Text;
        if (itmdata[1] <> '') and (itmdata[2] <> '') and (itmdata[3] <> '') and (itmdata[4] <> '') and (itmdata[5] <> '') and (itmdata[6] <> '') and (itmdata[7] <> '') then begin
          //ADODSCompany.Refresh;
          with ADOCmdSalesman do begin
            CommandText := 'UPDATE SALESMAN ' +
              'SET ' + //SALESMAN.COMP_ID = :sid,'+
                         //'SALESMAN.SALES_ID = :cid,'+
            'SALESMAN.SALES_PASS = :spass,' +
              'SALESMAN.SALES_NAME = :sname,' +
              'SALESMAN.ROLE = :role,' +
              'SALESMAN.REG_DATE = :regdate,' +
              'SALESMAN.EXP_DATE = :expdate ' +
              'WHERE (SALESMAN.COMP_ID = :id1)' +
              'AND (SALESMAN.SALES_ID = :id2)';
            CommandType := cmdText;
          //Parameters.ParamByName('sid').Value := itmdata[1];
          //Parameters.ParamByName('cid').Value := itmdata[2];
            Parameters.ParamByName('spass').Value := itmdata[3];
            Parameters.ParamByName('sname').Value := itmdata[4];
            Parameters.ParamByName('role').Value := itmdata[5];
            Parameters.ParamByName('regdate').Value := itmdata[6];
            Parameters.ParamByName('expdate').Value := itmdata[7];
            Parameters.ParamByName('id1').Value := old_cid;
            Parameters.ParamByName('id2').Value := old_sid;
            Execute
          end;
          StabrSalesman.Panels[1].Text := ' ข้อมูลถูกแก้ไขกับฐานข้อมูลเรียบร้อยแล้ว';
          StabrSalesman.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้เลือกสถานะเป็นแสดงข้อมูล';
          CbComId.Text := '';
          EdSalesId.Text := '';
          EdSalesPass.Text := '';
          EdSalesName.Text := '';
          CbRole.Text := '';
          EdRegDate.Text := '';
          EdExpDate.Text := '';
          CbComId.Enabled := True;
          EdSalesId.Enabled := True;
          EdSalesPass.Enabled := False;
          EdSalesName.Enabled := False;
          CbRole.Enabled := False;
          EdRegDate.Enabled := False;
          EdExpDate.Enabled := False;
          CbComId.SetFocus;
          state := status[4];
        end
        else begin
          ShowMessage('ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน'); // Plus2
          StabrSalesman.Panels[1].Text := 'ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน';
          StabrSalesman.Panels[2].Text := ' คำแนะนำ : กรุณากดปุ่มCancel แล้วบันทึกข้อมูลใหม่อีกครั้ง';
          state := status[4];
        end;
      end;
  end;
end;


procedure TFrmSalesman.BtbCancelClick(Sender: TObject);
begin
  CbComId.Enabled := True;
  EdSalesId.Enabled := True;
  case state of
    'F': begin
        CbComId.Text := '';
        EdSalesId.Text := '';
        EdSalesPass.Text := '';
        EdSalesName.Text := '';
        CbRole.Text := '';
        EdRegDate.Text := '';
        EdExpDate.Text := '';
        CbComId.SetFocus;
        numrec := 0;
        numallrec := 0;
        StabrSalesman.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ ' + InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
        StabrSalesman.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้กดปุ่มแว่นขยาย';
      end;
    'A': begin
        CbComId.Text := '';
        EdSalesId.Text := '';
        EdSalesPass.Text := '';
        EdSalesName.Text := '';
        CbRole.Text := '';
        EdRegDate.Text := '';
        EdExpDate.Text := '';
        CbComId.SetFocus;
        StabrSalesman.Panels[1].Text := '';
        StabrSalesman.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสพนักงานขายที่ต้องการจะค้นหา แล้วเลือกปุ่มOK';
      end;
    'D': begin
        CbComId.Text := '';
        EdSalesId.Text := '';
        EdSalesPass.Text := '';
        EdSalesName.Text := '';
        CbRole.Text := '';
        EdRegDate.Text := '';
        EdExpDate.Text := '';
        CbComId.SetFocus;
        StabrSalesman.Panels[1].Text := '';
        StabrSalesman.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสพนักงานขายที่ต้องการจะลบใหม่อีกครั้ง';
      end;
    'C': begin
        state := status[3]; //Plus
        CbComId.Text := '';
        EdSalesId.Text := '';
        EdSalesPass.Text := '';
        EdSalesName.Text := '';
        CbRole.Text := '';
        EdRegDate.Text := '';
        EdExpDate.Text := '';
        CbComId.SetFocus;
        StabrSalesman.Panels[1].Text := '';
        StabrSalesman.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสพนักงานขายที่ต้องการจะลบใหม่อีกครั้ง';
      end;
    'E': begin
        CbComId.Text := '';
        EdSalesId.Text := '';
        EdSalesPass.Text := '';
        EdSalesName.Text := '';
        CbRole.Text := '';
        EdRegDate.Text := '';
        EdExpDate.Text := '';
        CbComId.SetFocus;
        StabrSalesman.Panels[1].Text := '';
        StabrSalesman.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสพนักงานขายที่ต้องการจะแก้ไขใหม่อีกครั้ง';
      end;
    'U': begin
        state := status[4]; //Plus
        CbComId.Text := '';
        EdSalesId.Text := '';
        EdSalesPass.Text := '';
        EdSalesName.Text := '';
        CbRole.Text := '';
        EdRegDate.Text := '';
        EdExpDate.Text := '';
        CbComId.SetFocus;
        StabrSalesman.Panels[1].Text := '';
        StabrSalesman.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสพนักงานขายที่ต้องการจะแก้ไขใหม่อีกครั้ง';
      end;
  end;
end;

procedure TFrmSalesman.SBRegDateClick(Sender: TObject);
begin
  BrDateForm.Date := Now; { start with current date }
  if BrDateForm.ShowModal = mrOk then begin
    EdRegDate.text := FormatDatetime('DD/MM/YYYY', BrDateForm.Date);
  end;
end;

procedure TFrmSalesman.SBExpDateClick(Sender: TObject);
begin
  BrDateForm.Date := Now; { start with current date }
  if BrDateForm.ShowModal = mrOk then begin
    EdExpDate.text := FormatDatetime('DD/MM/YYYY', BrDateForm.Date);
  end;
end;

procedure TFrmSalesman.CbComIdDropDown(Sender: TObject);
var
  count: integer;
begin
//Load COMP_ID Data To Combo Box
  CbComId.Items.Clear;
  with ADODSCompany do begin
    CommandType := cmdText;
    CommandText := 'SELECT * FROM COMPANY';
    Open;
  end;
  ADODSCompany.First;
  numrec := ADODSCompany.RecNo;
  numallrec := ADODSCompany.RecordCount;

  for count := numrec to numallrec do begin
    load_id := ADODSCompany.FieldValues['COMP_ID'];
    CbComId.Items.Add(load_id);
    ADODSCompany.Next;
  end;
end;

procedure TFrmSalesman.BtbExitClick(Sender: TObject);
var reps: word;
begin
  reps := MessageDlg('คุณต้องการออกจากหน้าจอนี้ใช่หรือไม่', mtConfirmation, [mbYes, mbNo], 0);
  if reps = mrYes then close;
end;




procedure TFrmSalesman.CbComIdChange(Sender: TObject);
begin
  case state of
    'F': begin
        itmdata[1] := Uppercase(Trim(CbComId.Text));
        itmdata[2] := Uppercase(Trim(EdSalesId.Text));
        with ADOCmdSalesman do begin
          CommandText := 'SELECT * FROM SALESMAN ' +
            'WHERE COMP_ID = :cid ' +
            'AND SALES_ID = :sid ';
          CommandType := cmdText;
          Parameters.ParamByName('cid').Value := itmdata[1];
          Parameters.ParamByName('sid').Value := itmdata[2];
          ADODSSalesman.Recordset := Execute;
        end;
        ADODSSalesman.First;
        numrec := ADODSSalesman.RecNo;
        numallrec := ADODSSalesman.RecordCount;
        if numallrec <> 0 then begin
          CbComId.Text := ADODSSalesman.FieldValues['COMP_ID'];
          EdSalesId.Text := ADODSSalesman.FieldValues['SALES_ID'];
          EdSalesPass.Text := ADODSSalesman.FieldValues['SALES_PASS'];
          EdSalesName.Text := ADODSSalesman.FieldValues['SALES_NAME'];
          CbRole.Text := ADODSSalesman.FieldValues['ROLE'];
          EdRegDate.Text := ADODSSalesman.FieldValues['REG_DATE'];
          EdExpDate.Text := ADODSSalesman.FieldValues['EXP_DATE'];
          StabrSalesman.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ ' + InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrSalesman.Panels[2].Text := '';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end
        else begin
          EdSalesPass.Text := '';
          EdSalesName.Text := '';
          CbRole.Text := '';
          EdRegDate.Text := '';
          EdExpDate.Text := '';
          numrec := 0;
          numallrec := ADODSSalesman.RecordCount;
          StabrSalesman.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการค้นหา';
          StabrSalesman.Panels[2].Text := '';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end;
      end;
    'A': begin
        itmdata[1] := Uppercase(Trim(CbComId.Text));
        itmdata[2] := Uppercase(Trim(EdSalesId.Text));
        with ADOCmdSalesman do begin
          CommandText := 'SELECT * FROM SALESMAN ' +
            'WHERE COMP_ID = :cid ' +
            'AND SALES_ID = :sid ';
          CommandType := cmdText;
          Parameters.ParamByName('cid').Value := itmdata[1];
          Parameters.ParamByName('sid').Value := itmdata[2];
          ADODSSalesman.Recordset := Execute;
        end;
        ADODSSalesman.First;
        numrec := ADODSSalesman.RecNo;
        numallrec := ADODSSalesman.RecordCount;
        if numallrec <> 0 then begin
          CbComId.Text := ADODSSalesman.FieldValues['COMP_ID'];
          EdSalesId.Text := ADODSSalesman.FieldValues['SALES_ID'];
          EdSalesPass.Text := ADODSSalesman.FieldValues['SALES_PASS'];
          EdSalesName.Text := ADODSSalesman.FieldValues['SALES_NAME'];
          CbRole.Text := ADODSSalesman.FieldValues['ROLE'];
          EdRegDate.Text := ADODSSalesman.FieldValues['REG_DATE'];
          EdExpDate.Text := ADODSSalesman.FieldValues['EXP_DATE'];
          StabrSalesman.Panels[1].Text := ' มีข้อมูลอยู่ในฐานข้อมูลอยู่แล้ว';
          StabrSalesman.Panels[2].Text := ' คำแนะนำ : กด Cancel เพื่อ Clear ข้อมูล';
          ShowMessage('มีข้อมูลอยู่ในฐานข้อมูลอยู่แล้ว    กรุณาพิมพ์รหัสพนักงานขายใหม่อีกครั้ง');
        end
        else begin
          EdSalesPass.Text := '';
          EdSalesName.Text := '';
          CbRole.Text := '';
          EdRegDate.Text := '';
          EdExpDate.Text := '';
          numrec := 0;
          numallrec := ADODSSalesman.RecordCount;
        end;
      end;
    'D': begin
        itmdata[1] := Uppercase(Trim(CbComId.Text));
        itmdata[2] := Uppercase(Trim(EdSalesId.Text));
        with ADOCmdSalesman do begin
          CommandText := 'SELECT * FROM SALESMAN ' +
            'WHERE COMP_ID = :cid ' +
            'AND SALES_ID = :sid ';
          CommandType := cmdText;
          Parameters.ParamByName('cid').Value := itmdata[1];
          Parameters.ParamByName('sid').Value := itmdata[2];
          ADODSSalesman.Recordset := Execute;
        end;
        ADODSSalesman.First;
        numrec := ADODSSalesman.RecNo;
        numallrec := ADODSSalesman.RecordCount;
        if numallrec <> 0 then begin
          CbComId.Text := ADODSSalesman.FieldValues['COMP_ID'];
          EdSalesId.Text := ADODSSalesman.FieldValues['SALES_ID'];
          EdSalesPass.Text := ADODSSalesman.FieldValues['SALES_PASS'];
          EdSalesName.Text := ADODSSalesman.FieldValues['SALES_NAME'];
          CbRole.Text := ADODSSalesman.FieldValues['ROLE'];
          EdRegDate.Text := ADODSSalesman.FieldValues['REG_DATE'];
          EdExpDate.Text := ADODSSalesman.FieldValues['EXP_DATE'];
          StabrSalesman.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrSalesman.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ ลบข้อมูล';
        end
        else begin
          EdSalesPass.Text := '';
          EdSalesName.Text := '';
          CbRole.Text := '';
          EdRegDate.Text := '';
          EdExpDate.Text := '';
          numrec := 0;
          numallrec := ADODSSalesman.RecordCount;
        end;
      end;
    'C': begin
        EdSalesPass.Enabled := False;
        EdSalesName.Enabled := False;
        CbRole.Enabled := False;
        EdRegDate.Enabled := False;
        EdExpDate.Enabled := False;
        itmdata[1] := Uppercase(Trim(CbComId.Text));
        itmdata[2] := Uppercase(Trim(EdSalesId.Text));
        with ADOCmdSalesman do begin
          CommandText := 'SELECT * FROM SALESMAN ' +
            'WHERE COMP_ID = :cid ' +
            'AND SALES_ID = :sid ';
          CommandType := cmdText;
          Parameters.ParamByName('cid').Value := itmdata[1];
          Parameters.ParamByName('sid').Value := itmdata[2];
          ADODSSalesman.Recordset := Execute;
        end;
        ADODSSalesman.First;
        numrec := ADODSSalesman.RecNo;
        numallrec := ADODSSalesman.RecordCount;
        if numallrec <> 0 then begin
          CbComId.Text := ADODSSalesman.FieldValues['COMP_ID'];
          EdSalesId.Text := ADODSSalesman.FieldValues['SALES_ID'];
          EdSalesPass.Text := ADODSSalesman.FieldValues['SALES_PASS'];
          EdSalesName.Text := ADODSSalesman.FieldValues['SALES_NAME'];
          CbRole.Text := ADODSSalesman.FieldValues['ROLE'];
          EdRegDate.Text := ADODSSalesman.FieldValues['REG_DATE'];
          EdExpDate.Text := ADODSSalesman.FieldValues['EXP_DATE'];
          StabrSalesman.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrSalesman.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          EdSalesPass.Text := '';
          EdSalesName.Text := '';
          CbRole.Text := '';
          EdRegDate.Text := '';
          EdExpDate.Text := '';
          numrec := 0;
          numallrec := ADODSSalesman.RecordCount;
        end;
      end;
    'E': begin
        EdSalesPass.Enabled := False;
        EdSalesName.Enabled := False;
        CbRole.Enabled := False;
        EdRegDate.Enabled := False;
        EdExpDate.Enabled := False;
        itmdata[1] := Uppercase(Trim(CbComId.Text));
        itmdata[2] := Uppercase(Trim(EdSalesId.Text));
        with ADOCmdSalesman do begin
          CommandText := 'SELECT * FROM SALESMAN ' +
            'WHERE COMP_ID = :cid ' +
            'AND SALES_ID = :sid ';
          CommandType := cmdText;
          Parameters.ParamByName('cid').Value := itmdata[1];
          Parameters.ParamByName('sid').Value := itmdata[2];
          ADODSSalesman.Recordset := Execute;
        end;
        ADODSSalesman.First;
        numrec := ADODSSalesman.RecNo;
        numallrec := ADODSSalesman.RecordCount;
        if numallrec <> 0 then begin
          CbComId.Text := ADODSSalesman.FieldValues['COMP_ID'];
          EdSalesId.Text := ADODSSalesman.FieldValues['SALES_ID'];
          EdSalesPass.Text := ADODSSalesman.FieldValues['SALES_PASS'];
          EdSalesName.Text := ADODSSalesman.FieldValues['SALES_NAME'];
          CbRole.Text := ADODSSalesman.FieldValues['ROLE'];
          EdRegDate.Text := ADODSSalesman.FieldValues['REG_DATE'];
          EdExpDate.Text := ADODSSalesman.FieldValues['EXP_DATE'];
          StabrSalesman.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrSalesman.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          EdSalesPass.Text := '';
          EdSalesName.Text := '';
          CbRole.Text := '';
          EdRegDate.Text := '';
          EdExpDate.Text := '';
          numrec := 0;
          numallrec := ADODSSalesman.RecordCount;
        end;
      end;
    'U': begin
        EdSalesPass.Enabled := False;
        EdSalesName.Enabled := False;
        CbRole.Enabled := False;
        EdRegDate.Enabled := False;
        EdExpDate.Enabled := False;
        itmdata[1] := Uppercase(Trim(CbComId.Text));
        itmdata[2] := Uppercase(Trim(EdSalesId.Text));
        with ADOCmdSalesman do begin
          CommandText := 'SELECT * FROM SALESMAN ' +
            'WHERE COMP_ID = :cid ' +
            'AND SALES_ID = :sid ';
          CommandType := cmdText;
          Parameters.ParamByName('cid').Value := itmdata[1];
          Parameters.ParamByName('sid').Value := itmdata[2];
          ADODSSalesman.Recordset := Execute;
        end;
        ADODSSalesman.First;
        numrec := ADODSSalesman.RecNo;
        numallrec := ADODSSalesman.RecordCount;
        if numallrec <> 0 then begin
          CbComId.Text := ADODSSalesman.FieldValues['COMP_ID'];
          EdSalesId.Text := ADODSSalesman.FieldValues['SALES_ID'];
          EdSalesPass.Text := ADODSSalesman.FieldValues['SALES_PASS'];
          EdSalesName.Text := ADODSSalesman.FieldValues['SALES_NAME'];
          CbRole.Text := ADODSSalesman.FieldValues['ROLE'];
          EdRegDate.Text := ADODSSalesman.FieldValues['REG_DATE'];
          EdExpDate.Text := ADODSSalesman.FieldValues['EXP_DATE'];
          StabrSalesman.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrSalesman.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          EdSalesPass.Text := '';
          EdSalesName.Text := '';
          CbRole.Text := '';
          EdRegDate.Text := '';
          EdExpDate.Text := '';
          numrec := 0;
          numallrec := ADODSSalesman.RecordCount;
        end;
      end;
  end;
end;








procedure TFrmSalesman.EdSalesIdChange(Sender: TObject);
begin
  case state of
    'F': begin
        itmdata[1] := Uppercase(Trim(CbComId.Text));
        itmdata[2] := Uppercase(Trim(EdSalesId.Text));
        with ADOCmdSalesman do begin
          CommandText := 'SELECT * FROM SALESMAN ' +
            'WHERE COMP_ID = :cid ' +
            'AND SALES_ID = :sid ';
          CommandType := cmdText;
          Parameters.ParamByName('cid').Value := itmdata[1];
          Parameters.ParamByName('sid').Value := itmdata[2];
          ADODSSalesman.Recordset := Execute;
        end;
        ADODSSalesman.First;
        numrec := ADODSSalesman.RecNo;
        numallrec := ADODSSalesman.RecordCount;
        if numallrec <> 0 then begin
          CbComId.Text := ADODSSalesman.FieldValues['COMP_ID'];
          EdSalesId.Text := ADODSSalesman.FieldValues['SALES_ID'];
          EdSalesPass.Text := ADODSSalesman.FieldValues['SALES_PASS'];
          EdSalesName.Text := ADODSSalesman.FieldValues['SALES_NAME'];
          CbRole.Text := ADODSSalesman.FieldValues['ROLE'];
          EdRegDate.Text := ADODSSalesman.FieldValues['REG_DATE'];
          EdExpDate.Text := ADODSSalesman.FieldValues['EXP_DATE'];
          StabrSalesman.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ ' + InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrSalesman.Panels[2].Text := '';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end
        else begin
          EdSalesPass.Text := '';
          EdSalesName.Text := '';
          CbRole.Text := '';
          EdRegDate.Text := '';
          EdExpDate.Text := '';
          numrec := 0;
          numallrec := ADODSSalesman.RecordCount;
          StabrSalesman.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการค้นหา';
          StabrSalesman.Panels[2].Text := '';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end;
      end;
    'A': begin
        itmdata[1] := Uppercase(Trim(CbComId.Text));
        itmdata[2] := Uppercase(Trim(EdSalesId.Text));
        with ADOCmdSalesman do begin
          CommandText := 'SELECT * FROM SALESMAN ' +
            'WHERE COMP_ID = :cid ' +
            'AND SALES_ID = :sid ';
          CommandType := cmdText;
          Parameters.ParamByName('cid').Value := itmdata[1];
          Parameters.ParamByName('sid').Value := itmdata[2];
          ADODSSalesman.Recordset := Execute;
        end;
        ADODSSalesman.First;
        numrec := ADODSSalesman.RecNo;
        numallrec := ADODSSalesman.RecordCount;
        if numallrec <> 0 then begin
          CbComId.Text := ADODSSalesman.FieldValues['COMP_ID'];
          EdSalesId.Text := ADODSSalesman.FieldValues['SALES_ID'];
          EdSalesPass.Text := ADODSSalesman.FieldValues['SALES_PASS'];
          EdSalesName.Text := ADODSSalesman.FieldValues['SALES_NAME'];
          CbRole.Text := ADODSSalesman.FieldValues['ROLE'];
          EdRegDate.Text := ADODSSalesman.FieldValues['REG_DATE'];
          EdExpDate.Text := ADODSSalesman.FieldValues['EXP_DATE'];
          StabrSalesman.Panels[1].Text := ' มีข้อมูลอยู่ในฐานข้อมูลอยู่แล้ว';
          StabrSalesman.Panels[2].Text := ' คำแนะนำ : กด Cancel เพื่อ Clear ข้อมูล';
          ShowMessage('มีข้อมูลอยู่ในฐานข้อมูลอยู่แล้ว    กรุณาพิมพ์รหัสพนักงานขายใหม่อีกครั้ง');
        end
        else begin
          EdSalesPass.Text := '';
          EdSalesName.Text := '';
          CbRole.Text := '';
          EdRegDate.Text := '';
          EdExpDate.Text := '';
          numrec := 0;
          numallrec := ADODSSalesman.RecordCount;
        end;
      end;
    'D': begin
        itmdata[1] := Uppercase(Trim(CbComId.Text));
        itmdata[2] := Uppercase(Trim(EdSalesId.Text));
        with ADOCmdSalesman do begin
          CommandText := 'SELECT * FROM SALESMAN ' +
            'WHERE COMP_ID = :cid ' +
            'AND SALES_ID = :sid ';
          CommandType := cmdText;
          Parameters.ParamByName('cid').Value := itmdata[1];
          Parameters.ParamByName('sid').Value := itmdata[2];
          ADODSSalesman.Recordset := Execute;
        end;
        ADODSSalesman.First;
        numrec := ADODSSalesman.RecNo;
        numallrec := ADODSSalesman.RecordCount;
        if numallrec <> 0 then begin
          CbComId.Text := ADODSSalesman.FieldValues['COMP_ID'];
          EdSalesId.Text := ADODSSalesman.FieldValues['SALES_ID'];
          EdSalesPass.Text := ADODSSalesman.FieldValues['SALES_PASS'];
          EdSalesName.Text := ADODSSalesman.FieldValues['SALES_NAME'];
          CbRole.Text := ADODSSalesman.FieldValues['ROLE'];
          EdRegDate.Text := ADODSSalesman.FieldValues['REG_DATE'];
          EdExpDate.Text := ADODSSalesman.FieldValues['EXP_DATE'];
          StabrSalesman.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrSalesman.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ ลบข้อมูล';
        end
        else begin
          EdSalesPass.Text := '';
          EdSalesName.Text := '';
          CbRole.Text := '';
          EdRegDate.Text := '';
          EdExpDate.Text := '';
          numrec := 0;
          numallrec := ADODSSalesman.RecordCount;
        end;
      end;
    'C': begin
        EdSalesPass.Enabled := False;
        EdSalesName.Enabled := False;
        CbRole.Enabled := False;
        EdRegDate.Enabled := False;
        EdExpDate.Enabled := False;
        itmdata[1] := Uppercase(Trim(CbComId.Text));
        itmdata[2] := Uppercase(Trim(EdSalesId.Text));
        with ADOCmdSalesman do begin
          CommandText := 'SELECT * FROM SALESMAN ' +
            'WHERE COMP_ID = :cid ' +
            'AND SALES_ID = :sid ';
          CommandType := cmdText;
          Parameters.ParamByName('cid').Value := itmdata[1];
          Parameters.ParamByName('sid').Value := itmdata[2];
          ADODSSalesman.Recordset := Execute;
        end;
        ADODSSalesman.First;
        numrec := ADODSSalesman.RecNo;
        numallrec := ADODSSalesman.RecordCount;
        if numallrec <> 0 then begin
          CbComId.Text := ADODSSalesman.FieldValues['COMP_ID'];
          EdSalesId.Text := ADODSSalesman.FieldValues['SALES_ID'];
          EdSalesPass.Text := ADODSSalesman.FieldValues['SALES_PASS'];
          EdSalesName.Text := ADODSSalesman.FieldValues['SALES_NAME'];
          CbRole.Text := ADODSSalesman.FieldValues['ROLE'];
          EdRegDate.Text := ADODSSalesman.FieldValues['REG_DATE'];
          EdExpDate.Text := ADODSSalesman.FieldValues['EXP_DATE'];
          StabrSalesman.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrSalesman.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          EdSalesPass.Text := '';
          EdSalesName.Text := '';
          CbRole.Text := '';
          EdRegDate.Text := '';
          EdExpDate.Text := '';
          numrec := 0;
          numallrec := ADODSSalesman.RecordCount;
        end;
      end;
    'E': begin
        EdSalesPass.Enabled := False;
        EdSalesName.Enabled := False;
        CbRole.Enabled := False;
        EdRegDate.Enabled := False;
        EdExpDate.Enabled := False;
        itmdata[1] := Uppercase(Trim(CbComId.Text));
        itmdata[2] := Uppercase(Trim(EdSalesId.Text));
        with ADOCmdSalesman do begin
          CommandText := 'SELECT * FROM SALESMAN ' +
            'WHERE COMP_ID = :cid ' +
            'AND SALES_ID = :sid ';
          CommandType := cmdText;
          Parameters.ParamByName('cid').Value := itmdata[1];
          Parameters.ParamByName('sid').Value := itmdata[2];
          ADODSSalesman.Recordset := Execute;
        end;
        ADODSSalesman.First;
        numrec := ADODSSalesman.RecNo;
        numallrec := ADODSSalesman.RecordCount;
        if numallrec <> 0 then begin
          CbComId.Text := ADODSSalesman.FieldValues['COMP_ID'];
          EdSalesId.Text := ADODSSalesman.FieldValues['SALES_ID'];
          EdSalesPass.Text := ADODSSalesman.FieldValues['SALES_PASS'];
          EdSalesName.Text := ADODSSalesman.FieldValues['SALES_NAME'];
          CbRole.Text := ADODSSalesman.FieldValues['ROLE'];
          EdRegDate.Text := ADODSSalesman.FieldValues['REG_DATE'];
          EdExpDate.Text := ADODSSalesman.FieldValues['EXP_DATE'];
          StabrSalesman.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrSalesman.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          EdSalesPass.Text := '';
          EdSalesName.Text := '';
          CbRole.Text := '';
          EdRegDate.Text := '';
          EdExpDate.Text := '';
          numrec := 0;
          numallrec := ADODSSalesman.RecordCount;
        end;
      end;
    'U': begin
        EdSalesPass.Enabled := False;
        EdSalesName.Enabled := False;
        CbRole.Enabled := False;
        EdRegDate.Enabled := False;
        EdExpDate.Enabled := False;
        itmdata[1] := Uppercase(Trim(CbComId.Text));
        itmdata[2] := Uppercase(Trim(EdSalesId.Text));
        with ADOCmdSalesman do begin
          CommandText := 'SELECT * FROM SALESMAN ' +
            'WHERE COMP_ID = :cid ' +
            'AND SALES_ID = :sid ';
          CommandType := cmdText;
          Parameters.ParamByName('cid').Value := itmdata[1];
          Parameters.ParamByName('sid').Value := itmdata[2];
          ADODSSalesman.Recordset := Execute;
        end;
        ADODSSalesman.First;
        numrec := ADODSSalesman.RecNo;
        numallrec := ADODSSalesman.RecordCount;
        if numallrec <> 0 then begin
          CbComId.Text := ADODSSalesman.FieldValues['COMP_ID'];
          EdSalesId.Text := ADODSSalesman.FieldValues['SALES_ID'];
          EdSalesPass.Text := ADODSSalesman.FieldValues['SALES_PASS'];
          EdSalesName.Text := ADODSSalesman.FieldValues['SALES_NAME'];
          CbRole.Text := ADODSSalesman.FieldValues['ROLE'];
          EdRegDate.Text := ADODSSalesman.FieldValues['REG_DATE'];
          EdExpDate.Text := ADODSSalesman.FieldValues['EXP_DATE'];
          StabrSalesman.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrSalesman.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          EdSalesPass.Text := '';
          EdSalesName.Text := '';
          CbRole.Text := '';
          EdRegDate.Text := '';
          EdExpDate.Text := '';
          numrec := 0;
          numallrec := ADODSSalesman.RecordCount;
        end;
      end;
  end;
end;

end.
