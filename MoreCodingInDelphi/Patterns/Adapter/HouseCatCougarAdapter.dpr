program HouseCatCougarAdapter;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uCougarHouseCat in 'uCougarHouseCat.pas';

var
  HouseCat: IHouseCat;
  Cougar: ICougar;
  HouseCatAdapter: ICougar;

procedure DoCougarStuff(aCougar: ICougar);
begin
  aCougar.Hunt;
  aCougar.Growl;
end;

begin
  try
    HouseCat := THouseCat.Create;
    HouseCat.Meow;
    HouseCat.Hunt;

    Writeln;

    HouseCatAdapter := THouseCatAdapter.Create(HouseCat);
    DoCougarStuff(HouseCatAdapter);

    Readln;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
