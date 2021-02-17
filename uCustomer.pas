unit uCustomer;

interface

uses
  System.SysUtils;

type
  TCustomer = class
  private
    FName: string;
    FState: string;
    FID: integer;
    FCity: string;
  public
    property ID: integer read FID;
    property Name: string read FName;
    property City: string read FCity;
    property State: string read FState;

    procedure Load(AID: string); overload;
    procedure Load(AID: integer); overload;
  end;

implementation

{ TCustomer }

uses dmMain, uDefs;



procedure TCustomer.Load(AID: integer);
begin
  dtmMain.qryCustomer.ParamByName('id').Value := AID;
  dtmMain.qryCustomer.Open;
  try
    if dtmMain.qryCustomer.RecordCount = 0 then
      raise Exception.Create(sErrorCustomerNotFound);

    FID := AID;
    FName := dtmMain.qryCustomername.Value;
    FCity := dtmMain.qryCustomercity.Value;
    FState := dtmMain.qryCustomerstate.Value;
  finally
    dtmMain.qryCustomer.Close;
  end;
end;

procedure TCustomer.Load(AID: string);
begin
  try
    FID := StrToInt(AID);
  except
    raise Exception.Create(sErrorCustomerInvalidCode);
  end;

  Load(FID);
end;

end.
