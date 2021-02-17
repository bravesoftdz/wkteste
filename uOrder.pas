unit uOrder;

interface

uses
  System.SysUtils, System.Generics.Collections,
  Data.DB,
  uCustomer, uProduct;

type
  TEditMode = (emInsert, emEdit);

  TOrderLine = class;

  TOrder = class
  private
    FDate: TDateTime;
    FCustomer: TCustomer;
    FTotal: Double;
    FNumber: Integer;
    function GetTotal: Double;

    procedure SaveNewOrder;
    procedure UpdateOrder;
  public
    property Number: Integer read FNumber;
    property DateOrder: TDateTime read FDate;
    property Total: Double read GetTotal;
    property Customer: TCustomer read FCustomer;

    constructor Create;

    procedure AddItem(Item: TOrderLine);
    procedure Save;
    procedure Load(ANumber: Integer); overload;
    procedure Load(ANumber: string); overload;
    procedure Delete;
    procedure DeleteLocalItem;
    function GetLocalItem: TOrderLine;
  end;

  TOrderLine = class
  private
    FProduct: TProduct;
    FPrice: Double;
    FID: Integer;
    FQuantity: Integer;
    FEditMode: TEditMode;
    function GetTotal: Double;
  public
    property ID: Integer read FID write FID;
    property Quantity: Integer read FQuantity write FQuantity;
    property Price: Double read FPrice write FPrice;
    property Total: Double read GetTotal;
    property Product: TProduct read FProduct;
    property EditMode: TEditMode read FEditMode write FEditMode;

    constructor Create;
  end;

implementation

{ TOrder }

uses dmMain, uDefs;

procedure TOrder.AddItem(Item: TOrderLine);
begin
  if item.EditMode = emInsert then
  begin
    dtmMain.datLineOrder.Append;
    dtmMain.datLineOrderProductID.Value := Item.Product.ID;
    dtmMain.datLineOrderDescription.Value := Item.Product.Description;
    dtmMain.datLineOrderQuantity.Value := Item.Quantity;
    dtmMain.datLineOrderPrice.Value := Item.Price;
    dtmMain.datLineOrderTotal.Value := Item.Total;
    dtmMain.datLineOrder.Post;
  end
  else
  begin
    dtmMain.datLineOrder.Edit;
    dtmMain.datLineOrderQuantity.Value := Item.Quantity;
    dtmMain.datLineOrderPrice.Value := Item.Price;
    dtmMain.datLineOrderTotal.Value := Item.Total;
    dtmMain.datLineOrder.Post;
  end;
end;

constructor TOrder.Create;
begin
  FNumber := 0;
  FDate := Date;
  FTotal := 0;
  FCustomer := TCustomer.Create;

  if dtmMain.datLineOrder.Active then
    dtmMain.datLineOrder.Close;

  dtmMain.datLineOrder.Open;
end;

procedure TOrder.Delete;
begin
  dtmMain.cnnMain.StartTransaction;
  try
    dtmMain.cmdOrderLineCancel.ParamByName('OrderNum').Value := FNumber;
    dtmMain.cmdOrderLineCancel.Execute;

    dtmMain.cmdOrderCancel.ParamByName('OrderNum').Value := FNumber;
    dtmMain.cmdOrderCancel.Execute;

    dtmMain.cnnMain.Commit;
  except
    on E:Exception do
    begin
      dtmMain.cnnMain.Rollback;
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TOrder.DeleteLocalItem;
begin
  dtmMain.datLineOrder.Delete;
end;

function TOrder.GetLocalItem: TOrderLine;
begin
  result := TOrderLine.Create;
  result.ID := dtmMain.datLineOrderSeq.Value;
  result.FQuantity := dtmMain.datLineOrderQuantity.Value;
  result.FPrice := dtmMain.datLineOrderPrice.Value;
  result.FEditMode := emEdit;
  result.Product.Load(dtmMain.datLineOrderProductID.Value);
end;

function TOrder.GetTotal: Double;
var
  BookMark :TBookMark;
begin
  BookMark := dtmMain.datLineOrder.Bookmark;
  dtmMain.datLineOrder.DisableControls;
  try
    result := 0;

    dtmMain.datLineOrder.First;
    while not dtmMain.datLineOrder.Eof do
    begin
      result := result + dtmMain.datLineOrderTotal.Value;
      dtmMain.datLineOrder.Next;
    end;
  finally
    dtmMain.datLineOrder.GotoBookmark(BookMark);
    dtmMain.datLineOrder.EnableControls;
  end;
end;

procedure TOrder.Load(ANumber: string);
begin
  try
    FNumber := StrToInt(ANumber);
  except
    raise Exception.Create(sErrorOrderInvalidCode);
  end;

  Load(FNumber);
end;

procedure TOrder.Load(ANumber: Integer);
begin
  dtmMain.qryOrder.ParamByName('OrderNum').Value := ANumber;
  dtmMain.qryOrder.Open;
  try
    if dtmMain.qryOrder.RecordCount > 0 then
    begin
      dtmMain.qryOrderLine.ParamByName('OrderNum').Value := ANumber;
      dtmMain.qryOrderLine.Open;
      try
        Customer.Load(dtmMain.qryOrdercustomerid.AsString);

        dtmMain.qryOrderLine.First;
        while not (dtmMain.qryOrderLine.Eof) do
        begin
          dtmMain.datLineOrder.Append;
          dtmMain.datLineOrderSeq.Value := dtmMain.qryOrderLineid.Value;
          dtmMain.datLineOrderProductID.Value := dtmMain.qryOrderLineproductid.Value;
          dtmMain.datLineOrderDescription.Value := dtmMain.qryOrderLinedescription.Value;
          dtmMain.datLineOrderQuantity.Value := dtmMain.qryOrderLinequantity.Value;
          dtmMain.datLineOrderPrice.Value := dtmMain.qryOrderLineprice.Value;
          dtmMain.datLineOrderTotal.Value := dtmMain.qryOrderLinetotal.Value;
          dtmMain.datLineOrder.Post;

          dtmMain.qryOrderLine.Next;
        end;
      finally
        dtmMain.qryOrderLine.Close;
      end;
    end
    else
      raise Exception.Create(sErrorOrderNotFound);
  finally
    dtmMain.qryOrder.Close;
  end;
end;

procedure TOrder.Save;
begin
  if Number = 0 then SaveNewOrder
                else UpdateOrder;
end;

procedure TOrder.SaveNewOrder;
begin
  dtmMain.cnnMain.StartTransaction;
  try
    FNumber := dtmMain.GetNextOrderNum;

    dtmMain.cmdOrderIns.ParamByName('ordernum').Value := Number;
    dtmMain.cmdOrderIns.ParamByName('orderdate').Value := FDate;
    dtmMain.cmdOrderIns.ParamByName('customerid').Value := FCustomer.ID;
    dtmMain.cmdOrderIns.ParamByName('ordervalue').Value := GetTotal;
    dtmMain.cmdOrderIns.Execute;

    dtmMain.datLineOrder.DisableControls;
    try
      dtmMain.datLineOrder.First;
      while not dtmMain.datLineOrder.Eof do
      begin
        dtmMain.cmdOrderLineIns.ParamByName('ordernum').Value := Number;
        dtmMain.cmdOrderLineIns.ParamByName('productid').Value := dtmMain.datLineOrderProductID.Value;
        dtmMain.cmdOrderLineIns.ParamByName('quantity').Value := dtmMain.datLineOrderQuantity.Value;
        dtmMain.cmdOrderLineIns.ParamByName('price').Value := dtmMain.datLineOrderQuantity.Value;
        dtmMain.cmdOrderLineIns.ParamByName('total').Value := dtmMain.datLineOrderTotal.Value;
        dtmMain.cmdOrderLineIns.Execute;

        dtmMain.datLineOrder.Next;
      end;
    finally
      dtmMain.datLineOrder.EnableControls;
    end;
    dtmMain.cnnMain.Commit;
  except
    on E:Exception do
    begin
      dtmMain.cnnMain.Rollback;

      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TOrder.UpdateOrder;
begin
  dtmMain.cnnMain.StartTransaction;
  try
    dtmMain.cmdOrderUpdate.ParamByName('ordernum').Value := Number;
    dtmMain.cmdOrderUpdate.ParamByName('ordervalue').Value := GetTotal;
    dtmMain.cmdOrderUpdate.Execute;

    dtmMain.datLineOrder.DisableControls;
    try
      dtmMain.datLineOrder.First;
      while not dtmMain.datLineOrder.Eof do
      begin
        dtmMain.cmdOrderLineUpdate.ParamByName('quantity').Value := dtmMain.datLineOrderQuantity.Value;
        dtmMain.cmdOrderLineUpdate.ParamByName('price').Value := dtmMain.datLineOrderQuantity.Value;
        dtmMain.cmdOrderLineUpdate.ParamByName('total').Value := dtmMain.datLineOrderTotal.Value;
        dtmMain.cmdOrderLineUpdate.ParamByName('id').Value := dtmMain.datLineOrderSeq.Value;
        dtmMain.cmdOrderLineUpdate.Execute;

        dtmMain.datLineOrder.Next;
      end;

      dtmMain.cnnMain.Commit;
    finally
      dtmMain.datLineOrder.EnableControls;
    end;
  except
    on E:Exception do
    begin
      dtmMain.cnnMain.Rollback;

      raise Exception.Create(E.Message);
    end;
  end;
end;

{ TOrderLine }

constructor TOrderLine.Create;
begin
  FID := 0;
  FQuantity := 1;
  FPrice := 0;
  FProduct := TProduct.Create;
  FEditMode := emInsert;
end;

function TOrderLine.GetTotal: Double;
begin
  result := FQuantity * FPrice;
end;

end.
