unit uQueueDemo;

interface

uses
       Generics.Collections
     ;

type
  TWorkOrder = record
    Description: string;
    constructor Create(aDescription: string);
  end;

  TWorkOrderQueue = TQueue<TWorkOrder>;

procedure DoRepairs;


implementation

procedure DoWorkOrder(aWorkOrder: TWorkOrder);
begin
  WriteLn('I am now doing this job: ', aWorkOrder.Description);
end;

procedure DoRepairs;
var
   WorkOrderQueue: TWorkOrderQueue;
  i: Integer;
begin
  WorkOrderQueue := TWorkOrderQueue.Create;
  try
    // Orders come in
    WorkOrderQueue.Enqueue(TWorkOrder.Create('Fix the sink in #543'));
    WorkOrderQueue.Enqueue(TWorkOrder.Create('Repair air conditioner in #156'));

    //Time for one item
    DoWorkOrder(WorkOrderQueue.Dequeue);

    // More orders come in!
    WorkOrderQueue.Enqueue(TWorkOrder.Create('Stock the public bathroom'));
    WorkOrderQueue.Enqueue(TWorkOrder.Create('Fix door handle on #307'));
    WorkOrderQueue.Enqueue(TWorkOrder.Create('Catch mouse in #124'));
    WorkOrderQueue.Enqueue(TWorkOrder.Create('Repair the refrigerator in #402'));

    // I can squeeze one in!
    DoWorkOrder(WorkOrderQueue.Dequeue);

    // More work!!!
    WorkOrderQueue.Enqueue(TWorkOrder.Create('Unplug toilet in #109'));
    WorkOrderQueue.Enqueue(TWorkOrder.Create('Repair Carpet in #405'));
    WorkOrderQueue.Enqueue(TWorkOrder.Create('Replace bathroom doorknob in #322'));
    WorkOrderQueue.Enqueue(TWorkOrder.Create('Repair air conditioner in #143'));

    // All right, let's finish them all

    repeat
      begin
        DoWorkOrder(WorkOrderQueue.Dequeue);
      end;
    until WorkOrderQueue.Count = 0;

  finally
    WorkOrderQueue.Free;
  end;
end;


{ TWorkOrder }

constructor TWorkOrder.Create(aDescription: string);
begin
  Description := aDescription;
end;

end.
