unit frmFutureDemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Threading;

type
  TFuturesDemoForm = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    Result200000: IFuture<integer>;
    Result250000: IFuture<integer>;
    Result300000: IFuture<integer>;
    Futures: array[0..2] of ITask;
  public
    { Public declarations }
  end;

var
  FuturesDemoForm: TFuturesDemoForm;

implementation

{$R *.dfm}

uses
      uSlowCode
    ;

procedure TFuturesDemoForm.Button1Click(Sender: TObject);
begin
  Memo1.Clear;

  Result200000 := TTask.Future<integer>(function: integer
                                        begin
                                          Result := PrimesBelow(200000);
                                        end);
  Memo1.Lines.Add('200000 Started');
  Futures[0] := Result200000;

  Result250000 := TTask.Future<integer>(function: integer
                                        begin
                                          Result := PrimesBelow(250000);
                                        end);
  Memo1.Lines.Add('250000 Started');
  Futures[1] := Result250000;

  Result300000 := TTask.Future<integer>(function: integer
                                        begin
                                          Result := PrimesBelow(300000);
                                        end);
  Memo1.Lines.Add('300000 Started');
  Futures[2] := Result300000;

end;

procedure TFuturesDemoForm.Button2Click(Sender: TObject);
begin
  TFuture<integer>.WaitForAll(Futures);
  Memo1.Lines.Add('Done Waiting.  This should appear with all the results.');
  Memo1.Lines.Add('There are ' + Result200000.GetValue.ToString +  ' prime numbers under 200,000');
  Memo1.Lines.Add('There are ' + Result250000.GetValue.ToString +  ' prime numbers under 250,000');
  Memo1.Lines.Add('There are ' + Result300000.GetValue.ToString +  ' prime numbers under 300,000');
end;

procedure TFuturesDemoForm.Button3Click(Sender: TObject);
begin
  Memo1.Lines.Add('There are ' + Result200000.GetValue.ToString +  ' prime numbers under 200,000');
  Memo1.Lines.Add('Done Waiting. This should appear with the first result.');
  Memo1.Lines.Add('There are ' + Result250000.GetValue.ToString +  ' prime numbers under 250,000');
  Memo1.Lines.Add('There are ' + Result300000.GetValue.ToString +  ' prime numbers under 300,000');
end;

end.
