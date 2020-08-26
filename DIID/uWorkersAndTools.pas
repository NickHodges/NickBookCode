  unit uWorkersAndTools;

interface

uses
      Spring.Container.Common
    ;

type
   IBuilder = interface
   ['{C3EB1CBB-2953-4EB4-AEFE-1EE0EDFF25FA}']
      procedure Build;
   end;

   ITool = interface
   ['{F361A823-29A0-4062-81BF-1DE472124B4C}']
      procedure Use;
   end;

   TBuilder = class(TInterfacedObject, IBuilder)
   private
      FTool: ITool;
      FName: string;
   public
     constructor Create(aName: string; aTool: ITool);
     procedure Build;
   end;

   THammer = class(TInterfacedObject, ITool)
   private
      procedure Use;
   end;

   TSaw = class(TInterfacedObject, ITool)
   private
      procedure Use;
   end;

   TScrewdriver = class(TInterfacedObject, ITool)
   private
      procedure Use;
   end;

procedure Main;

implementation

uses
      Spring.Container
    , Spring
    ;

type
  {$M+}
  TBuilderFactory = reference to function(const aToolName: string; const aBuilderName: string): IBuilder;

procedure Main;
var
  BuilderFactory: TBuilderFactory;
  Builder: IBuilder;
begin
  GlobalContainer.RegisterType<ITool, THammer>('hammer').AsDefault;
  GlobalContainer.RegisterType<ITool, TSaw>('saw');
  GlobalContainer.RegisterType<ITool, TScrewDriver>('screwdriver');

  GlobalContainer.RegisterType<IBuilder, TBuilder>;

  GlobalContainer.RegisterInstance<TBuilderFactory>(
                 function(const aToolName: string; const aBuilderName: string): IBuilder
                 var
                  Tool: ITool;
                 begin
                  Tool := GlobalContainer.Resolve<ITool>(aToolName);
                  Result := TBuilder.Create(aBuilderName, Tool);
                 end);
  GlobalContainer.Build;

  GlobalContainer.Resolve<TBuilderFactory>()('screwdriver', 'Fred').Build;
end;


{ THammer }

procedure THammer.Use;
begin
  WriteLn('Pound a nail....');
end;

{ TSaw }

procedure TSaw.Use;
begin
  WriteLn('Cut a board......');
end;

{ TScrewdriver }

procedure TScrewdriver.Use;
begin
  WriteLn('Screw a screw......');
end;

{ TBuilder }

procedure TBuilder.Build;
begin
  WriteLn(FName, ' is building something.');
  FTool.Use;
end;

constructor TBuilder.Create(aName: string; aTool: ITool);
begin
  inherited Create;
  FName := aName;
  FTool := aTool;
end;

end.
