unit uCallMethods;

interface

procedure CallMethodsWithRTTI;

implementation

uses
      RTTI
    , uRTTIDemoClass
    , System.SysUtils
    , TypInfo
    ;

procedure CallMethodsWithRTTI;
var
  RDC: TRTTIDemoClass;
  Context: TRttiContext;
  TempType: TRttiType;
  TempMethod: TRttiMethod;
  TempParameters: TArray<TRttiParameter>;
  TempParameter: TRttiParameter;
  TempValue: TValue;
  TempResult: TValue;
  ParameterValues: array[0..1] of TValue;
  i: Integer;
begin
  RDC := TRTTIDemoClass.Create;
  try
    TempType := Context.GetType(TRTTIDemoClass);
    for TempMethod in TempType.GetDeclaredMethods do
    begin
      // Ignore constructor and grab only public methods
      if (TempMethod.Visibility <>  mvPublic) then Continue;
      if TempMethod.IsConstructor then Continue;
      WriteLn('About to invoke the method named: ', TempMethod.Name);
      case TempMethod.MethodKind of
        mkProcedure: begin
                        TempParameters := TempMethod.GetParameters;
                        // We know the possibilities here...
                        i := 0;

                        case Length(TempParameters) of
                          0: TempMethod.Invoke(RDC, []);
                          1: TempMethod.Invoke(RDC, [0]);
                          2: begin
                               for TempParameter in TempParameters do
                               begin
                                 case TempParameter.ParamType.TypeKind of
                                   tkString,
                                   tkUString: TempValue := 'Passed in via Invoke';
                                   tkFloat:  TempValue := 3.14159;
                                   tkInteger: TempValue := 0;
                                 end;
                                 ParameterValues[i] := TempValue;
                                 inc(i);
                               end;

                               TempMethod.Invoke(RDC, [ParameterValues[0], ParameterValues[1]]);
                             end;
                        end;
                      end;
        mkFunction:   begin
                        // Ignore the property getters
                        if not UpperCase(TempMethod.Name).Contains('GET') then
                        begin
                          TempResult := TempMethod.Invoke(RDC, []);
                          WriteLn('Result of a call to ', TempMethod.Name, ': ', TempResult.ToString);
                        end;
                      end;
      else
        Continue;
      end;
    end;
  finally
    RDC.Free;
  end;
end;

end.
