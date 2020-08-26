unit uSimpleInterception;

interface

uses
      Spring.Interception
    ;

type

  TInterceptor = class(TInterfacedObject, IInterceptor)
    procedure Intercept(const invocation: IInvocation);
  end;

  TClassToIntercept = class
    procedure InterceptedMethod; virtual;
  end;

procedure Main;

implementation

uses
      System.SysUtils
    ;

procedure Main;
var
  Interceptor: IInterceptor;
  InterceptedClass: TClassToIntercept;
begin
    Interceptor := TInterceptor.Create;
    InterceptedClass := TProxyGenerator.CreateClassProxy<TClassToIntercept>([Interceptor]);
    InterceptedClass.InterceptedMethod;
end;

{ TInterceptorClass }

procedure TInterceptor.Intercept(const Invocation: IInvocation);
begin
  WriteLn('Before Method call named: ', Invocation.Method.Name);
  try
    Invocation.Proceed;
  except
    on E: Exception do
    begin
      WriteLn('Method threw an exception: ' + E.Message);
    end;
  end;
  WriteLn('After Method Call named: ', Invocation.Method.Name);
end;

procedure TClassToIntercept.InterceptedMethod;
begin
  WriteLn('Calling InterceptedMethod');
end;

end.
