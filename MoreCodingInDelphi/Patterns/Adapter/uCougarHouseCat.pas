unit uCougarHouseCat;

interface


type
  IHouseCat = interface
  ['{4A5537CF-60D7-4617-95F9-9E4DC3660FB4}']
    procedure Hunt;
    procedure Meow;
  end;

  THouseCat = class(TInterfacedObject, IHouseCat)
    procedure Hunt;
    procedure Meow;
  end;

  ICougar  = interface
  ['{DD635959-ED9E-4A55-B17A-ABCE7B49204F}']
    procedure Hunt;
    procedure Growl;
  end;

  TCougar = class(TInterfacedObject, ICougar)
    procedure Hunt;
    procedure Growl;
  end;

  THouseCatAdapter = class(TInterfacedObject, ICougar)
  private
    FHouseCat: IHouseCat;
  public
    constructor Create(aHouseCat: IHouseCat);
    procedure Hunt;
    procedure Growl;
  end;

implementation

{ THouseCat }

procedure THouseCat.Hunt;
begin
  WriteLn('Catch a mouse');
end;

procedure THouseCat.Meow;
begin
  WriteLn('Meow!');
end;

{ TCougar }

procedure TCougar.Growl;
begin
  WriteLn('GROWL!');
end;

procedure TCougar.Hunt;
begin
  WriteLn('Run down a mule deer');
end;

{ THouseCatAdapter }

constructor THouseCatAdapter.Create(aHouseCat: IHouseCat);
begin
  inherited Create;
  FHouseCat := aHouseCat;
end;

procedure THouseCatAdapter.Growl;
var
  i: Integer;
begin
  for i := 1 to 5 do
  begin
    FHouseCat.Meow;
  end;
end;

procedure THouseCatAdapter.Hunt;
begin
  WriteLn('Catch a really big mouse and pretend it is a deer.');
end;

end.
