﻿$PBExportHeader$pro_n_cst_platformwin32.sru
$PBExportComments$(PRO) Extension Win32 Cross Platform service
forward
global type pro_n_cst_platformwin32 from pfc_n_cst_platformwin32
end type
end forward

global type pro_n_cst_platformwin32 from pfc_n_cst_platformwin32
end type
global pro_n_cst_platformwin32 pro_n_cst_platformwin32

type prototypes
function boolean FlashWindow( int a_hwnd, boolean fInvert ) library "user32.dll"
function boolean SetForegroundWindow( ulong a_hwnd ) library "user32.dll"
function ulong SendMessageA( ulong whwnd, uint wmsg,ulong wParam,ulong lparam ) library "user32.dll"
function boolean ShowWindow( ulong a_hwnd, int ncmdshow) library "user32.dll"
function ulong GetEnvironmentVariableA (string as_nomenvir, ref string as_valeurenvir, ulong al_grosseur ) library "KERNEL32.DLL" alias for "GetEnvironmentVariableA;Ansi"
SubRoutine Sleep(long al_miliseconds) library "kernel32.dll" 
function int ShellExecuteA( ulong hwnd, string lpOperation, string lpFile, string lpParameters, string lpDirectory, ulong nShowCmd) library "shell32.dll" alias for "ShellExecuteA;Ansi"
function ulong LoadImageA( ulong a_hInst, REF string a_lpszName, ulong a_uType, long a_cxDesired, long a_cyDesired, ulong a_fuLoad) library "user32.dll" alias for "LoadImageA;Ansi"
function long GetModuleFileNameA (long module, ref string path, long length) library "kernel32.dll" alias for "GetModuleFileNameA;Ansi"
function ulong WNetGetConnectionA (string szLocalName, REF string szRemoteName, REF ulong dwLength) library "mpr.dll" alias for "WNetGetConnectionA;Ansi"

//menu
FUNCTION boolean SetMenuItemBitmaps(ulong hmenu,uint upos,uint flags,ulong handle_bm1,ulong handle_bm2)  LIBRARY "USER32.DLL"
FUNCTION int GetSystemMetrics(  int nIndex ) LIBRARY "USER32.DLL"
FUNCTION ulong GetMenuItemID(ulong hMenu,uint uItem) LIBRARY "USER32.DLL"
FUNCTION int GetSubMenu(ulong hMenu,int pos) LIBRARY "USER32.DLL"
FUNCTION ulong GetMenu(ulong hWindow) LIBRARY "USER32.DLL"
FUNCTION boolean ModifyMenu(ulong  hMnu, ulong uPosition, ulong uFlags, ulong uIDNewItem, long lpNewI) alias for ModifyMenuA LIBRARY "USER32.DLL"
function boolean SetMenuDefaultItem(ulong hMenu,ulong uItem, ulong fByPos ) LIBRARY "USER32.DLL"

//curseur
Function long LoadCursorFromFile(string lpFileName) library "user32.dll" Alias for "LoadCursorFromFileA;Ansi"
Function Long SetSystemCursor(uLong hcur, uLong id)Library "user32.dll"
Function long GetCursor() Library "user32.dll"
Function long CopyIcon(uLong hcur) library"user32.dll"
FUNCTION uLong LoadCursorA( ulong hinst, ref string lpszCursor) library "user32.dll" alias for "LoadCursorA;Ansi"

function boolean GetKeyboardState( REF char lpKeyState[256] ) library "user32.dll" alias for "GetKeyboardState;Ansi"
Function int GetKeyState(integer VirtualKeycode) Library "User32.dll" 
end prototypes

forward prototypes
public function unsignedinteger of_findwindow (string as_window_name)
end prototypes

public function unsignedinteger of_findwindow (string as_window_name);
//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_FindWindow
//
//	Accès:  			Public
//
//	Argument: 		as_window_name - Le nom de la fenêtre que nous recherchons
//							
//	Retourne:  		uint - window handle
//
//	Description: 	Retourne le handle de la fenêtre recherchée
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

uint		lui_whnd
string 	ls_ClassName

SetNull(ls_ClassName)
lui_whnd = FindWindowA( ls_classname, as_window_name)

return lui_whnd
end function

on pro_n_cst_platformwin32.create
call super::create
end on

on pro_n_cst_platformwin32.destroy
call super::destroy
end on

