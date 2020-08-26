unit uVMIDemo;

interface

type
  TVMIDemo = class(TObject)
    procedure DoSomething;  virtual;
    procedure RaiseException; virtual;
  end;

procedure Main;

implementation

uses
       System.SysUtils
     , System.Rtti
     , Generics.Collections
     ;

procedure DoBefore(Instance: TObject; Method: TRttiMethod;
  const Args: TArray<TValue>; out DoInvoke: Boolean; out Result: TValue);
begin
  Writeln('Before: ', Method.Name);
end;

procedure DoAfter(Instance: TObject; Method: TRttiMethod;
  const Args: TArray<TValue>; var Result: TValue);
begin
  Writeln('After: ', Method.Name);
end;

procedure DoException(Instance: TObject; Method: TRttiMethod;
  const Args: TArray<TValue>; out RaiseException: Boolean;
  TheException: Exception; out Result: TValue);
var
  Str: string;
begin
  Str := Format('An exception occurred in %s with the message: %s', [Method.Name, TheException.Message]);
  WriteLn(Str);
  RaiseException := False;
  Result := False;
end;

{ TVMIDemoClass }

procedure TVMIDemo.DoSomething;
begin
  WriteLn('Doing something');
end;

procedure TVMIDemo.RaiseException;
begin
  raise Exception.Create('Raised on purpose.');
end;

procedure Main;
var
  VMI: TVirtualMethodInterceptor;
  VMIDemo: TVMIDemo;
begin
  VMIDemo := TVMIDemo.Create;

  VMI := TVirtualMethodInterceptor.Create(TVMIDemo);
  try
    VMI.OnBefore := DoBefore;
    VMI.OnAfter := DoAfter;
    VMI.OnException := DoException;

    VMI.Proxify(VMIDemo);

    VMIDemo.DoSomething;
    VMIDemo.RaiseException;

    Writeln('class: ', VMIDemo.ClassName);
    Writeln('parent class: ', VMIDemo.ClassParent.ClassName);
  finally
    VMI.Free;
  end;
end;



end.
