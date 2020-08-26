unit uRegisterMocks;

interface

type
  ///	<summary>
  ///	  <para>
  ///	    Recurd to make sure the Mock classes are registered, and the unique
  ///	    ServiceNames are obtained.
  ///	  </para>
  ///	  <para>
  ///	    You need to register the mock variety globally once, and give it a
  ///	    unique name, otherwise:
  ///	  </para>
  ///	  <list type="bullet">
  ///	    <item>
  ///	      you cannot run the test twice
  ///	    </item>
  ///	    <item>
  ///	      all routines after the Build use the Mock classes
  ///	    </item>
  ///	  </list>
  ///	</summary>
  RegisterMocks = record
  strict private
    class var FTOrderEntryMockServiceName: string;
    class var FTOrderValidatorMockServiceName: string;
    class function GetTOrderEntryMockServiceName(): string; static;
    class function GetTOrderValidatorMockServiceName(): string; static;
    class procedure RegisterMockClassesIfNeeded(); static;
  public
    class property TOrderEntryMockServiceName: string read GetTOrderEntryMockServiceName;
    class property TOrderValidatorMockServiceName: string read GetTOrderValidatorMockServiceName;
  end;

implementation

uses
  uRTTI,
  Spring.Container,
  uOrderValidatorMock,
  uOrderEntryMock,
  uOrderInterfaces;

class function RegisterMocks.GetTOrderEntryMockServiceName(): string;
begin
  RegisterMockClassesIfNeeded();
  Result := FTOrderEntryMockServiceName;
end;

class function RegisterMocks.GetTOrderValidatorMockServiceName(): string;
begin
  RegisterMockClassesIfNeeded();
  Result := FTOrderValidatorMockServiceName;
end;

class procedure RegisterMocks.RegisterMockClassesIfNeeded();
begin
  if '' = FTOrderValidatorMockServiceName then
  begin
    FTOrderValidatorMockServiceName := TRtti.GetMostQualifiedName<TOrderValidatorMock, IOrderValidator>();
    GlobalContainer.RegisterType<TOrderValidatorMock>().Implements<IOrderValidator>(FTOrderValidatorMockServiceName);
  end;

  if '' = FTOrderEntryMockServiceName then
  begin
    FTOrderEntryMockServiceName := TRtti.GetMostQualifiedName<TOrderEntryMock, IOrderEntry>();
    GlobalContainer.RegisterType<TOrderEntryMock>().Implements<IOrderEntry>(FTOrderEntryMockServiceName);
  end;
end;

initialization
  RegisterMocks.TOrderValidatorMockServiceName; // force initialization
end.
