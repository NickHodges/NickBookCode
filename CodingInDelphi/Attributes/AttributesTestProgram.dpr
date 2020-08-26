program AttributesTestProgram;
{$APPTYPE CONSOLE}
uses
  SysUtils,
  Classes,
  RTTI,
  uSimpleAttributes in 'uSimpleAttributes.pas',
  uDisplayNameAttributes in 'uDisplayNameAttributes.pas';

begin
//  ShowSimpleClassAttribute;
//  WriteLn;
//  ShowPropertyAttribute;
//  WriteLn;
//  ShowMethodAttribute;
//  WriteLn;
//  ShowFieldAttribute;
//  WriteLn;
//  ShowParameterAttribute;
//  WriteLn;
  ShowDisplayAttributes;

  Readln;
end.
