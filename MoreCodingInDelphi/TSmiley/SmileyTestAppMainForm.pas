unit SmileyTestAppMainForm;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uSmiley, ExtCtrls, AppEvnts;

type
  TSmileyTestForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    Panel1: TPanel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ApplicationEvents1Hint(Sender: TObject);
  private
    { Private declarations }
    MySmiley: TSmiley;
  public
    { Public declarations }
  end;

var
  SmileyTestForm: TSmileyTestForm;

implementation

{$R *.dfm}

uses
      frmChoose
    ;

procedure TSmileyTestForm.ApplicationEvents1Hint(Sender: TObject);
begin
  Label1.Caption := Application.Hint;
end;

procedure TSmileyTestForm.Button1Click(Sender: TObject);
begin
  MySmiley := TSmiley.Create(Panel1);

 // Centers the TSmiley in the Panel
 // Uses TRectHelper in SysUtils
  MySmiley.Left := Panel1.ClientRect.CenterPoint.X - (MySmiley.Width div 2);
  MySmiley.Top := Panel1.ClientRect.CenterPoint.Y - (MySmiley.Height div 2);


  MySmiley.Parent := Panel1;
  Button3.Enabled := True;
  Button2.Enabled := True;
  Button1.Enabled := False;
end;

procedure TSmileyTestForm.Button2Click(Sender: TObject);
begin
  MySmiley.Increment;
end;

procedure TSmileyTestForm.Button3Click(Sender: TObject);
var
  TempChooseDlg: TChooseDlg;
begin
  TempChooseDlg := TChooseDlg.Create(Self);
  try
    TempChooseDlg.Mood := MySmiley.Mood;
    TempChooseDlg.ShowModal;
    if MySmiley <> nil then
    begin
      MySmiley.ClickMood := TempChooseDlg.Mood;
    end;
  finally
    TempChooseDlg.Free;
  end;
end;

procedure TSmileyTestForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MySmiley.Free;
end;

end.
