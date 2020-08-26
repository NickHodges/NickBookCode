unit uJustRightResponsibilities;

interface

type
  IPrintable = interface
    procedure Print(aString: string);
  end;

  TConsolePrinter = class(TInterfacedObject, IPrintable)
    procedure Print(aString: string);
  end;

  IPageNumberSaver = interface
    procedure Save(aPageNumber: integer);
  end;


type
  TBook = class
  private
    FCurrentPage: integer;
    FTitle: string;
    FAuthor: string;
    procedure SetTitle(const Value: string);
    procedure SetAuthor(const Value: string);
  public
    function TurnPage: integer;
    procedure PrintCurrentPage(aPage: IPrintable);
    procedure SavePageNumber(aPageNumberSaver: IPageNumberSaver);
    property Title: string read FTitle write SetTitle;
    property Author: string read FAuthor write SetAuthor;
  end;



implementation



{ TBook }

procedure TBook.PrintCurrentPage(aPage: IPrintable);
begin
  aPage.Print('Contents of current page');
end;

procedure TBook.SavePageNumber(aPageNumberSaver: IPageNumberSaver);
begin
  aPageNumberSaver.Save(FCurrentPage);
end;

procedure TBook.SetAuthor(const Value: string);
begin
  FAuthor := Value;
end;

procedure TBook.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

function TBook.TurnPage: integer;
begin
  Inc(FCurrentPage);
  Result := FCurrentPage;
end;

{ TConsolePrinter }

procedure TConsolePrinter.Print(aString: string);
begin
  Writeln(aString);
end;

end.
