unit uDecoupled;

interface

type
  IReader = interface
    function ReadAll: TArray<Byte>;
  end;

  IWriter = interface
    procedure WriteAll(aBytes: TArray<Byte>);
  end;

  TCompressionService = class
  private
    function DoCompression(aByteArray: TArray<Byte>): TArray<Byte>;
  public
    procedure Compress(aReader: IReader; aWriter: IWriter);
  end;



implementation

{ TCompressionService }

procedure TCompressionService.Compress(aReader: IReader; aWriter: IWriter);
var
  LContent: TArray<Byte>;
  LCompressedContent: TArray<Byte>;
begin
  // Read Content
  LContent := aReader.ReadAll;
  // Compress
  LCompressedContent := DoCompression(LContent);
  // WriteContent
  aWriter.WriteAll(LCompressedContent);

end;

function TCompressionService.DoCompression(aByteArray: TArray<Byte>): TArray<Byte>;
begin
  // Compression Algorithm would go here.....
  Result := aByteArray;
end;



end.
