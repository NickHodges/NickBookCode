unit frmTerminatedDemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uTerminatedDemoThread;

type
  TForm49 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FThread: TCountUntilTerminatedThread;
    procedure HandleTermination(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form49: TForm49;

implementation

{$R *.dfm}

procedure TForm49.Button1Click(Sender: TObject);
begin
   FThread := TCountUntilTerminatedThread.Create(Label1);
   FThread.FreeOnTerminate := True;
   FThread.OnTerminate := HandleTermination;
   FThread.Start;
end;

procedure TForm49.Button2Click(Sender: TObject);
begin
  FThread.Terminate;
end;

procedure TForm49.HandleTermination(Sender: TObject);
begin
  Label1.Caption := 'Ended at ' + FThread.i.ToString;
end;

end.
