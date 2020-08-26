unit UNoLocker;

interface

uses
      uLockableIntf
    ;

type
  TNoLocker = class(TInterfacedObject, ILockable)
  public
    procedure Lock;
    procedure Unlock;
  end;

implementation

{ TNoLocker }

procedure TNoLocker.Lock;
begin
  // Do Nothing
end;

procedure TNoLocker.Unlock;
begin
  // Do Nothing
end;

end.
