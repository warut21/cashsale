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
  WindowState = wsMaximized
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
      Top = 78
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
    object ProgressBar1: TProgressBar
      Left = 144
      Top = 76
      Width = 159
      Height = 21
      TabOrder = 2
    end
    object BtnLoad: TButton
      Left = 45
      Top = 74
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
  end
  object SaveDialog2: TSaveDialog
    DefaultExt = 'TXT'
    Filter = 'Text File (*.txt)|*.txt|All Files (*.*)|*.*'
    InitialDir = 'C:\CashSales\Application'
    Left = 16
    Top = 4
  end
end
