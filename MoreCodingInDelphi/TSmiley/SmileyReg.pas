unit SmileyReg;

interface

uses
  Classes,
  uSmiley,
  frmChoose,
  DesignEditors,
  DesignIntf;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Custom', [TSmiley]);
  RegisterPropertyEditor(TypeInfo(TMood), TSmiley, '', TMoodProperty);
end; {Register}

end.
