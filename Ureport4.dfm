object FrmReport4: TFrmReport4
  Left = 186
  Top = 107
  Width = 800
  Height = 600
  Caption = #3619#3634#3618#3591#3634#3609#3651#3610' INVOICE '#3619#3623#3617
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 252
    Top = 36
    Width = 146
    Height = 16
    Caption = #3619#3634#3618#3591#3634#3609#3651#3610' INVOICE '#3619#3623#3617
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelComp: TLabel
    Left = 192
    Top = 8
    Width = 409
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 410
    Top = 36
    Width = 69
    Height = 16
    Caption = #3611#3619#3632#3592#3635#3648#3588#3619#3639#3656#3629#3591
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 490
    Top = 37
    Width = 49
    Height = 13
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 214
    Top = 76
    Width = 79
    Height = 16
    Caption = #3648#3621#3586#3607#3637#3656#3610#3636#3621#3648#3619#3636#3656#3617#3605#3657#3609
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 401
    Top = 76
    Width = 82
    Height = 16
    Caption = #3648#3621#3586#3607#3637#3656#3610#3636#3621#3626#3640#3604#3607#3657#3634#3618
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Lbls: TLabel
    Left = 303
    Top = 77
    Width = 31
    Height = 16
    Alignment = taRightJustify
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Lble: TLabel
    Left = 493
    Top = 77
    Width = 31
    Height = 16
    Alignment = taRightJustify
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object MemoReport: TMemo
    Left = 7
    Top = 180
    Width = 778
    Height = 381
    TabStop = False
    Font.Charset = THAI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier MonoThai'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 5
  end
  object BtnShow: TButton
    Left = 190
    Top = 125
    Width = 75
    Height = 25
    Caption = 'Preview'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BtnShowClick
  end
  object BtnPrint: TButton
    Left = 370
    Top = 125
    Width = 103
    Height = 25
    Caption = 'PrintBill '#3607#3640#3585#3651#3610
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = BtnPrintClick
  end
  object BtnClose: TButton
    Left = 488
    Top = 125
    Width = 75
    Height = 25
    Caption = 'Close'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = BtnCloseClick
  end
  object Edit1: TEdit
    Left = 338
    Top = 74
    Width = 47
    Height = 24
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 5
    ParentFont = False
    TabOrder = 0
    OnChange = Edit1Change
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 529
    Top = 74
    Width = 48
    Height = 24
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 5
    ParentFont = False
    TabOrder = 1
    OnChange = Edit2Change
    OnEnter = Edit2Enter
    OnKeyPress = Edit2KeyPress
  end
  object Button1: TButton
    Left = 280
    Top = 126
    Width = 75
    Height = 25
    Caption = 'Print'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = Button1Click
  end
end
