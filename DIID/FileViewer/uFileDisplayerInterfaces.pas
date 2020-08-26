unit uFileDisplayerInterfaces;

interface

uses
      Vcl.ExtCtrls
    ;

type
  IDisplayOnPanel = interface
  ['{C334B1AE-F562-4EA6-B98D-BB52F1CBE7A7}']
    procedure DisplayOnPanel(const aPanel: TPanel);
  end;

  IDisplayFile = interface
  ['{3437F0E6-2974-4C1A-BA07-2598A2774855}']
    procedure DisplayFile(const aFilename: string; const aPanel: TPanel);
  end;

  IFileExtensionGetter = interface
  ['{9E28B18F-3CDF-4F6E-B629-D3E02E0E0E6C}']
    function GetExtension(const aFilename: string): string;
  end;

  IFilenameGetter = interface
  ['{48E1FFD8-73EA-43DF-B722-4A86206BDFCE}']
    function GetFilename: string;
  end;

  IFileDisplayerRegistry = interface
  ['{7211F4E0-0E7E-4216-912D-069E21660DE1}']
    procedure AddDisplayer(const aExt: string; aDisplayer: IDisplayFile);
    function GetDisplayer(const aExt: string): IDisplayFile;
    function GetExtensions: TArray<string>;
  end;

implementation

end.
