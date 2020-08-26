unit uPictureDisplayer;

interface

uses
      uFileDisplayerInterfaces
    , Vcl.ExtCtrls
    ;

type
  TPictureDisplayer = class(TInterfacedObject, IDisplayFile)
    procedure DisplayFile(const aFilename: string; const aPanel: TPanel);
  end;

implementation

uses
      System.Classes
    , Vcl.Graphics
    , Vcl.Controls
    , Vcl.Imaging.JPEG
    , Vcl.Imaging.PngImage
    , Vcl.Imaging.GIFImg
    ;

procedure TPictureDisplayer.DisplayFile(const aFilename: string; const aPanel: TPanel);
var
  Image: TImage;
begin
  Image := TImage.Create(aPanel);
  Image.Parent := aPanel;
  Image.Align := alClient;

  Image.Picture.Bitmap := TBitmap.Create;
  Image.Picture.LoadFromFile(aFilename);

end;

end.




