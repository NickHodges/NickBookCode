unit uRegistration;

interface

uses
      Spring.Container
    ;

procedure RegisterInterfaces(aContainer: TContainer);
procedure RegisterDisplayers;

implementation

uses
      uFileDisplayerInterfaces
    , uFilenameGetter
    , uFileDisplayer
    , uFileNameExtensionGetter
    , uFileDisplayerRegistry
    , uTextFileDisplayer
    , uPictureDisplayer
    ;

procedure RegisterInterfaces(aContainer: TContainer);
begin
  aContainer.RegisterType<IDisplayOnPanel, TFileDisplayer>;
  aContainer.RegisterType<IFileExtensionGetter, TFileExtensionGetter>;
  aContainer.RegisterType<IFilenameGetter, TFilenameGetter>;
  aContainer.Build;
end;

procedure RegisterDisplayers;
var
  TextFileDisplayer: IDisplayFile;
  PictureFileDisplayer: IDisplayFile;
begin
  TextFileDisplayer := TTextFileDisplayer.Create;
  FileDisplayerRegistry.AddDisplayer('.txt', TextFileDisplayer);
  FileDisplayerRegistry.AddDisplayer('.pas', TextFileDisplayer);
  FileDisplayerRegistry.AddDisplayer('.dpr', TextFileDisplayer);
  FileDisplayerRegistry.AddDisplayer('.dproj', TextFileDisplayer);
  FileDisplayerRegistry.AddDisplayer('.xml', TextFileDisplayer);

  PictureFileDisplayer := TPictureDisplayer.Create;
  FileDisplayerRegistry.AddDisplayer('.jpg', PictureFileDisplayer);
  FileDisplayerRegistry.AddDisplayer('.bmp', PictureFileDisplayer);
  FileDisplayerRegistry.AddDisplayer('.png', PictureFileDisplayer);
  FileDisplayerRegistry.AddDisplayer('.gif', PictureFileDisplayer);
end;

end.
