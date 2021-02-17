unit fMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, uOrderItem, System.Actions,
  Vcl.ActnList, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls,
  uOrder, uProduct, uCustomer;

type
  TOperationMode = (omWaitingCustomer, omInsertProduct, omEditProduct);

  TfrmMain = class(TForm)
    StatusBar1: TStatusBar;
    grdItems: TDBGrid;
    Label1: TLabel;
    edtProductId: TEdit;
    Label2: TLabel;
    edtQuantity: TEdit;
    Label3: TLabel;
    edtPrice: TEdit;
    btnInsert: TBitBtn;
    Label4: TLabel;
    edtCustomerId: TEdit;
    Label5: TLabel;
    edtCustomerName: TEdit;
    pnlFooter: TPanel;
    Label6: TLabel;
    lblTotal: TLabel;
    btnSaveOrder: TBitBtn;
    btnFindOrder: TBitBtn;
    btnCancelOrder: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure edtCustomerIdExit(Sender: TObject);
    procedure edtProductIdExit(Sender: TObject);
    procedure edtQuantityExit(Sender: TObject);
    procedure edtPriceExit(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure grdItemsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSaveOrderClick(Sender: TObject);
    procedure edtCustomerIdChange(Sender: TObject);
    procedure btnCancelOrderClick(Sender: TObject);
    procedure btnFindOrderClick(Sender: TObject);
  private
    { Private declarations }
    FProductName: string;
    FOrderItem: TOrderItem;
    FOperationMode: TOperationMode;
    ActualOrderNum: Integer;

    Order: TOrder;
    Item: TOrderLine;

    procedure InsertOrderItem;
    procedure DeleteSelectedItem;
    procedure ShowTotal;
    procedure SaveOrder;
    procedure SetOperationMode(const Value: TOperationMode);
    procedure CancelOrder(OrderNum: string);
    procedure BindCustomer(Customer: TCustomer);
    procedure BindItem(Item: TOrderLine);

    property OperationMode: TOperationMode write SetOperationMode;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses dmMain, uDefs;

{ TfrmMain }

procedure TfrmMain.FormShow(Sender: TObject);
begin
  Order := TOrder.Create;
  OperationMode := omWaitingCustomer;
end;

procedure TfrmMain.edtCustomerIdChange(Sender: TObject);
begin
  btnFindOrder.Visible := edtCustomerId.Text = '';
  btnCancelOrder.Visible := edtCustomerId.Text = '';
end;

procedure TfrmMain.edtCustomerIdExit(Sender: TObject);
begin
  if edtCustomerId.Text = '' then
    Exit;

  Order.Customer.Load(edtCustomerId.Text);
  BindCustomer(Order.Customer);
end;

procedure TfrmMain.edtProductIdExit(Sender: TObject);
begin
  if edtProductId.Text = '' then
    Exit;

  Item := TOrderLine.Create;
  Item.Product.Load(edtProductId.Text);
  BindItem(Item);
end;

procedure TfrmMain.edtQuantityExit(Sender: TObject);
begin
  Item.Quantity := StrtoInt(edtQuantity.Text);
end;

procedure TfrmMain.edtPriceExit(Sender: TObject);
begin
  Item.Price := StrToFloat(edtPrice.Text);
end;

procedure TfrmMain.BindCustomer(Customer: TCustomer);
begin
  edtCustomerId.Text := IntToStr(Order.Customer.ID);
  edtCustomerName.Text := Order.Customer.Name;
  OperationMode := omInsertProduct;
end;

procedure TfrmMain.BindItem(Item: TOrderLine);
begin
  if Item.Price = 0 then
    Item.Price := Item.Product.Price;

  edtQuantity.Text := IntToStr(Item.Quantity);
  edtPrice.Text := FloatToStr(Item.Price);
end;

procedure TfrmMain.btnCancelOrderClick(Sender: TObject);
var
  NumOrder: string;
begin
  NumOrder := InputBox(sMsgCancelTitle, sMsgNumberOrderPrompt, '');

  if NumOrder <> '' then
    CancelOrder(NumOrder);
end;

procedure TfrmMain.btnFindOrderClick(Sender: TObject);
var
  NumOrder: string;
begin
  NumOrder := InputBox(sMsgFindOrderTitle, sMsgNumberOrderPrompt, '');

  if NumOrder <> '' then
  begin
    Order.Load(NumOrder);
    BindCustomer(Order.Customer);
  end;
end;

procedure TfrmMain.btnInsertClick(Sender: TObject);
begin
  InsertOrderItem;
end;

procedure TfrmMain.SetOperationMode(const Value: TOperationMode);
begin
  FOperationMode := Value;

  case Value of
    omWaitingCustomer:
    begin
      edtProductID.Enabled := False;
      edtQuantity.Enabled := False;
      edtPrice.Enabled := False;
      btnInsert.Enabled := False;
      edtCustomerId.Enabled := True;
      edtCustomerId.Text := '';
      edtCustomerName.Text := '';

      Order := TOrder.Create;
      
      ShowTotal;
      edtCustomerId.SetFocus;
    end;

    omInsertProduct:
    begin
      edtProductID.Enabled := True;
      edtQuantity.Enabled := True;
      edtPrice.Enabled := True;
      btnInsert.Enabled := True;
      edtCustomerId.Enabled := False;

      edtProductId.Text := '';
      edtQuantity.Text := '';
      edtPrice.Text := '';

      Item := TOrderLine.Create;

      edtProductId.SetFocus;
    end;

    omEditProduct:
    begin
      edtProductID.Enabled := False;
      edtQuantity.Enabled := True;
      edtPrice.Enabled := True;
      btnInsert.Enabled := True;
      edtCustomerId.Enabled := False;

      edtQuantity.SetFocus;
    end;
  end;
end;

procedure TfrmMain.grdItemsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = 13 then
  begin
    edtQuantity.Text := dtmMain.datLineOrderQuantity.AsString;
    edtPrice.Text := dtmMain.datLineOrderPrice.AsString;
    edtProductId.Text := dtmMain.datLineOrderProductID.AsString;

    Item := Order.GetLocalItem;
    BindItem(Item);
    
    OperationMode := omEditProduct;
  end
  else if Key = 46 then
  begin
    if (MessageDlg(sMsgConfirmDelOrderLine, mtInformation, [mbNo, mbYes], 0) = idYes) then
      DeleteSelectedItem;
  end;
end;

procedure TfrmMain.InsertOrderItem;
begin
  Order.AddItem(Item);

  ShowTotal;
  OperationMode := omInsertProduct;
end;

procedure TfrmMain.btnSaveOrderClick(Sender: TObject);
begin
  SaveOrder;
end;

procedure TfrmMain.CancelOrder(OrderNum: string);
begin
  Order.Load(OrderNum);
  BindCustomer(Order.Customer);

  if MessageDlg(sMsgConfirmOrderCancel, mtInformation, [mbyes, mbNo], 0) = idYes then
    Order.Delete;

  OperationMode := omWaitingCustomer;
end;

procedure TfrmMain.DeleteSelectedItem;
begin
  if (Order.Number = 0) then
  begin
    Order.DeleteLocalItem;
    ShowTotal;

    OperationMode := omInsertProduct;
  end
  else
    MessageDlg(sMsgErrorCancelItem, mtInformation, [mbOK],  0);
end;

procedure TfrmMain.ShowTotal;
var
  Total: Double;
begin
  Total := Order.Total;

  btnSaveOrder.Enabled := Total > 0;

  lblTotal.Caption := FormatFloat('R$ ###,##0.00', Total);
end;

procedure TfrmMain.SaveOrder;
begin
  Order.Save;
  OperationMode := omWaitingCustomer;
end;

end.
