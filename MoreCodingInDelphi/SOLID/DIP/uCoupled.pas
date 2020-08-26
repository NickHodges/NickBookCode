unit uCoupled;

interface

type
  TCompressionService = class
  private
    function DoCompression(aByteArray: TArray<Byte>): TArray<Byte>;
  public
    procedure Compress(aSourceFilename: string; aTargetFilename: string);
  end;

implementation

uses
     System.Classes
   , System.SysUtils
   ;

{ TCompressionService }

procedure TCompressionService.Compress(aSourceFilename: string; aTargetFilename: string);
var
  LContent, CompressedContent: TArray<Byte>;
  InFS, OutFS: TFileStream;
begin
  // Read content
  InFS := TFileStream.Create(aSourceFilename, fmOpenRead);
  try
    SetLength(LContent, InFS.Size);
    InFS.Read(LContent, InFS.Size);
  finally
    InFS.Free;
  end;

  // Compress
  CompressedContent := DoCompression(LContent);

  // Write compressed content
  OutFS := TFileStream.Create(aTargetFilename, fmCreate);
  try
    OutFS.Write(CompressedContent, Length(CompressedContent));
  finally
    OutFS.Free;
  end;


end;

function TCompressionService.DoCompression(aByteArray: TArray<Byte>): TArray<Byte>;
begin
  // Here's where you'd compress the file..........
  Result := aByteArray;
end;

end.
