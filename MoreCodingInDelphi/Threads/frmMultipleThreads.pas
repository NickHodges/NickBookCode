unit frmMultipleThreads;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm53 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    Button1: TButton;
    Memo3: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form53: TForm53;

implementation

uses
      uPrimeThreads
    ;

{$R *.dfm}

procedure TForm53.Button1Click(Sender: TObject);
begin
  TPrimeThread.Create(Memo1, 0);
  TPrimeThread.Create(Memo2, 10);
  TPrimeThread.Create(Memo3, 20);

end;

end.
