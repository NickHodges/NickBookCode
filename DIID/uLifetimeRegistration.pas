unit uLifetimeRegistration;

interface

implementation

uses
      Spring.Container
    , uSingletonDemo
    ;

initialization
  GlobalContainer.RegisterType<ILogger, TConsoleLogger>.AsSingleton();
  GlobalContainer.RegisterType<ICarPartManager, TCarPartManager>;
  GlobalContainer.Build;

end.
                                                                                                             z