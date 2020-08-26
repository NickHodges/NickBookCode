program SynchronizingThreadsDemo;

uses
  Vcl.Forms,
  frmSynchronizingThread in 'frmSynchronizingThread.pas' {Form51},
  uCriticalSectionLocker in 'uCriticalSectionLocker.pas',
  uIncrementerThread in 'uIncrementerThread.pas',
  uLockableIntf in 'uLockableIntf.pas',
  uMonitorLocker in 'uMonitorLocker.pas',
  UNoLocker in 'UNoLocker.pas',
  uGlobalInteger in 'uGlobalInteger.pas',
  uMutexLocker in 'uMutexLocker.pas',
  uSpinLockLocker in 'uSpinLockLocker.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm51, Form51);
  Application.Run;
end.
