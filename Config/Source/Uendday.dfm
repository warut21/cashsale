object FrmEndday: TFrmEndday
  Left = 149
  Top = 104
  Width = 800
  Height = 600
  Caption = #3618#3585#3618#3629#3604#3626#3636#3657#3609#3623#3633#3609
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 178
    Top = 139
    Width = 436
    Height = 294
    BevelInner = bvLowered
    Color = clBtnHighlight
    TabOrder = 0
    object Label1: TLabel
      Left = 153
      Top = 72
      Width = 131
      Height = 24
      Caption = #3618#3585#3618#3629#3604' '#3603' '#3626#3636#3657#3609#3623#3633#3609
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 94
      Top = 139
      Width = 248
      Height = 20
      Caption = #3588#3640#3603#3605#3657#3629#3591#3585#3634#3619#3618#3585#3618#3629#3604' '#3603' '#3626#3636#3657#3609#3623#3633#3609#3651#3594#3656#3627#3619#3639#3629#3652#3617#3656
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BtnOK: TButton
      Left = 141
      Top = 216
      Width = 57
      Height = 25
      Caption = 'YES'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BtnOKClick
    end
    object BtnCancel: TButton
      Left = 237
      Top = 216
      Width = 57
      Height = 25
      Caption = 'NO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BtnCancelClick
    end
  end
end
