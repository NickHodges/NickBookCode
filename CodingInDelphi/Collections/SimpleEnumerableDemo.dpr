program SimpleEnumerableDemo;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  Spring,
  Spring.Collections;


procedure OutputTheMax;
var
  List: IList<Integer>;
begin
    List := TCollections.CreateList<integer>;
    List.AddRange([1,6,2,9,5487,3,2,7,9,1]);

    WriteLn('The max number is: ', List.Max);

end;

function ContainsLetterZ: IEnumerable<string>;
var
  List: IList<string>;
begin
  List := TCollections.CreateList<string>;
  List.AddRange(['zoo', 'park', 'city', 'town', 'museum', 'jazz festival', 'fazed']);

  Result := List.Where(function(const aString: string): Boolean
                     begin
                       Result :=aString.Contains('z');
                     end);
end;

procedure WriteOutZWords;
var
  ContainsZ: IEnumerable<string>;
  S: string;
begin
  WriteLn('The following words have "z" in them:');
  ContainsZ := ContainsLetterZ;
  for S in ContainsZ do
  begin
    WriteLn(S);
  end;
end;

procedure SimpleForEachDemo;
var
  List: IList<integer>;
  Action: TAction<integer>;
  i: Integer;
begin
  Action := procedure(const aInt: integer) begin Writeln(Format('This number is: %d', [aInt])); end;

  List := TCollections.CreateList<integer>;
  for i := 1 to 10 do
  begin
    List.Add(Random(100));
  end;

  List.ForEach(Action);
end;




begin
  try
    OutputTheMax;
    WriteLn;
    WriteOutZWords;
    WriteLn;
    SimpleForEachDemo;
    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.

