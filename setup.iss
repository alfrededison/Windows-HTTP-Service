#define MyAppName "Standalone HTTP Service"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Hieu Nguyen"
#define MyAppURL "https://github.com/alfrededison"
#define MyAppExeName "setup-windows-http-service"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{A24AA61F-11EF-460B-8E34-C3525FC65746}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DisableDirPage=yes
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputBaseFilename={#MyAppExeName}-{#MyAppVersion}
Compression=lzma
SolidCompression=yes
PrivilegesRequired = admin
ArchitecturesInstallIn64BitMode=x64
VersionInfoVersion={#MyAppVersion}
VersionInfoCompany={#MyAppPublisher}
VersionInfoTextVersion={#MyAppVersion}
VersionInfoProductVersion={#MyAppVersion}
VersionInfoDescription={#MyAppName}

[Code]
function InitializeSetup(): Boolean;
label return;
begin
  if not IsWin64 then
  begin
    MsgBox('Please run the installer in Windows 64bit', mbCriticalError, MB_OK);
    Result := False;
    goto return;
  end;
  Result := True;
  return:
end;

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "publish\net6.0\win10-x64\appsettings.Development.json"; DestDir: "{app}"; Flags: ignoreversion
Source: "publish\net6.0\win10-x64\appsettings.json"; DestDir: "{app}"; Flags: ignoreversion
Source: "publish\net6.0\win10-x64\aspnetcorev2_inprocess.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "publish\net6.0\win10-x64\Windows HTTP Service.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "publish\net6.0\win10-x64\Windows HTTP Service.pdb"; DestDir: "{app}"; Flags: ignoreversion

[Run]
Filename: "{sys}\sc.exe"; Parameters: "create ""{#MyAppName}"" binpath= ""{app}\Windows HTTP Service.exe"" start= auto"; Flags: runhidden;
Filename: "{sys}\sc.exe"; Parameters: "start ""{#MyAppName}"""; Flags: runhidden;

[UninstallRun]
Filename: "{sys}\sc.exe"; Parameters: "stop ""{#MyAppName}"""; Flags: runhidden;
Filename: "{sys}\sc.exe"; Parameters: "delete ""{#MyAppName}"""; Flags: runhidden; RunOnceId: "Uninstall {#MyAppName}";