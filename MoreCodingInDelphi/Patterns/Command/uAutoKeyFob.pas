unit uAutoKeyFob;

interface

uses
      uAutoKeyFobInterfaces
    , uAutoKeyFobCommands
    ;

type

  TAutoKeyFob = class
  private
    FLockButton: ISimpleCommand;
    FUnLockButton: ISimpleCommand;
    FEmergencyButton: ISimpleCommand;
  public
    constructor Create(aLocker: ISimpleCommand; aUnlocker: ISimpleCommand; aEmergencyHorn: ISimpleCommand);
    procedure PressLockButton;
    procedure PressUnlockButton;
    procedure PressEmergencyButton;
  end;

implementation

constructor TAutoKeyFob.Create(aLocker: ISimpleCommand; aUnlocker: ISimpleCommand; aEmergencyHorn: ISimpleCommand);
begin
  inherited Create;
  FLockButton := aLocker;
  FUnlockButton := aUnlocker;
  FEmergencyButton := aEmergencyHorn;
end;

procedure TAutoKeyFob.PressEmergencyButton;
begin
  FEmergencyButton.Execute;
end;

procedure TAutoKeyFob.PressLockButton;
begin
  FLockButton.Execute;
end;

procedure TAutoKeyFob.PressUnlockButton;
begin
  FUnLockButton.Execute;
end;



end.
