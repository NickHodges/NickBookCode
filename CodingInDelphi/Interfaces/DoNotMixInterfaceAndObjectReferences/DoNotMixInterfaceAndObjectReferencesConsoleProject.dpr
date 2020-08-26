program DoNotMixInterfaceAndObjectReferencesConsoleProject;

{$APPTYPE CONSOLE}

{$R *.res}

uses
{$ifdef FastMM}
  FastMM4,
{$endif FastMM}
  System.SysUtils;

procedure ShowRefCount2(ObjectReference: TInterfacedObject; const Comment: string);
begin
  Writeln(ObjectReference.RefCount, ' = RefCount After "', Comment, '"');
end;

procedure UseOnlyInterfaceReferences;
var
  InterfaceReference: IInterface;
  procedure ShowRefCount(const Comment: string);
  var
    ObjectReference: TInterfacedObject;
  begin
    if not Assigned(InterfaceReference) then
    begin
      Writeln('Unassigned InterfaceReference');
      Exit;
    end;
    // as of Delphi 2010, you can do the below cast
    // see http://stackoverflow.com/questions/4138211/how-to-cast-a-interface-to-a-object-in-delphi/11167316#11167316
    // for older Delphi versions, see the workaround here: http://stackoverflow.com/questions/4138211/how-to-cast-a-interface-to-a-object-in-delphi/11167316#11167316
    ObjectReference := InterfaceReference as TInterfacedObject;
    ShowRefCount2(ObjectReference, Comment);
  end;
begin
  InterfaceReference := TInterfacedObject.Create();
  {1} ShowRefCount('InterfaceReference := TInterfacedObject.Create();');
  InterfaceReference := nil; // this causes RefCount = 0, thereby destroying the underlying object
  // we can do this since an assignment check is done in ShowRefCount
  {none} ShowRefCount('InterfaceReference := nil;');
end;

procedure DoNotMixInterfaceAndObjectReferences;
var
  ObjectReference: TInterfacedObject;
  InterfaceReference: IInterface;
  procedure ShowRefCount(const Comment: string);
  begin
    ShowRefCount2(ObjectReference, Comment);
  end;
begin
  ObjectReference := TInterfacedObject.Create();
  {0} ShowRefCount('ObjectReference := TInterfacedObject.Create();');
  InterfaceReference := ObjectReference;
  {1} ShowRefCount('InterfaceReference := ObjectReference;');
  InterfaceReference := nil;
  // this causes RefCount = 0, thereby destroying the underlying object
  // since ObjectReference has been destroyed, you cannot do this as ShowRefCount uses ObjectReference
  // but in reallity, this case succeeds as the freed memory has not yet been overwritten.
  // In this cast you will see 0.
  // It *only* fails when using FastMM4 in FullDebugMode with or without CatchUseOfFreedInterfaces
  // see http://stackoverflow.com/questions/3139344/how-to-find-a-dangling-interface-that-causes-an-av-in-delphi/3140228#3140228
  {0 for normally MM, <>0 for FastMM} ShowRefCount('InterfaceReference := nil;');
end;

begin
  try
    UseOnlyInterfaceReferences();
    DoNotMixInterfaceAndObjectReferences();
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
