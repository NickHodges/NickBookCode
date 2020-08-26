{ Copyright (c) 2007-2013 Jeroen Wiert Pluimers for BeSharp.net and Coding In Delphi.
Full BSD License is available at http://BeSharp.codeplex.com/license }

unit LogEventUnit;

interface

type
{$ifdef oldStyleSyntax}
  TLogEvent = procedure(const Line: string) of object;
{$else} // much more verasile as you can assign any method to it.
  TLogEvent = reference to procedure(const Line: string);
{$endif oldStyleSyntax}

implementation

end.
