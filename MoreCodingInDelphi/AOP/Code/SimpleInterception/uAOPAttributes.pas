unit uAOPAttributes;

interface

uses
  Spring.Interception,
  Spring.Container,
  Spring.Container.Common;


type

  TInterceptor = class(TInterfacedObject, IInterceptor)
    procedure Intercept(const invocation: IInvocation);
  end;

  IService = interface(IInvokable)
    ['{DA141445-02E8-4171-8B29-8F5583594772}']
    procedure DoSomething;
  end;

  [Interceptor(TypeInfo(TInterceptor))]
  //[Interceptor(TypeInfo(IInterceptor))]
  //[Interceptor('classbyname')]
  //[Interceptor('interfacebyname')]
  TService = class(TInterfacedObject, IService)
  public
    procedure DoSomething;
  end;


procedure DoIt;


implementation

uses
      System.SysUtils
    ;

procedure DoIt;
var
  LService: IService;
  LContainer: TContainer;
begin
  LContainer := TContainer.Create;
  try
    LContainer.RegisterType<TInterceptor>.Implements<TInterceptor>;
    //LContainer.RegisterType<TInterceptor>.Implements<IInterceptor>;
    //LContainer.RegisterType<TInterceptor>.Implements<TInterceptor>('classbyname');
    //LContainer.RegisterType<TInterceptor>.Implements<IInterceptor>('interfacebyname');

    LContainer.RegisterType<TService>.InterceptedBy(TypeInfo(TInterceptor));
    //LContainer.RegisterType<TService>.InterceptedBy(TypeInfo(IInterceptor));
    //LContainer.RegisterType<TService>.InterceptedBy('classbyname');
    //LContainer.RegisterType<TService>.InterceptedBy('interfacebyname');
    LContainer.Build;

    LService := LContainer.Resolve<IService>;
    LService.DoSomething;
  finally
    LContainer.Free;
  end;
end;

{ TInterceptorClass }

procedure TInterceptor.Intercept(const invocation: IInvocation);
begin
  WriteLn('Before Method call named: ' + Invocation.Method.Name);
  try
    invocation.Proceed;
  except
    on E: Exception do
    begin
      WriteLn('Method threw an exception: ' + E.Message);
    end;
  end;
  WriteLn('After Method Call');
end;

{ TService }

procedure TService.DoSomething;
begin
  Writeln('Doing Something');
end;

end.
