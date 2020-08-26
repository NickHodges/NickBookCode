{ Copyright (c) 2013 Nick Hodges for CodingInDelphi and Jeroen Wiert Pluimers
for BeSharp.net and Coding In Delphi.
Full BSD License is available at http://BeSharp.codeplex.com/license }

unit IntegerCalculatorFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Samples.Spin, IntegerCalculatorUnit, System.Classes;

type
  TIntegerCalculatorForm = class(TForm)
    LeftOperandLabel: TLabel;
    RightOperandLabel: TLabel;
    OperatorsRadioGroup: TRadioGroup;
    AddOperatorsButton: TButton;
    LogMemo: TMemo;
    ShowAnimalLocomotionsButton: TButton;
    LeftOperandSpinEdit: TSpinEdit;
    RightOperandSpinEdit: TSpinEdit;
    ActionManager: TActionManager;
    AddOperatorsAction: TAction;
    PerformOperationAction: TAction;
    Button1: TButton;
    Button2: TButton;
    AddDivisionOperatorsAction: TAction;
    AddPowerOperatorAction: TAction;
    procedure AddDivisionOperatorsActionExecute(Sender: TObject);
    procedure AddDivisionOperatorsActionUpdate(Sender: TObject);
    procedure AddOperatorsActionExecute(Sender: TObject);
    procedure AddPowerOperatorActionExecute(Sender: TObject);
    procedure AddPowerOperatorActionUpdate(Sender: TObject);
    procedure PerformOperationActionExecute(Sender: TObject);
    procedure PerformOperationActionUpdate(Sender: TObject);
  strict private
    FIntegerCalculator: TIntegerCalculator;
  private
  strict protected
    procedure Log(const Line: string); overload; virtual;
    procedure SetIntegerCalculator(const Value: TIntegerCalculator); virtual;
    procedure UpdateOperatorsRadioGroup(); virtual;
  public
    property IntegerCalculator: TIntegerCalculator read FIntegerCalculator write
        SetIntegerCalculator;
  end;

var
  IntegerCalculatorForm: TIntegerCalculatorForm;

implementation

uses
  System.Math, IntegerPowerUnit;

{$R *.dfm}

procedure TIntegerCalculatorForm.AddDivisionOperatorsActionExecute(Sender:
    TObject);
begin
  IntegerCalculator.RegisterIntegerOperatorFunction('Divide', function(Left, Right: Integer): Integer
    begin
      Result := Left div Right;
    end);

  IntegerCalculator.RegisterIntegerOperatorFunction('Modulus', function(Left, Right: Integer): Integer
    begin
      Result := Left mod Right;
    end);

  UpdateOperatorsRadioGroup();
end;

procedure TIntegerCalculatorForm.AddDivisionOperatorsActionUpdate(Sender:
    TObject);
var
  Enabled: Boolean;
begin
  Enabled := OperatorsRadioGroup.Items.Count > 0;
  Enabled := Enabled and (OperatorsRadioGroup.Items.IndexOf('Divide') = -1);
  (Sender as TAction).Enabled := Enabled;
end;

procedure TIntegerCalculatorForm.AddOperatorsActionExecute(Sender: TObject);
begin
  IntegerCalculator := TIntegerCalculator.Create();
end;

procedure TIntegerCalculatorForm.AddPowerOperatorActionExecute(Sender: TObject);
begin
  // the really cool thing: you can pass regular methods as anonymous methods.
  IntegerCalculator.RegisterIntegerOperatorFunction('Power', IntegerPower);

  UpdateOperatorsRadioGroup();
end;

procedure TIntegerCalculatorForm.AddPowerOperatorActionUpdate(Sender: TObject);
var
  Enabled: Boolean;
begin
  Enabled := OperatorsRadioGroup.Items.Count > 0;
  Enabled := Enabled and (OperatorsRadioGroup.Items.IndexOf('Power') = -1);
  (Sender as TAction).Enabled := Enabled;
end;

procedure TIntegerCalculatorForm.Log(const Line: string);
begin
  LogMemo.Lines.Add(Line);
end;

procedure TIntegerCalculatorForm.PerformOperationActionExecute(Sender: TObject);
var
  LeftOperand: Integer;
  OperatorName: string;
  Result: Integer;
  RightOperand: Integer;
begin
  OperatorName := OperatorsRadioGroup.Items[OperatorsRadioGroup.ItemIndex];
  LeftOperand := LeftOperandSpinEdit.Value;
  RightOperand := RightOperandSpinEdit.Value;
  try
    Result := IntegerCalculator.Calculate(OperatorName, LeftOperand, RightOperand);
    Log(Format('%s(%d, %d) = %d', [OperatorName, LeftOperand, RightOperand, Result]));
  except on E: Exception do
    Log(Format('Exception during operator %s with operands Left=%d, Right=%d. %s:%s',
      [OperatorName, LeftOperand, RightOperand, E.ClassName, E.Message]));
  end;
end;

procedure TIntegerCalculatorForm.PerformOperationActionUpdate(Sender: TObject);
var
  Enabled: Boolean;
begin
  Enabled := OperatorsRadioGroup.Items.Count > 0;
  Enabled := Enabled and (OperatorsRadioGroup.ItemIndex <> -1);
  (Sender as TAction).Enabled := Enabled;
end;

procedure TIntegerCalculatorForm.SetIntegerCalculator(const Value:
    TIntegerCalculator);
begin
  FIntegerCalculator := Value;
  UpdateOperatorsRadioGroup();
end;

procedure TIntegerCalculatorForm.UpdateOperatorsRadioGroup();
begin
  if Assigned(FIntegerCalculator) then
    OperatorsRadioGroup.Items.CommaText := FIntegerCalculator.BinaryIntegerOperatorNames
  else
    OperatorsRadioGroup.Items.Clear();
end;

end.
