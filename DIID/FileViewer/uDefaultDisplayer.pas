unit uDefaultDisplayer;

interface

uses
      uFileDisplayerInterfaces
    , Vcl.ExtCtrls
    ;

type
  TDefaultFileDisplayer = class(TInterfacedObject, IDisplayFile)
  strict private
    function GetFileSize(aFilename: string): Int64;
    procedure DisplayFile(const aFilename: string; const aPanel: TPanel);
  end;

implementation

uses
      Vcl.StdCtrls
    , Vcl.Controls
    , System.IOUtils
    , System.SysUtils
    ;

procedure TDefaultFileDisplayer.DisplayFile(const aFilename: string; const aPanel: TPanel);
var
  Memo: TMemo;
begin
  Memo := TMemo.Create(aPanel);
  Memo.Parent := aPanel;
  Memo.Align := alClient;
  Memo.ReadOnly := True;

  Memo.Lines.Add('Filename: ' + aFilename);
  Memo.Lines.Add('File Size: ' + IntToStr(GetFileSize(aFilename)) + ' bytes');
  Memo.Lines.Add('Creation Time: ' + DateTimeToStr(TFile.GetCreationTime(aFilename)));
  Memo.Lines.Add('Last Access Time: ' + DateTimeToStr(TFile.GetLastAccessTime(aFilename)));
  Memo.Lines.Add('Last Write Time: ' + DateTimeToStr(TFile.GetLastWriteTime(aFilename)));
end;

function TDefaultFileDisplayer.GetFileSize(aFilename: string): Int64;
var
  SR : TSearchRec;
begin
  if FindFirst(aFilename, faAnyFile, SR) = 0 then
  begin
    Result := Int64(SR.FindData.nFileSizeHigh) shl Int64(32) + Int64(SR.FindData.nFileSizeLow)
  end else
  begin
    Result := -1;
  end;
  FindClose(SR) ;
end;


end.
