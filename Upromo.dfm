object FrmPROMO: TFrmPROMO
  Left = 307
  Top = 147
  Width = 637
  Height = 330
  Caption = #3586#3657#3629#3617#3641#3621#3650#3611#3619#3650#3617#3594#3633#3656#3609
  Color = clGradientActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object BvCompany: TBevel
    Left = 22
    Top = 16
    Width = 578
    Height = 225
  end
  object LbFGId: TLabel
    Left = 38
    Top = 32
    Width = 83
    Height = 16
    Caption = #3619#3627#3633#3626#3650#3611#3619#3650#3617#3594#3633#3656#3609'  :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BtbOk: TBitBtn
    Left = 48
    Top = 190
    Width = 89
    Height = 33
    Caption = #3610#3633#3609#3607#3638#3585
    DragCursor = crDefault
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
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
    Left = 288
    Top = 190
    Width = 89
    Height = 33
    Cancel = True
    Caption = #3618#3585#3648#3621#3636#3585
    DragCursor = crDefault
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
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
    Left = 488
    Top = 190
    Width = 97
    Height = 33
    Caption = '&Exit'
    DragCursor = crDefault
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
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
  object StabrPROMO: TStatusBar
    Left = 0
    Top = 258
    Width = 621
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
    Top = 61
    Width = 561
    Height = 116
    Color = clMedGray
    TabOrder = 2
    object FGDES01: TLabel
      Left = 172
      Top = 32
      Width = 300
      Height = 25
      AutoSize = False
      Color = clGradientActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object FGDES02: TLabel
      Left = 172
      Top = 56
      Width = 300
      Height = 25
      AutoSize = False
      Color = clGradientActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object FGDES03: TLabel
      Left = 172
      Top = 80
      Width = 300
      Height = 25
      AutoSize = False
      Color = clGradientActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object Label49: TLabel
      Left = 32
      Top = 8
      Width = 109
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = #3619#3627#3633#3626#3626#3636#3609#3588#3657#3634
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
    object Label50: TLabel
      Left = 174
      Top = 8
      Width = 291
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = #3594#3639#3656#3629#3626#3636#3609#3588#3657#3634
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
    object Label9: TLabel
      Left = 474
      Top = 8
      Width = 79
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = #3619#3634#3588#3634'/'#3627#3609#3656#3623#3618
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
      Caption = '1'
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
    object Label2: TLabel
      Left = 8
      Top = 56
      Width = 25
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = '2'
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
    object Label3: TLabel
      Left = 8
      Top = 80
      Width = 25
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = '3'
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
    object FGPRC01: TEdit
      Tag = 1
      Left = 470
      Top = 32
      Width = 80
      Height = 24
      AutoSize = False
      Color = clCream
      TabOrder = 1
      OnExit = FGPRC01Exit
    end
    object FGPRC02: TEdit
      Tag = 2
      Left = 470
      Top = 56
      Width = 80
      Height = 24
      AutoSize = False
      Color = clCream
      TabOrder = 3
      OnExit = FGPRC02Exit
    end
    object FGPRC03: TEdit
      Tag = 3
      Left = 470
      Top = 80
      Width = 80
      Height = 24
      AutoSize = False
      Color = clCream
      TabOrder = 5
      OnExit = FGPRC03Exit
    end
    object FGID01: TComboBox
      Left = 32
      Top = 32
      Width = 137
      Height = 21
      ItemHeight = 13
      MaxLength = 18
      TabOrder = 0
      OnClick = FGID01Click
      OnExit = FGID01Exit
    end
    object FGID02: TComboBox
      Left = 32
      Top = 56
      Width = 137
      Height = 21
      ItemHeight = 13
      MaxLength = 18
      TabOrder = 2
      OnClick = FGID02Click
      OnExit = FGID02Exit
    end
    object FGID03: TComboBox
      Left = 32
      Top = 80
      Width = 137
      Height = 21
      ItemHeight = 13
      MaxLength = 18
      TabOrder = 4
      OnClick = FGID03Click
      OnExit = FGID03Exit
    end
  end
  object PromoNo: TComboBox
    Left = 134
    Top = 29
    Width = 110
    Height = 21
    ItemHeight = 13
    MaxLength = 10
    TabOrder = 0
    OnClick = PromoNoClick
    OnExit = PromoNoExit
  end
  object PromoDesc: TEdit
    Tag = 1
    Left = 246
    Top = 27
    Width = 339
    Height = 24
    AutoSize = False
    Color = clCream
    MaxLength = 40
    TabOrder = 1
    OnExit = PromoDescExit
  end
  object BtbDelete: TBitBtn
    Left = 168
    Top = 190
    Width = 89
    Height = 33
    Caption = #3621#3610
    DragCursor = crDefault
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = BtbDeleteClick
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
end
