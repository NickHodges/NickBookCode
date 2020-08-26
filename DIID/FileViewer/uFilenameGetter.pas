unit uFilenameGetter;

interface

uses uFileDisplayerInterfaces;

type
  TFilenameGetter = class(TInterfacedObject, IFilenameGetter)
  private
    function GetFilename: string;
  end;

implementation

uses
      Vcl.Dialogs
    , Spring.Container
    ;

function TFilenameGetter.GetFilename: string;
begin
  PromptForFileName(Result);
end;

end.
