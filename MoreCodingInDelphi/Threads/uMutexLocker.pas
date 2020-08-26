unit uMutexLocker;

interface

uses
      uLockableIntf
    , System.SyncObjs
    ;

type
  TMutexLocker = class(TInterfacedObject, ILockable)
  private
    FMutex: TMutex;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;
  end;

implementation

{ TMutexLocker }

constructor TMutexLocker.Create;
begin
  inherited Create;
  FMutex := TMutex.Create();
end;

destructor TMutexLocker.Destroy;
begin
  FMutex.Free;
  inherited;
end;

procedure TMutexLocker.Lock;
begin
  FMutex.Acquire;
end;

procedure TMutexLocker.Unlock;
begin
  FMutex.Release;
end;

end.
