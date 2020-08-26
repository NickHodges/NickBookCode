unit uDictionaryDemo;

interface

uses
      Generics.Collections
    ;

type

  TStudentGPADictionary = TDictionary<string, double>;

procedure ProcessStudents;

implementation

uses
      System.SysUtils
    ;

procedure ReportOnStudents(aStudents: TStudentGPADictionary);
var
  Student: string;
begin
  for Student in aStudents.Keys do
  begin
    WriteLn(Student, ' has a ', Format('%.2f', [aStudents[Student]]), ' GPA.');
  end;
end;

procedure ProcessStudents;
var
  StudentGPADictionary: TStudentGPADictionary;
begin
  StudentGPADictionary := TStudentGPADictionary.Create;
  try
    // Add some students
    StudentGPADictionary.Add('Sally Superstar', 4.0);
    StudentGPADictionary.Add('Harry Hardworker', 3.73);
    StudentGPADictionary.Add('Andy Average', 2.55);
    StudentGPADictionary.Add('Freddy Failure', 1.01);

    // Report out on students
    ReportOnStudents(StudentGPADictionary);
    WriteLn;

    WriteLn('Oops, we missed a few classes....');
    StudentGPADictionary['Andy Average'] := 2.62;
    StudentGPADictionary['Harry Hardworker'] := 3.70;
    // Report out on students
    ReportOnStudents(StudentGPADictionary );
    WriteLn;
  finally
    StudentGPADictionary.Free;
  end;
end;


end.
