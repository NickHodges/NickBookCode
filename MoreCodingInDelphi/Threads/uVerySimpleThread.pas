unit uVerySimpleThread;

interface

uses
      System.Classes
    , VCL.StdCtrls
    , System.SysUtils
    ;

type
  TVerySimpleThread = class(TThread)
  private
    FMemo: TMemo;
    FConcatenatedString: string;
  protected
    procedure Execute; override;
  public
    constructor Create(aMemo: TMemo; String1, String2: string);
  end;


implementation

{ TSimpleThread }

constructor TVerySimpleThread.Create(aMemo: TMemo; String1, String2: string);
begin
  if aMemo = nil then
  begin
    raise Exception.Create('You must pass a valid Memo');
  end;

  inherited Create(False);
  FMemo := aMemo;
  FConcatenatedString := String1 + ' ' + String2;
end;

procedure TVerySimpleThread.Execute;
begin
  Synchronize(procedure
              begin
                FMemo.Lines.Add('The concatenated string is: ' + FConcatenatedString);
              end);
end;


end.
