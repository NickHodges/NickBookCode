unit frmThreads;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uMemoMessageThread;

type
  TThreadsDemoForm = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    FMemoMessageThread: TMemoMessageThread;
  public
    { Public declarations }
  end;

var
  ThreadsDemoForm: TThreadsDemoForm;

implementation

{$R *.dfm}

uses
      uVerySimpleThread
    ;

procedure TThreadsDemoForm.Button1Click(Sender: TObject);
begin
  TVerySimpleThread.Create(Memo1, 'Hello','World');
  Memo1.Lines.Add('This comes from the main thread');
end;

procedure TThreadsDemoForm.Button2Click(Sender: TObject);
begin
  FMemoMessageThread := TMemoMessageThread.Create(Memo1);
  FMemoMessageThread.MemoMessage := 'Hello from the TMemoMessageThread thread';
end;

procedure TThreadsDemoForm.Button3Click(Sender: TObject);
begin
  FMemoMessageThread.Start;
  FMemoMessageThread := nil;
end;

end.
