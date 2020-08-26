unit uSmartPhone;

interface

type

  TSmartPhoneType = (CheapCrappy, Basic, Deluxe, SuperDuper);

  TBaseSmartPhone = class abstract
  protected
    function GetName: string; virtual; abstract;
  public
    procedure GatherParts; virtual; abstract;
    procedure Assemble; virtual; abstract;
    property Name: string read GetName;
  end;

  TCheapCrappySmartPhone = class(TBaseSmartPhone)
    protected
    function GetName: string; override;
  public
    procedure GatherParts; override;
    procedure Assemble; override;
  end;

  TBasicSmartPhone = class(TBaseSmartPhone)
  protected
    function GetName: string; override;
  public
    procedure GatherParts; override;
    procedure Assemble; override;
  end;

  TDeluxeSmartPhone = class(TBaseSmartPhone)
  protected
    function GetName: string; override;
  public
    procedure GatherParts; override;
    procedure Assemble; override;
  end;

  TSuperDuperSmartPhone = class(TBaseSmartPhone)
  protected
    function GetName: string; override;
  public
    procedure GatherParts; override;
    procedure Assemble; override;
  end;

implementation

{ TBasicSmartPhone }

procedure TBasicSmartPhone.Assemble;
begin
  WriteLn('Use the basic assembly procedure to assemble the phone');
end;

procedure TBasicSmartPhone.GatherParts;
begin
  WriteLn('Gather basic parts for the phone');
end;

function TBasicSmartPhone.GetName: string;
begin
  Result := 'Nick''s Basic Phone';
end;

{ TDeluxeSmartPhone }

procedure TDeluxeSmartPhone.Assemble;
begin
  WriteLn('Assemble using Deluxe assembly methods');
end;

procedure TDeluxeSmartPhone.GatherParts;
begin
  WriteLn('Gather up Deluxe phone parts');
end;

function TDeluxeSmartPhone.GetName: string;
begin
  Result := 'Nick''s Deluxe Phone';
end;

{ TSuperDuperSmartPhone }

procedure TSuperDuperSmartPhone.Assemble;
begin
  WriteLn('Assemble using SuperDuper assembly techniques');
end;

procedure TSuperDuperSmartPhone.GatherParts;
begin
  WriteLn('Gather up SuperDuper phone parts');
end;

function TSuperDuperSmartPhone.GetName: string;
begin
  Result := 'Nick''s Super Duper Phone';
end;

{ TCheapCrappySmartPhone }

procedure TCheapCrappySmartPhone.Assemble;
begin
  WriteLn('Slap the phone together');
end;

procedure TCheapCrappySmartPhone.GatherParts;
begin
  WriteLn('Grab some parts from wherever');
end;

function TCheapCrappySmartPhone.GetName: string;
begin
  Result := 'Nick''s Cheap Crappy Phone';
end;

end.
