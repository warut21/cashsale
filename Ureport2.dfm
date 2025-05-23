object FrmReport2: TFrmReport2
  Left = 46
  Top = 107
  Width = 800
  Height = 600
  Caption = #3626#3619#3640#3611#3585#3634#3619#3586#3634#3618#3611#3619#3632#3592#3635#3623#3633#3609
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
    Left = 249
    Top = 36
    Width = 173
    Height = 16
    Caption = #3619#3634#3618#3591#3634#3609#3626#3619#3640#3611#3585#3634#3619#3586#3634#3618#3611#3619#3632#3592#3635#3623#3633#3609#3607#3637#3656' :'
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
    Left = 332
    Top = 67
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
    Left = 412
    Top = 68
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
  object SpdBtn: TSpeedButton
    Left = 522
    Top = 34
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
    OnClick = SpdBtnClick
  end
  object MemoReport: TMemo
    Left = 8
    Top = 170
    Width = 777
    Height = 391
    TabStop = False
    Font.Charset = THAI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier MonoThai'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object BtnShow: TButton
    Left = 253
    Top = 113
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
    TabOrder = 0
    OnClick = BtnShowClick
  end
  object BtnPrint: TButton
    Left = 361
    Top = 113
    Width = 75
    Height = 25
    Caption = 'Print'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BtnPrintClick
  end
  object BtnClose: TButton
    Left = 464
    Top = 113
    Width = 75
    Height = 25
    Caption = 'Close'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BtnCloseClick
  end
  object Edit_1: TEdit
    Left = 424
    Top = 32
    Width = 89
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 10
    ParentFont = False
    TabOrder = 4
    Text = '00/00/0000'
    OnChange = Edit_1Change
    OnExit = Edit_1Exit
  end
end
