unit uRegistrationStuff;

interface

implementation

uses
    Spring.Container
  , uFieldInjection
  , uAttributes
  , uNoServiceLocatorDemo
  ;


initialization
  GlobalContainer.RegisterType<IBrake, TBrakes>;
  GlobalContainer.RegisterType<IEngine, TEngine>;
  GlobalContainer.RegisterType<ICar, TCar>.InjectField('FBrakes');

  GlobalContainer.RegisterType<IWeapon, TSword>('sword').AsDefault;
  GlobalContainer.RegisterType<IWeapon,TSpear>('spear');
  GlobalContainer.RegisterType<IFighter, TKnight>('knight');
  GlobalContainer.RegisterType<TBattleField>;

  GlobalContainer.RegisterType<ICowboy, TCowboy>;
  GlobalContainer.RegisterType<IHorse, THorse>;


end.
