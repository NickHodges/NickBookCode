unit frmExceptionInThread;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uExceptionInThread;

type
  TForm52 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FThread: TExceptionThread;
  public
    { Public declarations }
    procedure HandleException(Sender: TObject);
  end;

var
  Form52: TForm52;

implementation

{$R *.dfm}

procedure TForm52.Button1Click(Sender: TObject);
begin
  FThread := TExceptionThread.Create(Memo1);
  FThread.OnTerminate := HandleException;
  FThread.Start;
end;

procedure TForm52.HandleException(Sender: TObject);
var
  LThread: TExceptionThread;
begin
  if Sender is TExceptionThread then
  begin
    LThread := TExceptionThread(Sender);
  end else
  begin
    Memo1.Lines.Add('Sender is not a TExceptionThread');
    Exit;
  end;

  if LThread.FatalException <> nil then
  begin
    if LThread.FatalException is Exception then
    begin
      // Cast to Exception needed because FatalException is a TObject
      Memo1.Lines.Add(Exception(LThread.FatalException).Message);
    end;
  end;
end;

end.
