object FrmDataModule: TFrmDataModule
  OldCreateOrder = False
  Left = 216
  Top = 172
  Height = 401
  Width = 702
  object ADOConnection: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=C:\Ca' +
      'shSales\Database\billcash.mdb;Mode=Share Deny None;Extended Prop' +
      'erties="";Persist Security Info=False;Jet OLEDB:System database=' +
      '"";Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";Jet' +
      ' OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mode=1;Jet OLEDB' +
      ':Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;' +
      'Jet OLEDB:New Database Password="";Jet OLEDB:Create System Datab' +
      'ase=False;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don'#39't Copy ' +
      'Locale on Compact=False;Jet OLEDB:Compact Without Replica Repair' +
      '=False;Jet OLEDB:SFP=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 40
    Top = 16
  end
  object ADOT_BILL_HEAD: TADOTable
    Connection = ADOConnection
    CursorType = ctStatic
    TableName = 'BILL_HEAD'
    Left = 144
    Top = 16
  end
  object DataS_BILL_HEAD: TDataSource
    DataSet = ADOT_BILL_HEAD
    Left = 144
    Top = 72
  end
  object ADOT_BILL_DETAIL: TADOTable
    Connection = ADOConnection
    CursorType = ctStatic
    TableName = 'BILL_DETAIL'
    Left = 264
    Top = 16
  end
  object DataS_BILL_DETAIL: TDataSource
    DataSet = ADOT_BILL_DETAIL
    Left = 264
    Top = 72
  end
  object ADOT_COMPANY: TADOTable
    Connection = ADOConnection
    CursorType = ctStatic
    LockType = ltReadOnly
    TableName = 'COMPANY'
    Left = 374
    Top = 16
  end
  object DataS_COMPANY: TDataSource
    DataSet = ADOT_COMPANY
    Left = 374
    Top = 72
  end
  object ADOT_CONTROL: TADOTable
    Connection = ADOConnection
    CursorType = ctStatic
    TableName = 'CONTROL'
    Left = 488
    Top = 16
  end
  object DataS_CONTROL: TDataSource
    DataSet = ADOT_CONTROL
    Left = 488
    Top = 72
  end
  object ADOT_CUSTOMER: TADOTable
    Connection = ADOConnection
    CursorType = ctStatic
    TableName = 'CUSTOMER'
    Left = 608
    Top = 16
  end
  object ADOT_FINISH_GOODS: TADOTable
    Connection = ADOConnection
    CursorType = ctStatic
    TableName = 'FINISH_GOODS'
    Left = 264
    Top = 128
  end
  object ADOT_PRODGROUP: TADOTable
    Connection = ADOConnection
    CursorType = ctStatic
    TableName = 'PRODGROUP'
    Left = 384
    Top = 128
  end
  object ADOT_SALESMAN: TADOTable
    Connection = ADOConnection
    CursorType = ctStatic
    TableName = 'SALESMAN'
    Left = 496
    Top = 128
  end
  object ADOT_UNITS: TADOTable
    Connection = ADOConnection
    CursorType = ctStatic
    TableName = 'UNITS'
    Left = 608
    Top = 128
  end
  object DataS_UNITS: TDataSource
    DataSet = ADOT_UNITS
    Left = 608
    Top = 184
  end
  object DataS_FINISH_GOODS: TDataSource
    DataSet = ADOT_FINISH_GOODS
    Left = 264
    Top = 184
  end
  object DataS_PRODGROUP: TDataSource
    DataSet = ADOT_PRODGROUP
    Left = 384
    Top = 184
  end
  object DataS_SALESMAN: TDataSource
    DataSet = ADOT_SALESMAN
    Left = 496
    Top = 184
  end
  object DataS_CUSTOMER: TDataSource
    DataSet = ADOT_CUSTOMER
    Left = 608
    Top = 72
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    Left = 272
    Top = 264
  end
  object ADOQuery5: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    Left = 544
    Top = 264
  end
  object ADOQuery2: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    Left = 328
    Top = 264
  end
  object ADOQuery3: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    Left = 392
    Top = 264
  end
  object ADOQuery4: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    Left = 464
    Top = 264
  end
  object ADOQuery0: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    Left = 200
    Top = 264
  end
end
