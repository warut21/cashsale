object FrmLogon: TFrmLogon
  Left = 173
  Top = 87
  Width = 800
  Height = 600
  Align = alCustom
  BorderIcons = [biMinimize, biMaximize]
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 32
    Top = 24
    Width = 729
    Height = 521
    BevelInner = bvLowered
    Color = clGradientInactiveCaption
    TabOrder = 0
    object Label1: TLabel
      Left = 180
      Top = 150
      Width = 84
      Height = 16
      Alignment = taCenter
      Caption = #3623#3633#3609#3607#3637#3656#3586#3634#3618' ('#3588'.'#3624'.)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 180
      Top = 198
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
    object Label4: TLabel
      Left = 180
      Top = 302
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
    object Label5: TLabel
      Left = 180
      Top = 350
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
    object LabelComp_name: TLabel
      Left = 304
      Top = 246
      Width = 249
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label3: TLabel
      Left = 180
      Top = 246
      Width = 48
      Height = 16
      Caption = #3594#3639#3656#3629#3610#3619#3636#3625#3633#3607
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 48
      Top = 48
      Width = 649
      Height = 65
      Alignment = taCenter
      AutoSize = False
      Caption = #3619#3632#3610#3610' Point of Sales'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object SpdBtn: TSpeedButton
      Left = 404
      Top = 150
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
    object EdtSales_id: TEdit
      Left = 306
      Top = 301
      Width = 100
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 8
      ParentFont = False
      TabOrder = 1
      OnEnter = EdtSales_idEnter
      OnKeyPress = EdtSales_idKeyPress
    end
    object EdtSales_pass: TEdit
      Left = 306
      Top = 349
      Width = 100
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 10
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 2
      OnEnter = EdtSales_passEnter
      OnKeyPress = EdtSales_passKeyPress
    end
    object Panel2: TPanel
      Left = 392
      Top = 416
      Width = 69
      Height = 40
      BevelInner = bvLowered
      Color = clTeal
      TabOrder = 4
      object Button2: TButton
        Left = 8
        Top = 8
        Width = 54
        Height = 25
        Caption = 'Close'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = Button2Click
      end
    end
    object EdtComp_id: TEdit
      Left = 306
      Top = 197
      Width = 47
      Height = 24
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 4
      ParentFont = False
      TabOrder = 0
      OnKeyPress = EdtComp_idKeyPress
    end
    object Panel3: TPanel
      Left = 256
      Top = 416
      Width = 69
      Height = 40
      BevelInner = bvLowered
      Color = clTeal
      TabOrder = 3
      object btt_logon: TButton
        Left = 7
        Top = 7
        Width = 54
        Height = 25
        Caption = 'Logon'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btt_logonClick
      end
    end
    object DateSales: TEdit
      Left = 306
      Top = 148
      Width = 89
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 10
      ParentFont = False
      TabOrder = 5
      Text = '00/00/0000'
    end
  end
end
