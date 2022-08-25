; Script generated by the HM NIS Edit Script Wizard.

; add File Extensions
!macro APP_ASSOCIATE EXT FILECLASS DESCRIPTION ICON COMMANDTEXT COMMAND
  ; Backup the previously associated file class
  ReadRegStr $R0 HKCR ".${EXT}" ""
  WriteRegStr HKCR ".${EXT}" "${FILECLASS}_backup" "$R0"
  WriteRegStr HKCR ".${EXT}" "" "${FILECLASS}"
  WriteRegStr HKCR "${FILECLASS}" "" `${DESCRIPTION}`
  WriteRegStr HKCR "${FILECLASS}\DefaultIcon" "" `${ICON}`
  WriteRegStr HKCR "${FILECLASS}\shell" "" "open"
  WriteRegStr HKCR "${FILECLASS}\shell\open" "" `${COMMANDTEXT}`
  WriteRegStr HKCR "${FILECLASS}\shell\open\command" "" `${COMMAND}`
!macroend

!macro APP_ASSOCIATE_EX EXT FILECLASS DESCRIPTION ICON VERB DEFAULTVERB SHELLNEW COMMANDTEXT COMMAND
  ; Backup the previously associated file class
  ReadRegStr $R0 HKCR ".${EXT}" ""
  WriteRegStr HKCR ".${EXT}" "${FILECLASS}_backup" "$R0"
  WriteRegStr HKCR ".${EXT}" "" "${FILECLASS}"

  StrCmp "${SHELLNEW}" "0" +2

  WriteRegStr HKCR ".${EXT}\ShellNew" "NullFile" ""
  WriteRegStr HKCR "${FILECLASS}" "" `${DESCRIPTION}`
  WriteRegStr HKCR "${FILECLASS}\DefaultIcon" "" `${ICON}`
  WriteRegStr HKCR "${FILECLASS}\shell" "" `${DEFAULTVERB}`
  WriteRegStr HKCR "${FILECLASS}\shell\${VERB}" "" `${COMMANDTEXT}`
  WriteRegStr HKCR "${FILECLASS}\shell\${VERB}\command" "" `${COMMAND}`
!macroend

!macro APP_ASSOCIATE_WEMX EXT FILECLASS DESCRIPTION ICON VERB DEFAULTVERB SHELLNEW COMMANDTEXT COMMAND
  ; Backup the previously associated file class
  ReadRegStr $R0 HKCR ".${EXT}" ""
  WriteRegStr HKCR ".${EXT}" "${FILECLASS}_backup" "$R0"
  WriteRegStr HKCR ".${EXT}\OpenWithProgids" "${FILECLASS}" ""
  WriteRegStr HKCR ".${EXT}" "" "${FILECLASS}"
 
  StrCmp "${SHELLNEW}" "0" +2
 
  WriteRegStr HKCR ".${EXT}\ShellNew" "NullFile" ""
 
  WriteRegStr HKCR "${FILECLASS}" "" `${DESCRIPTION}`
  WriteRegStr HKCR "${FILECLASS}\DefaultIcon" "" `${ICON}`
  WriteRegStr HKCR "${FILECLASS}\shell" "" `${DEFAULTVERB}`
  WriteRegStr HKCR "${FILECLASS}\shell\${VERB}" "" `${COMMANDTEXT}`
  WriteRegStr HKCR "${FILECLASS}\shell\${VERB}\command" "" `${COMMAND}`
!macroend

!macro APP_UNASSOCIATE EXT FILECLASS
  ; Backup the previously associated file class
  ReadRegStr $R0 HKCR ".${EXT}" `${FILECLASS}_backup`
  WriteRegStr HKCR ".${EXT}" "" "$R0"
  DeleteRegKey HKCR `${FILECLASS}`
!macroend

!macro APP_ASSOCIATE_ADDVERB FILECLASS VERB COMMANDTEXT COMMAND
  WriteRegStr HKCR "${FILECLASS}\shell\${VERB}" "" `${COMMANDTEXT}`
  WriteRegStr HKCR "${FILECLASS}\shell\${VERB}\command" "" `${COMMAND}`
!macroend

; !defines for use with SHChangeNotify
!ifdef SHCNE_ASSOCCHANGED
!undef SHCNE_ASSOCCHANGED
!endif
!define SHCNE_ASSOCCHANGED 0x08000000
!ifdef SHCNF_FLUSH
!undef SHCNF_FLUSH
!endif
!define SHCNF_FLUSH        0x1000

!macro UPDATEFILEASSOC
; Using the system.dll plugin to call the SHChangeNotify Win32 API function so we
; can update the shell.
  System::Call "shell32::SHChangeNotify(i,i,i,i) (${SHCNE_ASSOCCHANGED}, ${SHCNF_FLUSH}, 0, 0)"
!macroend

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "weMX"
!define PRODUCT_FULL_NAME "${PRODUCT_NAME} ${PRODUCT_VERSION}"
!define PRODUCT_FULL_NAME_2018 "${PRODUCT_NAME} HMI+SCADA 2018"
!define PRODUCT_FULL_VERSION_NAME "${PRODUCT_NAME} ${PRODUCT_VERSION_NAME}"
!define PRODUCT_REGISTRY "v1.7"
!define PRODUCT_YEAR_NAME "weMX 2020"
!define PRODUCT_YEAR_NAME_2018 "weMX 2018"

; 2019-09-25 : 
;!define PRODUCT_VERSION "2018"
!define PRODUCT_VERSION "HMI+SCADA 2020"

; 2019-09-25 : 
;!define PRODUCT_VERSION_NAME "2018"
!define PRODUCT_VERSION_NAME "HMI+SCADA 2020"

!define PRODUCT_REVISION_PREV "weMX_2020_r"
!ifndef PRODUCT_REVISION
!define PRODUCT_REVISION "21603"
!endif
!define PRODUCT_PUBLISHER "weMX Tech Co., LTD."
!define PRODUCT_WEB_SITE "http://wemx.biz/"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\playerapp.exe"
!define PRODUCT_UNINST_KEY_2018 "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_FULL_NAME_2018}"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_FULL_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define PRODUCT_PROGRAM_VERSION "v2.1.0.${PRODUCT_REVISION}"

!define PRODUCT_PLAYER_NAME "weMX Player"
!define PRODUCT_DESIGNER_NAME "weMX Designer"
;!define PRODUCT_PLAYER_LINK_NAME "${PRODUCT_NAME} Player ${PRODUCT_VERSION}"
!define PRODUCT_PLAYER_LINK_NAME "${PRODUCT_NAME} Player 2020"
;!define PRODUCT_PLAYER_LINK_DEBUG_NAME "${PRODUCT_NAME} Player ${PRODUCT_VERSION}(Debug)"
!define PRODUCT_PLAYER_LINK_DEBUG_NAME "${PRODUCT_NAME} Player 2020(Debug)"
;!define PRODUCT_DESIGNER_LINK_NAME "${PRODUCT_NAME} Designer ${PRODUCT_VERSION}"
!define PRODUCT_DESIGNER_LINK_NAME "${PRODUCT_NAME} Designer 2020"
!define PRODUCT_LICENSETOOL_LINK_NAME "License Tool"
!define PRODUCT_DESIGNER_PROCESS_NAME "designercore.exe"
!define PRODUCT_PLAYER_PROCESS_NAME "playerapp.exe"
!define PRODUCT_MANUAL_NAME "Manual"
!define PRODUCT_MANUAL_PATH "$INSTDIR\manual"
;!define PRODUCT_LOCAL_APPDATA_PATH "$LOCALAPPDATA\weMX2"
!define PRODUCT_LOCAL_APPDATA_PATH "$PROFILE\weMX2\settings\HMI"
!define SETTING_DATA "Setting Data"

; MUI 1.67 compatible ------
!include "MUI.nsh"

; 폰트 추가 작업
!include "FontReg.nsh"
!include "FontName.nsh"
!include "WinMessages.nsh"
!include "LogicLib.nsh"
;!include "fileassoc.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"
!define MUI_WELCOMEFINISHPAGE_BITMAP "resource\setup.bmp" ;환영 페이지의 배경

; Welcome page
!insertmacro MUI_PAGE_WELCOME

; Language files
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "Korean"

LangString STR_CHECK_PROCESS        ${LANG_KOREAN} "현재 프로그램이 수행중입니다. 종료후 진행해 주시기 바랍니다."
LangString STR_CHECK_PROCESS        ${LANG_ENGLISH} "The program is currently running. Please proceed after exiting."
LangString STR_INSTALL_DESIGNER      ${LANG_KOREAN}  "${PRODUCT_DESIGNER_LINK_NAME} 바로가기를 생성합니다."
LangString STR_INSTALL_DESIGNER      ${LANG_ENGLISH} "Create shortcut to ${PRODUCT_DESIGNER_LINK_NAME}"
LangString STR_INSTALL_PLAYER        ${LANG_KOREAN}  "${PRODUCT_PLAYER_LINK_NAME} 바로가기를 생성합니다."
LangString STR_INSTALL_PLAYER        ${LANG_ENGLISH} "Create shortcut to ${PRODUCT_PLAYER_LINK_NAME}"
LangString STR_INSTALL_PLAYER_DEBUG  ${LANG_KOREAN}  "${PRODUCT_PLAYER_LINK_DEBUG_NAME}를 설치합니다."
LangString STR_INSTALL_PLAYER_DEBUG  ${LANG_ENGLISH} "Install to ${PRODUCT_PLAYER_LINK_DEBUG_NAME}"
LangString STR_IS_DELETE            ${LANG_KOREAN}  "$(^Name)를 제거하시겠습니까?"
LangString STR_IS_DELETE            ${LANG_ENGLISH} "Do you want to uninstall $(^Name)?"
LangString STR_DELETED              ${LANG_KOREAN}  "$(^Name)는 완전히 제거되었습니다."
LangString STR_DELETED              ${LANG_ENGLISH} "$(^Name) was removed."
LangString STR_INSTALL_REDIST_2012  ${LANG_KOREAN}  "프로그램 실행을 위해 Visual C++ 2012 Redistributable를 설치합니다."
LangString STR_INSTALL_REDIST_2012  ${LANG_ENGLISH} "Install the Redistributable Visual C ++ 2012 for run the program."
LangString STR_INSTALL_REDIST_2013  ${LANG_KOREAN}  "프로그램 실행을 위해 Visual C++ 2013 Redistributable를 설치합니다."
LangString STR_INSTALL_REDIST_2013  ${LANG_ENGLISH} "Install the Redistributable Visual C ++ 2013 for run the program."
LangString STR_INSTALL_REDIST_2017  ${LANG_KOREAN}  "프로그램 실행을 위해 Visual C++ 2017 Redistributable를 설치합니다."
LangString STR_INSTALL_REDIST_2017  ${LANG_ENGLISH} "Install the Redistributable Visual C ++ 2017 for run the program."

;2019-09-25
;LangString STR_ALREADY_INSTALLED    ${LANG_KOREAN}  "${PRODUCT_FULL_VERSION_NAME}은 이미 설치되어 있습니다. $\n$\n확인 버튼을 누르면 이전 버전을 삭제 후 재설치하고 취소 버튼을 누르면 업그레이드를 취소합니다."
;LangString STR_ALREADY_INSTALLED    ${LANG_ENGLISH} "${PRODUCT_FULL_VERSION_NAME} was already installed.$\n$\nIf you press the OK button, delete the old version and then reinstall. If you press the Cancel button, the upgrade will be canceled."
LangString STR_ALREADY_INSTALLED    ${LANG_KOREAN}  "${PRODUCT_YEAR_NAME}은 이미 설치되어 있습니다. $\n$\n확인 버튼을 누르면 이전 버전을 삭제 후 재설치하고 취소 버튼을 누르면 업그레이드를 취소합니다."
LangString STR_ALREADY_INSTALLED    ${LANG_ENGLISH} "${PRODUCT_YEAR_NAME} was already installed.$\n$\nIf you press the OK button, delete the old version and then reinstall. If you press the Cancel button, the upgrade will be canceled."

;2020-07-07
LangString STR_ALREADY_INSTALLED_2018    ${LANG_KOREAN}  "${PRODUCT_YEAR_NAME_2018}은 이미 설치되어 있습니다. $\n$\n확인 버튼을 누르면 이전 버전을 삭제합니다."
LangString STR_ALREADY_INSTALLED_2018    ${LANG_ENGLISH} "${PRODUCT_YEAR_NAME_2018} was already installed.$\n$\nIf you press the OK button, delete the old version."

;2019-09-25
;LangString STR_INSTALL_COMPLETE     ${LANG_KOREAN}  "${PRODUCT_FULL_VERSION_NAME} 설치가 완료되었습니다."
;LangString STR_INSTALL_COMPLETE     ${LANG_ENGLISH} "Finished to Install ${PRODUCT_FULL_VERSION_NAME}"
LangString STR_INSTALL_COMPLETE     ${LANG_KOREAN}  "${PRODUCT_YEAR_NAME} 설치가 완료되었습니다."
LangString STR_INSTALL_COMPLETE     ${LANG_ENGLISH} "Finished to Install ${PRODUCT_YEAR_NAME}"

;2019-09-25
;LangString STR_FINISH_AND_CLOSE     ${LANG_KOREAN}  "컴퓨터에 ${PRODUCT_FULL_VERSION_NAME} 구성요소가 모두 설치되었습니다. 설치 프로그램을 닫으려면 '닫음' 버튼을 눌러주세요."
;LangString STR_FINISH_AND_CLOSE     ${LANG_ENGLISH} "${PRODUCT_FULL_VERSION_NAME} all components have been installed on your computer. To close the installer, please press the 'close' button."
LangString STR_FINISH_AND_CLOSE     ${LANG_KOREAN}  "컴퓨터에 ${PRODUCT_YEAR_NAME} 구성요소가 모두 설치되었습니다. 설치 프로그램을 닫으려면 '닫음' 버튼을 눌러주세요."
LangString STR_FINISH_AND_CLOSE     ${LANG_ENGLISH} "${PRODUCT_YEAR_NAME} all components have been installed on your computer. To close the installer, please press the 'close' button."

LangString STR_UNINSTALL_WEMX       $(LANG_KOREAN)  "weMX 2.0을 삭제 합니다."
LangString STR_UNINSTALL_WEMX       $(LANG_ENGLISH) "Unstall a weMX 2.0"
LangString STR_UNINSTALL_USERDATA   $(LANG_KOREAN)  "사용자 데이터를 삭제 합니다."
LangString STR_UNINSTALL_USERDATA   $(LANG_ENGLISH) "Delete a user data."

LicenseLangString LicenseTXT        ${LANG_ENGLISH} "resource\license(en).txt" 
LicenseLangString LicenseTXT        ${LANG_KOREAN}  "resource\license(kr).txt"

;VIProductVersion				        2.0.0.0
;VIAddVersionKey "ProductName"			"weMX HMI+SCADA 2018"
;VIAddVersionKey "Comments"			    "weMX HMI+SCADA 2018 Installer"
;VIAddVersionKey "FileDescription"		"weMX HMI+SCADA 2018"
;VIAddVersionKey "FileVersion"			"${PRODUCT_REVISION}"
;VIAddVersionKey "CompanyName"			"Neodian Technology"
;VIAddVersionKey "LegalCopyright"		"Copyright @ Neodian Technology"

; License page
!define MUI_LICENSEPAGE_RADIOBUTTONS
;2019-09-25 ;2017-09-07 수정 
;!define MUI_LICENSEPAGE_TEXT_TOP "${PRODUCT_FULL_VERSION_NAME} License"
;!define MUI_LICENSEPAGE_TEXT_TOP "${PRODUCT_FULL_VERSION_NAME}"
!define MUI_LICENSEPAGE_TEXT_TOP "${PRODUCT_YEAR_NAME}"

!define MUI_PAGE_HEADER_TEXT "License Agreement"
;!define MUI_PAGE_HEADER_SUBTEXT "Please read the following license agreement carefully."
!insertmacro MUI_PAGE_LICENSE $(LicenseTXT)

; Components page
;2017-09-07 수정
;!define MUI_PAGE_HEADER_TEXT "Choose Components"
;!define MUI_PAGE_HEADER_TEXT "Create Shortcuts to Desktop"
;!define MUI_PAGE_HEADER_SUBTEXT "Choose which features of weMX you want to install."
;!insertmacro MUI_PAGE_COMPONENTS

; Directory page
!define MUI_PAGE_HEADER_TEXT "Choose Install Location"
;!define MUI_PAGE_HEADER_SUBTEXT "Click Next to install to this folder, or click Change to install to a different folder."
!insertmacro MUI_PAGE_DIRECTORY

; Instfiles page
!insertmacro MUI_PAGE_INSTFILES

; Finish page
!define MUI_PAGE_HEADER_SUBTEXT 

!define MUI_FINISHPAGE_LINK 'Click here to visit us at wemx.biz.'
  !define MUI_FINISHPAGE_LINK_LOCATION http://wemx.biz/
!define MUI_FINISHPAGE_TEXT_LARGE
!define MUI_FINISHPAGE_TITLE "$(STR_INSTALL_COMPLETE)"
!define MUI_FINISHPAGE_TEXT "$(STR_FINISH_AND_CLOSE)"
!insertmacro MUI_PAGE_FINISH

; Uninstall Component page
!define MUI_UNPAGE_HEADER_TEXT "weMX Uninstall"
!insertmacro MUI_UNPAGE_COMPONENTS

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Redistributable Visual C++ 2012 Redistributable
!define TIMEDOT_2012 "vcredist_x86_2012.exe"

; Redistributable Visual C++ 2013 Redistributable
!define TIMEDOT_2013 "vcredist_x86_2013.exe"

; Redistributable Visual C++ 2017 Redistributable
!define TIMEDOT_2017 "vcredist_x86_2017.exe"

RequestExecutionLevel admin

Function GetFontName 
    Exch $R0 
    Push $R1 
    Push $R2 

    System::Call *(i${NSIS_MAX_STRLEN})i.R1 
    System::Alloc ${NSIS_MAX_STRLEN} 
    Pop $R2 
    System::Call gdi32::GetFontResourceInfoW(wR0,iR1,iR2,i1)i.R0 
    ${If} $R0 == 0 
    StrCpy $R0 error 
    ${Else} 
    System::Call *$R2(&w${NSIS_MAX_STRLEN}.R0) 
    ${EndIf} 
    System::Free $R1 
    System::Free $R2 

    Pop $R2 
    Pop $R1 
    Exch $R0 
FunctionEnd 

Function .onInit
  ; ikban : 2019-09-25 : 모든 사용자 접근으로 설정 변경.
  SetShellVarContext all 
  
; 실행중인 프로그램 체크
  FindProcessLoop:
    FindProcDLL::FindProc "${PRODUCT_DESIGNER_PROCESS_NAME}"
    StrCmp $R0 "1" FindProcessMsg
    
  FindPlayerLoop:
    FindProcDLL::FindProc "${PRODUCT_PLAYER_PROCESS_NAME}"
    StrCmp $R0 "1" FindProcessMsg
    Goto FindProcessEnd
    
  FindProcessMsg:
    MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION "$(STR_CHECK_PROCESS)" IDOK FindProcessLoop IDCANCEL ExitInstaller
  ExitInstaller:
    Abort
  FindProcessEnd:

  FindTransmitDaemonLoop:
    FindProcDLL::FindProc "wemxTransmitDaemon.exe"
	StrCmp $R0 "1" killTransmitDaemon
	Goto FindTransmitDaemonLoopEnd
  killTransmitDaemon: 	
	KillProcDLL::KillProc "wemxTransmitDaemon.exe"
	Goto FindTransmitDaemonLoop
  FindTransmitDaemonLoopEnd:	
  
  ;StrCpy $InstDir "$PROGRAMFILES\${PRODUCT_FULL_NAME}"
  StrCpy $InstDir "$PROGRAMFILES\${PRODUCT_YEAR_NAME}"
  ReadRegStr $R0 "${PRODUCT_UNINST_ROOT_KEY}" "${PRODUCT_UNINST_KEY_2018}" "UninstallString"
  StrCmp $R0 "" chk2020  
  MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION \
  "$(STR_ALREADY_INSTALLED_2018)" IDOK uninst_2018 IDCANCEL chk2020 
  
chk2020: 
  ReadRegStr $R0 "${PRODUCT_UNINST_ROOT_KEY}" "${PRODUCT_UNINST_KEY}" "UninstallString"
  StrCmp $R0 "" done
showMessage:
  MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION \
  "$(STR_ALREADY_INSTALLED)" IDOK uninst IDCANCEL doAbort
doAbort:
  Abort
  
uninst_2018:
  ClearErrors
  ReadRegStr $InstDir "HKLM" "Software\Microsoft\Windows\CurrentVersion\Uninstall\weMX HMI+SCADA 2018" "InstallDir"
  StrCmp $InstDir "" emptyinstdir_2018  
  Goto execunint_2018
emptyinstdir_2018:  
  StrCpy $InstDir "$PROFILE\weMX HMI+SCADA 2018"
execunint_2018:
  ReadRegStr $R1 "HKLM" "Software\Microsoft\Windows\CurrentVersion\Uninstall\weMX HMI+SCADA 2018" "removePlayerString"
  StrCmp $R1 "" execuninststring_2018
  ExecWait '$R1 _?=$InstDir'
  Goto removedirectory_2018
execuninststring_2018:  
  ExecWait '$R0 _?=$InstDir'
removedirectory_2018:  
  Delete /REBOOTOK $R0
  RMDIR /r "$InstDir"
  Goto chk2020
  
;Run the uninstaller
uninst:
  ClearErrors
  ReadRegStr $InstDir "${PRODUCT_UNINST_ROOT_KEY}" "${PRODUCT_UNINST_KEY}" "InstallDir"
  StrCmp $InstDir "" emptyinstdir  
  Goto execunint
emptyinstdir:  
  StrCpy $InstDir "$PROGRAMFILES\${PRODUCT_YEAR_NAME}"
execunint:  
  ReadRegStr $R1 "${PRODUCT_UNINST_ROOT_KEY}" "${PRODUCT_UNINST_KEY}" "removePlayerString"
  StrCmp $R1 "" execuninststring
  ExecWait '$R1 _?=$InstDir'
  Goto removedirectory
execuninststring:  
  ExecWait '$R0 _?=$InstDir'
removedirectory: 
  Delete /REBOOTOK $R0
  RMDIR /r "$InstDir"

  RMDIR /r "$SMPROGRAMS\${PRODUCT_YEAR_NAME}"
  
  ;2019-09-25 : 바로가기 폴더 명만 변경 한다.
  RMDIR /r "$SMPROGRAMS\${PRODUCT_YEAR_NAME}"
done:
	StrCpy $InstDir "$PROGRAMFILES\${PRODUCT_YEAR_NAME}"
FunctionEnd
  
Function .onInstSuccess
   ;ikban : 2019-09-25 : 모든 사용자 접근으로 설정 변경.
   SetShellVarContext all 
  
   ReadRegStr $0 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{33d1fd90-4274-48a1-9bc1-97e33d9c2d6f}\" "DisplayName"
   StrCmp $0 "Microsoft Visual C++ 2012 Redistributable (x86) - 11.0.61030" VSRedistInstalled_2012

   MessageBox MB_OK|MB_ICONINFORMATION  "$(STR_INSTALL_REDIST_2012)"
   ExecWait "$INSTDIR\${TIMEDOT_2012}"
   Delete /REBOOTOK "$INSTDIR\${TIMEDOT_2012}"
VSRedistInstalled_2012:

   ReadRegStr $0 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{6031457b-1e35-46a2-9ae4-516ac306286b}\" "DisplayName"
   StrCmp $0 "Microsoft Visual C++ 2013 Redistributable (x86) - 12.0.30501" VSRedistInstalled_2013
   MessageBox MB_OK|MB_ICONINFORMATION  "$(STR_INSTALL_REDIST_2013)"
   ExecWait "$INSTDIR\${TIMEDOT_2013}"
   Delete /REBOOTOK "$INSTDIR\${TIMEDOT_2013}"
   
VSRedistInstalled_2013:
   ;ReadRegStr $0 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{5bfc1380-fd35-4b85-9715-7351535d077e}\" "DisplayName"
   ;StrCmp $0 "Microsoft Visual C++ 2015-2019 Redistributable (x86) - 14.22.27821" VSRedistInstalled_2017
   ;MessageBox MB_OK|MB_ICONINFORMATION  "$(STR_INSTALL_REDIST_2017)"
   ;ExecWait "$INSTDIR\${TIMEDOT_2017}"
   ;Delete /REBOOTOK "$INSTDIR\${TIMEDOT_2017}"
   
   ReadRegStr $0 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{86380aef-fd23-4fc3-8723-a98ccad8f2c6}\" "DisplayName"
   StrCmp $0 "Microsoft Visual C++ 2015-2019 Redistributable (x86) - 14.26.28720" VSRedistInstalled_2017
   MessageBox MB_OK|MB_ICONINFORMATION  "$(STR_INSTALL_REDIST_2017)"
   ExecWait "$INSTDIR\${TIMEDOT_2017}"
   Delete /REBOOTOK "$INSTDIR\${TIMEDOT_2017}"
   
VSRedistInstalled_2017:
FunctionEnd

Function un.onUninstSuccess
  ;ikban : 2019-09-25 : 모든 사용자 접근으로 설정 변경.
  SetShellVarContext all 
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(STR_DELETED)"
FunctionEnd

Function un.onInit
  ;ikban : 2019-09-25 : 모든 사용자 접근으로 설정 변경.
  SetShellVarContext all 
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "$(STR_IS_DELETE)" IDYES +2
  Abort
  
  FindDesignerLoop:
    FindProcDLL::FindProc "${PRODUCT_DESIGNER_PROCESS_NAME}"
	StrCmp $R0 "1" killDesigner
	Goto FindDesignerLoopEnd
  killDesigner: 	
	KillProcDLL::KillProc "${PRODUCT_DESIGNER_PROCESS_NAME}"
	Goto FindDesignerLoop
  FindDesignerLoopEnd:
  
  FindPlayerLoop:
    FindProcDLL::FindProc "${PRODUCT_PLAYER_PROCESS_NAME}"
	StrCmp $R0 "1" killPlayer
	Goto FindPlayerLoopEnd
  killPlayer: 	
	KillProcDLL::KillProc "${PRODUCT_PLAYER_PROCESS_NAME}"
	Goto FindPlayerLoop
  FindPlayerLoopEnd:
  
  FindTransmitDaemonLoop:
    FindProcDLL::FindProc "wemxTransmitDaemon.exe"
	StrCmp $R0 "1" killTransmitDaemon
	Goto FindTransmitDaemonLoopEnd
  killTransmitDaemon: 	
	KillProcDLL::KillProc "wemxTransmitDaemon.exe"
	Goto FindTransmitDaemonLoop
  FindTransmitDaemonLoopEnd:  
FunctionEnd
; MUI end ------

;2019-09-25
;Name "${PRODUCT_FULL_VERSION_NAME}"
Name "${PRODUCT_YEAR_NAME}"
;OutFile "${PRODUCT_FULL_NAME}_${PRODUCT_REVISION}.exe"
OutFile "${PRODUCT_REVISION_PREV}${PRODUCT_REVISION}.exe"
InstallDir "$PROGRAMFILES\${PRODUCT_YEAR_NAME}"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

;2019-09-25
;BrandingText /TRIMRIGHT "${PRODUCT_FULL_VERSION_NAME}" ;설치 프로그램의 하부에 가로줄과 함께 나올 텍스트
BrandingText /TRIMRIGHT "${PRODUCT_YEAR_NAME}" ;설치 프로그램의 하부에 가로줄과 함께 나올 텍스트

Function installCommomFile
  SetShellVarContext all 
  
  SetOutPath "$INSTDIR\bin"
    File /r "install\bin\*"
    SetOutPath "$INSTDIR\lib"
    File /r "install\lib\*"
  SetOutPath "$INSTDIR\controller"
    File /r "install\controller\*"
  SetOutPath "$INSTDIR\bin"
    File /r "install\bin\*"
  SetOutPath "$INSTDIR\lib"
    File /r "install\lib\*"
  SetOutPath "$INSTDIR\licenses"
    File /r "install\licenses\*"
  SetOutPath "$INSTDIR\manual"
    File /r "install\manual\*"
  SetOutPath "$INSTDIR\resources"
    File /r "install\resources\*"
  SetOutPath "$INSTDIR\scriptdrivers"
    File /r "install\scriptdrivers\*"
  SetOutPath "$INSTDIR\services"
    File /r "install\services\*"
  SetOutPath "$INSTDIR\services2.0"
    File /r "install\services2.0\*"
  SetOutPath "$INSTDIR\transmitter"
    File /r "install\transmitter\*"
  SetOutPath "$INSTDIR"
    File "install\vcredist_x86_2012.exe"
  SetOutPath "$INSTDIR"
    File "install\vcredist_x86_2013.exe"
  SetOutPath "$INSTDIR"
    File "install\vcredist_x86_2017.exe"	
FunctionEnd


; ikban : 2017-09-13 : hidden section
Section "-Default Section"
  ;ikban : 2019-09-25 : 모든 사용자 접근으로 설정 변경.
  SetShellVarContext all 
  
; 섹선별 설치용량 직접 계산시 사용 (KB 단위)
;AddSize 504000
  SetOutPath "$INSTDIR\bin"
    File /r "install\bin\*"
  SetOutPath "$INSTDIR\lib"
    File /r "install\lib\*"
  SetOutPath "$INSTDIR\controller"
    File /r "install\controller\*"
  SetOutPath "$INSTDIR\bin"
    File /r "install\bin\*"
  SetOutPath "$INSTDIR\lib"
    File /r "install\lib\*"
  SetOutPath "$INSTDIR\licenses"
    File /r "install\licenses\*"
  SetOutPath "$INSTDIR\manual"
    File /r "install\manual\*"
  SetOutPath "$INSTDIR\resources"
    File /r "install\resources\*"
  SetOutPath "$INSTDIR\scriptdrivers"
    File /r "install\scriptdrivers\*"
  SetOutPath "$INSTDIR\services"
    File /r "install\services\*"
  SetOutPath "$INSTDIR\services2.0"
    File /r "install\services2.0\*"
  SetOutPath "$INSTDIR\transmitter"
    File /r "install\transmitter\*"
  SetOutPath "$INSTDIR"
    File "install\vcredist_x86_2012.exe"
  SetOutPath "$INSTDIR"
    File "install\vcredist_x86_2013.exe"
  SetOutPath "$INSTDIR"
    File "install\vcredist_x86_2017.exe"	
SectionEnd



Section "weMX Designer 2020" SEC01
  Var /GLOBAL addfont
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  
  SetAutoClose true
  
  ; ikban : 2019-09-25 : 모든 사용자 접근으로 설정 변경.
  SetShellVarContext all 
  
  ;!insertmacro APP_UNASSOCIATE "w7z" "w7z.file"
  ;!insertmacro APP_UNASSOCIATE "w7z" "w7z.file.designer"
  ;!insertmacro APP_UNASSOCIATE "w7z" "w7z.file.player"
  ;!insertmacro APP_UNASSOCIATE "wex" "wex.file"
  ;!insertmacro APP_UNASSOCIATE "wex" "wex.file.designer"
  ;!insertmacro APP_UNASSOCIATE "wex" "wex.file.player"
  ;!insertmacro UPDATEFILEASSOC
  
  ; 폰트 추가 작업
  ;!define HWND_BROADCAST $hwnd
  ;SetShellVarContext all
  ;SetOverwrite off
  
  StrCpy $addfont "NO"
  StrCpy $FONT_DIR $FONTS
  SetOutPath "$FONT_DIR"
  
  IfFileExists "$%SystemRoot%\fonts\NanumGothic.ttf" SKIP_NANUMGOTHIC INSTALL_NANUMGOTHIC
  INSTALL_NANUMGOTHIC:
    !insertmacro InstallTTFFont ".\install\resources\fonts\NanumGothic.ttf"
    StrCpy $addfont "YES"
  SKIP_NANUMGOTHIC:
	ReadRegStr $R0 "HKLM" "Software\Microsoft\Windows NT\CurrentVersion\Fonts" "나눔고딕 (TrueType)"
	StrCmp $R0 "" REG_NANUMGOTHIC_HAN DONE_NANUMGOTHIC_HAN
  REG_NANUMGOTHIC_HAN:
	WriteRegStr HKLM "Software\Microsoft\Windows NT\CurrentVersion\Fonts" "나눔고딕 (TrueType)" "NanumGothic.ttf"
	StrCpy $addfont "YES"
  DONE_NANUMGOTHIC_HAN:
	ReadRegStr $R0 "HKLM" "Software\Microsoft\Windows NT\CurrentVersion\Fonts" "NanumGothic (TrueType)"
	StrCmp $R0 "" REG_NANUMGOTHIC_EN DONE_NANUMGOTHIC_EN
  REG_NANUMGOTHIC_EN:
	WriteRegStr HKLM "Software\Microsoft\Windows NT\CurrentVersion\Fonts" "NanumGothic (TrueType)" "NanumGothic.ttf"
	StrCpy $addfont "YES"
  DONE_NANUMGOTHIC_EN:  
  
  IfFileExists "$%SystemRoot%\fonts\NanumBarunGothic.ttf" SKIP_BARUNGOTHIC INSTALL_BARUNGOTHIC
  INSTALL_BARUNGOTHIC:
    !insertmacro InstallTTFFont ".\install\resources\fonts\NanumBarunGothic.ttf"
    StrCpy $addfont "YES"
  SKIP_BARUNGOTHIC:
	ReadRegStr $R0 "HKLM" "Software\Microsoft\Windows NT\CurrentVersion\Fonts" "나눔바른고딕 (TrueType)"
	StrCmp $R0 "" REG_BARUNGOTHIC_HAN DONE_BARUNGOTHIC_HAN
  REG_BARUNGOTHIC_HAN:
	WriteRegStr HKLM "Software\Microsoft\Windows NT\CurrentVersion\Fonts" "나눔바른고딕 (TrueType)" "NanumBarunGothic.ttf"
	StrCpy $addfont "YES"
  DONE_BARUNGOTHIC_HAN:
	ReadRegStr $R0 "HKLM" "Software\Microsoft\Windows NT\CurrentVersion\Fonts" "NanumBarunGothic (TrueType)"
	StrCmp $R0 "" REG_BARUNGOTHIC_EN DONE_BARUNGOTHIC_EN
  REG_BARUNGOTHIC_EN:
	WriteRegStr HKLM "Software\Microsoft\Windows NT\CurrentVersion\Fonts" "NanumBarunGothic (TrueType)" "NanumBarunGothic.ttf"
	StrCpy $addfont "YES"
  DONE_BARUNGOTHIC_EN:  
  
  IfFileExists "$%SystemRoot%\fonts\code128.ttf" SKIP_CODE128 INSTALL_CODE128
  INSTALL_CODE128:
    !insertmacro InstallTTFFont ".\install\resources\fonts\code128.ttf"
    StrCpy $addfont "YES"
  SKIP_CODE128:   
 	ReadRegStr $R0 "HKLM" "Software\Microsoft\Windows NT\CurrentVersion\Fonts" "Code 128 (TrueType)"
	StrCmp $R0 "" REG_CODE128 DONE_CODE128
  REG_CODE128:
	WriteRegStr HKLM "Software\Microsoft\Windows NT\CurrentVersion\Fonts" "Code 128 (TrueType)" "code128.ttf"
	StrCpy $addfont "YES"
  DONE_CODE128:
  
  IfFileExists "$%SystemRoot%\fonts\12LotteMartDreamBold.ttf" SKIP_12LOTTEMARTDREAMBOLD INSTALL_12LOTTEMARTDREAMBOLD
  INSTALL_12LOTTEMARTDREAMBOLD:
    !insertmacro InstallTTFFont ".\install\resources\fonts\12LotteMartDreamBold.ttf"
    StrCpy $addfont "YES"
  SKIP_12LOTTEMARTDREAMBOLD:  
	ReadRegStr $R0 "HKLM" "Software\Microsoft\Windows NT\CurrentVersion\Fonts" "12롯데마트드림Bold (TrueType)"
	StrCmp $R0 "" REG_12LOTTEMARTDREAMBOLD_HAN DONE_12LOTTEMARTDREAMBOLD_HAN
  REG_12LOTTEMARTDREAMBOLD_HAN:
	WriteRegStr HKLM "Software\Microsoft\Windows NT\CurrentVersion\Fonts" "12롯데마트드림Bold (TrueType)" "12LotteMartDreamBold.ttf"
	StrCpy $addfont "YES"
  DONE_12LOTTEMARTDREAMBOLD_HAN:
	ReadRegStr $R0 "HKLM" "Software\Microsoft\Windows NT\CurrentVersion\Fonts" "12LotteMartDreamBold (TrueType)"
	StrCmp $R0 "" REG_12LOTTEMARTDREAMBOLD_EN DONE_12LOTTEMARTDREAMBOLD_EN
  REG_12LOTTEMARTDREAMBOLD_EN:
	WriteRegStr HKLM "Software\Microsoft\Windows NT\CurrentVersion\Fonts" "12LotteMartDreamBold (TrueType)" "12LotteMartDreamBold.ttf"
	StrCpy $addfont "YES"
  DONE_12LOTTEMARTDREAMBOLD_EN:    
 
  IfFileExists "$%SystemRoot%\fonts\Segment7Standard.otf" SKIP_SEGMENT7 INSTALL_SEGMENT7
  INSTALL_SEGMENT7:
   	File "install\resources\fonts\Segment7Standard.otf"
   	System::Call "gdi32::AddFontResource(t 'Segment7Standard.otf')"  
	StrCpy $addfont "YES"
  SKIP_SEGMENT7:
 	ReadRegStr $R0 "HKLM" "Software\Microsoft\Windows NT\CurrentVersion\Fonts" "Segment7 (TrueType)"
	StrCmp $R0 "" REG_SEGMENT7 DONE_SEGMENT7
  REG_SEGMENT7:
	WriteRegStr HKLM "Software\Microsoft\Windows NT\CurrentVersion\Fonts" "Segment7 (TrueType)" "Segment7Standard.otf"
	StrCpy $addfont "YES"
  DONE_SEGMENT7:   
  
  ${If} $addfont == "YES"
     SendMessage ${HWND_BROADCAST} ${WM_FONTCHANGE} 0 0 /TIMEOUT=5000
  ${Else}
  ${EndIf}
  
  ; 2017-08-02
  ;Call installCommomFile 
  CreateDirectory "$SMPROGRAMS\${PRODUCT_YEAR_NAME}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\${PRODUCT_DESIGNER_LINK_NAME}.lnk" "$INSTDIR\bin\designercore.exe"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\${PRODUCT_PLAYER_LINK_NAME}.lnk" "$INSTDIR\bin\playerapp.exe" "" "$INSTDIR\resources\image\player.ico" 
  CreateShortCut "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\${PRODUCT_PLAYER_LINK_NAME}(Debug).lnk" "$INSTDIR\bin\playerapp.exe" '"-debug"' "$INSTDIR\resources\image\player.ico"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\${PRODUCT_PLAYER_LINK_NAME}(FullScreen).lnk" "$INSTDIR\bin\playerapp.exe" '"-mode" "fullscreen"' "$INSTDIR\resources\image\player_fullscreen.ico"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\${PRODUCT_PLAYER_LINK_NAME}(Fit-to-Screen).lnk" "$INSTDIR\bin\playerapp.exe" '"-mode" "fitscreen"' "$INSTDIR\resources\image\player_fitscreen.ico"
  CreateShortCut "$DESKTOP\${PRODUCT_DESIGNER_LINK_NAME}.lnk" "$INSTDIR\bin\designercore.exe"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\${PRODUCT_MANUAL_NAME}.lnk" "$INSTDIR\manual"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\${PRODUCT_LICENSETOOL_LINK_NAME}.lnk" "$INSTDIR\bin\licensetool.exe"
  ;CreateShortCut "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\weMX 2018 Transmitter.lnk" "$INSTDIR\bin\transmitter.exe"  
  CreateShortCut "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\Uninstall.lnk" "$INSTDIR\uninst.exe"
  
!insertmacro APP_ASSOCIATE_WEMX "w7z" "w7z.file.player" "w7z File" "$INSTDIR\resources\image\w7z_file.ico,0" "player" "" "" "" "$INSTDIR\bin\playerapp.exe $\"%1$\""
!insertmacro APP_ASSOCIATE_WEMX "w7z" "w7z.file.designer" "w7z File" "$INSTDIR\resources\image\w7z_file.ico,0" "designer" "" "" "" "$INSTDIR\bin\designercore.exe $\"%1$\""
!insertmacro APP_ASSOCIATE_WEMX "wex" "wex.file.player" "wex File" "$INSTDIR\resources\image\w7z_file.ico,0" "player" "" "" "" "$INSTDIR\bin\playerapp.exe $\"%1$\""
!insertmacro APP_ASSOCIATE_WEMX "wex" "wex.file.designer" "wex File" "$INSTDIR\resources\image\w7z_file.ico,0" "designer" "" "" "" "$INSTDIR\bin\designercore.exe $\"%1$\""

!insertmacro APP_ASSOCIATE "w7zc" "w7zc.file" "w7zc File" "$INSTDIR\resources\image\w7zc_file.ico,0" "" ""
!insertmacro APP_ASSOCIATE "w7zd" "w7zd.file" "w7zd File" "$INSTDIR\resources\image\w7zd_file.ico,0" "" ""
!insertmacro APP_ASSOCIATE "w7zs" "w7zs.file" "w7zs File" "$INSTDIR\resources\image\w7zs_file_256.ico,0" "" ""

!insertmacro UPDATEFILEASSOC

; FriendlyAppName 을 추가 하기위한 코드는 우선 적용해둔다. (*주석 처리 해둔다.)
WriteRegStr HKCR Applications\playerapp.exe\shell\open "FriendlyAppName" "weMX Player 2020"
WriteRegStr HKCR Applications\designercore.exe\shell\open "FriendlyAppName" "weMX Designer 2020"
    
SectionEnd

Section "weMX Player 2020" SEC02
  ; ikban : 2019-09-25 : 모든 사용자 접근으로 설정 변경.
  SetShellVarContext all 
  ;CreateShortCut "$DESKTOP\${PRODUCT_PLAYER_LINK_NAME}.lnk" "$INSTDIR\bin\playerapp.exe" 
  ;CreateShortCut "$DESKTOP\${PRODUCT_PLAYER_LINK_NAME}(FullScreen).lnk" "$INSTDIR\bin\playerapp.exe" '"-mode" "fullscreen"'
  IfFileExists "$INSTDIR\bin\designercore.exe" end file_not_found
    file_not_found:
        ; 2017-08-02
        ;Call installCommomFile
		CreateDirectory "$SMPROGRAMS\${PRODUCT_YEAR_NAME}"
        CreateShortCut "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\${PRODUCT_DESIGNER_LINK_NAME}.lnk" "$INSTDIR\bin\designercore.exe"
        CreateShortCut "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\${PRODUCT_PLAYER_LINK_NAME}.lnk" "$INSTDIR\bin\playerapp.exe" "" "$INSTDIR\resources\image\player.ico"  
        CreateShortCut "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\${PRODUCT_PLAYER_LINK_NAME}(Debug).lnk" "$INSTDIR\bin\playerapp.exe" '"-debug"' "$INSTDIR\resources\image\player.ico"
        CreateShortCut "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\${PRODUCT_PLAYER_LINK_NAME}(FullScreen).lnk" "$INSTDIR\bin\playerapp.exe" '"-mode" "fullscreen"' "$INSTDIR\resources\image\player_fullscreen.ico"
		CreateShortCut "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\${PRODUCT_PLAYER_LINK_NAME}(Fit-to-Screen).lnk" "$INSTDIR\bin\playerapp.exe" '"-mode" "fitscreen"' "$INSTDIR\resources\image\player_fitscreen.ico"
        CreateShortCut "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\${PRODUCT_MANUAL_NAME}.lnk" "$INSTDIR\manual"
        CreateShortCut "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\${PRODUCT_LICENSETOOL_LINK_NAME}.lnk" "$INSTDIR\bin\licensetool.exe"
		;CreateShortCut "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\weMX 2018 Transmitter.lnk" "$INSTDIR\bin\transmitter.exe"		
          !insertmacro APP_ASSOCIATE_WEMX "w7z" "w7z.file.player" "w7z File" "$INSTDIR\resources\image\w7z_file.ico,0" "player" "" "" "" "$INSTDIR\bin\playerapp.exe $\"%1$\""
        !insertmacro APP_ASSOCIATE_WEMX "wex" "wex.file.player" "wex File" "$INSTDIR\resources\image\w7z_file.ico,0" "player" "" "" "" "$INSTDIR\bin\playerapp.exe $\"%1$\""
        !insertmacro APP_ASSOCIATE "w7zc" "w7zc.file" "w7zc File" "$INSTDIR\resources\image\w7zc_file.ico,0" "" ""
        !insertmacro APP_ASSOCIATE "w7zd" "w7zd.file" "w7zd File" "$INSTDIR\resources\image\w7zd_file.ico,0" "" ""
        !insertmacro APP_ASSOCIATE "w7zs" "w7zs.file" "w7zs File" "$INSTDIR\resources\image\w7zs_file_256.ico,0" "" ""
        !insertmacro UPDATEFILEASSOC
    end:
    
SectionEnd


Section -AdditionalIcons
  ;ikban : 2019-09-25 : 모든 사용자 접근으로 설정 변경.
  SetShellVarContext all 
  SetOutPath $INSTDIR
  WriteIniStr "$INSTDIR\${PRODUCT_YEAR_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  ;ikban : 2019-09-25 : 모든 사용자 접근으로 설정 변경.
  SetShellVarContext all 
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\bin\playerapp.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" '"$INSTDIR\uninst.exe"'
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "removePlayerString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "InstallDir" "$INSTDIR"   
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\bin\designercore.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_PROGRAM_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Revision" "${PRODUCT_REVISION}"
  ;WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "EstimatedSize" ""
SectionEnd

; Section descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} "$(STR_INSTALL_DESIGNER)"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC02} "$(STR_INSTALL_PLAYER)"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC05} "$(STR_INSTALL_PLAYER_DEBUG)"
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Section un.weMX SEC03
  ;ikban : 2019-09-25 : 모든 사용자 접근으로 설정 변경.
  SetShellVarContext all 
SectionIn RO
  RMDir /r "$INSTDIR"
  
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  
  Delete "$DESKTOP\${PRODUCT_PLAYER_LINK_NAME}.lnk"
  Delete "$DESKTOP\${PRODUCT_DESIGNER_LINK_NAME}.lnk"
  Delete "$DESKTOP\${PRODUCT_PLAYER_LINK_NAME}(Debug).lnk"
  Delete "$DESKTOP\${PRODUCT_PLAYER_LINK_NAME}(FullScreen).lnk"  
  Delete "$DESKTOP\${PRODUCT_PLAYER_LINK_NAME}(Fit-to-Screen).lnk"  
  Delete "$SMPROGRAMS\${PRODUCT_FULL_NAME}\Uninstall.lnk"
  Delete "$SMPROGRAMS\${PRODUCT_FULL_NAME}\${PRODUCT_PLAYER_NAME}.lnk"
  Delete "$SMPROGRAMS\${PRODUCT_FULL_NAME}\${PRODUCT_DESIGNER_NAME}.lnk"
  Delete "$SMPROGRAMS\${PRODUCT_FULL_NAME}\${PRODUCT_PLAYER_NAME}(Debug).lnk"
  Delete "$SMPROGRAMS\${PRODUCT_FULL_NAME}\${PRODUCT_PLAYER_NAME}(FullScreen).lnk"  
  RMDIR /r "$SMPROGRAMS\${PRODUCT_FULL_NAME}"
  
  ;2019-09-25 : 바로가기 폴더 명만 변경 한다.
  Delete "$DESKTOP\${PRODUCT_PLAYER_LINK_NAME}.lnk"
  Delete "$DESKTOP\${PRODUCT_DESIGNER_LINK_NAME}.lnk"
  Delete "$DESKTOP\${PRODUCT_PLAYER_LINK_NAME}(Debug).lnk"
  Delete "$DESKTOP\${PRODUCT_PLAYER_LINK_NAME}(FullScreen).lnk"
  Delete "$DESKTOP\${PRODUCT_PLAYER_LINK_NAME}(Fit-to-Screen).lnk"
  Delete "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\Uninstall.lnk"
  Delete "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\${PRODUCT_PLAYER_NAME}.lnk"
  Delete "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\${PRODUCT_DESIGNER_NAME}.lnk"
  Delete "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\${PRODUCT_PLAYER_NAME}(Debug).lnk"
  Delete "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\${PRODUCT_PLAYER_NAME}(FullScreen).lnk"
  Delete "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\${PRODUCT_PLAYER_NAME}(Fit-to-Screen).lnk"  
  ;Delete "$SMPROGRAMS\${PRODUCT_YEAR_NAME}\weMX 2018 Transmitter.lnk"   
  RMDIR /r "$SMPROGRAMS\${PRODUCT_YEAR_NAME}"
  
  SetAutoClose true
  !insertmacro APP_UNASSOCIATE "w7z" "w7z.file"
  !insertmacro APP_UNASSOCIATE "w7z" "w7z.file.player"
  !insertmacro APP_UNASSOCIATE "w7z" "w7z.file.designer"
  !insertmacro APP_UNASSOCIATE "wex" "wex.file"
  !insertmacro APP_UNASSOCIATE "wex" "wex.file.player"
  !insertmacro APP_UNASSOCIATE "wex" "wex.file.designer"
  !insertmacro APP_UNASSOCIATE "w7zc" "w7zc.file"
  !insertmacro APP_UNASSOCIATE "w7zd" "w7zd.file"
  !insertmacro APP_UNASSOCIATE "w7zs" "w7zs.file"
  !insertmacro UPDATEFILEASSOC
SectionEnd

Section /o "un.Setting Data" SEC04
  ;ikban : 2019-09-25 : 모든 사용자 접근으로 설정 변경.
  SetShellVarContext all 
  
  RMDir /r "${PRODUCT_LOCAL_APPDATA_PATH}"
SectionEnd

; Section uninstall descriptions
!insertmacro MUI_UNFUNCTION_DESCRIPTION_BEGIN 
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC03} "$(STR_UNINSTALL_WEMX)"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC04} "$(STR_UNINSTALL_USERDATA)"
!insertmacro MUI_UNFUNCTION_DESCRIPTION_END