unit uTextFileDisplayer;

interface

uses
      uFileDisplayerInterfaces
    , Vcl.ExtCtrls
    ;

type
  TTextFileDisplayer = class(TInterfacedObject, IDisplayFile)
    procedure DisplayFile(const aFilename: string; const aPanel: TPanel);
  end;

implementation

uses
      Vcl.StdCtrls
    , Vcl.Controls
    ;

procedure TTextFileDisplayer.DisplayFile(const aFilename: string; const aPanel: TPanel);
var
  Memo: TMemo;
begin
  Memo := TMemo.Create(aPanel);
  Memo.Parent := aPanel;
  Memo.Align := alClient;
  Memo.ReadOnly := True;
  Memo.Lines.LoadFromFile(aFilename);
end;

end.
