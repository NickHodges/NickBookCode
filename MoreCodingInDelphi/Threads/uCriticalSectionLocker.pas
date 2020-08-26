unit uCriticalSectionLocker;

interface

uses
      System.SyncObjs
    , uLockableIntf
    ;


type

  TCriticalSectionLocker = class(TInterfacedObject, ILockable)
  private
    FCS: TCriticalSection;
    FCurrentlyInside: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;
  end;

implementation

{ TCriticalSectionLocker }

constructor TCriticalSectionLocker.Create;
begin
  FCS := TCriticalSection.Create;
end;

destructor TCriticalSectionLocker.Destroy;
begin
  if FCurrentlyInside then
  begin
    FCS.Leave;
  end;
  FCS.Free;
  inherited;
end;

procedure TCriticalSectionLocker.Lock;
begin
  FCS.Enter;
  FCurrentlyInside := True;
end;

procedure TCriticalSectionLocker.Unlock;
begin
  FCurrentlyInside := False;
  FCS.Leave;
end;

end.
