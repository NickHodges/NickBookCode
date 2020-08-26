unit frmSimpleTaskDemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TSimpleTaskForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SimpleTaskForm: TSimpleTaskForm;

implementation

uses
      System.Diagnostics
    , uSlowCode
    , System.Threading
    ;

{$R *.dfm}

procedure TSimpleTaskForm.Button1Click(Sender: TObject);
var
  Stopwatch: TStopWatch;
  Total: Integer;
  ElapsedSeconds: Double;
begin
    Stopwatch := TStopwatch.StartNew;
    Total := PrimesBelow(200000);
    ElapsedSeconds := StopWatch.Elapsed.TotalSeconds;
    Memo1.Lines.Add(Format('There are  %d primes under 200,000', [Total]));
    Memo1.Lines.Add(Format('It took %:2f seconds to calcluate that', [ElapsedSeconds]));
end;

procedure TSimpleTaskForm.Button2Click(Sender: TObject);
begin

  TTask.Run(procedure
            var
              Stopwatch: TStopWatch;
              Total: Integer;
              ElapsedSeconds: Double;
            begin
              Stopwatch := TStopwatch.StartNew;
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

end.
