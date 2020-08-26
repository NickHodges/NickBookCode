unit frmSynchronizingThread;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uIncrementerThread, uLockableIntf;

const
  MaxThreads = 4;
type
  TForm51 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
    FCSLocker: ILockable;
    FMonitorLocker: ILockable;
    FNoLocker: ILockable;
    FMutexLocker: ILockable;
    FSpinLocker: ILockable;
    ThreadArray: array[0..MaxThreads - 1] of TThread;
    procedure CreateThreads(aLocker: ILockable);
  public
    { Public declarations }
  end;

var
  Form51: TForm51;

implementation

{$R *.dfm}

uses
      uCriticalSectionLocker
    , uMonitorLocker
    , uNoLocker
    , uMutexLocker
    , uSpinLockLocker
    ;

procedure TForm51.Button1Click(Sender: TObject);
begin
  FCSLocker := TCriticalSectionLocker.Create;
  CreateThreads(FCSLocker);
end;

procedure TForm51.Button3Click(Sender: TObject);
begin
  FMonitorLocker := TMonitorLocker.Create;
  CreateThreads(FMonitorLocker);
end;

procedure TForm51.Button4Click(Sender: TObject);
begin
  FNoLocker := TNoLocker.Create;
  CreateThreads(FNoLocker);
end;

procedure TForm51.Button5Click(Sender: TObject);
begin
  FMutexLocker := TMutexLocker.Create;
  CreateThreads(FMonitorLocker);
end;

procedure TForm51.Button6Click(Sender: TObject);
begin
  FSpinLocker := TSpinLockLocker.Create;
  CreateThreads(FSpinLocker);
end;

procedure TForm51.CreateThreads(aLocker: ILockable);
var
  i: Integer;
begin
  Memo1.Clear;
  for i := 0 to MaxThreads - 1 do
  begin
    ThreadArray[i] := TIncrementerThread.Create(aLocker, Memo1);
  end;
end;

procedure TForm51.Button2Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to MaxThreads - 1 do
  begin
    ThreadArray[i].Terminate;
  end;
end;

end.
