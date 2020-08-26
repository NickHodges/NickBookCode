 unit uFileDisplayer;

interface

uses
      Vcl.ExtCtrls
    , uFileDisplayerInterfaces
    ;

type

  TFileDisplayer = class(TInterfacedObject, IDisplayOnPanel)
  private
    FFilenameGetter: IFilenameGetter;
    FFileExtensionGetter: IFileExtensionGetter;
    FFileDisplayer: IDisplayFile;
    procedure ClearPanelChildren(const aPanel: TPanel);
  public
    constructor Create(aFilenameGetter: IFilenameGetter; aFileExtensionGetter: IFileExtensionGetter);
    procedure DisplayOnPanel(const aPanel: TPanel);
  end;

implementation

uses
      System.Classes,
      uFileDisplayerRegistry
    ;

procedure TFileDisplayer.ClearPanelChildren(const aPanel: TPanel);
var
  Component: TComponent;
  i: integer;
begin
  for i := 0 to aPanel.ControlCount - 1 do
  begin
    Component := aPanel.Controls[i] as TComponent;
    Component.Free;
  end;
end;

constructor TFileDisplayer.Create(aFilenameGetter: IFilenameGetter; aFileExtensionGetter: IFileExtensionGetter);
begin
  inherited Create;
  FFilenameGetter := aFilenameGetter;
  FFileExtensionGetter := aFileExtensionGetter;
end;

procedure TFileDisplayer.DisplayOnPanel(const aPanel: TPanel);
var
  LExt: string;
  LFilename: string;
begin
  ClearPanelChildren(aPanel);
  LFilename := FFilenameGetter.GetFilename;
  LExt := FFileExtensionGetter.GetExtension(LFilename);
  FFileDisplayer := FileDisplayerRegistry.GetDisplayer(LExt);
  FFileDisplayer.DisplayFile(LFilename, aPanel);
end;

end.
