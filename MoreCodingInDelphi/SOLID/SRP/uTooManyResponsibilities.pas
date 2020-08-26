unit uTooManyResponsibilities;

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
    procedure DisplayPage;        // Book Stuff
    function TurnPage: integer;   // Book stuff
    procedure PrintCurrentPage;   // Prints itself
    procedure SaveCurrentPage;    // Saves itself
    property Title: string read FTitle write SetTitle;
    property Author: string read FAuthor write SetAuthor;
  end;

implementation

{ TBook }

procedure TBook.DisplayPage;
begin
  // Show current page
end;

procedure TBook.PrintCurrentPage;
begin
  // Code that prints the current page to a printer,
  // a PDF, the console, or somewhere else.
  WriteLn('Contents of current page');
end;

procedure TBook.SaveCurrentPage;
begin
  // Imagine code here to save page number to an INI
  // file or a database or some other datastore.
  WriteLn('Saving current page to disk');
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

end.
