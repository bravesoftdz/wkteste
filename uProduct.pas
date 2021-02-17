unit uProduct;

interface
uses
  System.SysUtils;

type
  TProduct = class
  private
    FPrice: Double;
    FID: Integer;
    FDescription: string;
  public
    property ID: Integer read FID;
    property Description: string read FDescription;
    property Price: Double read FPrice;

    procedure Load(AID: Integer); overload;
    procedure Load(AID: string); overload;
  end;

implementation

{ TProduct }

uses dmMain, uDefs;

procedure TProduct.Load(AID: Integer);
begin
  dtmMain.qryProduct.ParamByName('id').Value := AID;
  dtmMain.qryProduct.Open;
  try
    if dtmMain.qryProduct.RecordCount = 0 then
      raise Exception.Create(sErrorProductNotFOund);

    FID := AID;
    FDescription := dtmMain.qryProductdescription.Value;
    FPrice := dtmMain.qryProductprice.Value;
  finally
    dtmMain.qryProduct.Close;
  end;
end;

procedure TProduct.Load(AID: string);
begin
  try
    FID := StrToInt(AID);
  except
    raise Exception.Create(sErrorCustomerInvalidCode);
  end;

  Load(FID);
end;

end.
