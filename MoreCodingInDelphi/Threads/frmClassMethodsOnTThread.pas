unit frmClassMethodsOnTThread;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm50 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form50: TForm50;

implementation

uses
      uSlowCode
    ;

{$R *.dfm}

procedure TForm50.Button1Click(Sender: TObject);
var
  LTotal: integer;
begin
  TThread.CreateAnonymousThread(procedure
                                begin
                                  LTotal := PrimesBelow(150000);
                                  TThread.Synchronize(TThread.CurrentThread, procedure
                                                                             begin
                                                                               Memo1.Lines.Add('Total: ' + LTotal.ToString);
                                                                               Memo1.Lines.Add('All Done from an Anonymous thread');
                                                                             end);

                                end).Start;

end;

procedure TForm50.Button2Click(Sender: TObject);
var
  LTotal: integer;
begin
  TThread.Synchronize(TThread.CurrentThread, procedure
                                             begin
                                               LTotal := PrimesBelow(150000);
                                               Memo1.Lines.Add('Total: ' + LTotal.ToString);
                                               Memo1.Lines.Add('All done from the Synchronize class procedure');
                                             end);
end;

procedure TForm50.Button3Click(Sender: TObject);
var
  LTotal: integer;
begin
TThread.Queue(TThread.CurrentThread, procedure
                                     begin
                                       LTotal := PrimesBelow(150000);
                                       Memo1.Lines.Add('Total: ' + LTotal.ToString);
                                       Memo1.Lines.Add('All Done from the Queue class procedure');
                                     end);
end;

end.
