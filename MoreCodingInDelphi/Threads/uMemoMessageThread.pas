unit uMemoMessageThread;

interface

uses
      System.Classes
    , VCL.StdCtrls
    ;

type
  TMemoMessageThread = class(TThread)
  private
    FMemo: TMemo;
    FMemoMessage: string;
  protected
    procedure Execute; override;
  public
    constructor Create(aMemo: TMemo);
    property MemoMessage: string read FMemoMessage write FMemoMessage;
  end;

implementation

uses
      uSlowCode
    ;

{ TMemoMessageThread }

constructor TMemoMessageThread.Create(aMemo: TMemo);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FMemo := aMemo;
end;

procedure TMemoMessageThread.Execute;
begin
  inherited;
  // Do Something busy
  PrimesBelow(150000);
  Synchronize(procedure
              begin
                FMemo.Lines.Add(FMemoMessage);
              end);
end;

end.
