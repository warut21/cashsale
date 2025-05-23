unit Udatamodule;

interface

uses
  SysUtils, Classes, DB, ADODB;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDataModule: TFrmDataModule;

implementation

{$R *.dfm}

end.
