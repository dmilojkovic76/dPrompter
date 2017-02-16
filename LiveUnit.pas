unit LiveUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OpenGL;

type
  TLiveForm = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    procedure Draw;   // Draws OpenGL scene on request
  public
    { Public declarations }
  end;

var
  LiveForm: TLiveForm;
  FontLists: Cardinal;
  gmf:array [0..255] of GLYPHMETRICSFLOAT ;
  h_DC:HDC;
  h_RC:HGLRC;
  h_Wnd:HWND;

implementation

{$R *.dfm}

procedure setupPixelFormat(h_DC:HDC);
const
  pfd:TPIXELFORMATDESCRIPTOR = (
    nSize:sizeof(TPIXELFORMATDESCRIPTOR);            // size
    nVersion:1;                                      // version
    dwFlags:PFD_SUPPORT_OPENGL
      or PFD_DRAW_TO_WINDOW
      or PFD_DOUBLEBUFFER;                           // support double-buffering
    iPixelType:PFD_TYPE_RGBA;                        // color type
    cColorBits:16;                                   // preffered color depth
    cRedBits:0; cRedShift:0;                         // ignore color bits
    cGreenBits:0; cGreenShift:0;
    cBlueBits:0; cBlueShift:0;
    cAlphaBits:0; cAlphaShift:0;                     // no Alpha buffer
    cAccumBits:0;                                    // no Accumulation buffer
    cAccumRedBits:0; cAccumGreenBits:0; cAccumBlueBits:0; cAccumAlphaBits:0;
    cDepthBits:16;                                   // depth Buffer
    cStencilBits:1;                                  // no stencil buffer
    cAuxBuffers:0;                                    // no auxiliary buffer
    iLayerType:PFD_MAIN_PLANE;                       // main layer
    bReserved:0;
    dwLayerMask:0;
    dwVisibleMask:0;
    dwDamageMask:0;
  );
var pixelFormat:integer;
begin
  pixelFormat := ChoosePixelFormat(h_DC, @pfd);
  if (pixelFormat = 0) then
      exit;
  if (SetPixelFormat (h_DC, pixelFormat, @pfd) <> TRUE) then
      exit;
end;

procedure GLInit;
begin
    glMatrixMode(GL_PROJECTION);    // set viewing projection
    glFrustum(-0.1, 0.1, -0.1, 0.1, 0.3, 25.0);    // Position viewer
    glMatrixMode(GL_MODELVIEW);
    glEnable(GL_DEPTH_TEST);
end;

procedure CreateFontLists; // Will be called once at the beginning
var
  CustomFont: HFont;
begin
  FontLists := glGenLists(256);
  CustomFont := CreateFont(
                           -32,                  // Height
                           0,                   // Width 0=default width
                           0,                   // Angle of Escapement
                           0,                   // Orientation angle
                           FW_BOLD,             // Bold?
                           0,                   // Italic?
                           0,                   // Underline?
                           0,                   // Strikethrough?
                           ANSI_CHARSET,        // Character Set identifier
                           OUT_TT_PRECIS,       // Output Precision
                           CLIP_DEFAULT_PRECIS, // Clipping Precision
                           ANTIALIASED_QUALITY, //Output quality
                           FF_DONTCARE or DEFAULT_PITCH, // Family and Pitch
                           'Tahoma');  // Font Name

  SelectObject(h_DC, CustomFont);               // Select the Font we created
  wglUseFontOutlines (h_DC, 0, 255, FontLists, 0, 0.2, WGL_FONT_POLYGONS, @gmf);  // Create Font Objects from selected
end;

procedure DestroyFontLists;
begin
  glDeleteLists(FontLists, 256);
end;

procedure ShowText(pText: AnsiString);
begin
    glListBase(FontLists);
    glCallLists(Length(pText), GL_UNSIGNED_BYTE, Pointer(pText));
end;

procedure TLiveForm.Draw;
begin
   glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
   glLoadIdentity;
   CreateFontLists;
   ShowText('Neki Text ');
end;

procedure TLiveForm.FormCreate(Sender: TObject);
begin
    h_DC:= GetDC(Handle); //GetDC(Handle);     // Actually, you can use any windowed controll here
    SetupPixelFormat(h_DC);
    h_RC:=wglCreateContext(h_DC);   // makes OpenGL window out of h_DC
    wglMakeCurrent(h_DC, h_RC);     // makes OpenGL window active
    GLInit;
end;

procedure TLiveForm.FormPaint(Sender: TObject);
begin
    Draw;
end;

end.
