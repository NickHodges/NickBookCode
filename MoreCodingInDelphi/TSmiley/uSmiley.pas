unit uSmiley;

interface

uses
    Classes
  , Graphics
  , Controls
  , uSmileyConsts
  , System.SysUtils
  ;

type
  /// <summary>
  ///   The enumeration that defines the different moods (faces) that a <c>TSmiley</c> has.
  /// </summary>
  TMood = (smHappy, smSad, smShades, smTongue, smIndifferent, smOoh, smFrazzled, smOutCold, smWink);
const
  /// <summary>
  ///   <c>TMoodStrings</c> provides the short name for each <c>TMood</c>.  These are used for the short hints as well.
  /// </summary>
  TMoodStrings: array [TMood] of string = (strHappy, strSad, strShades, strTongue, strIndifferent, strOoh, strFrazzled, strOutCold, strWink);
  /// <summary>
  ///  <c>TMoodDescription</c> includes the long description for each <c>Mood</c>.  These are used for the long hint as well.
  /// </summary>
  TMoodDescriptions: array [TMood] of string = (strHappyDesc, strSadDesc, strShadesDesc, strTongueDesc, strIndifferentDesc, strOohDesc, strFrazzledDesc, strOutColdDesc, strWinkDesc);

type
  /// <summary>
  ///   <c>TMoodChange</c> is the event definition for the OnMoodChange event.
  /// </summary>
  TMoodChangeEvent = procedure(Sender: TObject; NewMood: TMood) of object;

  ESmileyException = class(Exception);

type

  /// <summary>
  ///  <c>TSmiley</c> is a graphical component that displays various smiley faces dependingon its <c>aMood</c> property.
  ///  </summary
  /// <remarks>
  ///  <c>TSmiley</c> is one of the very first components ever written for Delphi.  It is also one of the most
  ///  useless components ever created, as all it does is show off silly smiley faces.   Nevertheless, it is
  ///  illustrative of a number of different component building techniques.
  /// </remarks>
  TSmiley = class(TGraphicControl)
  private
    FFace: TBitmap;
    FMood: TMood;
    FOldMood: TMood;
    FOnMoodChange: TMoodChangeEvent;
    FClicking: Boolean;
    FClickMood: TMood;
    procedure SetBitmap;
    procedure SetMood(aNewMood: TMood);
    procedure SetSmileyHint;
    procedure SetClickMood(const Value: TMood);
    procedure SetupSmiley;
  protected
    procedure DoMoodChange; virtual;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure ConstrainedResize(var MinWidth, MinHeight, MaxWidth, MaxHeight: Integer); override;
  public
    /// <summary>
    ///   Creates a new instance of TSmiley
    /// </summary>
    constructor Create(AOwner: TComponent); override;
    /// <summary>
    ///   Destroys and cleans up an existing instance of <c>TSmiley</c>
    /// </summary>
    destructor Destroy; override;
    /// <summary>
    ///  The <c>Toggle</c> procedure is used to move to the next <c>Mood</c>.
    ///  </summary>
    ///  <remarks>
    ///  If the current mood is the last mood, then the Mood property rolls over to the first mood.
    /// </remarks>
    procedure Increment;

    // TSmiley API -- use these class methods to get info about TSmiley
    // Especially useful in the design time package

    /// <summary>
    ///   <c>GetMoodBitmap</c> is a class procedure that fills a passed-in <c>TBitmap</c> with the bitmap for the passed in <c>Mood</c>
    /// </summary>
    ///  <param name="aMood">
    ///    The <c>aMood</c> parameter indicates the <c>Mood</c> for which the name should be retrieved.
    ///  </param>
    ///  <param name="aBitmap">
    ///    The <c>aBitmap</c> parameter is an instance of <c>TBitmap</c> that will be filled with a bitmap indicated by the <c>aMood</c> parameter
    ///  </param>
    class procedure GetMoodBitmap(aBitmap: TBitmap; aMood: TMood);
    /// <summary>
    ///   <c>GetMoodName</c> is a class procedure that returns the name (short string) for the passed in <c>Mood</c>
    /// </summary>
    ///  <param name="aMood">
    ///    The <c>aMood</c> parameter indicates the Mood for which the name should be retrieved.
    ///  </param>
    ///  <returns>
    ///    Returns a string containing the short <c>Mood</c> name.
    ///  </returns>
    class function GetMoodName(aMood: TMood): string;
    /// <summary>
    ///   <c>GetMoodDescription</c> is a class procedure that returns the description (long string) for the passed in <c>aMood</c>
    /// </summary>
    ///  <param name="aMood">
    ///    The <c>aMood</c> parameter indicates the <c>Mood</c> for which the description should be retrieved.
    ///  </param>
    ///  <returns>
    ///     Returns a string containing the full <c>Mood</c> description.
    ///  </returns>
    class function GetMoodDescription(aMood: TMood): string;

  published
    /// <summary>
    ///   The <c>Mood</c> property determines which face the <c>TSmiley</c> displays.
    /// </summary>
    property Mood: TMood read FMood write SetMood;
    /// <summary>
    ///   The <c>ClickMood</c> property determines which face the <c>TSmiley</c> displays when it is clicked on.
    /// </summary>
    property ClickMood: TMood read FClickMood write SetClickMood;
    /// <summary>
    ///   The <c>OnMoodChange</c> event is fired whenever the mood of <c>TSmiley</c> changes.
    ///   It passes along the new <c>Mood</c> to which the <c>Mood</c> property is being changed.
    /// </summary>
    property OnMoodChange: TMoodChangeEvent read FOnMoodChange write FOnMoodChange;

    // Unpublished events from TGraphicControl that are published here for your
    // enjoyment, use, and edification.
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnGesture;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnStartDock;
    property OnStartDrag;

  end;

implementation

uses
       TypInfo
     ;

procedure TSmiley.ConstrainedResize(var MinWidth, MinHeight, MaxWidth, MaxHeight: Integer);
begin
  MinWidth := cMaxWidth;
  MaxWidth := cMaxWidth;
  MinHeight := cMaxHeight;
  MaxHeight := cMaxHeight;
end;

constructor TSmiley.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMood := smHappy;
  FClickMood := smWink;
  FFace := TBitmap.Create;
  Self.Height := cMaxHeight;
  Self.Width := cMaxWidth;
  SetupSmiley;
  FOldMood := FMood;
end;

destructor TSmiley.Destroy;
begin
  FFace.Free;
  inherited Destroy;
end;

procedure TSmiley.DoMoodChange;
begin
  if Assigned(FOnMoodChange) and (not FClicking) then
  begin
    FOnMoodChange(Self, FMood);
  end;
end;

class procedure TSmiley.GetMoodBitmap(aBitmap: TBitmap; aMood: TMood);
var
  TempName: string;
begin
  if aBitmap = nil then
  begin
    raise ESmileyException.Create('You can''t pass a nil bitmap to TSmiley.GetMoodBitmap');
  end;
  begin
    TempName := UpperCase(GetEnumName(TypeInfo(TMood), Ord(aMood)));
    aBitmap.LoadFromResourceName(hInstance, TempName);
  end;
end;

class function TSmiley.GetMoodDescription(aMood: TMood): string;
begin
  Result := TMoodDescriptions[aMood];
end;

procedure TSmiley.SetupSmiley;
begin
  SetBitmap;
  SetSmileyHint;
end;

class function TSmiley.GetMoodName(aMood: TMood): string;
begin
  Result := TMoodStrings[aMood];
end;

procedure TSmiley.Increment;
begin
  if FMood = High(TMood) then
  begin
    FMood := Low(TMood)
  end else
  begin
    Inc(FMood);
  end;
  SetMood(FMood);
end;

procedure TSmiley.SetBitmap;
begin
  GetMoodBitmap(FFace, Mood);
  Invalidate;
end;

procedure TSmiley.SetClickMood(const Value: TMood);
begin
  FClickMood := Value;
end;

procedure TSmiley.SetMood(aNewMood: TMood);
begin
  FMood := aNewMood;
  DoMoodChange;
  SetupSmiley;
end;

procedure TSmiley.SetSmileyHint;
begin
  Hint := Format(HintStringTemplate, [TMoodStrings[FMood], TMoodDescriptions[FMood]]);
end;

procedure TSmiley.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  FOldMood := Mood;
  FClicking := True;
  SetMood(ClickMood);
end;

procedure TSmiley.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  SetMood(FOldMood);
  FClicking := False;
end;

procedure TSmiley.Paint;
begin
  inherited;
  Canvas.Draw(0, 0, FFace);
end;

end.
