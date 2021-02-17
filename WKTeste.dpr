program WKTeste;

uses
  Vcl.Forms,
  dmMain in 'dmMain.pas' {dtmMain: TDataModule},
  fMain in 'fMain.pas' {frmMain},
  uOrderItem in 'uOrderItem.pas',
  uCustomer in 'uCustomer.pas',
  uDefs in 'uDefs.pas',
  uProduct in 'uProduct.pas',
  uOrder in 'uOrder.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdtmMain, dtmMain);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
