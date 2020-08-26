unit uFilenameExtensionGetter;

interface

uses uFileDisplayerInterfaces;

type
  TFileExtensionGetter = class(TInterfacedObject, IFileExtensionGetter)
    function GetExtension(const aFilename: string): string;
  end;

implementation

uses
      System.IOUtils
    , Spring.Container
    ;

function TFileExtensionGetter.GetExtension(const aFilename: string): string;
begin
  Result := TPath.GetExtension(aFilename);
end;

end.
