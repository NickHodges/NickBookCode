unit uExceptionInThread;

interface

uses
      System.Classes
    , VCL.StdCtrls
    , uSlowCode
    , System.SysUtils
    ;

type
  TExceptionThread = class(TThread)
  private
    FMemo: TMemo;
  public
    constructor Create(aMemo: TMemo);
    procedure Execute; override;
  end;

implementation

{ TExceptionThread }

constructor TExceptionThread.Create(aMemo: TMemo);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FMemo := aMemo;
end;

procedure TExceptionThread.Execute;
begin
  PrimesBelow(50000);
  raise Exception.Create('This exception was raised on purpose');
end;

end.
