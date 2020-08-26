unit RttiContext_GetTypes_vs_GetType_on_Interfaces_MainUnit;

interface

type
  IPublicImplementedInterface = interface(IInterface)
  ['{E1962EFF-64CD-4ABB-9C44-1503E3CE77A9}']
  end;

  IPublicNonImplementedInterface = interface(IInterface)
  ['{AD72354C-BD8D-4453-8838-A9C261115A25}']
  end;

  IPublicNonImplementedInterfaceThatHasNoTypeInfoCalls = interface(IInterface)
  ['{A846E993-EF55-4463-93F1-E7979D17F605}']
  end;

  TPublicImplementingObject = class(TInterfacedObject, IPublicImplementedInterface)
  end;

  IPublicImplementedInterfaceThatHasNoTypeInfoCalls = interface(IInterface)
  ['{D471001B-77CA-4B8E-87D4-1AF1F17C0128}']
  end;

  TPublicImplementingObjectWithoutTypeInfoCalls = class(TInterfacedObject, IPublicImplementedInterfaceThatHasNoTypeInfoCalls)
  end;

procedure Main();

implementation

uses
  System.Rtti,
  RttiHelpers,
  RttiContext_GetTypes_vs_GetType_on_Interfaces_ConsoleReportUnit;

type
  IPrivateImplementedInterface = interface(IInterface)
  ['{E1962EFF-64CD-4ABB-9C44-1503E3CE77A9}']
  end;

  IPrivateNonImplementedInterface = interface(IInterface)
  ['{AD72354C-BD8D-4453-8838-A9C261115A25}']
  end;

  IPrivateNonImplementedInterfaceThatHasNoTypeInfoCalls = interface(IInterface)
  ['{A846E993-EF55-4463-93F1-E7979D17F605}']
  end;

  TPrivateImplementingObject = class(TInterfacedObject, IPrivateImplementedInterface)
  end;

  IPrivateImplementedInterfaceThatHasNoTypeInfoCalls = interface(IInterface)
  ['{D471001B-77CA-4B8E-87D4-1AF1F17C0128}']
  end;

  TPrivateImplementingObjectWithoutTypeInfoCalls = class(TInterfacedObject, IPrivateImplementedInterfaceThatHasNoTypeInfoCalls)
  end;

procedure Main();
var
  PublicImplementedInterfaceReference: IPublicImplementedInterface;
  PublicImplementedInterfaceThatHasNoTypeInfoCallsReference: IPublicImplementedInterfaceThatHasNoTypeInfoCalls;
  PrivateImplementedInterfaceReference: IPrivateImplementedInterface;
  PrivateImplementedInterfaceThatHasNoTypeInfoCallsReference: IPrivateImplementedInterfaceThatHasNoTypeInfoCalls;
  RttiContext: TRttiContext;
begin
  PublicImplementedInterfaceReference := TPublicImplementingObject.Create();
  PublicImplementedInterfaceThatHasNoTypeInfoCallsReference := TPublicImplementingObjectWithoutTypeInfoCalls.Create();

  PrivateImplementedInterfaceReference := TPrivateImplementingObject.Create();
  PrivateImplementedInterfaceThatHasNoTypeInfoCallsReference := TPrivateImplementingObjectWithoutTypeInfoCalls.Create();

  RttiContext := TRttiContext.Create();
  try
    {TODO -o##jwp -cExtend : see what happens if we interface them from another unit}
    ReportRttiTypes(RttiContext, IInterface, 'IInterface', TypeInfo(IInterface));

    Writeln;
    ReportRttiTypes(RttiContext, IPublicImplementedInterface, 'IPublicImplementedInterface', TypeInfo(IPublicImplementedInterface));
    ReportRttiTypes(RttiContext, IPublicNonImplementedInterface, 'IPublicNonImplementedInterface', TypeInfo(IPublicNonImplementedInterface));
    // we don't want to call TypeInfo on IPublicNonImplementedInterfaceThatHasNoTypeInfoCalls and IPublicImplementedInterfaceThatHasNoTypeInfoCalls
    ReportRttiTypes(RttiContext, IPublicNonImplementedInterfaceThatHasNoTypeInfoCalls, 'IPublicNonImplementedInterfaceThatHasNoTypeInfoCalls', nil);
    ReportRttiTypes(RttiContext, IPublicImplementedInterfaceThatHasNoTypeInfoCalls, 'IPublicImplementedInterfaceThatHasNoTypeInfoCalls', nil);

    Writeln;
    ReportRttiTypes(RttiContext, IPrivateImplementedInterface, 'IPrivateImplementedInterface', TypeInfo(IPrivateImplementedInterface));
    ReportRttiTypes(RttiContext, IPrivateNonImplementedInterface, 'IPrivateNonImplementedInterface', TypeInfo(IPrivateNonImplementedInterface));
    // we don't want to call TypeInfo on IPrivateNonImplementedInterfaceThatHasNoTypeInfoCalls and IPrivateImplementedInterfaceThatHasNoTypeInfoCalls
    ReportRttiTypes(RttiContext, IPrivateNonImplementedInterfaceThatHasNoTypeInfoCalls, 'IPrivateNonImplementedInterfaceThatHasNoTypeInfoCalls', nil);
    ReportRttiTypes(RttiContext, IPrivateImplementedInterfaceThatHasNoTypeInfoCalls, 'IPrivateImplementedInterfaceThatHasNoTypeInfoCalls', nil);

    Writeln;
    ReportImplementedInterfacesByClass(RttiContext, TPublicImplementingObject);
    ReportImplementedInterfacesByClass(RttiContext, TPublicImplementingObjectWithoutTypeInfoCalls);

    Writeln;
    ReportImplementedInterfacesByClass(RttiContext, TPrivateImplementingObject);
    ReportImplementedInterfacesByClass(RttiContext, TPrivateImplementingObjectWithoutTypeInfoCalls);

    Writeln;
    Writeln(RttiContext.GetMostQualifiedName<TPublicImplementingObject, IPublicImplementedInterface>());

    Writeln;
    ReportGetTypes(RttiContext);
  finally
    RttiContext.Free;
  end;
end;

end.

