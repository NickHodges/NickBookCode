unit uObserverPatternInterfaces;

interface

uses
      uGameInfo
    ;

type

  IObserver = interface
  ['{69B40B25-B2C8-4F11-B442-39B7DC26FE80}']
    procedure Update(aGameInfo: TGameInfo);
  end;

  IDisplay = interface
  ['{1517E56B-DDB3-4E04-AF1A-C70CF16293B2}']
    procedure Display;
  end;

  ISubject = interface
  ['{A9240295-B0C2-441D-BD43-932AF735832A}']
    procedure RegisterObserver(aObserver: IObserver);
    procedure RemoveObserver(aObserver: IObserver);
    procedure NotifyObservers;
  end;

implementation

end.
