unit Udatamodule;

interface

uses
  SysUtils, Classes, DB, ADODB, Variants;

type
  TFrmDataModule = class(TDataModule)

    ADOConnection: TADOConnection;
    ADOT_BILL_HEAD: TADOTable;
    DataS_BILL_HEAD: TDataSource;
    ADOT_BILL_DETAIL: TADOTable;
    DataS_BILL_DETAIL: TDataSource;
    ADOT_COMPANY: TADOTable;
    DataS_COMPANY: TDataSource;
    ADOT_CONTROL: TADOTable;
    DataS_CONTROL: TDataSource;
    ADOT_CUSTOMER: TADOTable;
    ADOT_FINISH_GOODS: TADOTable;
    ADOT_PRODGROUP: TADOTable;
    ADOT_SALESMAN: TADOTable;
    ADOT_UNITS: TADOTable;
    DataS_UNITS: TDataSource;
    DataS_FINISH_GOODS: TDataSource;
    DataS_PRODGROUP: TDataSource;
    DataS_SALESMAN: TDataSource;
    DataS_CUSTOMER: TDataSource;
    ADOQuery1: TADOQuery;
    ADOQuery5: TADOQuery;
    ADOQuery2: TADOQuery;
    ADOQuery3: TADOQuery;
    ADOQuery4: TADOQuery;
    ADOQuery0: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public

    Curr_bill_num: string;
    app_dir,app_sql : string;
    procedure EXE_SQL(var Q: TADOQuery; S,F: string);
    procedure SQL_Q(var Q: TADOQuery; S,F: string);
    function Ck_null(X: variant): string;
    { Public declarations }
  end;

var
  FrmDataModule: TFrmDataModule;

const CK_Version = '2.5';

implementation

{$R *.dfm}

procedure TFrmDataModule.EXE_SQL(var Q: TADOQuery; S,F: string);
begin
  Q.Close;
  Q.SQL.Clear;
  Q.SQL.Add(s);
  Q.SQL.SaveToFile(F);
  Q.ExecSQL;
end;

procedure TFrmDataModule.SQL_Q(var Q: TADOQuery; S,F: string);
begin
  Q.Close;
  Q.SQL.Clear;
  Q.SQL.Add(s);
  Q.SQL.SaveToFile(F);
  Q.open;
end;


procedure TFrmDataModule.DataModuleCreate(Sender: TObject);
begin
  ShortDateFormat := 'dd/mm/yyyy';
end;

function TFrmDataModule.Ck_null(X: variant): string;
begin
  if VarIsnull(X) then result := ''
  else if VarIsEmpty(X) then result := ''
  else result := X;
end;

end.
