unit frmStrideDemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls, Vcl.Samples.Spin;

type
  TStrideDemoForm = class(TForm)
    Button1: TButton;
    PaintBox1: TPaintBox;
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    procedure PaintRectangle(aIndex: integer);
    procedure ClearRectangle;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StrideDemoForm: TStrideDemoForm;

implementation

uses
      System.Threading
    , System.UIConsts
    , System.UITypes
    ;

{$R *.dfm}

const
  SquareSize = 30;
  SquaresPerRow = 10;
  TotalSquares = 100;


procedure TStrideDemoForm.Button1Click(Sender: TObject);
begin
  ClearRectangle;
  TTask.Run(procedure
            begin
              TParallel.For(SpinEdit1.Value, 0, TotalSquares - 1, PaintRectangle)
            end)
end;

procedure TStrideDemoForm.PaintRectangle(aIndex: integer);
var
  LTop, LLeft: integer;
  LRed, LGreen, LBLue: Byte;
  LColor: TAlphaColor;
begin
    Sleep(100);
    LTop :=  (aIndex div SquaresPerRow) * SquareSize;
    LLeft := (aIndex mod SquaresPerRow) * SquareSize;

    LGreen := TThread.Current.ThreadID MOD High(Byte);
    LRed := (16 * LGreen) MOD High(Byte);
    LBlue := (4 * LGreen) MOD High(Byte);
    LColor := RGB(LRed, LGreen, LBlue);
    TThread.Queue(TThread.Current,
                        procedure
                        begin
                          Paintbox1.Canvas.Brush.Color := LColor;
                          Paintbox1.Canvas.Rectangle(LLeft, LTop, LLeft + SquareSize, LTop + SquareSize);
                        end);

end;

procedure TStrideDemoForm.ClearRectangle;
begin
  PaintBox1.Canvas.Brush.Color := Self.Color;
  PaintBox1.Canvas.Rectangle(0, 0, PaintBox1.Width, PaintBox1.Height);
end;

end.


