unit uPointInterfaces;

interface

type

  IPointCommand = interface
  ['{5D792581-9D05-4A52-BE44-4EB0CB0D3B3B}']
    procedure Execute;
    procedure Undo;
  end;

implementation

end.
