object FrmCompany: TFrmCompany
  Left = 255
  Top = 76
  Width = 635
  Height = 519
  Caption = #3586#3657#3629#3617#3641#3621#3610#3619#3636#3625#3633#3607
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object BvCompany: TBevel
    Left = 22
    Top = 64
    Width = 578
    Height = 380
  end
  object LblComId: TLabel
    Left = 70
    Top = 72
    Width = 57
    Height = 16
    Caption = #3619#3627#3633#3626#3610#3619#3636#3625#3633#3607
  end
  object LblComName: TLabel
    Left = 180
    Top = 72
    Width = 48
    Height = 16
    Caption = #3594#3639#3656#3629#3610#3619#3636#3625#3633#3607
  end
  object LblAdd1: TLabel
    Left = 60
    Top = 140
    Width = 65
    Height = 16
    Caption = #3607#3637#3656#3629#3618#3641#3656'1('#3606#3609#3609')'
  end
  object LblAdd2: TLabel
    Left = 60
    Top = 180
    Width = 62
    Height = 16
    Caption = #3607#3637#3656#3629#3618#3641#3656'2('#3648#3586#3605')'
  end
  object LblAdd3: TLabel
    Left = 60
    Top = 220
    Width = 80
    Height = 16
    Caption = #3607#3637#3656#3629#3618#3641#3656'3('#3592#3633#3591#3627#3623#3633#3604')'
  end
  object LblPost: TLabel
    Left = 60
    Top = 260
    Width = 71
    Height = 16
    Caption = #3619#3627#3633#3626#3652#3611#3619#3625#3603#3637#3618#3660
  end
  object LblTaxId: TLabel
    Left = 30
    Top = 300
    Width = 124
    Height = 16
    Caption = #3619#3627#3633#3626#3611#3619#3632#3592#3635#3605#3633#3623#3612#3641#3657#3648#3626#3637#3618#3616#3634#3625#3637
  end
  object EdComId: TEdit
    Left = 70
    Top = 98
    Width = 57
    Height = 24
    MaxLength = 4
    TabOrder = 0
    OnChange = EdComIdChange
  end
  object EdComName: TEdit
    Left = 180
    Top = 98
    Width = 393
    Height = 24
    MaxLength = 40
    TabOrder = 1
  end
  object EdAdd1: TEdit
    Left = 180
    Top = 140
    Width = 393
    Height = 24
    MaxLength = 25
    TabOrder = 2
  end
  object EdAdd2: TEdit
    Left = 180
    Top = 180
    Width = 393
    Height = 24
    MaxLength = 25
    TabOrder = 3
  end
  object EdAdd3: TEdit
    Left = 180
    Top = 220
    Width = 393
    Height = 24
    MaxLength = 25
    TabOrder = 4
  end
  object EdPost: TEdit
    Left = 180
    Top = 260
    Width = 140
    Height = 24
    MaxLength = 5
    TabOrder = 5
  end
  object EdTaxId: TEdit
    Left = 180
    Top = 300
    Width = 140
    Height = 24
    MaxLength = 10
    TabOrder = 6
  end
  object BtbOk: TBitBtn
    Left = 120
    Top = 350
    Width = 89
    Height = 33
    Caption = 'OK'
    Default = True
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
  object StabrCompany: TStatusBar
    Left = 0
    Top = 459
    Width = 627
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
  object ADODSCompany: TADODataSet
    Connection = FrmDataModule.ADOConnection
    DataSource = FrmDataModule.DataS_COMPANY
    Parameters = <>
    Left = 64
    Top = 328
  end
  object ADOCmdCompany: TADOCommand
    Connection = FrmDataModule.ADOConnection
    Parameters = <>
    Left = 64
    Top = 360
  end
  object ADOCmdBillH: TADOCommand
    Connection = FrmDataModule.ADOConnection
    Parameters = <>
    Left = 144
    Top = 400
  end
  object ADODSBillH: TADODataSet
    Connection = FrmDataModule.ADOConnection
    DataSource = FrmDataModule.DataS_BILL_HEAD
    Parameters = <>
    Left = 184
    Top = 400
  end
  object ADOCmdSalesman: TADOCommand
    Connection = FrmDataModule.ADOConnection
    Parameters = <>
    Left = 240
    Top = 400
  end
  object ADODSSalesman: TADODataSet
    Connection = FrmDataModule.ADOConnection
    DataSource = FrmDataModule.DataS_SALESMAN
    Parameters = <>
    Left = 280
    Top = 400
  end
end
