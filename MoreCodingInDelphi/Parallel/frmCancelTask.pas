unit frmCancelTask;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Threading, Vcl.StdCtrls;

type
  TForm62 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Task: ITask;
  end;

var
  Form62: TForm62;

implementation

{$R *.dfm}

procedure TForm62.Button1Click(Sender: TObject);
begin
  Task := TTask.Run(procedure
                    var
                      i: Integer;
                    begin
                      for i := 1 to 100000 do
                      begin
                        Sleep(1000);
                        if TTask.CurrentTask.Status = TTaskStatus.Canceled then
                        begin
                          Exit;
                        end;
                        TThread.Queue(TThread.Current,
                                      procedure
                                      begin
                                        Memo1.Lines.Add(i.ToString());
                                      end );
                      end;
                    end
                    ).Start;
end;

procedure TForm62.Button2Click(Sender: TObject);
begin
  Task.Cancel;
end;

end.
