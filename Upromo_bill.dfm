object FrmPROMOBILL: TFrmPROMOBILL
  Left = 214
  Top = 61
  Width = 664
  Height = 555
  Caption = #3648#3621#3639#3629#3585#3650#3611#3619#3650#3617#3594#3633#3656#3609
  Color = clGradientActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BvCompany: TBevel
    Left = 22
    Top = 16
    Width = 603
    Height = 457
  end
  object LbFGId: TLabel
    Left = 70
    Top = 32
    Width = 67
    Height = 16
    Caption = #3648#3621#3586#3607#3637#3656' Bill : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BtbOk: TBitBtn
    Left = 408
    Top = 430
    Width = 89
    Height = 33
    Caption = #3618#3639#3609#3618#3633#3609
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
  object StabrPROMO: TStatusBar
    Left = 0
    Top = 484
    Width = 648
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
  object Panel2: TPanel
    Left = 32
    Top = 69
    Width = 577
    Height = 348
    Color = clMedGray
    TabOrder = 1
    object ProDsc01: TLabel
      Left = 148
      Top = 35
      Width = 317
      Height = 20
      AutoSize = False
      Color = clScrollBar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Label49: TLabel
      Left = 32
      Top = 6
      Width = 109
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = #3619#3627#3633#3626#3650#3611#3619#3650#3617#3594#3633#3656#3609
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 8
      Top = 32
      Width = 25
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = '1.'
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 224
      Top = 6
      Width = 109
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = #3619#3634#3618#3621#3632#3648#3629#3637#3618#3604
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 476
      Top = 6
      Width = 69
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = #3611#3619#3636#3617#3634#3603
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 9
      Top = 136
      Width = 25
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = '2.'
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object ProDsc02: TLabel
      Left = 149
      Top = 139
      Width = 317
      Height = 20
      AutoSize = False
      Color = clScrollBar
      ParentColor = False
      Layout = tlCenter
    end
    object Label11: TLabel
      Left = 9
      Top = 240
      Width = 25
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = '3.'
      Color = clMedGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object ProDsc03: TLabel
      Left = 149
      Top = 243
      Width = 317
      Height = 20
      AutoSize = False
      Color = clScrollBar
      ParentColor = False
      Layout = tlCenter
    end
    object MatDsc11: TLabel
      Left = 164
      Top = 60
      Width = 273
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object MatPrc11: TLabel
      Left = 440
      Top = 60
      Width = 84
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Mat11: TLabel
      Left = 46
      Top = 60
      Width = 116
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Mat12: TLabel
      Left = 46
      Top = 83
      Width = 116
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object MatDsc12: TLabel
      Left = 164
      Top = 83
      Width = 273
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object MatPrc12: TLabel
      Left = 440
      Top = 83
      Width = 84
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Mat13: TLabel
      Left = 46
      Top = 106
      Width = 116
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object MatDsc13: TLabel
      Left = 164
      Top = 106
      Width = 273
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object MatPrc13: TLabel
      Left = 440
      Top = 106
      Width = 84
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Mat21: TLabel
      Left = 46
      Top = 164
      Width = 116
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object MatDsc21: TLabel
      Left = 164
      Top = 164
      Width = 273
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object MatPrc21: TLabel
      Left = 440
      Top = 164
      Width = 84
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Mat22: TLabel
      Left = 46
      Top = 187
      Width = 116
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Mat23: TLabel
      Left = 46
      Top = 210
      Width = 116
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object MatDsc23: TLabel
      Left = 164
      Top = 210
      Width = 273
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object MatDsc22: TLabel
      Left = 164
      Top = 187
      Width = 273
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object MatPrc22: TLabel
      Left = 440
      Top = 187
      Width = 84
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object MatPrc23: TLabel
      Left = 440
      Top = 210
      Width = 84
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Mat31: TLabel
      Left = 46
      Top = 268
      Width = 116
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object MatDsc31: TLabel
      Left = 164
      Top = 268
      Width = 273
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object MatPrc31: TLabel
      Left = 440
      Top = 268
      Width = 84
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Mat32: TLabel
      Left = 46
      Top = 291
      Width = 116
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Mat33: TLabel
      Left = 46
      Top = 314
      Width = 116
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object MatDsc33: TLabel
      Left = 164
      Top = 314
      Width = 273
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object MatDsc32: TLabel
      Left = 164
      Top = 291
      Width = 273
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object MatPrc32: TLabel
      Left = 440
      Top = 291
      Width = 84
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object MatPrc33: TLabel
      Left = 440
      Top = 314
      Width = 84
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Line11: TLabel
      Left = 526
      Top = 60
      Width = 25
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Line12: TLabel
      Left = 526
      Top = 83
      Width = 25
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Line13: TLabel
      Left = 526
      Top = 106
      Width = 25
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Line21: TLabel
      Left = 526
      Top = 164
      Width = 25
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Line22: TLabel
      Left = 526
      Top = 187
      Width = 25
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Line23: TLabel
      Left = 526
      Top = 210
      Width = 25
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Line31: TLabel
      Left = 526
      Top = 268
      Width = 25
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Line32: TLabel
      Left = 526
      Top = 291
      Width = 25
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Line33: TLabel
      Left = 526
      Top = 314
      Width = 25
      Height = 20
      AutoSize = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
  end
  object ProNo01: TComboBox
    Left = 62
    Top = 102
    Width = 110
    Height = 21
    ItemHeight = 13
    MaxLength = 10
    Sorted = True
    TabOrder = 2
    OnClick = ProNo01Click
    OnExit = ProNo01Exit
  end
  object BILLNO: TEdit
    Left = 158
    Top = 28
    Width = 121
    Height = 28
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object ProQty01: TEdit
    Tag = 1
    Left = 502
    Top = 99
    Width = 80
    Height = 24
    AutoSize = False
    Color = clCream
    TabOrder = 3
    OnExit = ProQty01Exit
  end
  object ProNo02: TComboBox
    Left = 63
    Top = 206
    Width = 110
    Height = 21
    ItemHeight = 13
    MaxLength = 10
    Sorted = True
    TabOrder = 4
    OnClick = ProNo02Click
    OnExit = ProNo02Exit
  end
  object ProQty02: TEdit
    Tag = 1
    Left = 503
    Top = 204
    Width = 80
    Height = 24
    AutoSize = False
    Color = clCream
    TabOrder = 5
    OnExit = ProQty02Exit
  end
  object ProNo03: TComboBox
    Left = 63
    Top = 310
    Width = 110
    Height = 21
    ItemHeight = 13
    MaxLength = 10
    Sorted = True
    TabOrder = 6
    OnClick = ProNo03Click
    OnExit = ProNo03Exit
  end
  object ProQty03: TEdit
    Tag = 1
    Left = 503
    Top = 308
    Width = 80
    Height = 24
    AutoSize = False
    Color = clCream
    TabOrder = 7
    OnExit = ProQty03Exit
  end
  object BtbExit: TBitBtn
    Left = 512
    Top = 430
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
end
