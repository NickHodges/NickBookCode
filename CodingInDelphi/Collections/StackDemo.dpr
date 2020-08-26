program StackDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uStackDemo in 'uStackDemo.pas';

  procedure CheckIsPalindrome(const aString: string);
  begin
    if IsPalindrome(aString) then
    begin
      Writeln(Format('%s is indeed a palindrome', [QuotedStr(aString)]));
    end else
    begin
      Writeln(Format('%s is NOT a palindrome', [QuotedStr(aString)]));
    end;
  end;


begin
  try
    CheckIsPalindrome('racecar');
    CheckIsPalindrome('A Toyota');
    CheckIsPalindrome('Madam, I''m Adam');
    CheckIsPalindrome('I am not a bicycle');
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.
