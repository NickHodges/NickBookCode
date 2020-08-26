program OCPDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,

  uSimpleExample in 'uSimpleExample.pas',
  uWideOpenToModification in 'uWideOpenToModification.pas',
  uClosedToModOpenToExt in 'uClosedToModOpenToExt.pas';

var
  Order: TOrder;

begin
  try
    Order := TOrder.Create;
    try
      Order.Add(TItem.Create('Lego Set', 49.99, 1, TNormalPricer.Create));
      Order.Add(TItem.Create('Teddy Bear', 19.99, 1, TTenPercentOffPricer.Create));
      WriteLn(Format('Total: $%.2f',  [Order.TotalAmount]));
    finally
      Order.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.
