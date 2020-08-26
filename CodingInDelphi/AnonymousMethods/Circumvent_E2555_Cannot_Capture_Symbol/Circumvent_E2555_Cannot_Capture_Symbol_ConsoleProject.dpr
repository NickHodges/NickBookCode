{ Copyright (c) 2013 Jeroen Wiert Pluimers for BeSharp.net and Coding In Delphi.
Full BSD License is available at http://BeSharp.codeplex.com/license }

{$REGION 'Documentation'}
///	<summary>
///	  Most
///	  <see cref="https://www.google.com/search?q=E2555+site%3Aqc.embarcadero.com">E2555 compiler errors</see>
///	   have been resolved, except for
///	  <see cref="http://qc.embarcadero.com/wc/qcmain.aspx?d=101129">QC101129</see>
///	   (passing const records of more than 4 bytes).
///	</summary>
///	<remarks>
///
///	  <see cref="http://docwiki.embarcadero.com/RADStudio/XE4/en/E2555_Cannot_capture_symbol_'%25s'_(Delphi)">E2555 compiler error documentation</see>.
///	</remarks>
{$ENDREGION}
program Circumvent_E2555_Cannot_Capture_Symbol_ConsoleProject;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Rtti;

{$REGION 'Documentation'}
///	<summary>
///	  Non-record parameters bigger than 4 bytes work fine.
///	</summary>
{$ENDREGION}
procedure MethodWithExtendedConstParameter(const AParameter: Extended);
var
  Proc: TProc;
begin
  Proc := procedure
  var
    Variable: Extended;
  begin
    Variable := AParameter;
  end;
end;

{$REGION 'Documentation'}
///	<summary>
///	  Non-record parameters bigger than 4 bytes work fine.
///	</summary>
{$ENDREGION}
procedure MethodWithInt64ConstParameter(const AParameter: Int64);
var
  Proc: TProc;
begin
  Proc := procedure
  var
    Variable: Int64;
  begin
    Variable := AParameter;
  end;
end;

type
  {$REGION 'Documentation'}
  ///	<summary>
  ///	  It does not matter if you overflow the record to be more than 4 bytes
  ///	  in size using single bytes, or using a single big field (like Extended).
  ///	</summary>
  {$ENDREGION}
  TRecordAbove4Bytes = record
{$ifdef useBytes}
    B1: Byte;
    B2: Byte;
    B3: Byte;
    B4: Byte;
    B5: Byte;
{$else}
    E: Extended;
{$endif useBytes}
  end;

procedure MethodWithRecordConstParameterE255Workaround(const AParameter: TRecordAbove4Bytes);
var
  Proc: TProc;
  Parameter: TRecordAbove4Bytes;
begin
  Parameter := AParameter;
  Proc := procedure
  var
    Variable: TRecordAbove4Bytes;
  begin
    Variable := Parameter;
  end;
end;

procedure MethodWithGuidConstParameterE255Workaround(const AParameter: TGUID);
var
  Proc: TProc;
  Parameter: TGUID;
begin
  Parameter := AParameter;
  Proc := procedure
  var
    Variable: TGUID;
  begin
    Variable := Parameter;
  end;
end;

{$REGION 'Documentation'}
///	<summary>
///	  <para>
///	    Fails with record types lager than 4 bytes (including TGUID). The first
///	    method having this error will fail the project. You have to fix each
///	    one in turn, then recompile.
///	  </para>
///	  <para>
///	    There is no need to actually call the anonymous method, or call the
///	    encompassing method.
///	  </para>
///	  <para>
///	    Workaround: remove `const`, or introduce temporary variable.
///	  </para>
///	</summary>
{$ENDREGION}
procedure MethodWithRecordConstParameter(const AParameter: TRecordAbove4Bytes);
var
  Proc: TProc;
begin
  Proc := procedure
  var
    Variable: TRecordAbove4Bytes;
  begin
    Variable := AParameter; // the E2555 compiler error here is intentional.
  end;
end;

procedure MethodWithGuidConstParameter(const AParameter: TGUID);
var
  Proc: TProc;
begin
  Proc := procedure
  var
    Variable: TGUID;
  begin
    Variable := AParameter;
  end;
end;

begin
end.
