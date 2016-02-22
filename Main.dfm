object MainWindow: TMainWindow
  Left = 474
  Top = 98
  Width = 707
  Height = 502
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pc: TPageControl
    Left = 0
    Top = 0
    Width = 699
    Height = 448
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    TabStop = False
    object TabSheet1: TTabSheet
      Caption = 'Differential equations'
      object Label4: TLabel
        Left = 528
        Top = 138
        Width = 33
        Height = 17
        AutoSize = False
        Caption = 'dt = '
      end
      object Label2: TLabel
        Left = 248
        Top = 62
        Width = 49
        Height = 17
        AutoSize = False
        Caption = 'dy/dt  = '
      end
      object Label1: TLabel
        Left = 248
        Top = 35
        Width = 49
        Height = 17
        AutoSize = False
        Caption = 'dx/dt  = '
      end
      object __info1: TLabel
        Left = 0
        Top = 347
        Width = 691
        Height = 15
        Align = alBottom
        AutoSize = False
        Caption = 'Status:'
      end
      object Label5: TLabel
        Left = 0
        Top = 252
        Width = 691
        Height = 13
        Align = alBottom
        Caption = 'Additional parameters:'
      end
      object Label7: TLabel
        Left = 264
        Top = 138
        Width = 25
        Height = 17
        AutoSize = False
        Caption = 't0 ='
      end
      object Label8: TLabel
        Left = 400
        Top = 138
        Width = 32
        Height = 13
        AutoSize = False
        Caption = 't = '
      end
      object tasks: TListBox
        Left = 0
        Top = 0
        Width = 241
        Height = 252
        TabStop = False
        Align = alLeft
        ItemHeight = 13
        TabOrder = 1
        OnClick = tasksClick
      end
      object add_plot: TCheckBox
        Left = 248
        Top = 8
        Width = 201
        Height = 17
        TabStop = False
        Caption = 'Draw points over existing'
        TabOrder = 4
      end
      object params: TMemo
        Left = 0
        Top = 265
        Width = 691
        Height = 82
        Align = alBottom
        MaxLength = 128
        ScrollBars = ssVertical
        TabOrder = 6
      end
      object draw_btn: TButton
        Left = 248
        Top = 180
        Width = 137
        Height = 21
        Caption = 'Draw'
        TabOrder = 7
        OnClick = draw_btnClick
      end
      object idbg: TMemo
        Left = 0
        Top = 362
        Width = 691
        Height = 58
        TabStop = False
        Align = alBottom
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object edt_t: TEdit
        Left = 288
        Top = 136
        Width = 65
        Height = 21
        TabOrder = 2
      end
      object GroupBox1: TGroupBox
        Left = 288
        Top = 32
        Width = 393
        Height = 49
        TabOrder = 11
        object eq2: TEdit
          Left = 0
          Top = 0
          Width = 393
          Height = 21
          TabOrder = 0
        end
        object eq1: TEdit
          Left = 0
          Top = 27
          Width = 393
          Height = 21
          TabOrder = 1
        end
      end
      object edt_t1: TEdit
        Left = 416
        Top = 136
        Width = 65
        Height = 21
        TabOrder = 3
      end
      object edt_dt: TEdit
        Left = 552
        Top = 136
        Width = 65
        Height = 21
        TabOrder = 5
      end
      object GroupBox2: TGroupBox
        Left = 256
        Top = 80
        Width = 425
        Height = 49
        Caption = 'Initial conditions: '
        TabOrder = 14
        object Label9: TLabel
          Left = 16
          Top = 18
          Width = 17
          Height = 13
          Caption = 'x = '
        end
        object Label10: TLabel
          Left = 248
          Top = 18
          Width = 17
          Height = 13
          Caption = 'y = '
        end
        object Edit1: TEdit
          Left = 32
          Top = 16
          Width = 145
          Height = 21
          TabOrder = 0
        end
        object Edit2: TEdit
          Left = 264
          Top = 16
          Width = 145
          Height = 21
          TabOrder = 1
        end
      end
      object clear_btn: TButton
        Left = 248
        Top = 208
        Width = 137
        Height = 21
        Caption = 'Clear plane'
        TabOrder = 8
        OnClick = clear_btnClick
      end
      object new_btn: TButton
        Left = 392
        Top = 180
        Width = 137
        Height = 21
        Caption = 'Add new task'
        TabOrder = 9
        OnClick = new_btnClick
      end
      object save_btn: TButton
        Left = 392
        Top = 208
        Width = 137
        Height = 21
        Caption = 'Save selected task'
        TabOrder = 10
        OnClick = save_btnClick
      end
      object del_btn: TButton
        Left = 536
        Top = 208
        Width = 137
        Height = 21
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1091#1102' '#1079#1072#1076#1072#1095#1091' '#1080#1079' '#1089#1087#1080#1089#1082#1072'/'#1089' '#1076#1080#1089#1082#1072', '#1077#1089#1083#1080' '#1079#1072#1087#1080#1089#1072#1085#1072
        Caption = 'Remove selected task'
        TabOrder = 12
        TabStop = False
        OnClick = del_btnClick
      end
      object settings_btn: TButton
        Left = 536
        Top = 2
        Width = 137
        Height = 25
        Caption = 'Settings...'
        Enabled = False
        TabOrder = 13
        TabStop = False
        Visible = False
        OnClick = settings_btnClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Probabilities'
      Enabled = False
      ImageIndex = 1
      TabVisible = False
      object Bevel1: TBevel
        Left = 240
        Top = 216
        Width = 457
        Height = 42
      end
      object probs: TValueListEditor
        Left = 0
        Top = 252
        Width = 691
        Height = 168
        Align = alBottom
        TabOrder = 0
        TitleCaptions.Strings = (
          'Occasion'
          'Probability')
        ColWidths = (
          309
          376)
      end
      object probtasks: TListBox
        Left = 0
        Top = 0
        Width = 241
        Height = 252
        Align = alLeft
        ItemHeight = 13
        TabOrder = 1
        OnClick = probtasksClick
      end
      object addOccasion_btn: TButton
        Left = 248
        Top = 224
        Width = 137
        Height = 25
        Caption = 'Add occasion'
        TabOrder = 2
      end
      object delOccasion_btn: TButton
        Left = 560
        Top = 224
        Width = 121
        Height = 25
        Caption = 'Remove selected'
        TabOrder = 3
      end
      object renOccasion_btn: TButton
        Left = 400
        Top = 224
        Width = 145
        Height = 25
        Caption = 'Rename selected'
        TabOrder = 4
      end
      object setCustomDistr_btn: TButton
        Left = 480
        Top = 8
        Width = 113
        Height = 25
        Caption = 'Set formula...'
        TabOrder = 5
      end
      object addProbTask_btn: TButton
        Left = 248
        Top = 184
        Width = 137
        Height = 25
        Caption = 'Add new task'
        TabOrder = 6
      end
      object saveProbTask_btn: TButton
        Left = 400
        Top = 184
        Width = 145
        Height = 25
        Caption = 'Save task'
        TabOrder = 7
      end
      object delProbTask_btn: TButton
        Left = 560
        Top = 184
        Width = 121
        Height = 25
        Caption = 'Add task'
        TabOrder = 8
      end
    end
  end
  object MainMenu1: TMainMenu
    object N1: TMenuItem
      Caption = 'Settings'
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = 'About'
      OnClick = N2Click
    end
  end
end
