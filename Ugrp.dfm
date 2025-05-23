object FrmPrdGrp: TFrmPrdGrp
  Left = 191
  Top = 138
  Width = 634
  Height = 519
  Caption = #3586#3657#3629#3617#3641#3621#3585#3621#3640#3656#3617#3626#3636#3609#3588#3657#3634
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object BvCompany: TBevel
    Left = 22
    Top = 64
    Width = 578
    Height = 380
  end
  object LblPrdGrpId: TLabel
    Left = 70
    Top = 72
    Width = 77
    Height = 16
    Caption = #3619#3627#3633#3626#3585#3621#3640#3656#3617#3626#3636#3609#3588#3657#3634
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblGrpNameT: TLabel
    Left = 180
    Top = 72
    Width = 122
    Height = 16
    Caption = #3594#3639#3656#3629#3585#3621#3640#3656#3617#3626#3636#3609#3588#3657#3634' '#3616#3634#3625#3634#3652#3607#3618
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblGrpNameE: TLabel
    Left = 180
    Top = 140
    Width = 136
    Height = 16
    Caption = #3594#3639#3656#3629#3585#3621#3640#3656#3617#3626#3636#3609#3588#3657#3634' '#3616#3634#3625#3634#3629#3633#3591#3585#3620#3625
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
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
    TabOrder = 0
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
    TabOrder = 1
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
    TabOrder = 2
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
    TabOrder = 3
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
    TabOrder = 4
    OnClick = RdbUpdateClick
  end
  object EdPrdGrpId: TEdit
    Left = 70
    Top = 98
    Width = 57
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 2
    ParentFont = False
    TabOrder = 5
    OnChange = EdPrdGrpIdChange
  end
  object EdGrpNameT: TEdit
    Left = 180
    Top = 98
    Width = 393
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 50
    ParentFont = False
    TabOrder = 6
  end
  object EdGrpNameE: TEdit
    Left = 180
    Top = 164
    Width = 393
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 50
    ParentFont = False
    TabOrder = 7
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
    TabOrder = 8
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
    TabOrder = 9
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
    TabOrder = 10
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
  object StabrPrdGrp: TStatusBar
    Left = 0
    Top = 458
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
  object ADODSPrdGrp: TADODataSet
    Connection = FrmDataModule.ADOConnection
    DataSource = FrmDataModule.DataS_PRODGROUP
    Parameters = <>
    Left = 64
    Top = 328
  end
  object ADOCmdPrdGrp: TADOCommand
    Connection = FrmDataModule.ADOConnection
    Parameters = <>
    Left = 64
    Top = 360
  end
  object ADOCmdFG: TADOCommand
    Connection = FrmDataModule.ADOConnection
    Parameters = <>
    Left = 64
    Top = 280
  end
  object ADODSFG: TADODataSet
    Connection = FrmDataModule.ADOConnection
    DataSource = FrmDataModule.DataS_FINISH_GOODS
    Parameters = <>
    Left = 64
    Top = 240
  end
end
