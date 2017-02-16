unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, ActnList, ComCtrls, StdCtrls, StdActns, ExtActns,
  ExtCtrls, XPMan, SHFolder, ToolWin, LiveUnit;

type
  TEditForm = class(TForm)
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    ImageList1: TImageList;
    File1: TMenuItem;
    Edit1: TMenuItem;
    Help1: TMenuItem;
    StartButton: TButton;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    EditDelete1: TEditDelete;
    RichEditBold1: TRichEditBold;
    RichEditItalic1: TRichEditItalic;
    RichEditUnderline1: TRichEditUnderline;
    RichEditStrikeOut1: TRichEditStrikeOut;
    RichEditBullets1: TRichEditBullets;
    RichEditAlignLeft1: TRichEditAlignLeft;
    RichEditAlignRight1: TRichEditAlignRight;
    RichEditAlignCenter1: TRichEditAlignCenter;
    About1: THelpOnHelp;
    FileOpen1: TFileOpen;
    FileSaveAs1: TFileSaveAs;
    FilePrintSetup1: TFilePrintSetup;
    FilePageSetup1: TFilePageSetup;
    FileExit1: TFileExit;
    SearchFind1: TSearchFind;
    SearchFindNext1: TSearchFindNext;
    SearchReplace1: TSearchReplace;
    SearchFindFirst1: TSearchFindFirst;
    FontEdit1: TFontEdit;
    ColorSelect1: TColorSelect;
    Open1: TMenuItem;
    SaveAs1: TMenuItem;
    PageSetup1: TMenuItem;
    PrintSetup1: TMenuItem;
    Exit1: TMenuItem;
    Copy1: TMenuItem;
    Cut1: TMenuItem;
    Paste1: TMenuItem;
    Undo1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    SelectAll1: TMenuItem;
    Delete1: TMenuItem;
    Delete2: TMenuItem;
    FindFirst1: TMenuItem;
    FindNext1: TMenuItem;
    Replace1: TMenuItem;
    Format1: TMenuItem;
    SelectFont1: TMenuItem;
    AlignLeft1: TMenuItem;
    Center1: TMenuItem;
    AlignRight1: TMenuItem;
    Bold1: TMenuItem;
    Italic1: TMenuItem;
    Underline1: TMenuItem;
    Strikeout1: TMenuItem;
    Bullets1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    RichEdit1: TRichEdit;
    XPManifest1: TXPManifest;
    Timer1: TTimer;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    About2: TMenuItem;
    FileNew1: TAction;
    ToolBar1: TToolBar;
    New1: TMenuItem;
    Importtext1: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    procedure StartButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure FontEdit1Accept(Sender: TObject);
    procedure ColorSelect1Accept(Sender: TObject);
    procedure About1Execute(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EditForm: TEditForm;

implementation

{$R *.dfm}

function GetSpecialFolderPath(folder : integer) : string;
 const
   SHGFP_TYPE_CURRENT = 0;
 var
   path: array [0..MAX_PATH] of char;
 begin
   if SUCCEEDED(SHGetFolderPath(0,folder,0,SHGFP_TYPE_CURRENT,@path[0])) then
     Result := path
   else
     Result := '';
 end;

procedure RedrawEditForm;
begin
  with EditForm do begin
    StartButton.Left := round(EditForm.ClientWidth/2 - StartButton.Width/2);
    StartButton.Top := EditForm.ClientHeight - StartButton.Height - 15;
    RichEdit1.Height:= StartButton.Top - RichEdit1.Top -15
  end;
end;

procedure TEditForm.FontEdit1Accept(Sender: TObject);
begin
    RichEdit1.Font := FontEdit1.Dialog.Font;
end;

procedure TEditForm.FormCreate(Sender: TObject);
begin
    RedrawEditForm;
end;

procedure TEditForm.FormPaint(Sender: TObject);
begin
    RedrawEditForm;
end;

procedure TEditForm.About1Execute(Sender: TObject);
begin
    ShowMessage('AboutBox');
end;

procedure TEditForm.Open1Click(Sender: TObject);
begin
    OpenDialog1.InitialDir := GetSpecialFolderPath(CSIDL_PERSONAL);
    if OpenDialog1.Execute then
      begin
        EditForm.Caption := OpenDialog1.FileName;
        RichEdit1.Lines.LoadFromFile(OpenDialog1.FileName);
      end;
end;

procedure TEditForm.SaveAs1Click(Sender: TObject);
begin
    SaveDialog1.InitialDir := GetSpecialFolderPath(CSIDL_PERSONAL);
    if SaveDialog1.Execute then
    begin
      if RichEdit1.Modified then
      SaveDialog1.FileName := EditForm.Caption
      else
      SaveDialog1.FileName := 'Untitled';
    end;
end;

procedure TEditForm.ToolButton1Click(Sender: TObject);
begin
    RichEdit1.Clear;
end;

procedure TEditForm.ColorSelect1Accept(Sender: TObject);
begin
    RichEdit1.Color := ColorSelect1.Dialog.Color;
end;

procedure TEditForm.StartButtonClick(Sender: TObject);
begin
  LiveForm.Show;
end;

end.
