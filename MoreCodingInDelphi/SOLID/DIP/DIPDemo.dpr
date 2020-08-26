program DIPDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uCoupled in 'uCoupled.pas',
  uDecoupled in 'uDecoupled.pas',
  uFileReaderWriter in 'uFileReaderWriter.pas';

var
  CoupledCS: uCoupled.TCompressionService;
  DeCoupledCS: uDecoupled.TCompressionService;
  R: IReader;
  W: IWriter;

begin
{$REGION 'CoupledVersion'}
//    try
//      CoupledCS := uCoupled.TCompressionService.Create;
//      try
//        CoupledCS.Compress('c:\junk\blah.txt', 'c:\junk\foo.txt');
//      finally
//        CoupledCS.Free;
//      end;
//    except
//      on E: Exception do
//        Writeln(E.ClassName, ': ', E.Message);
//    end;
{$ENDREGION}

{$REGION 'Decoupled Version'}
    try
      DeCoupledCS := TCompressionService.Create;
      try
        R := TFileReader.Create('c:\junk\blah.txt');
        W := TFileWriter.Create('c:\junk\foo.txt');
        DeCoupledCS.Compress(R, W);
      finally
        DeCoupledCS.Free;
      end;
    except
      on E: Exception do
        Writeln(E.ClassName, ': ', E.Message);
    end;
{$ENDREGION}


end.
