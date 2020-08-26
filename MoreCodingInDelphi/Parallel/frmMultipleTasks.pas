unit frmMultipleTasks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Threading;

type
  TMultipleTasksDemoForm = class(TForm)
    Button3: TButton;
    Memo1: TMemo;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
      AllTasks: array[0..2] of ITask;
  public
    { Public declarations }
  end;

var
  MultipleTasksDemoForm: TMultipleTasksDemoForm;

implementation

{$R *.dfm}

uses
      uSlowCode
    ;

  procedure TMultipleTasksDemoForm.Button4Click(Sender: TObject);
  begin
    TTask.Run(procedure
              begin
                TTask.WaitForAll(AllTasks);
                TThread.Synchronize(TThread.Current,
                                    procedure
                                    begin
                                      Memo1.Lines.Add('All Done');
                                    end);
              end);
  end;

  procedure TMultipleTasksDemoForm.Button5Click(Sender: TObject);
  begin
    TTask.Run(procedure
              begin
                TTask.WaitForAny(AllTasks);
                TThread.Synchronize(TThread.Current,
                                    procedure
                                    begin
                                      Memo1.Lines.Add('At least one is Done');
                                    end);
              end);
  end;

procedure TMultipleTasksDemoForm.Button6Click(Sender: TObject);
begin
    TTask.Run(procedure
              var
                SomeTasks: array[0..1] of ITask;
              begin
                SomeTasks[0] := AllTasks[0];
                SomeTasks[1] := AllTasks[1];
                TTask.WaitForAll(SomeTasks);
                TThread.Synchronize(TThread.Current,
                                    procedure
                                    begin
                                      Memo1.Lines.Add('The First Two are Done');
                                    end);
              end);

end;

procedure TMultipleTasksDemoForm.Button3Click(Sender: TObject);
begin
  AllTasks[0] := TTask.Run(procedure
                           begin
                             PrimesBelow(200000);
                             TThread.Synchronize(TThread.Current,
                                                 procedure
                                                 begin
                                                   Memo1.Lines.Add('200000 is done');
                                                 end);
                           end);

  AllTasks[1] := TTask.Run(procedure
                           begin
                             PrimesBelow(250000);
                             TThread.Synchronize(TThread.Current,
                                                 procedure
                                                 begin
                                                   Memo1.Lines.Add('250000 is done');
                                                 end);
                           end);

   AllTasks[2] := TTask.Run(procedure
                           begin
                             PrimesBelow(300000);
                             TThread.Synchronize(TThread.Current,
                                                 procedure
                                                 begin
                                                   Memo1.Lines.Add('300000 is done');
                                                 end);
                           end);
end;

end.
