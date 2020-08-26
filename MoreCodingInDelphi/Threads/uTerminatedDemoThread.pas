unit uTerminatedDemoThread;

interface

uses
      System.Classes
    , VCL.StdCtrls
    ;

type
  TCountUntilTerminatedThread = class(TThread)
  private
    FLabel: TLabel;
  protected
    procedure Execute; override;
  public
    i: integer;
    constructor Create(aLabel: TLabel);
  end;

implementation

uses
      System.SysUtils
    , WinAPI.Windows
    , System.SyncObjs
    ;

{ TCountUntilTerminatedThread }

constructor TCountUntilTerminatedThread.Create(aLabel: TLabel);
begin
  inherited Create(True);
  FLabel := aLabel;
end;

procedure TCountUntilTerminatedThread.Execute;
begin
  inherited;
  while not Terminated do
  begin
    Synchronize(procedure
                begin
                  FLabel.Caption := i.ToString;
                end);
    Sleep(1000);
    TInterlocked.Increment(i);
  end;
end;

end.
