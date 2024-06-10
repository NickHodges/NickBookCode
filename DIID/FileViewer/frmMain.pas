unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, uFileDisplayerInterfaces,
  Spring.Container;

type
  TFileDisplayerForm = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    Button2: TButton;
    ListBox1: TListBox;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
     FFileDisplayer: IDisplayOnPanel;
     FContainer: TContainer;
  end;

var
  FileDisplayerForm: TFileDisplayerForm;

implementation

uses
      uFileDisplayerRegistry
    , uRegistration
    ;

{$R *.dfm}

procedure TFileDisplayerForm.Button1Click(Sender: TObject);
begin
  FFileDisplayer.DisplayOnPanel(Panel1);
end;

procedure TFileDisplayerForm.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TFileDisplayerForm.FormCreate(Sender: TObject);
var
  Extensions: TArray<string>;
  Ext: string;
  s: string;
begin
  FContainer := TContainer.Create;
  RegisterInterfaces(FContainer);
  RegisterDisplayers;
  FFileDisplayer := FContainer.Resolve<IDisplayOnPanel>;
  Extensions := FileDisplayerRegistry.GetExtensions;
  for Ext in Extensions do
  begin
    s := Format('*%s', [Ext]);
    ListBox1.Items.Add(s);
  end;
end;

procedure TFileDisplayerForm.FormDestroy(Sender: TObject);
begin
  FContainer.Free;
end;

end.
