unit frmParallelForDemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Threading;

type

  TParallelForDemoForm = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
    ForLoopTask: ITask;
  public
    { Public declarations }
  end;

var
  ParallelForDemoForm: TParallelForDemoForm;

implementation

uses

      System.Diagnostics
    , System.SyncObjs
    , uSlowCode
    ;

{$R *.dfm}

procedure TParallelForDemoForm.Button1Click(Sender: TObject);
begin
  Memo1.Clear;
  Memo1.Update;
  TParallel.&For(1, 10,
                 procedure (aIndex: integer)
                 begin
                   PrimesBelow(50000);
                   TThread.Queue(TThread.Current,
                                 procedure
                                 begin
                                   Memo1.Lines.Add(aIndex.ToString());
                                 end);

                 end);
end;

procedure TParallelForDemoForm.Button2Click(Sender: TObject);
var
  PrimeTotal: integer;
  TotalTime: integer;
  StopWatch: TStopWatch;
  S: string;
begin
  Memo1.Clear;
  Memo1.Update;

  StopWatch := TStopWatch.StartNew;
  PrimeTotal := PrimesBelow(100000);
  StopWatch.Stop;
  TotalTime := StopWatch.ElapsedMilliseconds;
  S := Format('There are %d primes below 100,000.  It took %d milliseconds to figure that out.', [PrimeTotal, TotalTime]);
  Memo1.Lines.Add(S);

  Memo1.Lines.Add('');

  StopWatch := TStopWatch.StartNew;
  PrimeTotal := PrimesBelowParallel(100000);
  StopWatch.Stop;
  TotalTime := StopWatch.ElapsedMilliseconds;
  S := Format('There are %d primes below 100,000.  It took %d milliseconds to figure that out.', [PrimeTotal, TotalTime]);
  Memo1.Lines.Add(S);

end;

procedure TParallelForDemoForm.Button3Click(Sender: TObject);
var
  LoopResult: TParallel.TLoopResult;
begin
  Memo1.Clear;
  Memo1.Update;
  ForLoopTask := TTask.Create(
    procedure
    begin
      LoopResult := TParallel.&For(1, 30,
        procedure (aIndex: integer; LoopState: TParallel.TLoopState)
        begin
          if (ForLoopTask.Status = TTaskStatus.Canceled) and (not LoopState.Stopped) then
          begin
            LoopState.Stop;
          end;
          if LoopState.Stopped then
          begin
            TThread.Queue(TThread.Current,
                          procedure
                          begin
                            Memo1.Lines.Add(aIndex.ToString +  ' has stopped early');
                          end);
            Exit;
          end;
          PrimesBelow(150000);
          TThread.Queue(TThread.Current,
                        procedure
                        begin
                          Memo1.Lines.Add(aIndex.ToString());
                        end
                        );
        end
      );
      if LoopResult.Completed then
      begin
        Memo1.Lines.Add('The Loop Completed')
      end else
      begin
        Memo1.Lines.Add('The loop stopped before the end')
      end;
    end
  );
  ForLoopTask.Start;
end;

procedure TParallelForDemoForm.Button4Click(Sender: TObject);
begin
  if Assigned(ForLoopTask) then
  begin
    ForLoopTask.Cancel
  end;
end;

procedure TParallelForDemoForm.Button6Click(Sender: TObject);
var
  LoopResult: TParallel.TLoopResult;
begin
  Memo1.Clear;

  TTask.Run(
            procedure
            begin
              LoopResult :=  TParallel.&For(1, 30,
                                            procedure(aIndex: integer)
                                            begin
                                              PrimesBelow(50000);
                                              TThread.Queue(TThread.Current,
                                                                 procedure
                                                                 begin
                                                                   Memo1.Lines.Add(aIndex.ToString());
                                                                 end);
                                            end);
              if LoopResult.Completed then
              begin
                Memo1.Lines.Add('The loop completed.');
              end;
            end);
end;

end.
