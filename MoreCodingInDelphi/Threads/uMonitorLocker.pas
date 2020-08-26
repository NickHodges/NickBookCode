unit uMonitorLocker;

interface

uses
      uLockableIntf
    ;

type
  TMonitorLocker = class(TInterfacedObject, ILockable)
  private
    FMonitorObj: TObject;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;
  end;

implementation

{ TMonitorLocker }

constructor TMonitorLocker.Create;
begin
  inherited Create;
  FMonitorObj := TObject.Create;
end;

destructor TMonitorLocker.Destroy;
begin
  FMonitorObj.Free;
  inherited;
end;

procedure TMonitorLocker.Lock;
begin
  TMonitor.Enter(FMonitorObj);
end;

procedure TMonitorLocker.Unlock;
begin
  TMonitor.Exit(FMonitorObj);
end;

end.
