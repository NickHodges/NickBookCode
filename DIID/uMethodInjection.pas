unit uMethodInjection;

interface

type
  INinjaStar = interface
    procedure Throw;
  end;

  INinjaSword = interface
    procedure Swing;
  end;

  TNinja = class
  private
    FNinjaSword: INinjaSword;
  public
    constructor Create(aSword: INinjaSword);
    procedure ThrowNinjaStar(aNinjaStar: INinjaStar);
  end;

implementation

{ TNinja }

constructor TNinja.Create(aSword: INinjaSword);
begin
  inherited Create;
  FNinjaSword := aSword;
end;

procedure TNinja.ThrowNinjaStar(aNinjaStar: INinjaStar);
begin
  aNinjaStar.Throw;
end;

end.
