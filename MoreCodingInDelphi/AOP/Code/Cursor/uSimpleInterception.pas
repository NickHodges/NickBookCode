unit uSimpleInterception;

interface

uses
  Spring.Interception;


type

  TInterceptor = class(TInterfacedObject, IInterceptor)
    procedure Intercept(const invocation: IInvocation);
  end;

  TClassToIntercept = class
    procedure InterceptedMethod; virtual;
  end;

procedure DoIt;


implementation

uses
      System.SysUtils
    ;

procedure DoIt;
var
  Generator: TProxyGenerator;
  Interceptor: IInterceptor;
  InterceptedClass: TClassToIntercept;
begin
  Generator := TProxyGenerator.Create;
  try
    Interceptor := TInterceptor.Create;
    InterceptedClass := Generator.CreateClassProxy<TClassToIntercept>([Interceptor]);
    InterceptedClass.InterceptedMethod;
  finally
    Generator.Free;
  end;
end;


{ TInterceptorClass }


procedure TInterceptor.Intercept(const Invocation: IInvocation);
begin
  WriteLn('Before Method call named: ', Invocation.Method.Name);
  try
    //Invocation.
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
