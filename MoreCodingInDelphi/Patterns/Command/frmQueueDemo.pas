unit frmQueueDemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Spring.Collections;

type
  IQueueCommand = interface
  ['{380B35B6-3157-4835-BDC7-6BD7746F1147}']
    procedure Execute(aMemo: TMemo);
  end;

  TQueueCommand = class(TInterfacedObject, IQueueCommand)
  private
    FID: integer;
  public
    constructor Create(aID: integer);
    procedure Execute(aMemo: TMemo);
    property ID: integer read FID;
  end;

type
  TForm49 = class(TForm)
    Timer1: TTimer;
    Button1: TButton;
    Memo1: TMemo;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    Counter: integer;
    CommandQueue: IQueue<IQueueCommand>;
  public
    { Public declarations }
  end;

var
  Form49: TForm49;

implementation

{$R *.dfm}

procedure TForm49.Button1Click(Sender: TObject);
var
  LCommand: IQueueCommand;
begin
  if CommandQueue.Count > 0  then
  begin
    LCommand := CommandQueue.Dequeue;
    LCommand.Execute(Memo1);
    Label1.Caption := CommandQueue.Count.ToString();
  end;
end;

procedure TForm49.FormCreate(Sender: TObject);
begin
  Counter := 1;
  CommandQueue := TCollections.CreateQueue<IQueueCommand>;
end;

procedure TForm49.Timer1Timer(Sender: TObject);
var
  LCommand: IQueueCommand;
begin
  if CommandQueue.Count <= 10 then
  begin
    LCommand := TQueueCommand.Create(Counter);
    Inc(Counter);
    CommandQueue.Enqueue(LCommand);
    Label1.Caption := CommandQueue.Count.ToString();
  end;
end;

{ TQueueCommand }

constructor TQueueCommand.Create(aID: integer);
begin
  inherited Create;
  FID := aID;
end;

procedure TQueueCommand.Execute(aMemo: TMemo);
begin
  aMemo.Lines.Add('Command #' + ID.ToString());
end;

end.
