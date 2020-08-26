unit frmUndoExample;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Spring.Collections, uPointCommand, uPointInterfaces;

type
  TUndoExampleForm = class(TForm)
    Panel1: TPanel;
    btnUndo: TButton;
    btnClear: TButton;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnUndoClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
  private
    { Private declarations }
    FDots: IStack<IPointCommand>;
    procedure UpdateLabel;
  public
    { Public declarations }
  end;

var
  UndoExampleForm: TUndoExampleForm;

implementation

{$R *.dfm}

procedure TUndoExampleForm.btnClearClick(Sender: TObject);
begin
  if FDots.Count > 0  then
  begin
    repeat
      FDots.Pop.Undo;
    until FDots.Count <= 0;
  end;
  UpdateLabel;
end;

procedure TUndoExampleForm.btnUndoClick(Sender: TObject);
begin
  if FDots.Count > 0 then
  begin
    FDots.Pop.Undo;
  end;
  PaintBox1.Invalidate;
  UpdateLabel;
end;

procedure TUndoExampleForm.FormCreate(Sender: TObject);
begin
  FDots := TCollections.CreateStack<IPointCommand>;
end;

procedure TUndoExampleForm.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  LCommand: IPointCommand;
begin
  LCommand := TPointPlacerCommand.Create(PaintBox1.Canvas, TPoint.Create(X, Y));
  LCommand.Execute;
  FDots.Push(LCommand);
  UpdateLabel;
end;

procedure TUndoExampleForm.PaintBox1Paint(Sender: TObject);
var
  LDot: IPointCommand;
begin
  for LDot in FDots do
  begin
    LDot.Execute;
  end;
end;

procedure TUndoExampleForm.UpdateLabel;
begin
  Label1.Caption := 'Number of Dots: ' + FDots.Count.ToString();
end;

end.
