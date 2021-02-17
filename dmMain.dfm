object dtmMain: TdtmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 443
  Width = 545
  object cnnMain: TFDConnection
    Params.Strings = (
      'Database=wkteste'
      'User_Name=masterdb'
      'Password=master@123'
      'Server=45.34.12.248'
      'DriverID=MySQL')
    ResourceOptions.AssignedValues = [rvAutoReconnect]
    ResourceOptions.AutoReconnect = True
    Connected = True
    Left = 144
    Top = 16
  end
  object datLineOrder: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 32
    Top = 84
    object datLineOrderProductID: TIntegerField
      DisplayLabel = 'C'#243'd. Produto'
      FieldName = 'ProductID'
    end
    object datLineOrderDescription: TStringField
      DisplayLabel = 'Descri'#231#227'o '
      FieldName = 'Description'
      Size = 100
    end
    object datLineOrderQuantity: TIntegerField
      DisplayLabel = 'Quantidade'
      FieldName = 'Quantity'
    end
    object datLineOrderPrice: TCurrencyField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'Price'
    end
    object datLineOrderTotal: TCurrencyField
      FieldName = 'Total'
    end
    object datLineOrderSeq: TIntegerField
      FieldName = 'Seq'
    end
  end
  object dtsLineOrder: TDataSource
    DataSet = datLineOrder
    Left = 32
    Top = 142
  end
  object cmdCustomerIns: TFDCommand
    Connection = cnnMain
    CommandText.Strings = (
      'INSERT customer'
      '  (id, name, city, state)'
      'VALUES'
      '  (:id, :name, :city, :state)')
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'NAME'
        DataType = ftString
        ParamType = ptInput
        Size = 100
        Value = Null
      end
      item
        Name = 'CITY'
        DataType = ftString
        ParamType = ptInput
        Size = 50
        Value = Null
      end
      item
        Name = 'STATE'
        DataType = ftString
        ParamType = ptInput
        Size = 2
        Value = Null
      end>
    Left = 144
    Top = 142
  end
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Temp\libmysql.dll'
    Left = 252
    Top = 16
  end
  object cmdProductIns: TFDCommand
    Connection = cnnMain
    CommandText.Strings = (
      'INSERT product'
      '  (id, description, price)'
      'VALUES'
      '  (:id, :description, :price)')
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DESCRIPTION'
        DataType = ftString
        ParamType = ptInput
        Size = 100
        Value = Null
      end
      item
        Name = 'PRICE'
        DataType = ftCurrency
        ParamType = ptInput
        Value = Null
      end>
    Left = 252
    Top = 142
  end
  object qryCustomer: TFDQuery
    Connection = cnnMain
    SQL.Strings = (
      'SELECT '
      '  name,'
      '  city,'
      '  state'
      'FROM'
      '  customer'
      'WHERE'
      '  id = :id')
    Left = 144
    Top = 200
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryCustomername: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'name'
      Origin = '`name`'
      Size = 100
    end
    object qryCustomercity: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'city'
      Origin = 'city'
      Size = 50
    end
    object qryCustomerstate: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'state'
      Origin = 'state'
      FixedChar = True
      Size = 2
    end
  end
  object qryCustomerIsEmpty: TFDQuery
    Connection = cnnMain
    SQL.Strings = (
      'SELECT 1 FROM customer LIMIT 1')
    Left = 144
    Top = 84
  end
  object qryProductIsEmpty: TFDQuery
    Connection = cnnMain
    SQL.Strings = (
      'SELECT 1 FROM product LIMIT 1')
    Left = 252
    Top = 84
  end
  object qryProduct: TFDQuery
    Connection = cnnMain
    SQL.Strings = (
      'SELECT'
      '  description,'
      '  price'
      'FROM'
      '  product'
      'WHERE'
      '  id = :id')
    Left = 252
    Top = 200
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryProductdescription: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'description'
      Origin = 'description'
      Size = 100
    end
    object qryProductprice: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'price'
      Origin = 'price'
      Precision = 13
      Size = 2
    end
  end
  object cmdOrderIns: TFDCommand
    Connection = cnnMain
    CommandText.Strings = (
      'INSERT wkteste.order'
      '  (ordernum, orderdate, customerid, ordervalue)'
      'VALUES'
      '  (:ordernum, :orderdate, :customerid, :ordervalue)')
    ParamData = <
      item
        Name = 'ORDERNUM'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ORDERDATE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'CUSTOMERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ORDERVALUE'
        DataType = ftCurrency
        ParamType = ptInput
        Value = Null
      end>
    Left = 348
    Top = 84
  end
  object cmdOrderLineIns: TFDCommand
    Connection = cnnMain
    CommandText.Strings = (
      'INSERT orderline'
      '  (ordernum, productid, quantity, price, total)'
      'VALUES'
      '  (:ordernum, :productid, :quantity, :price, :total)')
    ParamData = <
      item
        Name = 'ORDERNUM'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PRODUCTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'QUANTITY'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PRICE'
        DataType = ftCurrency
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'TOTAL'
        DataType = ftCurrency
        ParamType = ptInput
        Value = Null
      end>
    Left = 451
    Top = 84
  end
  object qryNextOrdermNum: TFDQuery
    Connection = cnnMain
    SQL.Strings = (
      'SELECT MAX(ordernum) FROM wkteste.order')
    Left = 348
    Top = 142
  end
  object qryOrder: TFDQuery
    Connection = cnnMain
    SQL.Strings = (
      'SELECT'
      '  ordernum,'
      '  customerid,'
      '  orderdate,'
      '  ordervalue,'
      '  name'
      'FROM'
      '  wkteste.order'
      'JOIN'
      '  customer ON customerid = id'
      'WHERE'
      '  ordernum= :ordernum')
    Left = 348
    Top = 200
    ParamData = <
      item
        Name = 'ORDERNUM'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryOrderordernum: TIntegerField
      FieldName = 'ordernum'
      Origin = 'ordernum'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryOrdercustomerid: TIntegerField
      FieldName = 'customerid'
      Origin = 'customerid'
      Required = True
    end
    object qryOrderorderdate: TDateTimeField
      FieldName = 'orderdate'
      Origin = 'orderdate'
      Required = True
    end
    object qryOrderordervalue: TBCDField
      FieldName = 'ordervalue'
      Origin = 'ordervalue'
      Required = True
      Precision = 12
      Size = 2
    end
    object qryOrdername: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'name'
      Origin = '`name`'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
  end
  object qryOrderLine: TFDQuery
    Connection = cnnMain
    SQL.Strings = (
      'SELECT'
      '  t1.id,'
      '  t1.ordernum,'
      '  t1.productid,'
      '  t1.quantity,'
      '  t1.price,'
      '  t1.total,'
      '  t2.description'
      'FROM'
      '  orderline t1'
      'JOIN'
      '  product t2 on t1.productid = t2.id'
      'WHERE'
      '  t1.ordernum = :ordernum ')
    Left = 451
    Top = 200
    ParamData = <
      item
        Name = 'ORDERNUM'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryOrderLineid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryOrderLineordernum: TIntegerField
      FieldName = 'ordernum'
      Origin = 'ordernum'
      Required = True
    end
    object qryOrderLineproductid: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'productid'
      Origin = 'productid'
    end
    object qryOrderLinequantity: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'quantity'
      Origin = 'quantity'
    end
    object qryOrderLineprice: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'price'
      Origin = 'price'
      Precision = 12
      Size = 2
    end
    object qryOrderLinetotal: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'total'
      Origin = 'total'
      Precision = 12
      Size = 2
    end
    object qryOrderLinedescription: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'description'
      Origin = 'description'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
  end
  object cmdOrderCancel: TFDCommand
    Connection = cnnMain
    CommandText.Strings = (
      'DELETE FROM wkteste.order where ordernum = :ordernum')
    ParamData = <
      item
        Name = 'ORDERNUM'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    Left = 348
    Top = 264
  end
  object cmdOrderLineCancel: TFDCommand
    Connection = cnnMain
    CommandText.Strings = (
      'DELETE FROM orderline where ordernum = :ordernum')
    ParamData = <
      item
        Name = 'ORDERNUM'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    Left = 451
    Top = 264
  end
  object cmdOrderUpdate: TFDCommand
    Connection = cnnMain
    CommandText.Strings = (
      'UPDATE '
      '  wkteste.order '
      'SET'
      '  ordervalue = :ordervalue'
      'WHERE '
      '  ordernum = :ordernum')
    ParamData = <
      item
        Name = 'ORDERVALUE'
        DataType = ftCurrency
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ORDERNUM'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    Left = 348
    Top = 332
  end
  object cmdOrderLineUpdate: TFDCommand
    Connection = cnnMain
    CommandText.Strings = (
      'UPDATE orderline'
      'SET'
      '  quantity = :quantity, '
      '  price = :price, '
      '  total = :total'
      'WHERE'
      '  id = :id')
    ParamData = <
      item
        Name = 'QUANTITY'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PRICE'
        DataType = ftCurrency
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'TOTAL'
        DataType = ftCurrency
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    Left = 451
    Top = 332
  end
end
