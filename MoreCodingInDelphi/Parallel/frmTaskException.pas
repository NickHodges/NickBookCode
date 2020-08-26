unit frmTaskException;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm61 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form61: TForm61;

implementation

{$R *.dfm}

uses
      System.Threading
    , uSlowCode
    , System.Diagnostics
    ;

type
   ETaskException = class(Exception);


procedure TForm61.Button1Click(Sender: TObject);
begin

  TTask.Run(procedure
            var
              Stopwatch: TStopWatch;
              Total: Integer;
              ElapsedSeconds: Double;
            begin
              Stopwatch := TStopwatch.StartNew;
              // oops, something happened!
              raise Exception.Create('An error of some sort occurred in the task');
              Total := PrimesBelow(200000);
              ElapsedSeconds := StopWatch.Elapsed.TotalSeconds;
              TThread.Synchronize(TThread.Current,
                                       procedure
                                       begin
                                          Memo1.Lines.Add(Format('There are  %d primes under 200,000', [Total]));
                                          Memo1.Lines.Add(Format('It took %:2f seconds to calcluate that', [ElapsedSeconds]));
                                       end);
            end
            );

end;

procedure TForm61.Button2Click(Sender: TObject);
begin
  TTask.Run(procedure
            var
              Stopwatch: TStopWatch;
              Total: Integer;
              ElapsedSeconds: Double;
            begin
              try
                Stopwatch := TStopwatch.StartNew;
                // oops, something happened!
                raise ETaskException.Create('An error of some sort occurred in the task');
                Total := PrimesBelow(200000);
                ElapsedSeconds := StopWatch.Elapsed.TotalSeconds;
                TThread.Synchronize(TThread.Current,
                                         procedure
                                         begin
                                            Memo1.Lines.Add(Format('There are  %d primes under 200,000', [Total]));
                                            Memo1.Lines.Add(Format('It took %:2f seconds to calcluate that', [ElapsedSeconds]));
                                         end);
              except
                on e: ETaskException do
                begin
                  TThread.Queue(TThread.Current,
                                procedure
                                begin
                                  raise E;
                                end
                                );
                end
              end;
            end
            );
end;

  procedure TForm61.Button3Click(Sender: TObject);
  var
    AcquiredException: Exception;
  begin
    TTask.Run(procedure
              var
                Stopwatch: TStopWatch;
                Total: Integer;
                ElapsedSeconds: Double;
              begin
                try
                  Stopwatch := TStopwatch.StartNew;
                  // oops, something happened!
                  raise ETaskException.Create('An error of some sort occurred in the task');
                  Total := PrimesBelow(200000);
                  ElapsedSeconds := StopWatch.Elapsed.TotalSeconds;
                  TThread.Synchronize(TThread.Current,
                                           procedure
                                           begin
                                              Memo1.Lines.Add(Format('There are  %d primes under 200,000', [Total]));
                                              Memo1.Lines.Add(Format('It took %:2f seconds to calcluate that', [ElapsedSeconds]));
                                           end);
                except
                  on e: ETaskException do
                  begin
                    AcquiredException := AcquireExceptionObject;
                    TThread.Queue(TThread.Current,
                                  procedure
                                  begin
                                    raise AcquiredException;
                                  end
                                  );
                  end
                end;
              end
              );
  end;

end.
