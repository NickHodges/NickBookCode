unit uRTTI;

interface

type
  TRTTI = class

    ///	<summary>
    ///	  Combine the most qualified name for TInterface and TClass for use in
    ///	  the GlobalContainer of the Spring4D dependency injection framework.
    ///	</summary>
    class function GetMostQualifiedName<TClass: class; TInterface: IInterface>(): string;
  end;

implementation

uses
  Spring,
  Rtti;

class function TRTTI.GetMostQualifiedName<TClass, TInterface>(): string;
var
  TClassType: PTypeInfo;
  TInterfaceType: PTypeInfo;
  TClassRttiType: TRttiType;
  TInterfaceRttiType: TRttiType;
  TClassName: string;
  TInterfaceName: string;
  RttiContext: TRttiContext;
begin
  TClassType := TypeInfo(TClass);
  TInterfaceType := TypeInfo(TInterface);
  RttiContext := TRttiContext.Create();
  TClassRttiType := RttiContext.GetType(TClassType);
  TInterfaceRttiType := RttiContext.GetType(TInterfaceType);
  if TClassRttiType.IsPublicType then
    TClassName := TClassRttiType.QualifiedName
  else
    TClassName := TClassRttiType.Name;
  if TInterfaceRttiType.IsPublicType then
    TInterfaceName := TInterfaceRttiType.QualifiedName
  else
    TInterfaceName := TInterfaceRttiType.Name;
  Result := TInterfaceName + '@' + TClassName;
end;

end.
