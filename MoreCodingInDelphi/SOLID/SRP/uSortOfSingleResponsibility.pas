unit uSortOfSingleResponsibility;

interface

type
  TBook = class
  private
    FCurrentPage: integer;
    FTitle: string;
    FAuthor: string;
    procedure SetTitle(const Value: string);
    procedure SetAuthor(const Value: string);
  public
    function TurnPage: integer;   // Book stuff
    procedure PrintCurrentPage;   // Prints itself
    procedure SaveCurrentPage;    // Saves itself
    property Title: string read FTitle write SetTitle;
    property Author: string read FAuthor write SetAuthor;
  end;

  // Add these classes

  TBookPagePrinter = class
  public
    class procedure PrintPage(aBook: TBook; aPageNumber: integer);
  end;

  TBookPageSaver = class
  public
    class procedure SavePage(aBook: TBook; aPageNumber: integer);
  end;



implementation

{ TBook }

procedure TBook.PrintCurrentPage;
var
  BookPagePrinter: TBookPagePrinter;
begin
  try
    BookPagePrinter.PrintPage(Self, FCurrentPage);
  finally
    BookPagePrinter.Free;
  end;
end;

procedure TBook.SaveCurrentPage;
var
  BookPageSaver: TBookPageSaver;
begin
  BookPageSaver := TBookPageSaver.Create;
  try
    BookPageSaver.SavePage(Self, FCurrentPage);
  finally
    BookPageSaver.Free;
  end;
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

{ TBookPagePrinter }

class procedure TBookPagePrinter.PrintPage(aBook: TBook; aPageNumber: integer);
begin
  // Print Page here
end;

{ TBookPageSaver }

class procedure TBookPageSaver.SavePage(aBook: TBook; aPageNumber: integer);
begin
  // Save page number for specific book here....
end;

end.
