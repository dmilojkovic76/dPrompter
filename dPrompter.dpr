program dPrompter;



uses
  Forms,
  MainUnit in 'MainUnit.pas' {EditForm},
  LiveUnit in 'LiveUnit.pas' {LiveForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TEditForm, EditForm);
  Application.CreateForm(TLiveForm, LiveForm);
  Application.Run;
end.
