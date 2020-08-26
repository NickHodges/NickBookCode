unit uPointCommand;

interface

uses
      System.Types
    , Vcl.ExtCtrls
    , VCL.Graphics
    , Spring.Collections
    , uPointInterfaces
    , System.UITypes
    ;

type

  TPointPlacerCommand = class(TInterfacedObject, IPointCommand)
  private
    FCanvas: TCanvas;
    FPoint: TPoint;
  public
    constructor Create(aCanvas: TCanvas; aPoint: TPoint);
    procedure Execute;
    procedure Undo;
  end;

implementation

const
  CircleDiameter = 15;

constructor TPointPlacerCommand.Create(aCanvas: TCanvas; aPoint: TPoint);
begin
  inherited Create;
  FCanvas := aCanvas;
  FPoint := aPoint;
end;

procedure TPointPlacerCommand.Execute;
var
  FOriginalColor: TColor;
begin
  FOriginalColor := FCanvas.Brush.Color;
  try
    FCanvas.Brush.Color := clRed;
    FCanvas.Pen.Color := clRed;
    FCanvas.Ellipse(FPoint.X, FPoint.Y, FPoint.X + CircleDiameter, FPoint.Y + CircleDiameter);
  finally
    FCanvas.Brush.Color := FOriginalColor;
    FCanvas.Pen.Color := FOriginalColor;
  end;
end;

procedure TPointPlacerCommand.Undo;
begin
  FCanvas.Ellipse(FPoint.X, FPoint.Y, FPoint.X + CircleDiameter, FPoint.Y + CircleDiameter);
end;

end.
