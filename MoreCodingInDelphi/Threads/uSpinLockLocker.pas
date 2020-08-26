unit uSpinLockLocker;

interface

uses
      uLockableIntf
    , System.SyncObjs
    , WinAPI.Windows  // inline
    ;

type
  TSpinLockLocker = class(TInterfacedObject, ILockable)
  private
    FSpinLock: TSpinLock;
  public
    constructor Create;
    procedure Lock;
    procedure Unlock;
  end;

implementation

{ TSpinLockLocker }

constructor TSpinLockLocker.Create;
begin
  inherited Create;
  FSpinLock := TSpinLock.Create(False);
end;

procedure TSpinLockLocker.Lock;
begin
  FSpinLock.Enter;
end;

procedure TSpinLockLocker.Unlock;
begin
  FSpinLock.Exit();
end;

end.
