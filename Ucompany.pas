unit Ucompany;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, StdCtrls, Buttons, ComCtrls, ADODB, DB;
const status: array[0..6] of char = ('R', 'F', 'A', 'D', 'E', 'C', 'U');
  // R=Read,F=Find,A=Append,D=Delete,E=Edit,C=Commit,U=Update

type
  TFrmCompany = class(TForm)
    BvCompany: TBevel;
    LblComId: TLabel;
    LblComName: TLabel;
    LblAdd1: TLabel;
    LblAdd2: TLabel;
    LblAdd3: TLabel;
    LblPost: TLabel;
    LblTaxId: TLabel;
    EdComId: TEdit;
    EdComName: TEdit;
    EdAdd1: TEdit;
    EdAdd2: TEdit;
    EdAdd3: TEdit;
    EdPost: TEdit;
    EdTaxId: TEdit;
    BtbOk: TBitBtn;
    BtbCancel: TBitBtn;
    BtbExit: TBitBtn;
    RdgrpStatus: TRadioGroup;
    RdbShow: TRadioButton;
    RdbInsert: TRadioButton;
    RdbDelete: TRadioButton;
    RdbUpdate: TRadioButton;
    StabrCompany: TStatusBar;
    ADODSCompany: TADODataSet;
    ADOCmdCompany: TADOCommand;
    ADOCmdBillH: TADOCommand;
    ADODSBillH: TADODataSet;
    ADOCmdSalesman: TADOCommand;
    ADODSSalesman: TADODataSet;
    Label1: TLabel;
    EdBranch: TEdit;
    procedure RdbShowClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtbOkClick(Sender: TObject);
    procedure BtbCancelClick(Sender: TObject);
    procedure RdbInsertClick(Sender: TObject);
    procedure RdbDeleteClick(Sender: TObject);
    procedure RdbUpdateClick(Sender: TObject);
    procedure EdComIdChange(Sender: TObject);
    procedure BtbExitClick(Sender: TObject);
  private
    { Private declarations }
    itmdata: array[1..8] of string;
    numrec, numallrec: variant;
    old_id: string;
    chk: boolean;
    state: char;
  public
    { Public declarations }
  end;

var
  FrmCompany: TFrmCompany;

implementation

uses Udatamodule;

{$R *.dfm}

procedure TFrmCompany.FormCreate(Sender: TObject);

begin
  StabrCompany.Panels[0].Width := 15;
  StabrCompany.Panels[1].Width := 285;
  RdbShow.Checked := True;
end;

procedure TFrmCompany.RdbShowClick(Sender: TObject);
begin
  state := status[1];
  EdComId.Enabled := True;
  EdComName.Enabled := False;
  EdAdd1.Enabled := False;
  EdAdd2.Enabled := False;
  EdAdd3.Enabled := False;
  EdPost.Enabled := False;
  EdTaxId.Enabled := False;
  EdBranch.Enabled := False;
  EdBranch.Text := '';
  EdComId.Text := '';
  EdComName.Text := '';
  EdAdd1.Text := '';
  EdAdd2.Text := '';
  EdAdd3.Text := '';
  EdPost.Text := '';
  EdTaxId.Text := '';
  StabrCompany.Panels[1].Text := ' ';
  StabrCompany.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสบริษัทที่ต้องการจะค้นหา ';
  BtbOk.Enabled := False;
  BtbCancel.Enabled := False;
end;

procedure TFrmCompany.RdbInsertClick(Sender: TObject);
begin
  state := status[2];
  EdComId.Text := '';
  EdComName.Text := '';
  EdAdd1.Text := '';
  EdAdd2.Text := '';
  EdAdd3.Text := '';
  EdPost.Text := '';
  EdTaxId.Text := '';
  EdBranch.Text := '';
  EdBranch.Enabled := True;
  EdComId.Enabled := True;
  EdComId.SetFocus;
  EdComName.Enabled := True;
  EdAdd1.Enabled := True;
  EdAdd2.Enabled := True;
  EdAdd3.Enabled := True;
  EdPost.Enabled := True;
  EdTaxId.Enabled := True;
  StabrCompany.Panels[1].Text := '';
  StabrCompany.Panels[2].Text := ' คำแนะนำ : เลื่อนโดยกด TAB แล้วเลือกปุ่ม OK เพื่อบันทึกข้อมูล';
  BtbOk.Enabled := True;
  BtbCancel.Enabled := True;
end;

procedure TFrmCompany.RdbDeleteClick(Sender: TObject);
begin
  state := status[3];
  EdComId.Text := '';
  EdComName.Text := '';
  EdAdd1.Text := '';
  EdAdd2.Text := '';
  EdAdd3.Text := '';
  EdPost.Text := '';
  EdTaxId.Text := '';
  EdBranch.Text := '';
  EdBranch.Enabled := True;
  EdComId.Enabled := True;
  EdComId.SetFocus;
  EdComName.Enabled := False;
  EdAdd1.Enabled := False;
  EdAdd2.Enabled := False;
  EdAdd3.Enabled := False;
  EdPost.Enabled := False;
  EdTaxId.Enabled := False;
  StabrCompany.Panels[1].Text := '';
  StabrCompany.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสบริษัทที่ต้องการจะลบ แล้วเลือกปุ่มOK';
  BtbOk.Enabled := True;
  BtbCancel.Enabled := True;
end;

procedure TFrmCompany.RdbUpdateClick(Sender: TObject);
begin
  state := status[4];
  EdComId.Text := '';
  EdComName.Text := '';
  EdAdd1.Text := '';
  EdAdd2.Text := '';
  EdAdd3.Text := '';
  EdPost.Text := '';
  EdTaxId.Text := '';
  EdBranch.Text := '';
  EdBranch.Enabled := True;
  EdComId.Enabled := True;
  EdComId.SetFocus;
  EdComName.Enabled := False;
  EdAdd1.Enabled := False;
  EdAdd2.Enabled := False;
  EdAdd3.Enabled := False;
  EdPost.Enabled := False;
  EdTaxId.Enabled := False;
  StabrCompany.Panels[1].Text := '';
  StabrCompany.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสบริษัทที่ต้องการจะแก้ไข แล้วเลือกปุ่ม OK';
  BtbOk.Enabled := True;
  BtbCancel.Enabled := True;
end;

procedure TFrmCompany.BtbOkClick(Sender: TObject);
var
  count: integer;
begin
  count := 0;
  case state of
    'F': begin
        itmdata[1] := Uppercase(Trim(EdComId.Text));
        with ADOCmdCompany do begin
          CommandText := 'SELECT * FROM COMPANY WHERE COMP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSCompany.Recordset := Execute;
        end;
        ADODSCompany.First;
        numrec := ADODSCompany.RecNo;
        numallrec := ADODSCompany.RecordCount;
        if numallrec <> 0 then begin
          EdComId.Text := ADODSCompany.FieldValues['COMP_ID'];
          EdComName.Text := ADODSCompany.FieldValues['COMP_NAME'];
          EdAdd1.Text := ADODSCompany.FieldValues['COMP_ADD1'];
          EdAdd2.Text := ADODSCompany.FieldValues['COMP_ADD2'];
          EdAdd3.Text := ADODSCompany.FieldValues['COMP_ADD3'];
          EdPost.Text := ADODSCompany.FieldValues['COMP_POST'];
          EdTaxId.Text := ADODSCompany.FieldValues['COMP_TAX'];
          EdBranch.Text := ADODSCompany.FieldValues['COMP_BRANCH'];
          StabrCompany.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ ' + InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrCompany.Panels[2].Text := '';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end
        else begin
          EdComId.Text := '';
          EdComName.Text := '';
          EdAdd1.Text := '';
          EdAdd2.Text := '';
          EdAdd3.Text := '';
          EdPost.Text := '';
          EdTaxId.Text := '';
          EdBranch.Text := '';
          EdComId.SetFocus;
          numrec := 0;
          numallrec := ADODSCompany.RecordCount;
          StabrCompany.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการค้นหา';
          StabrCompany.Panels[2].Text := '';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end;
      end;
    'A': begin
        //Get data from input screen
        itmdata[1] := Uppercase(Trim(EdComId.Text));
        itmdata[2] := EdComName.Text;
        itmdata[3] := EdAdd1.Text;
        itmdata[4] := EdAdd2.Text;
        itmdata[5] := EdAdd3.Text;
        itmdata[6] := EdPost.Text;
        itmdata[7] := EdTaxId.Text;
        itmdata[8] := EdBranch.Text;
        // Check primary key
        with ADOCmdCompany do begin
          CommandText := 'SELECT * FROM COMPANY';
          CommandType := cmdText;
          ADODSCompany.Recordset := Execute;
        end;
        numallrec := ADODSCompany.RecordCount;
        with ADOCmdCompany do begin
          CommandText := 'SELECT * FROM COMPANY WHERE COMP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSCompany.Recordset := Execute;
        end;
        chk := False;
        ADODSCompany.First;
        numrec := ADODSCompany.RecNo;

        for count := numrec to numallrec do
          if itmdata[1] = ADODSCompany.FieldValues['COMP_ID'] then chk := True;
        ADODSCompany.Next;

        if chk = True then begin
          StabrCompany.Panels[1].Text := 'ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลรหัสบริษัทซ้ำ';
          StabrCompany.Panels[2].Text := ' คำแนะนำ : กรุณากดปุ่มCancel แล้วบันทึกข้อมูลใหม่อีกครั้ง';
        end
        else begin
          // Check not null
          if (itmdata[1] <> '') and (itmdata[2] <> '') and (itmdata[3] <> '') and (itmdata[4] <> '') and (itmdata[5] <> '') and (itmdata[6] <> '') and (itmdata[7] <> '') and (itmdata[8] <> '') then begin
            StabrCompany.Panels[1].Text := ' บันทึกข้อมูลเรียบร้อยแล้ว';
            StabrCompany.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้เลือกสถานะเป็นแสดงข้อมูล';
            with ADOCmdCompany do begin
              CommandText := 'INSERT INTO COMPANY (COMP_ID, COMP_NAME, COMP_ADD1, COMP_ADD2, COMP_ADD3, COMP_POST, COMP_TAX, COMP_BRANCH)' +
                'VALUES (:newid, :newname, :newadd1, :newadd2, :newadd3, :newpost, :newtaxid, :newbranch)';
              CommandType := cmdText;
              Parameters.ParamByName('newid').Value := itmdata[1];
              Parameters.ParamByName('newname').Value := itmdata[2];
              Parameters.ParamByName('newadd1').Value := itmdata[3];
              Parameters.ParamByName('newadd2').Value := itmdata[4];
              Parameters.ParamByName('newadd3').Value := itmdata[5];
              Parameters.ParamByName('newpost').Value := itmdata[6];
              Parameters.ParamByName('newtaxid').Value := itmdata[7];
              Parameters.ParamByName('newbranch').Value := itmdata[8];
              Execute
            end;
            EdComId.Text := ''; // Plus
            EdComName.Text := ''; // Plus
            EdAdd1.Text := ''; // Plus
            EdAdd2.Text := ''; // Plus
            EdAdd3.Text := ''; // Plus
            EdPost.Text := ''; // Plus
            EdTaxId.Text := ''; // Plus
            EdBranch.Text := '';
            EdComId.SetFocus; // Plus
          end
          else begin
            ShowMessage('ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน'); // Plus2
            StabrCompany.Panels[1].Text := 'ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน';
            StabrCompany.Panels[2].Text := ' คำแนะนำ : กรุณากดปุ่มCancel แล้วบันทึกข้อมูลใหม่อีกครั้ง';
          end;
        end;
      end;
    'D': begin
        count := count + 1;
        itmdata[1] := Uppercase(Trim(EdComId.Text));
        with ADOCmdCompany do begin
          CommandText := 'SELECT * FROM COMPANY WHERE COMP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSCompany.Recordset := Execute;
        end;
        ADODSCompany.First;
        numrec := ADODSCompany.RecNo;
        numallrec := ADODSCompany.RecordCount;
        if numallrec <> 0 then begin
          EdComId.Text := ADODSCompany.FieldValues['COMP_ID'];
          EdComName.Text := ADODSCompany.FieldValues['COMP_NAME'];
          EdAdd1.Text := ADODSCompany.FieldValues['COMP_ADD1'];
          EdAdd2.Text := ADODSCompany.FieldValues['COMP_ADD2'];
          EdAdd3.Text := ADODSCompany.FieldValues['COMP_ADD3'];
          EdPost.Text := ADODSCompany.FieldValues['COMP_POST'];
          EdTaxId.Text := ADODSCompany.FieldValues['COMP_TAX'];
          EdBranch.Text := ADODSCompany.FieldValues['COMP_BRANCH'];
          StabrCompany.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ ' + InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrCompany.Panels[2].Text := ' คำแนะนำ : คุณแน่ใจที่จะลบข้อมูลหรือไม่ ถ้าใช่ให้กดปุ่ม OK อีกครั้งหนึ่ง';
          ShowMessage('คุณแน่ใจที่จะลบข้อมูลหรือไม่ ถ้าใช่ให้กดปุ่ม OK ที่หน้าจอ อีกครั้งหนึ่ง');
          if count > 0 then begin
            state := status[5];
          end;
        end
        else begin
          EdComId.Text := '';
          EdComName.Text := '';
          EdAdd1.Text := '';
          EdAdd2.Text := '';
          EdAdd3.Text := '';
          EdPost.Text := '';
          EdTaxId.Text := '';
          EdBranch.Text := '';;
          EdComId.SetFocus;
          numrec := 0;
          numallrec := ADODSCompany.RecordCount;
          StabrCompany.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการจะลบ';
          StabrCompany.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการป้อนข้อมูลใหม่อีกครั้งให้กดปุ่ม Cancel';
          state := status[3];
        end;
      end;
    'C': begin
        with ADOCmdBillH do begin // Check delete foreign key reference from another table
          CommandText := 'SELECT * FROM BILL_HEAD WHERE BILLH_COMP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSBillH.Recordset := Execute;
        end;
        numrec := ADODSBillH.RecordCount;
        if numrec > 0 then begin
          StabrCompany.Panels[1].Text := ' ไม่สามารถลบข้อมูลได้เนื่องจากมีการนำข้อมูลนี้ไปใช้งานแล้ว';
          StabrCompany.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการลบข้อมูลให้แจ้งผู้ดูแลฐานข้อมูล';
        end
        else begin
          numrec := 0;
          with ADOCmdSalesman do begin // Check delete foreign key reference from another table
            CommandText := 'SELECT * FROM SALESMAN WHERE COMP_ID = :id';
            CommandType := cmdText;
            Parameters.ParamByName('id').Value := itmdata[1];
            ADODSSalesman.Recordset := Execute;
          end;
          numrec := ADODSSalesman.RecordCount;
          if numrec > 0 then begin
            StabrCompany.Panels[1].Text := ' ไม่สามารถลบข้อมูลได้เนื่องจากมีการนำข้อมูลนี้ไปใช้งานแล้ว';
            StabrCompany.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการลบข้อมูลให้แจ้งผู้ดูแลฐานข้อมูล';
          end
          else begin
            with ADOCmdCompany do begin
              CommandText := 'DELETE * FROM COMPANY WHERE COMP_ID = :id';
              CommandType := cmdText;
              Parameters.ParamByName('id').Value := itmdata[1];
              Execute;
            end;
            EdComId.Text := '';
            EdComName.Text := '';
            EdAdd1.Text := '';
            EdAdd2.Text := '';
            EdAdd3.Text := '';
            EdPost.Text := '';
            EdTaxId.Text := '';
            EdBranch.Text := '';
            EdComId.SetFocus;
            StabrCompany.Panels[1].Text := ' ข้อมูลถูกลบออกจากฐานข้อมูลเรียบร้อยแล้ว';
            StabrCompany.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้เลือกสถานะเป็นแสดงข้อมูล';
            state := status[3];
          end;
        end;
      end;
    'E': begin
        EdComId.Enabled := False;
        count := count + 1;
        itmdata[1] := Uppercase(Trim(EdComId.Text));
        old_id := itmdata[1];
        with ADOCmdCompany do begin
          CommandText := 'SELECT * FROM COMPANY WHERE COMP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSCompany.Recordset := Execute;
        end;
        ADODSCompany.First;
        numrec := ADODSCompany.RecNo;
        numallrec := ADODSCompany.RecordCount;
        EdComName.Enabled := True;
        EdAdd1.Enabled := True;
        EdAdd2.Enabled := True;
        EdAdd3.Enabled := True;
        EdPost.Enabled := True;
        EdTaxId.Enabled := True;
        EdBranch.Enabled := True;
        if numallrec <> 0 then begin
          EdComId.Text := ADODSCompany.FieldValues['COMP_ID'];
          EdComName.Text := ADODSCompany.FieldValues['COMP_NAME'];
          EdAdd1.Text := ADODSCompany.FieldValues['COMP_ADD1'];
          EdAdd2.Text := ADODSCompany.FieldValues['COMP_ADD2'];
          EdAdd3.Text := ADODSCompany.FieldValues['COMP_ADD3'];
          EdPost.Text := ADODSCompany.FieldValues['COMP_POST'];
          EdTaxId.Text := ADODSCompany.FieldValues['COMP_TAX'];
          EdBranch.Text := ADODSCompany.FieldValues['COMP_BRANCH'];
          StabrCompany.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ ' + InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrCompany.Panels[2].Text := ' คำแนะนำ : เมื่อแก้ไขข้อมูลเสร็จเรียบร้อยแล้วให้กดปุ่มOK ';
          if count > 0 then begin
            state := status[6];
          end;
        end
        else begin
          EdComId.Text := '';
          EdComName.Text := '';
          EdAdd1.Text := '';
          EdAdd2.Text := '';
          EdAdd3.Text := '';
          EdPost.Text := '';
          EdTaxId.Text := '';
          EdBranch.Text := '';
          EdComId.Enabled := True;
          EdComId.SetFocus;
          numrec := 0;
          numallrec := ADODSCompany.RecordCount;
          StabrCompany.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการจะแก้ไข';
          StabrCompany.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการป้อนข้อมูลใหม่อีกครั้งให้กดปุ่ม Cancel';
          state := status[4];
        end;
      end;
    'U': begin
        //itmdata[1] := Uppercase(Trim(EdComId.Text));
        itmdata[2] := EdComName.Text;
        itmdata[3] := EdAdd1.Text;
        itmdata[4] := EdAdd2.Text;
        itmdata[5] := EdAdd3.Text;
        itmdata[6] := EdPost.Text;
        itmdata[7] := EdTaxId.Text;
        itmdata[8] := EdBranch.Text;
        if (itmdata[1] <> '') and (itmdata[2] <> '') and (itmdata[3] <> '') and (itmdata[4] <> '') and (itmdata[5] <> '') and (itmdata[6] <> '') and (itmdata[7] <> '') and (itmdata[8] <> '') then begin
          with ADOCmdCompany do begin
            CommandText := 'UPDATE COMPANY ' +
              'SET ' + //COMPANY.COMP_ID = :edid,'+
              'COMPANY.COMP_NAME = :edname,' +
              'COMPANY.COMP_ADD1 = :edadd1,' +
              'COMPANY.COMP_ADD2 = :edadd2,' +
              'COMPANY.COMP_ADD3 = :edadd3,' +
              'COMPANY.COMP_POST = :edpost,' +
              'COMPANY.COMP_TAX = :edtaxid, ' +
              'COMPANY.COMP_BRANCH = :edbranch ' +
              'WHERE (COMPANY.COMP_ID = :id)';
            CommandType := cmdText;
          //Parameters.ParamByName('edid').Value := itmdata[1];
            Parameters.ParamByName('edname').Value := itmdata[2];
            Parameters.ParamByName('edadd1').Value := itmdata[3];
            Parameters.ParamByName('edadd2').Value := itmdata[4];
            Parameters.ParamByName('edadd3').Value := itmdata[5];
            Parameters.ParamByName('edpost').Value := itmdata[6];
            Parameters.ParamByName('edtaxid').Value := itmdata[7];
            Parameters.ParamByName('edbranch').Value := itmdata[8];
            Parameters.ParamByName('id').Value := old_id;
            Execute
          end;
          StabrCompany.Panels[1].Text := ' ข้อมูลถูกแก้ไขกับฐานข้อมูลเรียบร้อยแล้ว';
          StabrCompany.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้เลือกสถานะเป็นแสดงข้อมูล';
          state := status[4];
          EdComId.Text := '';
          EdComName.Text := '';
          EdAdd1.Text := '';
          EdAdd2.Text := '';
          EdAdd3.Text := '';
          EdPost.Text := '';
          EdTaxId.Text := '';
          EdBranch.Text := '';
          EdComId.Enabled := True;
          EdComName.Enabled := False;
          EdAdd1.Enabled := False;
          EdAdd2.Enabled := False;
          EdAdd3.Enabled := False;
          EdPost.Enabled := False;
          EdTaxId.Enabled := False;
          EdBranch.Enabled := False;
          EdComId.SetFocus;
        end
        else begin
          ShowMessage('ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน'); // Plus2
          StabrCompany.Panels[1].Text := 'ไม่สามารถบันทึกข้อมูลได้เพราะป้อนข้อมูลไม่ครบถ้วน';
          StabrCompany.Panels[2].Text := ' คำแนะนำ : กรุณากดปุ่มCancel แล้วบันทึกข้อมูลใหม่อีกครั้ง';
          state := status[4];
        end;
      end;
  end;
end;


procedure TFrmCompany.BtbCancelClick(Sender: TObject);
begin
  EdComId.Enabled := True;
  case state of
    'F': begin
        EdComId.Text := '';
        EdComName.Text := '';
        EdAdd1.Text := '';
        EdAdd2.Text := '';
        EdAdd3.Text := '';
        EdPost.Text := '';
        EdTaxId.Text := '';
        EdBranch.Text := '';
        EdComId.SetFocus;
        numrec := 0;
        numallrec := 0;
        StabrCompany.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ ' + InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
        StabrCompany.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้กดปุ่มแว่นขยาย';
      end;
    'A': begin
        EdComId.Text := '';
        EdComName.Text := '';
        EdAdd1.Text := '';
        EdAdd2.Text := '';
        EdAdd3.Text := '';
        EdPost.Text := '';
        EdTaxId.Text := '';
        EdBranch.Text := '';
        EdComId.SetFocus;
        StabrCompany.Panels[1].Text := '';
        StabrCompany.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสบริษัทที่ต้องการจะค้นหา แล้วเลือกปุ่มOK';
      end;
    'D': begin
        EdComId.Text := '';
        EdComName.Text := '';
        EdAdd1.Text := '';
        EdAdd2.Text := '';
        EdAdd3.Text := '';
        EdPost.Text := '';
        EdTaxId.Text := '';
        EdBranch.Text := '';
        EdComId.SetFocus;
        StabrCompany.Panels[1].Text := '';
        StabrCompany.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสบริษัทที่ต้องการจะลบใหม่อีกครั้ง';
      end;
    'C': begin
        state := status[3]; //Plus
        EdComId.Text := '';
        EdComName.Text := '';
        EdAdd1.Text := '';
        EdAdd2.Text := '';
        EdAdd3.Text := '';
        EdPost.Text := '';
        EdTaxId.Text := '';
        EdBranch.Text := '';
        EdComId.SetFocus;
        StabrCompany.Panels[1].Text := '';
        StabrCompany.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสบริษัทที่ต้องการจะลบใหม่อีกครั้ง';
      end;
    'E': begin
        EdComId.Text := '';
        EdComName.Text := '';
        EdAdd1.Text := '';
        EdAdd2.Text := '';
        EdAdd3.Text := '';
        EdPost.Text := '';
        EdTaxId.Text := '';
        EdBranch.Text := '';
        EdComId.SetFocus;
        StabrCompany.Panels[1].Text := '';
        StabrCompany.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสบริษัทที่ต้องการจะแก้ไขใหม่อีกครั้ง';
      end;
    'U': begin
        state := status[4]; //Plus
        EdComId.Text := '';
        EdComName.Text := '';
        EdAdd1.Text := '';
        EdAdd2.Text := '';
        EdAdd3.Text := '';
        EdPost.Text := '';
        EdTaxId.Text := '';
        EdBranch.Text := '';
        EdComId.SetFocus;
        StabrCompany.Panels[1].Text := '';
        StabrCompany.Panels[2].Text := ' คำแนะนำ : กรุณาป้อนรหัสบริษัทที่ต้องการจะแก้ไขใหม่อีกครั้ง';
      end;
  end;
end;





procedure TFrmCompany.EdComIdChange(Sender: TObject);
begin
  case state of
    'F': begin
        itmdata[1] := Uppercase(Trim(EdComId.Text));
        with ADOCmdCompany do begin
          CommandText := 'SELECT * FROM COMPANY WHERE COMP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSCompany.Recordset := Execute;
        end;
        ADODSCompany.First;
        numrec := ADODSCompany.RecNo;
        numallrec := ADODSCompany.RecordCount;
        if numallrec <> 0 then begin
          EdComId.Text := ADODSCompany.FieldValues['COMP_ID'];
          EdComName.Text := ADODSCompany.FieldValues['COMP_NAME'];
          EdAdd1.Text := ADODSCompany.FieldValues['COMP_ADD1'];
          EdAdd2.Text := ADODSCompany.FieldValues['COMP_ADD2'];
          EdAdd3.Text := ADODSCompany.FieldValues['COMP_ADD3'];
          EdPost.Text := ADODSCompany.FieldValues['COMP_POST'];
          EdTaxId.Text := ADODSCompany.FieldValues['COMP_TAX'];
          EdBranch.Text := ADODSCompany.FieldValues['COMP_BRANCH'];
          StabrCompany.Panels[1].Text := ' กำลังแสดงข้อมูลของ record ที่ ' + InttoStr(numrec) + ' จากทั้งหมด ' + InttoStr(numallrec) + ' record';
          StabrCompany.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้กดปุ่มแว่นขยาย';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end
        else begin
          EdComName.Text := '';
          EdAdd1.Text := '';
          EdAdd2.Text := '';
          EdAdd3.Text := '';
          EdPost.Text := '';
          EdTaxId.Text := '';
          EdBranch.Text := '';
          EdComId.SetFocus;
          numrec := 0;
          numallrec := ADODSCompany.RecordCount;
          StabrCompany.Panels[1].Text := ' ไม่พบข้อมูลที่ต้องการค้นหา';
          StabrCompany.Panels[2].Text := ' คำแนะนำ : ถ้าต้องการค้นหาข้อมูลให้กดปุ่มแว่นขยาย';
          BtbOk.Enabled := False;
          BtbCancel.Enabled := False;
        end;
      end;
    'A': begin
        itmdata[1] := Uppercase(Trim(EdComId.Text));
        with ADOCmdCompany do begin
          CommandText := 'SELECT * FROM COMPANY WHERE COMP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSCompany.Recordset := Execute;
        end;
        ADODSCompany.First;
        numrec := ADODSCompany.RecNo;
        numallrec := ADODSCompany.RecordCount;
        if numallrec <> 0 then begin
          EdComId.Text := ADODSCompany.FieldValues['COMP_ID'];
          EdComName.Text := ADODSCompany.FieldValues['COMP_NAME'];
          EdAdd1.Text := ADODSCompany.FieldValues['COMP_ADD1'];
          EdAdd2.Text := ADODSCompany.FieldValues['COMP_ADD2'];
          EdAdd3.Text := ADODSCompany.FieldValues['COMP_ADD3'];
          EdPost.Text := ADODSCompany.FieldValues['COMP_POST'];
          EdTaxId.Text := ADODSCompany.FieldValues['COMP_TAX'];
          EdBranch.Text := ADODSCompany.FieldValues['COMP_BRANCH'];
          StabrCompany.Panels[1].Text := ' มีข้อมูลอยู่ในฐานข้อมูลอยู่แล้ว';
          StabrCompany.Panels[2].Text := ' คำแนะนำ : กด Cancel เพื่อ Clear ข้อมูล';
          ShowMessage('มีข้อมูลอยู่ในฐานข้อมูลอยู่แล้ว    กรุณาพิมพ์รหัสบริษัทใหม่อีกครั้ง');
        end
        else begin
          EdComName.Text := '';
          EdAdd1.Text := '';
          EdAdd2.Text := '';
          EdAdd3.Text := '';
          EdPost.Text := '';
          EdTaxId.Text := '';
          EdBranch.Text := '';
          numrec := 0;
          numallrec := ADODSCompany.RecordCount;
        end;
      end;
    'D': begin
        itmdata[1] := Uppercase(Trim(EdComId.Text));
        with ADOCmdCompany do begin
          CommandText := 'SELECT * FROM COMPANY WHERE COMP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSCompany.Recordset := Execute;
        end;
        ADODSCompany.First;
        numrec := ADODSCompany.RecNo;
        numallrec := ADODSCompany.RecordCount;
        if numallrec <> 0 then begin
          EdComId.Text := ADODSCompany.FieldValues['COMP_ID'];
          EdComName.Text := ADODSCompany.FieldValues['COMP_NAME'];
          EdAdd1.Text := ADODSCompany.FieldValues['COMP_ADD1'];
          EdAdd2.Text := ADODSCompany.FieldValues['COMP_ADD2'];
          EdAdd3.Text := ADODSCompany.FieldValues['COMP_ADD3'];
          EdPost.Text := ADODSCompany.FieldValues['COMP_POST'];
          EdTaxId.Text := ADODSCompany.FieldValues['COMP_TAX'];
          EdBranch.Text := ADODSCompany.FieldValues['COMP_BRANCH'];
          StabrCompany.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrCompany.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ ลบข้อมูล';
        end
        else begin
          EdComName.Text := '';
          EdAdd1.Text := '';
          EdAdd2.Text := '';
          EdAdd3.Text := '';
          EdPost.Text := '';
          EdTaxId.Text := '';
          EdBranch.Text := '';
          numrec := 0;
          numallrec := ADODSCompany.RecordCount;
        end;
      end;
    'C': begin
        EdComName.Enabled := False;
        EdAdd1.Enabled := False;
        EdAdd2.Enabled := False;
        EdAdd3.Enabled := False;
        EdPost.Enabled := False;
        EdTaxId.Enabled := False;
        EdBranch.Enabled := False;
        itmdata[1] := Uppercase(Trim(EdComId.Text));
        with ADOCmdCompany do begin
          CommandText := 'SELECT * FROM COMPANY WHERE COMP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSCompany.Recordset := Execute;
        end;
        ADODSCompany.First;
        numrec := ADODSCompany.RecNo;
        numallrec := ADODSCompany.RecordCount;
        if numallrec <> 0 then begin
          EdComId.Text := ADODSCompany.FieldValues['COMP_ID'];
          EdComName.Text := ADODSCompany.FieldValues['COMP_NAME'];
          EdAdd1.Text := ADODSCompany.FieldValues['COMP_ADD1'];
          EdAdd2.Text := ADODSCompany.FieldValues['COMP_ADD2'];
          EdAdd3.Text := ADODSCompany.FieldValues['COMP_ADD3'];
          EdPost.Text := ADODSCompany.FieldValues['COMP_POST'];
          EdTaxId.Text := ADODSCompany.FieldValues['COMP_TAX'];
          EdBranch.Text := ADODSCompany.FieldValues['COMP_BRANCH'];
          StabrCompany.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrCompany.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          EdComName.Text := '';
          numrec := 0;
          numallrec := ADODSCompany.RecordCount;
        end;
      end;
    'E': begin
        EdComName.Enabled := False;
        EdAdd1.Enabled := False;
        EdAdd2.Enabled := False;
        EdAdd3.Enabled := False;
        EdPost.Enabled := False;
        EdTaxId.Enabled := False;
        EdBranch.Enabled := False;
        itmdata[1] := Uppercase(Trim(EdComId.Text));
        with ADOCmdCompany do begin
          CommandText := 'SELECT * FROM COMPANY WHERE COMP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSCompany.Recordset := Execute;
        end;
        ADODSCompany.First;
        numrec := ADODSCompany.RecNo;
        numallrec := ADODSCompany.RecordCount;
        if numallrec <> 0 then begin
          EdComId.Text := ADODSCompany.FieldValues['COMP_ID'];
          EdComName.Text := ADODSCompany.FieldValues['COMP_NAME'];
          EdAdd1.Text := ADODSCompany.FieldValues['COMP_ADD1'];
          EdAdd2.Text := ADODSCompany.FieldValues['COMP_ADD2'];
          EdAdd3.Text := ADODSCompany.FieldValues['COMP_ADD3'];
          EdPost.Text := ADODSCompany.FieldValues['COMP_POST'];
          EdTaxId.Text := ADODSCompany.FieldValues['COMP_TAX'];
          EdBranch.Text := ADODSCompany.FieldValues['COMP_BRANCH'];
          StabrCompany.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrCompany.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          EdComName.Text := '';
          EdAdd1.Text := '';
          EdAdd2.Text := '';
          EdAdd3.Text := '';
          EdPost.Text := '';
          EdTaxId.Text := '';
          EdBranch.Text := '';
          numrec := 0;
          numallrec := ADODSCompany.RecordCount;
        end;
      end;
    'U': begin
        EdComName.Enabled := False;
        EdAdd1.Enabled := False;
        EdAdd2.Enabled := False;
        EdAdd3.Enabled := False;
        EdPost.Enabled := False;
        EdTaxId.Enabled := False;
        EdBranch.Enabled := False;
        itmdata[1] := Uppercase(Trim(EdComId.Text));
        with ADOCmdCompany do begin
          CommandText := 'SELECT * FROM COMPANY WHERE COMP_ID = :id';
          CommandType := cmdText;
          Parameters.ParamByName('id').Value := itmdata[1];
          ADODSCompany.Recordset := Execute;
        end;
        ADODSCompany.First;
        numrec := ADODSCompany.RecNo;
        numallrec := ADODSCompany.RecordCount;
        if numallrec <> 0 then begin
          EdComId.Text := ADODSCompany.FieldValues['COMP_ID'];
          EdComName.Text := ADODSCompany.FieldValues['COMP_NAME'];
          EdAdd1.Text := ADODSCompany.FieldValues['COMP_ADD1'];
          EdAdd2.Text := ADODSCompany.FieldValues['COMP_ADD2'];
          EdAdd3.Text := ADODSCompany.FieldValues['COMP_ADD3'];
          EdPost.Text := ADODSCompany.FieldValues['COMP_POST'];
          EdTaxId.Text := ADODSCompany.FieldValues['COMP_TAX'];
          EdBranch.Text := ADODSCompany.FieldValues['COMP_BRANCH'];
          StabrCompany.Panels[1].Text := ' พบข้อมูลที่ต้องการอยู่ในฐานข้อมูล';
          StabrCompany.Panels[2].Text := ' คำแนะนำ : กด Ok เพื่อ แก้ไขข้อมูล';
        end
        else begin
          EdComName.Text := '';
          EdAdd1.Text := '';
          EdAdd2.Text := '';
          EdAdd3.Text := '';
          EdPost.Text := '';
          EdTaxId.Text := '';
          EdBranch.Text := '';
          numrec := 0;
          numallrec := ADODSCompany.RecordCount;
        end;
      end;
  end;
end;

procedure TFrmCompany.BtbExitClick(Sender: TObject);
var reps: word;
begin
  reps := MessageDlg('คุณต้องการออกจากหน้าจอนี้ใช่หรือไม่', mtConfirmation, [mbYes, mbNo], 0);
  if reps = mrYes then close;
end;

end.
