unit dmMain;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.DApt;

type
  TdtmMain = class(TDataModule)
    cnnMain: TFDConnection;
    datLineOrder: TFDMemTable;
    datLineOrderProductID: TIntegerField;
    datLineOrderDescription: TStringField;
    datLineOrderQuantity: TIntegerField;
    datLineOrderPrice: TCurrencyField;
    datLineOrderTotal: TCurrencyField;
    dtsLineOrder: TDataSource;
    cmdCustomerIns: TFDCommand;
    FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;
    cmdProductIns: TFDCommand;
    qryCustomer: TFDQuery;
    qryCustomername: TStringField;
    qryCustomercity: TStringField;
    qryCustomerstate: TStringField;
    qryCustomerIsEmpty: TFDQuery;
    qryProductIsEmpty: TFDQuery;
    qryProduct: TFDQuery;
    qryProductdescription: TStringField;
    qryProductprice: TBCDField;
    cmdOrderIns: TFDCommand;
    cmdOrderLineIns: TFDCommand;
    qryNextOrdermNum: TFDQuery;
    qryOrder: TFDQuery;
    qryOrderordernum: TIntegerField;
    qryOrdercustomerid: TIntegerField;
    qryOrderorderdate: TDateTimeField;
    qryOrderordervalue: TBCDField;
    qryOrderLine: TFDQuery;
    qryOrderLineid: TFDAutoIncField;
    qryOrderLineordernum: TIntegerField;
    qryOrderLineproductid: TIntegerField;
    qryOrderLinequantity: TIntegerField;
    qryOrderLineprice: TBCDField;
    qryOrderLinetotal: TBCDField;
    qryOrderLinedescription: TStringField;
    qryOrdername: TStringField;
    datLineOrderSeq: TIntegerField;
    cmdOrderCancel: TFDCommand;
    cmdOrderLineCancel: TFDCommand;
    cmdOrderUpdate: TFDCommand;
    cmdOrderLineUpdate: TFDCommand;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure LoadData;
    procedure LoadCustomerData;
    procedure LoadProductData;

    procedure InsertCustomer(AId: Integer; AName: string; ACity: string; AState: string);
    procedure InsertProduct(AId: Integer; ADescription: string; APrice: Double);
  public
    { Public declarations }
    function GetNextOrderNum: Integer;
  end;

var
  dtmMain: TdtmMain;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdtmMain }

procedure TdtmMain.DataModuleCreate(Sender: TObject);
begin
  LoadData;
end;

procedure TdtmMain.LoadData;
begin
  qryCustomerIsEmpty.Open;
  try
    if qryCustomerIsEmpty.RecordCount = 0 then
      LoadCustomerData;
  finally
    qryCustomerIsEmpty.Close;
  end;

  qryProductIsEmpty.Open;
  try
    if qryProductIsEmpty.RecordCount = 0 then
      LoadProductData;
  finally
    qryProductIsEmpty.Close;
  end;
end;

procedure TdtmMain.LoadCustomerData;
begin
  cnnMain.StartTransaction;
  try
    InsertCustomer(1, 'CASA DE CARNES MIKILAS LTDA', 'Curitiba', 'PR');
    InsertCustomer(2, 'CC BERRI COM.VAREGISTA. DE PROD.ALIM. LT', 'Curitiba', 'PR');
    InsertCustomer(3, 'LUIZ C. A. BRANCO - ME', 'Araucaria', 'PR');
    InsertCustomer(4, 'CLARICE CARDOSO - ME', 'Curitiba', 'PR');
    InsertCustomer(5, 'CLAUDINEI IANNES', 'Curitiba', 'PR');
    InsertCustomer(6, 'CLEYTON FERNANDES BRITO', 'Campo Largo', 'PR');
    InsertCustomer(7, 'COM. ALIM ZAMPROGNA LTDA', 'Sao Jose dos Pinhais', 'PR');
    InsertCustomer(8, 'COM. DE MOVEIS E ALIM. LORINEI LTDA', 'Curitiba', 'PR');
    InsertCustomer(9, 'COM. DE PROD. ALIM. KRAINSKI LTDA', 'Sao Jose dos Pinhais', 'PR');
    InsertCustomer(10, 'COML. DE ALIMENTOS ASSIS DA FAZENDA LTDA', 'Sao Jose dos Pinhais', 'PR');
    InsertCustomer(11, 'CONF.E REST. BOM JESUS LTDA', 'Pinhais', 'PR');
    InsertCustomer(12, 'CONFEITERIA LEUCH LTDA', 'Pinhais', 'PR');
    InsertCustomer(13, 'CRISTIANE ISABEL FRANCISCO ALVES- BAR DO', 'Curitiba', 'PR');
    InsertCustomer(14, 'CRUZETA & CRUZETA LTDA - ME', 'Curitiba', 'PR');
    InsertCustomer(15, 'D E B SILVA LTDA', 'Pinhais', 'PR');
    InsertCustomer(16, 'D. A PAGNOCELLI & CIA LTDA', 'Campo Largo', 'PR');
    InsertCustomer(17, 'DANIEL PANGRACIO NERONE & CIA LTDA', 'Araucaria', 'PR');
    InsertCustomer(18, 'DANIELE APARECIDA ALVES', 'Sao Jose dos Pinhais', 'PR');
    InsertCustomer(19, 'DAVID BATISTA DE OLIVEIRA - PANIF. PAO D', 'Curitiba', 'PR');
    InsertCustomer(20, 'DE LUCA ALVES & CIA LTDA.-PAN. REQUINTE', 'Curitiba', 'PR');
    cnnMain.Commit;
  except
    dtmMain.cnnMain.Rollback;
  end;
end;

procedure TdtmMain.LoadProductData;
begin
  cnnMain.StartTransaction;
  try
    InsertProduct(1, 'COCA COLA PET 1,5L C/6', 4.65);
    InsertProduct(2, 'GUARANA KUAT PET 600ML', 2.77);
    InsertProduct(3, 'SPRITE SA PET 600ML', 3.13);
    InsertProduct(4, 'COCA COLA PET 600ML', 3.19);
    InsertProduct(5, 'COCA COLA PET 1L', 3.89);
    InsertProduct(6, 'COCA COLA ZERO PET 600ML', 3.19);
    InsertProduct(7, 'SCHWEPPES CITRUS LT 350ML', 2.04);
    InsertProduct(8, 'COCA COLA LT 350ML', 2.16);
    InsertProduct(9, 'SCHWEPPES AGUA TONICA LT 350ML', 1.99);
    InsertProduct(10, 'DV MAIS PESSEGO SEM ACUCAR 1L C/6', 5.16);
    InsertProduct(11, 'DV MAIS UVA SEM ACUCAR 1L C/6', 5.16);
    InsertProduct(12, 'MONSTER ULTRA LT 473ML C/6', 5.76);
    InsertProduct(13, 'MONSTER JUICE LT 473ML C/6', 5.76);
    InsertProduct(14, 'BURN PET 1L C/4', 8.94);
    InsertProduct(15, 'BURN LT SLEEK 260ML C/6', 3.83);
    InsertProduct(16, 'MONSTER LO CARB LT 473ML C/6', 5.76);
    InsertProduct(17, 'LEÃO FUZE CHA VER ABAC/HOR ZER PET 1L C/6', 5.09);
    InsertProduct(18, 'ICE TEA LIMAO COPO 300ML C/12', 1.98);
    InsertProduct(19, 'ICE TEA PESSEGO COPO 300ML C/12', 1.98);
    InsertProduct(20, 'ICE TEA LIMAO PET 1,5L C/6', 3.96);
    cnnMain.Commit;
  except
    cnnMain.Rollback;
  end;
end;

procedure TdtmMain.InsertCustomer(AId: Integer; AName, ACity, AState: string);
begin
  cmdCustomerIns.ParamByName('id').Value := AId;
  cmdCustomerIns.ParamByName('name').Value := AName;
  cmdCustomerIns.ParamByName('city').Value := ACity;
  cmdCustomerIns.ParamByName('state').Value := AState;
  cmdCustomerIns.Execute;
end;

procedure TdtmMain.InsertProduct(AId: Integer; ADescription: string;
  APrice: Double);
begin
  cmdProductIns.ParamByName('id').Value := AId;
  cmdProductIns.ParamByName('description').Value := ADescription;
  cmdProductIns.ParamByName('price').Value := APrice;
  cmdProductIns.Execute;
end;

function TdtmMain.GetNextOrderNum: Integer;
begin
  qryNextOrdermNum.Open;
  try
    if qryNextOrdermNum.Fields[0].IsNull then result := 1
                                         else result := qryNextOrdermNum.Fields[0].Value + 1;
  finally
    qryNextOrdermNum.Close;
  end;
end;

end.
