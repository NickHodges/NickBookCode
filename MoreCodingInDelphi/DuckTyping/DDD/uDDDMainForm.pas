unit uDDDMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Duck, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm49 = class(TForm)
    Label1: TLabel;
    Panel1: TPanel;
    Button1: TButton;
    CheckBox1: TCheckBox;
    RadioButton1: TRadioButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form49: TForm49;

implementation

{$R *.dfm}

procedure TForm49.Button1Click(Sender: TObject);
begin
  Self.duck.all.setTo('Caption', 'Hello');
end;

end.
