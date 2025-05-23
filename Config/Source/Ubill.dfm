object FrmBill: TFrmBill
  Left = 197
  Top = 116
  Width = 800
  Height = 600
  Caption = 'Billing'
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    00000000FFFFFF0000000000000000000000000F333333F00000000000000000
    000000F3BBBBBB3FFFFFFFF00000000000000F3BBBBBBBB3F000000FFF000000
    0000F3BBB0000BBB3F33333000F00000000F3BBB0BBBB0BBB3F33333330F0000
    000F3BBBBBBBBBBBB3F00003330F0000000F3BBBBBBBBBBBB3F33330000F0000
    000F3BBBB0BB0BBBB3F33333330F0000FFFF3BBBB0BB0BBBB3F00003330F000F
    DDDDF3BBBBBBBBBB3F333330000F000FDDDDDF3BBBBBBBB3F3333333330F00FF
    FFFDDFF3BBBBBB3F00000003330F0F0033FDDFFF333333F0BBBBBBB0000FF033
    33FDDFFDFFFFFFBBBBBBBBBBBB0FF03330FDDFFDDFDDF000BBBBBBB000F0F000
    03FDDFFDDFDDFFFF0000000FFF00F03333FDDFFDDFDDFFFDFFFFFFF0F000F033
    30FDDFFDDFDDFDDDF0003330F000F0000BFDDDDDDDDDDDDF33330000F000F0BB
    BBFDDDDDDDDDDFF333333330F000F0BBBBFDDFFDDFDDDDDF00003330F0000F00
    0BFDDFFDDFDDFDDF33330000F00000FFF0FDDFFDDFDDFFDDF3333330F0000000
    0FFDDFFDDFDDFFDDF0003330F000000000FDDFFDDFDDFDDDFBBB0000F0000000
    FFFDDFFDDFDDDDDFBBBBBBB0F000000FDDDDDDDDDDDDDDFBBBBBBBB0F000000F
    DDDDDDDDDDDDDFBBBBBB000F00000000FFFFFFFDDFDDF0000000FFF000000000
    000000FDDFDDFFFFFFFF0000000000000000000FF0FF0000000000000000FFF0
    3FFFFFE01FFFFFC0001FFF800003FF000001FE000000FE000000FE000000FE00
    0000F0000000E0000000E0000000C00000008000000000000000000000010000
    0003000000070000000700000007000000070000000780000007C0000007F800
    0007FC000007F0000007E0000007E000000FF000001FFFC000FFFFE4FFFF}
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 792
    Height = 553
    BevelOuter = bvNone
    Color = clSkyBlue
    TabOrder = 0
    object LabelComp_name: TLabel
      Left = 8
      Top = 16
      Width = 778
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Transparent = True
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 625
      Top = 16
      Width = 57
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Caption = #3623#3633#3609#3607#3637#3656
      Font.Charset = THAI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Microsoft Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object LabelDate: TLabel
      Left = 696
      Top = 15
      Width = 81
      Height = 18
      Alignment = taCenter
      AutoSize = False
      Color = clCaptionText
      Font.Charset = THAI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Microsoft Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 50
      Top = 54
      Width = 68
      Height = 23
      AutoSize = False
      Caption = #3648#3621#3586#3607#3637#3656#3648#3629#3585#3626#3634#3619
      Transparent = True
      Layout = tlCenter
    end
    object LabelBill_No: TLabel
      Left = 138
      Top = 54
      Width = 129
      Height = 23
      AutoSize = False
      Transparent = True
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 313
      Top = 54
      Width = 53
      Height = 23
      AutoSize = False
      Caption = #3619#3627#3633#3626#3621#3641#3585#3588#3657#3634
      Transparent = True
      Layout = tlCenter
    end
    object LabelCust_name: TLabel
      Left = 497
      Top = 54
      Width = 280
      Height = 23
      AutoSize = False
      Layout = tlCenter
    end
    object EdtCust_ID: TEdit
      Left = 385
      Top = 55
      Width = 97
      Height = 24
      Color = clCaptionText
      MaxLength = 8
      TabOrder = 0
      OnExit = EdtCust_IDExit
      OnKeyPress = EdtCust_IDKeyPress
    end
    object Panel2: TPanel
      Left = 11
      Top = 100
      Width = 769
      Height = 355
      Color = clMedGray
      TabOrder = 1
      object Lblmat_des1: TLabel
        Left = 236
        Top = 32
        Width = 116
        Height = 25
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_des2: TLabel
        Left = 236
        Top = 56
        Width = 116
        Height = 25
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_des3: TLabel
        Left = 236
        Top = 80
        Width = 116
        Height = 25
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_des4: TLabel
        Left = 236
        Top = 104
        Width = 116
        Height = 25
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_des5: TLabel
        Left = 236
        Top = 128
        Width = 116
        Height = 25
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_des6: TLabel
        Left = 236
        Top = 152
        Width = 116
        Height = 25
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_des7: TLabel
        Left = 236
        Top = 176
        Width = 116
        Height = 25
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_des8: TLabel
        Left = 236
        Top = 200
        Width = 116
        Height = 25
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_des9: TLabel
        Left = 236
        Top = 224
        Width = 116
        Height = 25
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_des10: TLabel
        Left = 236
        Top = 248
        Width = 116
        Height = 25
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_price1: TLabel
        Left = 353
        Top = 32
        Width = 100
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_price2: TLabel
        Left = 353
        Top = 56
        Width = 100
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_price3: TLabel
        Left = 353
        Top = 80
        Width = 100
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_price4: TLabel
        Left = 353
        Top = 104
        Width = 100
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_price5: TLabel
        Left = 353
        Top = 128
        Width = 100
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_price6: TLabel
        Left = 353
        Top = 152
        Width = 100
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_price7: TLabel
        Left = 353
        Top = 176
        Width = 100
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_price8: TLabel
        Left = 353
        Top = 200
        Width = 100
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_price9: TLabel
        Left = 353
        Top = 224
        Width = 100
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_price10: TLabel
        Left = 353
        Top = 248
        Width = 100
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_unit1: TLabel
        Left = 557
        Top = 32
        Width = 47
        Height = 25
        Alignment = taCenter
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_unit2: TLabel
        Left = 557
        Top = 56
        Width = 47
        Height = 25
        Alignment = taCenter
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_unit3: TLabel
        Left = 557
        Top = 80
        Width = 47
        Height = 25
        Alignment = taCenter
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_unit4: TLabel
        Left = 557
        Top = 104
        Width = 47
        Height = 25
        Alignment = taCenter
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_unit5: TLabel
        Left = 557
        Top = 128
        Width = 47
        Height = 25
        Alignment = taCenter
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_unit6: TLabel
        Left = 557
        Top = 152
        Width = 47
        Height = 25
        Alignment = taCenter
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_unit7: TLabel
        Left = 557
        Top = 176
        Width = 47
        Height = 25
        Alignment = taCenter
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_unit8: TLabel
        Left = 557
        Top = 200
        Width = 47
        Height = 25
        Alignment = taCenter
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_unit9: TLabel
        Left = 557
        Top = 224
        Width = 47
        Height = 25
        Alignment = taCenter
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_unit10: TLabel
        Left = 557
        Top = 248
        Width = 47
        Height = 25
        Alignment = taCenter
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblamount1: TLabel
        Left = 605
        Top = 32
        Width = 158
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblamount2: TLabel
        Left = 605
        Top = 56
        Width = 158
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblamount3: TLabel
        Left = 605
        Top = 80
        Width = 158
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblamount4: TLabel
        Left = 605
        Top = 104
        Width = 158
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblamount5: TLabel
        Left = 605
        Top = 128
        Width = 158
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblamount6: TLabel
        Left = 605
        Top = 152
        Width = 158
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblamount7: TLabel
        Left = 605
        Top = 176
        Width = 158
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblamount8: TLabel
        Left = 605
        Top = 200
        Width = 158
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblamount9: TLabel
        Left = 605
        Top = 224
        Width = 158
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblamount10: TLabel
        Left = 605
        Top = 248
        Width = 158
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Label49: TLabel
        Left = 8
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
        Left = 118
        Top = 8
        Width = 234
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
        Left = 354
        Top = 8
        Width = 100
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
      object Label51: TLabel
        Left = 453
        Top = 8
        Width = 102
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
      object Label52: TLabel
        Left = 557
        Top = 8
        Width = 45
        Height = 25
        Alignment = taCenter
        AutoSize = False
        Caption = #3627#3609#3656#3623#3618
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
      object Label53: TLabel
        Left = 605
        Top = 8
        Width = 158
        Height = 25
        Alignment = taCenter
        AutoSize = False
        Caption = #3619#3634#3588#3634#3619#3623#3617
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
      object Label59: TLabel
        Left = 18
        Top = 289
        Width = 352
        Height = 16
        Caption = 'F5 = Reprint , F8 = Cancel Bill, F9 = Summary Sales'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label65: TLabel
        Left = 392
        Top = 288
        Width = 150
        Height = 48
        Caption = 
          #3619#3623#3617#3617#3641#3621#3588#3656#3634#3626#3636#3609#3588#3657#3634#3607#3633#3657#3591#3626#3636#3657#3609'         '#3616#3634#3625#3637#3617#3641#3621#3588#3656#3634#3648#3614#3636#3656#3617' (VAT 7%)  '#3619#3623#3617#3648#3591#3636 +
          #3609#3607#3633#3657#3591#3626#3636#3657#3609' (TOTAL)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
      object LblNetprice: TLabel
        Left = 544
        Top = 288
        Width = 215
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LblVat: TLabel
        Left = 544
        Top = 304
        Width = 215
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LblTot_amount: TLabel
        Left = 544
        Top = 320
        Width = 215
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Lblmat_num1: TLabel
        Left = 116
        Top = 33
        Width = 120
        Height = 25
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_num2: TLabel
        Left = 116
        Top = 56
        Width = 120
        Height = 25
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_num3: TLabel
        Left = 116
        Top = 80
        Width = 120
        Height = 25
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_num4: TLabel
        Left = 116
        Top = 104
        Width = 120
        Height = 25
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_num5: TLabel
        Left = 116
        Top = 128
        Width = 120
        Height = 25
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_num6: TLabel
        Left = 116
        Top = 152
        Width = 120
        Height = 25
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_num7: TLabel
        Left = 116
        Top = 176
        Width = 120
        Height = 25
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_num8: TLabel
        Left = 116
        Top = 200
        Width = 120
        Height = 25
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_num9: TLabel
        Left = 116
        Top = 224
        Width = 120
        Height = 25
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Lblmat_num10: TLabel
        Left = 116
        Top = 248
        Width = 120
        Height = 25
        AutoSize = False
        Color = clInactiveCaptionText
        ParentColor = False
        Layout = tlCenter
      end
      object Edtmat_num1: TEdit
        Left = 5
        Top = 32
        Width = 110
        Height = 24
        AutoSize = False
        CharCase = ecUpperCase
        Color = clCream
        MaxLength = 18
        TabOrder = 0
        OnExit = Edtmat_num1Exit
        OnKeyPress = Edtmat_num1KeyPress
      end
      object Edtmat_num2: TEdit
        Left = 5
        Top = 56
        Width = 110
        Height = 24
        AutoSize = False
        CharCase = ecUpperCase
        Color = clCream
        Enabled = False
        MaxLength = 18
        TabOrder = 2
        OnExit = Edtmat_num2Exit
        OnKeyPress = Edtmat_num2KeyPress
      end
      object Edtmat_num3: TEdit
        Left = 5
        Top = 80
        Width = 110
        Height = 24
        AutoSize = False
        CharCase = ecUpperCase
        Color = clCream
        Enabled = False
        MaxLength = 18
        TabOrder = 4
        OnExit = Edtmat_num3Exit
        OnKeyPress = Edtmat_num3KeyPress
      end
      object Edtmat_num4: TEdit
        Left = 5
        Top = 104
        Width = 110
        Height = 24
        AutoSize = False
        CharCase = ecUpperCase
        Color = clCream
        Enabled = False
        MaxLength = 18
        TabOrder = 6
        OnExit = Edtmat_num4Exit
        OnKeyPress = Edtmat_num4KeyPress
      end
      object Edtmat_num5: TEdit
        Left = 5
        Top = 128
        Width = 110
        Height = 24
        AutoSize = False
        CharCase = ecUpperCase
        Color = clCream
        Enabled = False
        MaxLength = 18
        TabOrder = 8
        OnExit = Edtmat_num5Exit
        OnKeyPress = Edtmat_num5KeyPress
      end
      object Edtmat_num6: TEdit
        Left = 5
        Top = 152
        Width = 110
        Height = 24
        AutoSize = False
        CharCase = ecUpperCase
        Color = clCream
        Enabled = False
        MaxLength = 18
        TabOrder = 10
        OnExit = Edtmat_num6Exit
        OnKeyPress = Edtmat_num6KeyPress
      end
      object Edtmat_num7: TEdit
        Left = 5
        Top = 176
        Width = 110
        Height = 24
        AutoSize = False
        CharCase = ecUpperCase
        Color = clCream
        Enabled = False
        MaxLength = 18
        TabOrder = 12
        OnExit = Edtmat_num7Exit
        OnKeyPress = Edtmat_num7KeyPress
      end
      object Edtmat_num8: TEdit
        Left = 5
        Top = 200
        Width = 110
        Height = 24
        AutoSize = False
        CharCase = ecUpperCase
        Color = clCream
        Enabled = False
        MaxLength = 18
        TabOrder = 14
        OnExit = Edtmat_num8Exit
        OnKeyPress = Edtmat_num8KeyPress
      end
      object Edtmat_num9: TEdit
        Left = 5
        Top = 224
        Width = 110
        Height = 24
        AutoSize = False
        CharCase = ecUpperCase
        Color = clCream
        Enabled = False
        MaxLength = 18
        TabOrder = 16
        OnExit = Edtmat_num9Exit
        OnKeyPress = Edtmat_num9KeyPress
      end
      object Edtmat_num10: TEdit
        Left = 5
        Top = 248
        Width = 110
        Height = 24
        AutoSize = False
        CharCase = ecUpperCase
        Color = clCream
        Enabled = False
        MaxLength = 18
        TabOrder = 18
        OnExit = Edtmat_num10Exit
        OnKeyPress = Edtmat_num10KeyPress
      end
      object BtnSave: TButton
        Left = 24
        Top = 320
        Width = 73
        Height = 25
        Action = Action3
        TabOrder = 20
      end
      object BtnPrint: TButton
        Left = 104
        Top = 320
        Width = 73
        Height = 25
        Action = Action2
        TabOrder = 21
      end
      object BtnClear: TButton
        Left = 184
        Top = 320
        Width = 73
        Height = 25
        Caption = 'Clear'
        TabOrder = 22
        OnClick = BtnClearClick
      end
      object BtnExit: TButton
        Left = 264
        Top = 320
        Width = 73
        Height = 25
        Caption = 'Exit'
        TabOrder = 23
        OnClick = Action1Execute
      end
      object EdtQty1: TEdit
        Left = 454
        Top = 32
        Width = 102
        Height = 24
        AutoSize = False
        Color = clCream
        Enabled = False
        TabOrder = 1
        OnExit = EdtQty1Exit
        OnKeyPress = EdtQty1KeyPress
      end
      object EdtQty2: TEdit
        Left = 454
        Top = 56
        Width = 102
        Height = 24
        AutoSize = False
        Color = clCream
        Enabled = False
        TabOrder = 3
        OnExit = EdtQty2Exit
        OnKeyPress = EdtQty2KeyPress
      end
      object EdtQty3: TEdit
        Left = 454
        Top = 80
        Width = 102
        Height = 24
        AutoSize = False
        Color = clCream
        Enabled = False
        TabOrder = 5
        OnExit = EdtQty3Exit
        OnKeyPress = EdtQty3KeyPress
      end
      object EdtQty4: TEdit
        Left = 454
        Top = 104
        Width = 102
        Height = 24
        AutoSize = False
        Color = clCream
        Enabled = False
        TabOrder = 7
        OnExit = EdtQty4Exit
        OnKeyPress = EdtQty4KeyPress
      end
      object EdtQty5: TEdit
        Left = 454
        Top = 128
        Width = 102
        Height = 24
        AutoSize = False
        Color = clCream
        Enabled = False
        TabOrder = 9
        OnExit = EdtQty5Exit
        OnKeyPress = EdtQty5KeyPress
      end
      object EdtQty6: TEdit
        Left = 454
        Top = 152
        Width = 102
        Height = 24
        AutoSize = False
        Color = clCream
        Enabled = False
        TabOrder = 11
        OnExit = EdtQty6Exit
        OnKeyPress = EdtQty6KeyPress
      end
      object EdtQty7: TEdit
        Left = 454
        Top = 176
        Width = 102
        Height = 24
        AutoSize = False
        Color = clCream
        Enabled = False
        TabOrder = 13
        OnExit = EdtQty7Exit
        OnKeyPress = EdtQty7KeyPress
      end
      object EdtQty8: TEdit
        Left = 454
        Top = 200
        Width = 102
        Height = 24
        AutoSize = False
        Color = clCream
        Enabled = False
        TabOrder = 15
        OnExit = EdtQty8Exit
        OnKeyPress = EdtQty8KeyPress
      end
      object EdtQty9: TEdit
        Left = 454
        Top = 224
        Width = 102
        Height = 24
        AutoSize = False
        Color = clCream
        Enabled = False
        TabOrder = 17
        OnExit = EdtQty9Exit
        OnKeyPress = EdtQty9KeyPress
      end
      object EdtQty10: TEdit
        Left = 454
        Top = 248
        Width = 102
        Height = 24
        AutoSize = False
        Color = clCream
        Enabled = False
        TabOrder = 19
        OnExit = EdtQty10Exit
        OnKeyPress = EdtQty10KeyPress
      end
    end
    object Panel3: TPanel
      Left = 11
      Top = 461
      Width = 769
      Height = 88
      TabOrder = 2
      object Label54: TLabel
        Left = 32
        Top = 8
        Width = 120
        Height = 25
        Alignment = taCenter
        AutoSize = False
        Caption = #3619#3627#3633#3626#3648#3588#3619#3639#3656#3629#3591
        Layout = tlCenter
      end
      object Label55: TLabel
        Left = 160
        Top = 8
        Width = 120
        Height = 25
        Alignment = taCenter
        AutoSize = False
        Caption = #3619#3627#3633#3626#3614#3609#3633#3585#3591#3634#3609#3586#3634#3618
        Layout = tlCenter
      end
      object Label56: TLabel
        Left = 288
        Top = 8
        Width = 185
        Height = 25
        Alignment = taCenter
        AutoSize = False
        Caption = #3594#3639#3656#3629
        Layout = tlCenter
      end
      object Label57: TLabel
        Left = 496
        Top = 8
        Width = 120
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Caption = #3618#3629#3604#3586#3634#3618#3623#3633#3609#3609#3637#3657
        Layout = tlCenter
      end
      object Label58: TLabel
        Left = 640
        Top = 8
        Width = 120
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Caption = #3618#3629#3604#3586#3634#3618#3626#3632#3626#3617
        Layout = tlCenter
      end
      object Labelpc_id: TLabel
        Left = 32
        Top = 45
        Width = 120
        Height = 20
        Alignment = taCenter
        AutoSize = False
        Color = clActiveBorder
        ParentColor = False
        Layout = tlCenter
      end
      object Labelsales_id: TLabel
        Left = 160
        Top = 45
        Width = 120
        Height = 20
        Alignment = taCenter
        AutoSize = False
        Color = clActiveBorder
        ParentColor = False
        Layout = tlCenter
      end
      object LabelSales_name: TLabel
        Left = 288
        Top = 45
        Width = 185
        Height = 20
        Alignment = taCenter
        AutoSize = False
        Color = clActiveBorder
        ParentColor = False
        Layout = tlCenter
      end
      object LabelSum: TLabel
        Left = 496
        Top = 45
        Width = 120
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        Color = clActiveBorder
        ParentColor = False
        Layout = tlCenter
      end
      object LabelAcc: TLabel
        Left = 640
        Top = 45
        Width = 120
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        Color = clActiveBorder
        ParentColor = False
        Layout = tlCenter
      end
    end
    object MemoPrint: TMemo
      Left = 488
      Top = 8
      Width = 129
      Height = 89
      Lines.Strings = (
        'MemoPrint')
      TabOrder = 3
      Visible = False
    end
    object EdtComp_id: TEdit
      Left = 492
      Top = 64
      Width = 121
      Height = 24
      TabOrder = 4
      Text = 'EdtComp_id'
      Visible = False
    end
  end
  object MainMenu1: TMainMenu
    Left = 193
    Top = 3
    object N1: TMenuItem
      Caption = #3649#3615#3657#3617#3586#3657#3629#3617#3641#3621
      object N9: TMenuItem
        Caption = #3586#3657#3629#3617#3641#3621#3627#3609#3656#3623#3618#3609#3633#3610
        OnClick = N9Click
      end
      object N10: TMenuItem
        Caption = #3586#3657#3629#3617#3641#3621#3626#3636#3609#3588#3657#3634
        OnClick = N10Click
      end
      object N11: TMenuItem
        Caption = #3586#3657#3629#3617#3641#3621#3610#3619#3636#3625#3633#3607
        OnClick = N11Click
      end
      object N12: TMenuItem
        Caption = #3586#3657#3629#3617#3641#3621#3585#3621#3640#3656#3617#3626#3636#3609#3588#3657#3634
        OnClick = N12Click
      end
      object N13: TMenuItem
        Caption = #3586#3657#3629#3617#3641#3621#3614#3609#3633#3585#3591#3634#3609#3586#3634#3618
        OnClick = N13Click
      end
      object N14: TMenuItem
        Caption = #3586#3657#3629#3617#3641#3621#3621#3641#3585#3588#3657#3634
        OnClick = N14Click
      end
    end
    object N2: TMenuItem
      Caption = #3650#3627#3621#3604#3586#3657#3629#3617#3641#3621
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #3626#3635#3619#3629#3591#3649#3615#3657#3617
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #3648#3619#3637#3618#3585#3588#3639#3609#3649#3615#3657#3617
      OnClick = N4Click
    end
    object N15: TMenuItem
      Caption = #3585#3619#3629#3585#3619#3634#3618#3585#3634#3619
      OnClick = N15Click
    end
    object N5: TMenuItem
      Caption = #3618#3585#3648#3621#3636#3585#3610#3636#3621
      OnClick = Action5Execute
    end
    object N6: TMenuItem
      Caption = #3619#3634#3618#3591#3634#3609
      object N16: TMenuItem
        Caption = #3619#3634#3618#3591#3634#3609#3585#3634#3619#3586#3634#3618#3619#3623#3617
        OnClick = N16Click
      end
      object INVOICE1: TMenuItem
        Caption = #3619#3634#3618#3591#3634#3609#3651#3610' INVOICE '#3619#3623#3617
        OnClick = INVOICE1Click
      end
      object N17: TMenuItem
        Caption = #3619#3634#3618#3591#3634#3609#3611#3619#3632#3592#3635#3623#3633#3609
        OnClick = N17Click
      end
    end
    object N7: TMenuItem
      Caption = #3618#3585#3618#3629#3604#3626#3636#3657#3609#3623#3633#3609
      OnClick = N7Click
    end
    object N8: TMenuItem
      Caption = #3592#3610#3585#3634#3619#3607#3635#3591#3634#3609
      OnClick = N8Click
    end
  end
  object ActionManager1: TActionManager
    Left = 241
    Top = 3
    StyleName = 'XP Style'
    object Action1: TAction
      Caption = 'Close'
      OnExecute = Action1Execute
    end
    object Action2: TAction
      Caption = 'Print(F4)'
      ShortCut = 115
      OnExecute = Action2Execute
    end
    object Action3: TAction
      Caption = 'Save(F2)'
      ShortCut = 113
      OnExecute = Action3Execute
    end
    object Action4: TAction
      Caption = 'Reprint'
      ShortCut = 116
      OnExecute = Action4Execute
    end
    object Action5: TAction
      Caption = 'Cancel_Bill'
      ShortCut = 119
      OnExecute = Action5Execute
    end
    object Action6: TAction
      Caption = #3626#3619#3640#3611#3586#3634#3618
      ShortCut = 120
      OnExecute = Action6Execute
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'mdb'
    Filter = 'Access File (*.mdb)|*.mdb|All Files (*.*)|*.*'
    InitialDir = 'C:\CashSales\backup'
    Left = 112
    Top = 3
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'mdb'
    Filter = 'Access File (*.mdb)|*.mdb|All Files (*.*)|*.*'
    InitialDir = 'C:\CashSales\backup'
    Left = 73
    Top = 4
  end
end
