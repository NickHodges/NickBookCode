program Identity;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  TReportInfo = class
  private
    FReportStuff: string;
    procedure SetReportStuff(const Value: string);
  public
    property ReportStuff: string read FReportStuff write SetReportStuff;
  end;

procedure TReportInfo.SetReportStuff(const Value: string);
begin
  FReportStuff := Value;
end;

type

  TInventoryReport = class
  private
    FReportInfo: TReportInfo;
  public
    constructor Create(aReportInfo: TReportInfo);
    property ReportInfo: TReportInfo read FReportInfo write FReportInfo;
  end;

  TSalesReport = class
  private
    FReportInfo: TReportInfo;
  public
    constructor Create(aReportInfo: TReportInfo);
    property ReportInfo: TReportInfo read FReportInfo write FReportInfo;
  end;

{ TInventoryReport }

constructor TInventoryReport.Create(aReportInfo: TReportInfo);
begin
  FReportInfo := aReportInfo;
end;

{ TSalesReport }

constructor TSalesReport.Create(aReportInfo: TReportInfo);
begin
  FReportInfo := aReportInfo;
end;

var
  ReportInfo: TReportInfo;
  NewReportInfo: TReportInfo;
  InventoryReport: TInventoryReport;
  SalesReport: TSalesReport;


begin
  try
    ReportInfo := TReportInfo.Create;
    InventoryReport := TInventoryReport.Create(ReportInfo);
    SalesReport := TSalesReport.Create(ReportInfo);
    try
      // Do Stuff with reports

      NewReportInfo := TReportInfo.Create;
      try
        InventoryReport.ReportInfo := NewReportInfo;
        // Do stuff with report
        // But the reports now point to different ReportInfo.
        // This is Connascence of Identity
      finally
        NewReportInfo.Free;
      end;
    finally
      ReportInfo.Free;
      InventoryReport.Free;
      SalesReport.Free;
    end;


  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
