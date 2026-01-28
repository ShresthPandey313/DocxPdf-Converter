
[Setup]
AppName=DocxPdfconverter
AppVersion=1.0
AppPublisher=Shresth Pandey
AppPublisherURL=https://github.com/yourname
AppSupportURL=https://github.com/yourname
AppCopyright=Created by Shresth Pandey
DefaultDirName={userappdata}\DocxPdfconverter
DefaultGroupName=DocxPdfconverter
UninstallDisplayIcon={app}\DocxPdfconverter.exe
OutputBaseFilename=DocxPdfconverter_Setup
Compression=lzma
SolidCompression=yes
PrivilegesRequired=lowest
WizardStyle=modern

[Tasks]
Name: "desktopicon"; Description: "Create a &desktop icon"; GroupDescription: "Additional icons:"; Flags: unchecked
Name: "add_context"; Description: "Add right-click context menu entries for .pdf and .docx"; GroupDescription: "Additional tasks:"

[Files]
Source: "dist\DocxPdfconverter.exe"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\DocxPdfconverter"; Filename: "{app}\DocxPdfconverter.exe"; WorkingDir: "{app}"
Name: "{userdesktop}\DocxPdfconverter"; Filename: "{app}\DocxPdfconverter.exe"; Tasks: desktopicon

[Registry]
[Registry]
Root: HKCU; Subkey: "Software\Classes\SystemFileAssociations\.pdf\Shell\ConvertToDOCX"; ValueType: string; ValueName: ""; ValueData: "Convert to DOCX"; Flags: uninsdeletekey; Check: IsTaskSelected('add_context')
Root: HKCU; Subkey: "Software\Classes\SystemFileAssociations\.pdf\Shell\ConvertToDOCX"; ValueType: string; ValueName: "Icon"; ValueData: "{app}\DocxPdfconverter.exe,0"; Flags: uninsdeletevalue; Check: IsTaskSelected('add_context')
Root: HKCU; Subkey: "Software\Classes\SystemFileAssociations\.pdf\Shell\ConvertToDOCX\command"; ValueType: string; ValueName: ""; ValueData: """{app}\DocxPdfconverter.exe"" ""%1"""; Flags: uninsdeletekey; Check: IsTaskSelected('add_context')

Root: HKCU; Subkey: "Software\Classes\SystemFileAssociations\.docx\Shell\ConvertToPDF"; ValueType: string; ValueName: ""; ValueData: "Convert to PDF"; Flags: uninsdeletekey; Check: IsTaskSelected('add_context')
Root: HKCU; Subkey: "Software\Classes\SystemFileAssociations\.docx\Shell\ConvertToPDF"; ValueType: string; ValueName: "Icon"; ValueData: "{app}\DocxPdfconverter.exe,0"; Flags: uninsdeletevalue; Check: IsTaskSelected('add_context')
Root: HKCU; Subkey: "Software\Classes\SystemFileAssociations\.docx\Shell\ConvertToPDF\command"; ValueType: string; ValueName: ""; ValueData: """{app}\DocxPdfconverter.exe"" ""%1"""; Flags: uninsdeletekey; Check: IsTaskSelected('add_context')

[UninstallDelete]
Type: filesandordirs; Name: "{app}\assets"

[Run]
Filename: "{app}\DocxPdfconverter.exe"; Description: "Launch DocxPdfconverter"; Flags: nowait postinstall skipifsilent

[Code]
procedure AddCreatorLabel;
var
  L: TLabel;
begin
  L := TLabel.Create(WizardForm);
  L.Parent := WizardForm;
  L.Caption := 'Created by Shresth Pandey';
  L.Left := ScaleX(12);
  L.Top := WizardForm.ClientHeight - ScaleY(48);
  L.Font.Size := 9;
  L.Font.Style := [fsItalic];
  L.AutoSize := True;
  L.BringToFront;
end;

procedure InitializeWizard();
begin
  AddCreatorLabel();
end;
