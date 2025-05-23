object FrmSalesman: TFrmSalesman
  Left = 205
  Top = 96
  Width = 634
  Height = 521
  Caption = #3586#3657#3629#3617#3641#3621#3614#3609#3633#3585#3591#3634#3609#3586#3634#3618
  Color = clGradientActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object BvCompany: TBevel
    Left = 22
    Top = 64
    Width = 578
    Height = 380
  end
  object LblComId: TLabel
    Left = 70
    Top = 75
    Width = 57
    Height = 16
    Caption = #3619#3627#3633#3626#3610#3619#3636#3625#3633#3607
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblSalesId: TLabel
    Left = 180
    Top = 75
    Width = 91
    Height = 16
    Caption = #3619#3627#3633#3626#3614#3609#3633#3585#3591#3634#3609#3586#3634#3618
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblSalesPass: TLabel
    Left = 332
    Top = 75
    Width = 47
    Height = 16
    Caption = #3619#3627#3633#3626#3612#3656#3634#3609
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblSalesName: TLabel
    Left = 60
    Top = 140
    Width = 82
    Height = 16
    Caption = #3594#3639#3656#3629#3614#3609#3633#3585#3591#3634#3609#3586#3634#3618
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblRole: TLabel
    Left = 68
    Top = 180
    Width = 63
    Height = 16
    Caption = #3585#3635#3627#3609#3604#3626#3636#3607#3608#3636
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblRegDate: TLabel
    Left = 52
    Top = 220
    Width = 87
    Height = 16
    Caption = #3623#3633#3609#3607#3637#3656#3610#3633#3609#3607#3638#3585#3586#3657#3629#3617#3641#3621
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblExpDate: TLabel
    Left = 54
    Top = 260
    Width = 87
    Height = 16
    Caption = #3623#3633#3609#3607#3637#3656#3618#3585#3648#3621#3636#3585#3586#3657#3629#3617#3641#3621
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SBRegDate: TSpeedButton
    Left = 325
    Top = 220
    Width = 23
    Height = 22
    Glyph.Data = {
      4E010000424D4E01000000000000760000002800000012000000120000000100
      040000000000D800000000000000000000001000000010000000000000000000
      BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333330000003333333333333333330000003338888888888888330000003304
      0404404040483300000033FFFFFFFFFFFF483300000033FFFFFFFFFFFF483300
      000033FF000F0007FF483300000033FFF0FF7F70FF483300000033FFF0FFFFF0
      FF483300000033FFF0FF0007FF483300000033FF00FF0FFFFF483300000033FF
      F0FF0000FF483300000033FFFFFFFFFFFF483300000033FFFFFFFFFFFF483300
      000033F7777777777F4833000000330000000000003333000000333333333333
      333333000000333333333333333333000000}
    OnClick = SBRegDateClick
  end
  object SBExpDate: TSpeedButton
    Left = 325
    Top = 260
    Width = 23
    Height = 22
    Glyph.Data = {
      4E010000424D4E01000000000000760000002800000012000000120000000100
      040000000000D800000000000000000000001000000010000000000000000000
      BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333330000003333333333333333330000003338888888888888330000003304
      0404404040483300000033FFFFFFFFFFFF483300000033FFFFFFFFFFFF483300
      000033FF000F0007FF483300000033FFF0FF7F70FF483300000033FFF0FFFFF0
      FF483300000033FFF0FF0007FF483300000033FF00FF0FFFFF483300000033FF
      F0FF0000FF483300000033FFFFFFFFFFFF483300000033FFFFFFFFFFFF483300
      000033F7777777777F4833000000330000000000003333000000333333333333
      333333000000333333333333333333000000}
    OnClick = SBExpDateClick
  end
  object EdSalesId: TEdit
    Left = 170
    Top = 95
    Width = 117
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 8
    ParentFont = False
    TabOrder = 1
    OnChange = EdSalesIdChange
  end
  object EdSalesPass: TEdit
    Left = 325
    Top = 95
    Width = 117
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 10
    ParentFont = False
    TabOrder = 2
  end
  object EdSalesName: TEdit
    Left = 170
    Top = 140
    Width = 393
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 30
    ParentFont = False
    TabOrder = 3
  end
  object EdRegDate: TEdit
    Left = 170
    Top = 220
    Width = 140
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 5
    ParentFont = False
    TabOrder = 5
  end
  object EdExpDate: TEdit
    Left = 170
    Top = 260
    Width = 140
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 10
    ParentFont = False
    TabOrder = 6
  end
  object BtbOk: TBitBtn
    Left = 120
    Top = 350
    Width = 89
    Height = 33
    Caption = 'OK'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = BtbOkClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BtbCancel: TBitBtn
    Left = 272
    Top = 350
    Width = 89
    Height = 33
    Cancel = True
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnClick = BtbCancelClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BtbExit: TBitBtn
    Left = 424
    Top = 350
    Width = 97
    Height = 33
    Caption = '&Exit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = BtbExitClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
      F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
      000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
      338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
      45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
      3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
      F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
      000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
      338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
      4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
      8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
      333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
      0000}
    NumGlyphs = 2
  end
  object RdgrpStatus: TRadioGroup
    Left = 22
    Top = 0
    Width = 578
    Height = 57
    Caption = #3626#3606#3634#3609#3632#3627#3609#3657#3634#3592#3629
    Color = clSkyBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 10
  end
  object RdbShow: TRadioButton
    Left = 56
    Top = 24
    Width = 100
    Height = 17
    Caption = #3649#3626#3604#3591#3586#3657#3629#3617#3641#3621
    Color = clSkyBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 11
    OnClick = RdbShowClick
  end
  object RdbInsert: TRadioButton
    Left = 184
    Top = 24
    Width = 100
    Height = 17
    Caption = #3648#3614#3636#3656#3617#3586#3657#3629#3617#3641#3621
    Color = clSkyBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 12
    OnClick = RdbInsertClick
  end
  object RdbDelete: TRadioButton
    Left = 320
    Top = 24
    Width = 100
    Height = 17
    Caption = #3621#3610#3586#3657#3629#3617#3641#3621
    Color = clSkyBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 13
    OnClick = RdbDeleteClick
  end
  object RdbUpdate: TRadioButton
    Left = 456
    Top = 24
    Width = 100
    Height = 17
    Caption = #3649#3585#3657#3652#3586#3586#3657#3629#3617#3641#3621
    Color = clSkyBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 14
    OnClick = RdbUpdateClick
  end
  object StabrSalesman: TStatusBar
    Left = 0
    Top = 461
    Width = 626
    Height = 33
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end>
    ParentShowHint = False
    ShowHint = True
  end
  object CbComId: TComboBox
    Left = 65
    Top = 95
    Width = 65
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 16
    MaxLength = 4
    ParentFont = False
    TabOrder = 0
    OnChange = CbComIdChange
    OnDropDown = CbComIdDropDown
  end
  object CbRole: TComboBox
    Left = 170
    Top = 180
    Width = 140
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 16
    MaxLength = 10
    ParentFont = False
    TabOrder = 4
    Items.Strings = (
      '1-Normal'
      '9-Administrator')
  end
  object ADODSSalesman: TADODataSet
    Connection = FrmDataModule.ADOConnection
    DataSource = FrmDataModule.DataS_SALESMAN
    Parameters = <>
    Left = 32
    Top = 304
  end
  object ADOCmdSalesman: TADOCommand
    Connection = FrmDataModule.ADOConnection
    Parameters = <>
    Left = 72
    Top = 304
  end
  object ADOCmdCompany: TADOCommand
    Connection = FrmDataModule.ADOConnection
    Parameters = <>
    Left = 72
    Top = 352
  end
  object ADODSCompany: TADODataSet
    Connection = FrmDataModule.ADOConnection
    DataSource = FrmDataModule.DataS_COMPANY
    Parameters = <>
    Left = 32
    Top = 352
  end
  object ADODSBillHcid: TADODataSet
    Connection = FrmDataModule.ADOConnection
    DataSource = FrmDataModule.DataS_BILL_HEAD
    Parameters = <>
    Left = 144
    Top = 400
  end
  object ADOCmdBillHcid: TADOCommand
    Connection = FrmDataModule.ADOConnection
    Parameters = <>
    Left = 184
    Top = 400
  end
  object ADOCmdBillHsid: TADOCommand
    Connection = FrmDataModule.ADOConnection
    Parameters = <>
    Left = 288
    Top = 400
  end
  object ADODSBillHsid: TADODataSet
    Connection = FrmDataModule.ADOConnection
    DataSource = FrmDataModule.DataS_BILL_HEAD
    Parameters = <>
    Left = 248
    Top = 400
  end
end
