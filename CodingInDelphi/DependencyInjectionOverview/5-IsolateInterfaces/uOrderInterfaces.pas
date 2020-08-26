unit uOrderInterfaces;

interface

uses
  uOrder;

type
  IOrderValidator = interface
    function ValidateOrder(const aOrder: TOrder): Boolean;
  end;

  IOrderEntry = interface
    function EnterOrderIntoDatabase(const aOrder: TOrder): Boolean;
  end;

  IOrderProcessor = interface
    function ProcessOrder(const aOrder: TOrder): Boolean;
  end;

implementation

end.
