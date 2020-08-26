unit WaysOfSpeakingUnit;

// http://www.saberingles.com.ar/ways/03.html

interface

type
  ISpeak = interface
  ['{6088FB20-1B1A-4265-9095-04E070539143}']
    function Speak(): string;
  end;

  //////////////////////////////////////////////////////////////////////////////

  TSay = class(TInterfacedObject, ISpeak)
    function Speak(): string;
  end;

  TShout = class(TSay, ISpeak)
    function Speak(): string;
  end;

  TMumble = class(TInterfacedObject, ISpeak)
    function Speak(): string;
  end;

  //////////////////////////////////////////////////////////////////////////////

  ISpeakFactory<T: ISpeak, constructor> = class
    class function Produce(): ISpeak;
  end;

  TSpeakFactory<T: TSay, constructor> = class
    class function Produce(): ISpeak;
  end;

implementation

function TSay.Speak(): string;
begin
  Result := 'Just saying...';
end;

function TShout.Speak(): string;
begin
  Result := 'Shouting out LOUD!';
end;

function TMumble.Speak(): string;
begin
  Result := 'mumble mumble...';
end;

  //////////////////////////////////////////////////////////////////////////////

class function ISpeakFactory<T>.Produce: ISpeak;
begin
  Result := T.Create();
end;

class function TSpeakFactory<T>.Produce(): ISpeak;
begin
  Result := T.Create();
end;

end.
