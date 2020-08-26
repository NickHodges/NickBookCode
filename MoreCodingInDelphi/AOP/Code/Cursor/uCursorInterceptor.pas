unit uCursorInterceptor;

interface

uses
  Spring.Interception,
  Spring.Container,
  Spring.Container.Common;


type

  TCursorInterceptor = class(TInterfacedObject, IInterceptor)
    procedure Intercept(const invocation: IInvocation);
  end;

  IService = interface(IInvokable)
    ['{DA141445-02E8-4171-8B29-8F5583594772}']
    procedure DoSomethingThatTakesAWhile;
  end;

  //[Interceptor(TypeInfo(TCursorInterceptor))]
  //[Interceptor(TypeInfo(TCursorInterceptor))]
  [Interceptor('cursor')]
  //[Interceptor('interfacebyname')]
  TService = class(TInterfacedObject, IService)
  public
    procedure DoSomethingThatTakesAWhile;
  end;


procedure DoIt;


implementation

uses
      System.SysUtils
    ;

procedure DoIt;
var
  Service: IService;
begin
  //GlobalContainer.RegisterType<TInterceptor>.Implements<TCursorInterceptor>;
  //GlobalContainer.RegisterType<TInterceptor>.Implements<TCursorInterceptor>;
  GlobalContainer.RegisterType<TCursorInterceptor>.Implements<TCursorInterceptor>('cursor');
  //GlobalContainer.RegisterType<TInterceptor>.Implements<IInterceptor>('cursor');

  //GlobalContainer.RegisterType<TService>;//.InterceptedBy(TypeInfo(TCursorInterceptor));
  //GlobalContainer.RegisterType<TService>.InterceptedBy(TypeInfo(IInterceptor));
  GlobalContainer.RegisterType<TService>.InterceptedBy('cursor');
  //GlobalContainer.RegisterType<TService>.InterceptedBy('cursor');
  GlobalContainer.Build;

  Service := GlobalContainer.Resolve<IService>;
  Service.DoSomethingThatTakesAWhile;
end;

{ TInterceptorClass }

procedure TCursorInterceptor.Intercept(const invocation: IInvocation);
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

procedure TService.DoSomethingThatTakesAWhile;
begin
  Sleep(5000);
end;

end.
