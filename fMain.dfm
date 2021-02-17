object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'WK Teste'
  ClientHeight = 433
  ClientWidth = 620
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 56
    Width = 71
    Height = 13
    Caption = 'C'#243'digo do item'
    FocusControl = edtProductId
  end
  object Label2: TLabel
    Left = 114
    Top = 56
    Width = 56
    Height = 13
    Caption = 'Quantidade'
  end
  object Label3: TLabel
    Left = 222
    Top = 56
    Width = 63
    Height = 13
    Caption = 'Valor unit'#225'rio'
  end
  object Label4: TLabel
    Left = 8
    Top = 12
    Width = 82
    Height = 13
    Caption = 'C'#243'digo do cliente'
  end
  object Label5: TLabel
    Left = 114
    Top = 12
    Width = 78
    Height = 13
    Caption = 'Nome do Cliente'
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 414
    Width = 620
    Height = 19
    Panels = <>
    ExplicitWidth = 606
  end
  object grdItems: TDBGrid
    Left = 0
    Top = 104
    Width = 620
    Height = 280
    Align = alBottom
    DataSource = dtmMain.dtsLineOrder
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyDown = grdItemsKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'ProductID'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Description'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Quantity'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Price'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Total'
        Width = 100
        Visible = True
      end>
  end
  object edtProductId: TEdit
    Left = 8
    Top = 70
    Width = 100
    Height = 21
    TabOrder = 1
    OnExit = edtProductIdExit
  end
  object edtQuantity: TEdit
    Left = 114
    Top = 70
    Width = 100
    Height = 21
    TabOrder = 2
    OnExit = edtQuantityExit
  end
  object edtPrice: TEdit
    Left = 222
    Top = 70
    Width = 110
    Height = 21
    TabOrder = 3
    OnExit = edtPriceExit
  end
  object btnInsert: TBitBtn
    Left = 338
    Top = 69
    Width = 75
    Height = 23
    Caption = 'Inserir'
    TabOrder = 4
    OnClick = btnInsertClick
  end
  object edtCustomerId: TEdit
    Left = 8
    Top = 26
    Width = 100
    Height = 21
    TabOrder = 0
    OnChange = edtCustomerIdChange
    OnExit = edtCustomerIdExit
  end
  object edtCustomerName: TEdit
    Left = 114
    Top = 26
    Width = 218
    Height = 21
    ReadOnly = True
    TabOrder = 7
  end
  object pnlFooter: TPanel
    Left = 0
    Top = 384
    Width = 620
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 8
    ExplicitWidth = 606
    object Label6: TLabel
      Left = 348
      Top = 6
      Width = 87
      Height = 18
      Caption = 'Valor Total:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotal: TLabel
      Left = 441
      Top = 6
      Width = 144
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object btnSaveOrder: TBitBtn
    Left = 441
    Top = 11
    Width = 84
    Height = 23
    Caption = 'Salvar Pedido'
    Enabled = False
    TabOrder = 9
    OnClick = btnSaveOrderClick
  end
  object btnFindOrder: TBitBtn
    Left = 441
    Top = 40
    Width = 84
    Height = 23
    Caption = 'Buscar Pedido'
    TabOrder = 10
    OnClick = btnFindOrderClick
  end
  object btnCancelOrder: TBitBtn
    Left = 441
    Top = 69
    Width = 84
    Height = 23
    Caption = 'Cancelar Pedido'
    TabOrder = 11
    OnClick = btnCancelOrderClick
  end
end
