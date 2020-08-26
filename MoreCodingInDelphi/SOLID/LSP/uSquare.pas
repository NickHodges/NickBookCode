unit uSquare;

interface

type
  TRectangle = class
  private
    FWidth: integer;
    FHeight: integer;
    function GetArea: integer;
  protected
    procedure SetHeight(const Value: integer); virtual;
    procedure SetWidth(const Value: integer);  virtual;
  public
    property Height: integer read FHeight write SetHeight;
    property Width: integer read FWidth write SetWidth;
    property Area: integer read GetArea;
  end;

  TSquare = class(TRectangle)
  private
    procedure SetHeight(const Value: integer); override;
    procedure SetWidth(const Value: integer);  override;
  end;

  procedure DoRectangleStuff;


implementation

uses
      Spring.Collections
    ;

procedure DoRectangleStuff;
var
  LRectangle: TRectangle;
  Rectangles: IList<TRectangle>;
begin
  Rectangles := TCollections.CreateList<TRectangle>;

  LRectangle := TRectangle.Create;
  LRectangle.Height := 7;
  LRectangle.Width := 3;
  Rectangles.Add(LRectangle);

  LRectangle := TSquare.Create;
  LRectangle.Height := 7;
  LRectangle.Width := 3;
  Rectangles.Add(LRectangle);

  for LRectangle in Rectangles do
  begin
    WriteLn(LRectangle.GetArea);
  end;

end;



{ TRectangle }

function TRectangle.GetArea: integer;
begin
  Result := Height * Width;
end;

procedure TRectangle.SetHeight(const Value: integer);
begin
  FHeight := Value;
end;

procedure TRectangle.SetWidth(const Value: integer);
begin
  FWidth := Value;
end;

{ TSquare }

procedure TSquare.SetHeight(const Value: integer);
begin
  FHeight := Value;
  FWidth := Value;
end;

procedure TSquare.SetWidth(const Value: integer);
begin
  FHeight := Value;
  FWidth := Value;
end;


end.
