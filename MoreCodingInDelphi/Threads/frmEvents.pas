unit frmEvents;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.SyncObjs, Vcl.StdCtrls, Spring.Collections, Vcl.ExtCtrls, uEventThread;

type
  TForm61 = class(TForm)
    Button1: TButton;
    Timer1: TTimer;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    const
      NumOfThreads = 6;
    var
    EventHandles: THandleObjectArray;
    Threads: IList<TEventThread>;
    function AThreadIsStillRunning: Boolean;
  public
    { Public declarations }
  end;

var
  Form61: TForm61;

implementation

{$R *.dfm}

function TForm61.AThreadIsStillRunning: Boolean;
var
  HandleObject: THandleObject;
begin
  Result := TEvent.WaitForMultiple(EventHandles, 1, True, HandleObject) = wrTimeout;
end;

procedure TForm61.Button1Click(Sender: TObject);
var
  i: Integer;
  LEvent: TEvent;
begin
  if (Threads.Count > 0) and AThreadIsStillRunning then
  begin
    ShowMessage('Ooops, don''t press that button! Threads are still running!');
    Exit
  end;

  SetLength(EventHandles, NumOfThreads);

  for i := 0 to NumOfThreads - 1 do
  begin
    LEvent := TEvent.Create;
    EventHandles[i] := LEvent;
    Threads.Add(TEventThread.Create(LEvent));
  end;

  Timer1.Enabled := True;
  Memo1.Lines.Add('The threads have been started!');
end;
procedure TForm61.FormCreate(Sender: TObject);
begin
  Threads := TCollections.CreateList<TEventThread>;
end;

procedure TForm61.Timer1Timer(Sender: TObject);
var
  i: Integer;
begin
  if not AThreadIsStillRunning then
  begin
    Timer1.Enabled := False;
    Memo1.Lines.Add('All the threads are done now.');
    for i := 0 to NumOfThreads - 1 do
    begin
      Memo1.Lines.Add(Threads[i].Primes.ToString)
    end;
  end;
end;

end.
