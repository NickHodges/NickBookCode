unit uFileReaderWriter;

interface

uses
      uDecoupled
    ;

type

  TFileReader = class(TInterfacedObject, IReader)
  private
    FFilename: string;
  public
    constructor Create(aFilename: string);
    function ReadAll: TArray<Byte>;
  end;

  TFileWriter = class(TInterfacedObject, IWriter)
  private
    FFilename: string;
  public
    constructor Create(aFilename: string);
    procedure WriteAll(aBytes: TArray<Byte>);
  end;

implementation

uses
       System.Classes
     , System.SysUtils
     ;

{ TFileReader }

constructor TFileReader.Create(aFilename: string);
begin
  inherited Create;
  FFilename := aFilename;
end;

function TFileReader.ReadAll: TArray<Byte>;
var
  FS: TFileStream;
begin
  FS := TFileStream.Create(FFilename, fmOpenRead);
  try
    SetLength(Result, FS.Size);
    FS.Read(Result, FS.Size);
  finally
    FS.Free;
  end;
end;

{ TFileWriter }

constructor TFileWriter.Create(aFilename: string);
begin
  inherited Create;
  FFilename := aFilename;
end;

procedure TFileWriter.WriteAll(aBytes: TArray<Byte>);
var
  FS: TFileStream;
begin
  FS := TFileStream.Create(FFilename, fmCreate);
  try
    FS.Write(aBytes, Length(aBytes));
  finally
    FS.Free;
  end;
end;

end.
