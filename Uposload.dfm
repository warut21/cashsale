object FrmLoadtxt: TFrmLoadtxt
  Left = 199
  Top = 121
  Width = 800
  Height = 600
  BorderIcons = [biMinimize, biMaximize]
  Caption = 'LOAD '#3586#3657#3629#3617#3641#3621#3648#3586#3657#3634' SAP'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MemoHead: TMemo
    Left = 224
    Top = 456
    Width = 105
    Height = 57
    TabStop = False
    TabOrder = 1
    Visible = False
  end
  object MemoDet: TMemo
    Left = 504
    Top = 448
    Width = 105
    Height = 57
    TabStop = False
    TabOrder = 2
    Visible = False
  end
  object Panel1: TPanel
    Left = 168
    Top = 178
    Width = 457
    Height = 217
    BevelInner = bvLowered
    Color = clSkyBlue
    TabOrder = 0
    object Label1: TLabel
      Left = 320
      Top = 110
      Width = 93
      Height = 16
      Caption = 'COMPLETED'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 198
      Top = 32
      Width = 61
      Height = 16
      Caption = #3650#3627#3621#3604#3586#3657#3629#3617#3641#3621
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object SpdBtn: TSpeedButton
      Left = 308
      Top = 62
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
    object Label3: TLabel
      Left = 36
      Top = 62
      Width = 144
      Height = 16
      Alignment = taCenter
      Caption = #3623#3633#3609#3607#3637#3656#3605#3657#3629#3591#3585#3634#3619' load  ('#3588'.'#3624'.)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ProgressBar1: TProgressBar
      Left = 144
      Top = 108
      Width = 159
      Height = 21
      TabOrder = 2
    end
    object BtnLoad: TButton
      Left = 45
      Top = 106
      Width = 75
      Height = 25
      Caption = 'LOAD'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BtnLoadClick
    end
    object BtnClose: TButton
      Left = 191
      Top = 138
      Width = 75
      Height = 25
      Caption = 'Close'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BtnCloseClick
    end
    object DateSales: TEdit
      Left = 194
      Top = 60
      Width = 89
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
      Text = '00/00/0000'
    end
  end
  object SaveDialog2: TSaveDialog
    DefaultExt = 'TXT'
    Filter = 'Text File (*.txt)|*.txt|All Files (*.*)|*.*'
    InitialDir = 'C:\CashSales\load_textfile'
    Left = 16
    Top = 4
  end
end
