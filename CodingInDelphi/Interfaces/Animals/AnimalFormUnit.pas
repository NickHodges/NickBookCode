{ Copyright (c) 2013 Jeroen Wiert Pluimers for BeSharp.net and Coding In Delphi.
Full BSD License is available at http://BeSharp.codeplex.com/license }

unit AnimalFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.Actions, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan,
  AnimalClassesUnit, System.Rtti;

type
  TAnimalForm = class(TForm)
    AnimalTypeRadioGroup: TRadioGroup;
    FillAnimalTypesButton: TButton;
    LogMemo: TMemo;
    ShowAnimalLocomotionsButton: TButton;
    ActionManager: TActionManager;
    FillAnimalTypesAction: TAction;
    ShowAnimalLocomotionsAction: TAction;
    procedure FillAnimalTypesActionExecute(Sender: TObject);
    procedure ShowAnimalLocomotionsActionExecute(Sender: TObject);
    procedure ShowAnimalLocomotionsActionUpdate(Sender: TObject);
  strict private
    function SupportsAndLog_Fails(const Instance: IInterface; out Intf; const IID:
        TGUID; const InterfaceTypeInfo: Pointer = nil): Boolean;
    function SupportsAndLog_Works(const Instance: IInterface; out Intf; const IID:
        TGUID; const InterfaceTypeInfo: Pointer = nil): Boolean;
  strict protected
    procedure Log(const Line: string); overload; virtual;
    procedure Log(AnimalClass: TClass); overload; virtual;
  public
    function GetAnimalClasses(): TArray<TAnimalClass>;
    function SupportsAndLog(const Instance: IInterface; const IID: TGUID; out Intf;
        const InterfaceTypeInfo: Pointer = nil): Boolean; overload;
  end;

var
  AnimalForm: TAnimalForm;

implementation

uses
  RttiHelpers,
  LocomotionInterfacesUnit;

{$R *.dfm}

function TAnimalForm.GetAnimalClasses(): TArray<TAnimalClass>;
begin
  // Without referencing the animal classes, no RTTI will be generated.
  // For the code in FillAnimalTypesActionExecute, it needs to be in the order of the hierarchy.
  Result := TArray<TAnimalClass>.Create(
    TAnimal,
    TBird, TDuck, TEmu, TPigeon,
    TFish, THerring, TSalmon, TShark,
    TInsect, TAnt, TButterfly,
    TMammal, TBat, TCat, TDog, THuman, TWhale
  );
end;

procedure TAnimalForm.FillAnimalTypesActionExecute(Sender: TObject);
var
  AnimalClass: TAnimalClass;
  RttiContext: TRttiContext;
  RttiTypes: TArray<TRttiType>;
  RttiType: TRttiType;
  Predicate: TPredicate<TRttiType>;
begin
  // Basically two ways to do this: through the AnimalClasses, or through all of the classes through RTTI

  // first way:
  AnimalTypeRadioGroup.Items.Clear();
  for AnimalClass in GetAnimalClasses() do
  begin
    Log(AnimalClass);
    AnimalTypeRadioGroup.Items.Add(
      StringOfChar(' ', 4*AnimalClass.ClassHierarchyDepth()-12) + AnimalClass.ClassName);
  end;
  AnimalTypeRadioGroup.ItemIndex := 0;

  // second way:
  Predicate := function(ARttiType: TRttiType): Boolean
  begin
    Result := ARttiType.GetUnitName = TAnimal.UnitName;
    Result := Result and ARttiType.IsInstance;
  end;

  RttiContext := TRttiContext.Create();
  RttiTypes := RttiContext.FindTypes(Predicate);
  for RttiType in RttiTypes do
  begin
    Log(RttiType.AsInstance.MetaclassType);
  end;
end;

procedure TAnimalForm.Log(const Line: string);
begin
  LogMemo.Lines.Add(Line);
end;

procedure TAnimalForm.Log(AnimalClass: TClass);
begin
  Log(Format('%s (%s) %d', [
    AnimalClass.QualifiedClassName, AnimalClass.ClassName, AnimalClass.ClassHierarchyDepth]));
end;

procedure TAnimalForm.ShowAnimalLocomotionsActionExecute(Sender: TObject);
var
  AnimalClassName: string;
  AnimalClass: TAnimalClass;
  Animal: IInterface;
  Flying: IFlying;
  Jumping: IJumping;
  Running: IRunning;
  Swimming: ISwimming;
begin
  Log('');

  AnimalClassName := Trim(AnimalTypeRadioGroup.Items[AnimalTypeRadioGroup.ItemIndex]);

  Log(Format('Searching for an animal class matching %s', [AnimalClassName]));
  for AnimalClass in GetAnimalClasses() do
  begin
    if AnimalClass.ClassNameIs(AnimalClassName) then
    begin
      Log(Format('Constructing an instance of %s', [AnimalClassName]));
      Animal := AnimalClass.Create(Self.Log);

      Log(Format('Listing the interfaces supported by %s', [AnimalClassName]));

      if SupportsAndLog(Animal, IJumping, Jumping) then //, TypeInfo(IJumping)) then
        Jumping.Jump();

      if SupportsAndLog(Animal, IFlying, Flying) then //, TypeInfo(IFlying)) then
        Flying.Fly();

      if SupportsAndLog(Animal, IRunning, Running) then //, TypeInfo(IRunning)) then
        Running.Run();

      if SupportsAndLog(Animal, ISwimming, Swimming) then //, TypeInfo(ISwimming)) then
        Swimming.Swim();
    end;
  end;
end;

procedure TAnimalForm.ShowAnimalLocomotionsActionUpdate(Sender: TObject);
var
  Enabled: Boolean;
begin
  Enabled := AnimalTypeRadioGroup.Items.Count > 0;
  Enabled := Enabled and (AnimalTypeRadioGroup.ItemIndex <> -1);
  (Sender as TAction).Enabled := Enabled;
end;

{ Interface support routines }

function TAnimalForm.SupportsAndLog(const Instance: IInterface; const IID:
    TGUID; out Intf; const InterfaceTypeInfo: Pointer = nil): Boolean;
begin
  Result := SupportsAndLog_Works(Instance, Intf, IID, InterfaceTypeInfo);
//  Result := SupportsAndLog_Fails(Instance, Intf, IID, InterfaceTypeInfo);
end;

function TAnimalForm.SupportsAndLog_Fails(const Instance: IInterface; out Intf;
    const IID: TGUID; const InterfaceTypeInfo: Pointer = nil): Boolean;
var
  RttiContext: TRttiContext;
  Line: string;
  RttiType: TRttiType;
begin
// This works because we always call RttiContext.FindType(IID) even if no class implements the interface with the IID.
// When no such class exists, FindType will return nil, and we AV  when using RttiType.
// That is demonstrated in RttiContext_GetTypes_vs_GetType_on_Interfaces_ConsoleProject.dproj
  if Instance is TObject then
    Line := TObject(Instance).ClassName;
  Result := Supports(Instance, IID, Intf);
  RttiContext := TRttiContext.Create();
  try
    RttiType := RttiContext.FindType(IID);
    if not Assigned(RttiType) then
      if Assigned(InterfaceTypeInfo) then
        RttiType := RttiContext.GetType(InterfaceTypeInfo);
    if Result then
    begin
      Line := Format('%s implements %s', [Line, RttiType.Name]);
      Log(Line);
    end
    else
    begin
      Line := Format('%s does not implement %s', [Line, RttiType.Name]);
      Log(Line);
    end;
  finally
    RttiContext.Free;
  end;
end;

function TAnimalForm.SupportsAndLog_Works(const Instance: IInterface; out Intf;
    const IID: TGUID; const InterfaceTypeInfo: Pointer = nil): Boolean;
var
  RttiContext: TRttiContext;
  Line: string;
  RttiType: TRttiType;
begin
// This works because we only call RttiContext.FindType(IID) when the interface with the IID actually is implemented by a class
  Result := Supports(Instance, IID, Intf);
  if Result then
  begin
    if Instance is TObject then
      Line := TObject(Instance).ClassName;
    RttiContext := TRttiContext.Create;
    try
      RttiType := RttiContext.FindType(IID);
      if not Assigned(RttiType) then
        if Assigned(InterfaceTypeInfo) then
          RttiType := RttiContext.GetType(InterfaceTypeInfo);
      Line := Format('%s implements %s', [Line, RttiType.Name]);
      Log(Line);
    finally
      RttiContext.Free;
    end;
  end;
end;

end.
