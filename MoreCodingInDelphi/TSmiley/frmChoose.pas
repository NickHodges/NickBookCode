unit frmChoose;

interface

uses
  SysUtils,
  Controls,
  TypInfo,
  uSmiley,
  DesignEditors,
  DesignIntf,
  StdCtrls,
  Buttons,
  Classes,
  Forms,
  ExtCtrls,
  ImgList,
  ComCtrls,
  System.ImageList
  ;

type
  /// <summary>
  /// <para>
  ///  The <c>TChooseDlg</c> class is a dialog that is used by the <c>TMoodProperty</c> editor
  ///  to allow users to visually choose a mood for any property of type <c>TMood</c>.
  /// </para>
  ///
  /// <para>
  ///  The dialog itself is a plain dialog that will be called by the property editor
  ///  when a user clicks on the ellipse in the Object Inspector.  The dialog builds the choices
  ///  dynamically, allowing for easy addition of more Moods if desired.  The dialog will automatically
  ///  display and thus allow the user to choos all the existing moods of <c>TSmiley</c>.
  /// </para>
  /// </summary>
  TChooseDlg = class(TForm)
    SmileyListView: TListView;
    SmileyImageList: TImageList;
    OkButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure SmileyListViewClick(Sender: TObject);
    procedure SmileyListViewDblClick(Sender: TObject);
  private
    FMood: TMood;
    procedure SetMood(aMood: TMood);
    procedure PopulateImageList;
    procedure SetConstraints;
  protected
    procedure FillUpListView;
  public
    property Mood: TMood read FMood write SetMood;
  end;

  /// <summary>
  ///   The <c>TMoodProperty</c> class is a property editor for the <c>TMood</c> enumerated type.
  /// </summary>
    TMoodProperty = class(TEnumProperty)
    /// <summary>
    ///  The <c>GetAttributes</c> function in an overridden method that tells the IDE how to treat this property editor.
    ///  In this case, it tells the sytem that the property editor in question will be a dialog.
    /// </summary>
    ///  <returns>
    ///    Returns a set of <c>TPropertyAttribute</c> values that determine the behavior of the Property Editor within
    ///    the Object Inspector and the IDE.  In this case, it merely retursn <c>paDialog</c>.
    ///  </returns>
    function GetAttributes: TPropertyAttributes; override;
    /// <summary>
    /// Defines how the actual editing of the property will be done.
    /// </summary>
    /// <remarks>
    ///  <para>The <c>Edit</c> method is overridden, and the developer can do almost anything he wants here.
    ///  This method will be called when the user clicks on the ellipse or double clicks on the property
    ///  value.  It uses the <c>GetOrdValue</c> and the <c>SetOrdValue</c> methods to get and set the current value
    ///  for the property being edited.</para> <para>  In this case, it merely shows the <c>TChooseDlg</c>, allowing the user
    ///  to choose a mood for the property of type <c>TMood</c>. </para>
    /// </remarks>
    procedure Edit; override;
  end;

var
  ChooseDlg: TChooseDlg;

implementation

uses
     VCL.Graphics
   , uSmileyConsts
   ;

{$R *.DFM}

procedure TChooseDlg.FormCreate(Sender: TObject);
begin
  FillUpListView;
  SetConstraints;
end;

procedure TChooseDlg.SetConstraints;
begin
  Constraints.MinHeight := Height;
  Constraints.MinWidth := Width;
end;

procedure TChooseDlg.FillUpListView;
var
  TempItem: TListItem;
  LMood: TMood;
  TempName: string;
  TempDescription: string;
begin
  PopulateImageList;
  for LMood := Low(TMood) to High(TMood) do
  begin
    TempItem := SmileyListView.Items.Add;
    TempName := TSmiley.GetMoodName(LMood);
    TempItem.Caption := TempName;

    TempDescription := TSmiley.GetMoodDescription(LMood);
    TempItem.SubItems.Add(TempDescription);
    TempItem.ImageIndex := Ord(LMood);
    TempItem.Data := Pointer(Ord(LMood));
  end;
end;

procedure TChooseDlg.PopulateImageList;
var
  TempMood: TMood;
  TempBitmap: TBitmap;
  TempName: string;
begin
  SmileyImageList.Height := cMaxHeight;
  SmileyImageList.Width := cMaxWidth;
  TempBitmap := TBitmap.Create;
  try
    for TempMood := low(TMood) to high(TMood) do
    begin
      TempName := UpperCase(GetEnumName(TypeInfo(TMood), Ord(TempMood)));
      TSmiley.GetMoodBitmap(TempBitmap, TempMood);
      SmileyImageList.Add(TempBitmap, nil);
    end;
  finally
    TempBitmap.Free;
  end;
end;

procedure TChooseDlg.SetMood(aMood: TMood);
begin
  FMood := aMood;
  if SmileyListView.ItemIndex <> Ord(aMood) then
  begin
    SmileyListView.ItemIndex := Ord(aMood);
  end;
end;

procedure TChooseDlg.SmileyListViewClick(Sender: TObject);
var
  TempIndex: integer;
begin
  TempIndex := Integer(SmileyListView.Selected.Data);
  Mood := TMood(TempIndex);
end;

procedure TChooseDlg.SmileyListViewDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

{ ---------Property Editor Stuff-------------- }

function TMoodProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

procedure TMoodProperty.Edit;
var
  ChooseDlg: TChooseDlg;
begin
  ChooseDlg := TChooseDlg.Create(Application);
  try
    ChooseDlg.Mood := TMood(GetOrdValue);
    ChooseDlg.ShowModal;
    SetOrdValue(Ord(ChooseDlg.Mood));
  finally
    ChooseDlg.Free
  end;
end;

end.
