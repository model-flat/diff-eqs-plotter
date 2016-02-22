object SettingsWindow: TSettingsWindow
  Left = 344
  Top = 113
  BorderStyle = bsToolWindow
  Caption = 'Settings window'
  ClientHeight = 308
  ClientWidth = 385
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 385
    Height = 308
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Diff. equations'
      object Label1: TLabel
        Left = 24
        Top = 8
        Width = 137
        Height = 25
        AutoSize = False
        Caption = 'Plot points color'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object ColorBox1: TColorBox
        Left = 168
        Top = 8
        Width = 161
        Height = 22
        Selected = clRed
        ItemHeight = 16
        TabOrder = 0
      end
      object Edit1: TEdit
        Left = 80
        Top = 48
        Width = 121
        Height = 21
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 1
        Text = 'Edit1'
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Probabilities'
      ImageIndex = 2
    end
    object TabSheet2: TTabSheet
      Caption = 'Help'
      ImageIndex = 1
      object RichEdit1: TRichEdit
        Left = 0
        Top = 0
        Width = 377
        Height = 280
        Align = alClient
        Ctl3D = False
        Lines.Strings = (
          'coming soon')
        ParentCtl3D = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
end
