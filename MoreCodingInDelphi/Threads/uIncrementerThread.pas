unit uIncrementerThread;

interface

uses
      System.Classes
    , System.SysUtils
    , VCL.StdCtrls
    , uLockableIntf
    , uGlobalInteger
    ;

type
  TIncrementerThread = class(TThread)
  private
    FLock: ILockable;
    FMemo: TMemo;
  protected
    procedure Execute; override;
  public
    constructor Create(aLock: ILockable; aMemo: TMemo);
  end;

implementation

{ TIncrementerThread }

constructor TIncrementerThread.Create(aLock: ILockable; aMemo: TMemo);
begin
  inherited Create(False);
  FreeOnTerminate := True;
  FLock := aLock;
  FMemo := aMemo;
end;

procedure TIncrementerThread.Execute;
begin
  i := 0;
  while not Terminated do
  begin
    FLock.Lock;
    try
      i := i + 1;   // i is a global variable
      Synchronize(procedure
                  begin
                    FMemo.Lines.Add(i.ToString);
                  end);
      Sleep(1000);
    finally
      FLock.Unlock;
    end;


  end;
end;

end.
