unit uDependencyRaisesObjection;

interface

uses
      SysUtils
    ;

type

  IWidget = interface(IInvokable)
    function IsValid: Boolean;
  end;

  TWidget = class(TInterfacedObject, IWidget)
  public
    function IsValid: Boolean;
  end;

  IWidgetProcessor = interface(IInvokable)
    procedure ProcessWidget(aWidget: IWidget);
  end;

  TWidgetProcessor = class(TInterfacedObject, IWidgetProcessor)
  public
    procedure ProcessWidget(aWidget: IWidget);
  end;

  EInvalidWidgetException = class(Exception);

implementation

{ TWidgetProcessor }

procedure TWidgetProcessor.ProcessWidget(aWidget: IWidget);
begin
  try
    if aWidget.IsValid then
    begin
      WriteLn('Widget has been properly processed');
    end;
  except
    On E: EInvalidWidgetException do
    begin
      WriteLn('IsValid failed to validate the widget');
    end;
  end;
end;

{ TWidget }

function TWidget.IsValid: Boolean;
begin
  // Just for demo purposes, lets say that 1 in 100 widgets are bad
  // But then again, we'll never call this code because it will be mocked out
  Result := Random(100) >= 99;
  if not Result then
  begin
    raise EInvalidWidgetException.Create('Bad Widget! Bad, bad widget!');
  end;
end;

end.
