unit frmStartTaskDemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Threading;

type
  TStartTaskDemoForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    Task: ITask;
  public
    { Public declarations }
  end;

var
  StartTaskDemoForm: TStartTaskDemoForm;

implementation

{$R *.dfm}

uses uSlowCode;

procedure TStartTaskDemoForm.Button1Click(Sender: TObject);
begin
  Task := TTask.Create(procedure
                       var
                         Num: integer;
                       begin
                         Num := PrimesBelow(100000);
                         TThread.Synchronize(TThread.Current,
                                             procedure
                                             begin
                                               Memo1.Lines.Add('There are ' + Num.ToString() + ' primes below 100000');
                                             end);
                       end);
end;

procedure TStartTaskDemoForm.Button2Click(Sender: TObject);
begin
  Task.Start;
end;

end.
