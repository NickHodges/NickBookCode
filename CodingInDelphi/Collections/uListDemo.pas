unit uListDemo;

interface

procedure DemoList;

implementation

uses
     Generics.Collections
   ;

type
  TIntegerList = TList<integer>;

procedure OutputList(aMessage: string; aIntegerList: TIntegerList);
var
  i: integer;
begin
    Write(aMessage, ', the list is: ');
    for i in aIntegerList do
    begin
      Write(i, ', ');
    end;
    WriteLn;
end;


procedure DemoList;
var
  IntegerList: TIntegerList;
  i: Integer;
begin
  IntegerList := TIntegerList.Create;
  try
    for i := 1 to 10 do
    begin
      IntegerList.Add(i);
    end;
    OutputList('At the start', IntegerList);

    for I in IntegerList  do
    begin
      if i mod 2 = 0 then
      begin
        IntegerList.Remove(i);
      end;
    end;
    OutputList('After removing even numbers', IntegerList);

    // Insert 42 where the evens were
    for i := 1 to 9 do
    begin
      if i mod 2 = 0 then
      begin
        IntegerList.Insert(i, 42);
      end;
    end;
    OutputList('After inserting 42', IntegerList);

    IntegerList.Sort;
    OutputList('After sorting', IntegerList);

  finally
    IntegerList.Free;
  end;
end;


end.
