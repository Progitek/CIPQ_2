$PBExportHeader$n_cst_theme.sru
forward
global type n_cst_theme from nonvisualobject
end type
type str_size from structure within n_cst_theme
end type
end forward

type str_size from structure
	long		cx
	Long		cy
end type

global type n_cst_theme from nonvisualobject autoinstantiate
end type

type prototypes
Function Long SetWindowTheme( uLong hwnd, Ref String pszSubAppName, ref String pszSubIdList ) Library "UxTheme.dll" Alias for "SetWindowTheme;Ansi"
Function Long SetWindowTheme( uLong hwnd, Ref Blob pszSubAppName, ref Blob pszSubIdList ) Library "UxTheme.dll" Alias for "SetWindowTheme"
Function uLong GetWindowTheme( uLong hwnd ) Library "UxTheme.dll" Alias for "GetWindowTheme"
Function Boolean IsThemeActive() Library "UxTheme.dll"
Function Boolean IsThemePartDefined( uLong hTheme, Int iPartId, Int iStateId ) Library "UxTheme.dll"
Function Boolean IsAppThemed() Library "UxTheme.dll"
Function uLong GetCurrentThemeName( Ref String pszThemeFileName, long dwMaxNameChars, Ref String pszColorBuff, Long cchMaxColorChars, Ref String pszSizeBuff, Long cchMaxSizeChars ) Library "UxTheme.dll"
Function uLong GetCurrentThemeName( Ref Blob pszThemeFileName, long dwMaxNameChars, Ref Blob pszColorBuff, Long cchMaxColorChars, Ref Blob pszSizeBuff, Long cchMaxSizeChars ) Library "UxTheme.dll"
Function uLong GetThemeColor( uLong hTheme, Int iPartId, Int iStateId, Int iPropId, Ref Long pColor ) Library "UxTheme.dll"
Function uLong GetThemeInt( uLong hTheme, Int iPartId, Int iStateId, Int iPropId, Ref Integer piVal ) Library "UxTheme.dll"
Function uLong GetThemeEnumValue( uLong hTheme, Int iPartId, Int iStateId, Int iPropId, Ref Integer piVal ) Library "UxTheme.dll"
Function uLong GetThemePartSize( uLong hTheme, uLong hdc, Int iPartId, Int iStateId, uLong prc, Integer eSize, Ref str_Size psz ) Library "UxTheme.dll" alias for "GetThemePartSize;Ansi"
Function uLong OpenThemeData( uLong hWnd, Ref String pszClassList )  Library "UxTheme.dll" alias for "OpenThemeData"
Function uLong OpenThemeData( uLong hWnd, Ref Blob pszClassList )  Library "UxTheme.dll"
Function uLong CloseThemeData( uLong hTheme )  Library "UxTheme.dll"

Function Long MulDiv( Long nNumber, Long nNumerator, Long nDenominator ) Library "kernel32.dll"
Function Long GetNearestColor( uLong hdc, Long crColor ) Library "gdi32.dll" 

Function Boolean SystemParametersInfo( uInt uiAction, uInt uiParam, Ref Any pvPAram, uInt fWinIni ) Library "user32.dll" Alias For "SystemParametersInfoA"
Function Boolean SystemParametersInfo( uInt uiAction, uInt uiParam, Long pvPAram, uInt fWinIni ) Library "user32.dll" Alias For "SystemParametersInfoA"//A"

Function long GlobalAlloc(long Flags, long Bytes) Library "kernel32.dll"
Function long GlobalFree(long MemHandle) Library "kernel32.dll"
Function long GlobalLock(long MemHandle) Library "kernel32.dll"
Function long GlobalUnlock(long MemHandle) Library "kernel32.dll"

end prototypes

type variables
Private:
String	is_CurrentThemeName
Boolean	ib_IsAppThemed

Constant Integer	WINDOWSXP = 0
Constant Integer	WINDOWS2000 = 1
Constant Integer	WINDOWSNT = 2
Constant Integer	WINDOWS95 = 3
Constant Integer	WINDOWS98 = 4
Constant Integer	WINDOWSME = 5
Constant Integer	WINDOWS31 = 6
Constant Integer	WINDOWSELSE = 7

Integer	ii_WindowsVersion
end variables

forward prototypes
public function long of_getcolor (integer ai_partid, integer ai_stateid, integer ai_propid)
public function long of_lightencolor (long al_scale, long al_color)
public function long of_midcolor (long al_color1, long al_color2)
public function long of_darkencolor (long al_scale, long al_color)
public function string of_getcurrenttheme ()
public function boolean of_isappthemed ()
public function integer of_getwindowsversion ()
public subroutine of_setwindowsversion ()
public function boolean of_iswindowsxp ()
public function long of_lightencolor (double ad_factor, long al_color)
public function long of_darkencolorxp (long al_color)
public subroutine of_setwindowtheme (unsignedlong aul_handle, string as_subappname, string as_subidlist)
public subroutine of_setcurrenttheme ()
public function unsignedlong of_opentheme (string as_classlist)
public function long of_getcolor (integer ai_partid, integer ai_stateid, integer ai_propid)
public function long of_lightencolor (long al_scale, long al_color)
public function long of_midcolor (long al_color1, long al_color2)
public function long of_darkencolor (long al_scale, long al_color)
public function string of_getcurrenttheme ()
public function boolean of_isappthemed ()
public function integer of_getwindowsversion ()
public subroutine of_setwindowsversion ()
public function boolean of_iswindowsxp ()
public function long of_lightencolor (double ad_factor, long al_color)
public function long of_darkencolorxp (long al_color)
public subroutine of_setwindowtheme (unsignedlong aul_handle, string as_subappname, string as_subidlist)
public subroutine of_setcurrenttheme ()
public function unsignedlong of_opentheme (string as_classlist)
end prototypes

public function long of_getcolor (integer ai_partid, integer ai_stateid, integer ai_propid);//********************************************************************************
//	Object:			n_cst_theme
//	Function:		of_GetColor
//	Arguments:		Integer 		ai_PartId
//						Integer 		ai_StateId
//						Integer 		ai_PropId
//	Returns:			Long
//	Description:	Returns a specific theme color (Windows Xp and higher only).
//
//********************************************************************************
// Revision History
// Date			Name					Revision
//--------------------------------------------------------------------------------
// 12-08-2005	Aart Onkenhout		Initial version
//********************************************************************************
// Copyright ©2005 Aart Onkenhout  All Rights Reserved.
//********************************************************************************
Long		ll_Color
uLong		lul_Null, lul_Theme
String	ls_ClassList

ls_ClassList = "Window"
lul_Theme = of_OpenTheme( ls_ClassList )
If lul_Theme > 0 Then
	GetThemeColor( lul_Theme, ai_PartId, ai_StateId, ai_PropId, ll_Color )
	CloseThemeData( lul_Theme )
End If

Return ll_Color
end function

public function long of_lightencolor (long al_scale, long al_color);//********************************************************************************
//	Object:			n_cst_theme
//	Function:		of_LightenColor
//	Arguments:		Long 			al_Scale
//						Long			al_Color
//	Returns:			None
//	Description:	Lightens a given color.
//
//********************************************************************************
// Revision History
// Date			Name					Revision
//--------------------------------------------------------------------------------
// 12-08-2005	Aart Onkenhout		Initial version
//********************************************************************************
// Copyright ©2005 Aart Onkenhout  All Rights Reserved.
//********************************************************************************
Integer	li_Red, li_Green, li_Blue, li_RedNew, li_GreenNew, li_BlueNew

li_Blue = al_Color / 65536
li_Green = ( al_Color - li_Blue * 65536 ) / 256
li_Red = al_Color - ( li_Green * 256 ) - ( li_Blue * 65536 )

li_RedNew = MulDiv( 255 - li_Red, al_Scale, 255 ) + li_Red
li_GreenNew = MulDiv( 255 - li_Green, al_Scale, 255 ) + li_Green
li_BlueNew = MulDiv( 255 - li_Blue, al_Scale, 255 ) + li_Blue

Return Rgb( li_RedNew, li_GreenNew, li_BlueNew )
end function

public function long of_midcolor (long al_color1, long al_color2);//********************************************************************************
//	Object:			n_cst_theme
//	Function:		of_MidColor
//	Arguments:		Long 			al_Color1
//						Long			al_Color2
//	Returns:			None
//	Description:	Mixes two colors.
//
//********************************************************************************
// Revision History
// Date			Name					Revision
//--------------------------------------------------------------------------------
// 12-08-2005	Aart Onkenhout		Initial version
//********************************************************************************
// Copyright ©2005 Aart Onkenhout  All Rights Reserved.
//********************************************************************************
Integer	li_Red1, li_Green1, li_Blue1, li_Red2, li_Green2, li_Blue2, li_RedNew, li_GreenNew, li_BlueNew

li_Blue1 = al_Color1 / 65536
li_Green1 = ( al_Color1 - li_Blue1 * 65536 ) / 256
li_Red1 = al_Color1 - ( li_Green1 * 256 ) - ( li_Blue1 * 65536 )

li_Blue2 = al_Color2 / 65536
li_Green2 = ( al_Color2 - li_Blue2 * 65536 ) / 256
li_Red2 = al_Color2 - ( li_Green2 * 256 ) - ( li_Blue2 * 65536 )

li_RedNew = MulDiv( 7, li_Red1, 10 ) + MulDiv( 3, li_Red2, 10 )
li_GreenNew = MulDiv( 7, li_Green1, 10 ) + MulDiv( 3, li_Green2, 10 )
li_BlueNew = MulDiv( 7, li_Blue1, 10 ) + MulDiv( 3, li_Blue2, 10 )

Return Rgb( li_RedNew, li_GreenNew, li_BlueNew )
end function

public function long of_darkencolor (long al_scale, long al_color);//********************************************************************************
//	Object:			n_cst_theme
//	Function:		of_DarkenColor
//	Arguments:		Long 			al_Scale
//						Long			al_Color
//	Returns:			None
//	Description:	Darkens a given color.
//
//********************************************************************************
// Revision History
// Date			Name					Revision
//--------------------------------------------------------------------------------
// 12-08-2005	Aart Onkenhout		Initial version
//********************************************************************************
// Copyright ©2005 Aart Onkenhout  All Rights Reserved.
//********************************************************************************
Integer	li_Red, li_Green, li_Blue, li_RedNew, li_GreenNew, li_BlueNew

li_Blue = al_Color / 65536
li_Green = ( al_Color - li_Blue * 65536 ) / 256
li_Red = al_Color - ( li_Green * 256 ) - ( li_Blue * 65536 )

li_RedNew = MulDiv( li_Red, 255 - al_Scale, 255 )
li_GreenNew = MulDiv( li_Green, 255 - al_Scale, 255 )
li_BlueNew = MulDiv( li_Blue, 255 - al_Scale, 255 )

Return Rgb( li_RedNew, li_GreenNew, li_BlueNew )
end function

public function string of_getcurrenttheme ();//********************************************************************************
//	Object:			n_cst_theme
//	Function:		of_GetCurrentTheme
//	Arguments:		None
//	Returns:			String
//	Description:	Returns the theme the application uses before turning it off (Windows Xp and higher only).
//
//********************************************************************************
// Revision History
// Date			Name					Revision
//--------------------------------------------------------------------------------
// 12-08-2005	Aart Onkenhout		Initial version
//********************************************************************************
// Copyright ©2005 Aart Onkenhout  All Rights Reserved.
//********************************************************************************
Return is_CurrentThemeName
end function

public function boolean of_isappthemed ();//********************************************************************************
//	Object:			n_cst_theme
//	Function:		of_IsAppThemed
//	Arguments:		None
//	Returns:			Boolean
//	Description:	Returns if the application is themed (Xp and higher only).
//
//********************************************************************************
// Revision History
// Date			Name					Revision
//--------------------------------------------------------------------------------
// 12-08-2005	Aart Onkenhout		Initial version
//********************************************************************************
// Copyright ©2005 Aart Onkenhout  All Rights Reserved.
//********************************************************************************
If Not of_IsWindowsXp() Then Return False

Return IsThemeActive() And IsAppThemed()
end function

public function integer of_getwindowsversion ();//********************************************************************************
//	Object:			n_cst_theme
//	Function:		of_GetWindowsVersion
//	Arguments:		None
//	Returns:			Integer
//	Description:	Returns the current Windows version.
//
//********************************************************************************
// Revision History
// Date			Name					Revision
//--------------------------------------------------------------------------------
// 12-08-2005	Aart Onkenhout		Initial version
//********************************************************************************
// Copyright ©2005 Aart Onkenhout  All Rights Reserved.
//********************************************************************************
Return ii_WindowsVersion
end function

public subroutine of_setwindowsversion ();//********************************************************************************
//	Object:			n_cst_theme
//	Function:		of_SetWindowsVersion
//	Arguments:		None
//	Returns:			None
//	Description:	Determines what windows version we're on..
//
//********************************************************************************
// Revision History
// Date			Name					Revision
//--------------------------------------------------------------------------------
// 12-08-2005	Aart Onkenhout		Initial version
//********************************************************************************
// Copyright ©2005 Aart Onkenhout  All Rights Reserved.
//********************************************************************************
Environment	le_env
String		ls_Version

ii_WindowsVersion = WINDOWSELSE

GetEnvironment( le_env )

If le_env.OSType = WindowsNT! Then
	If le_env.OSMajorRevision = 5 Then
		CHOOSE CASE le_env.OSMinorRevision
			CASE 0
				ii_WindowsVersion = WINDOWS2000
			CASE 1
				ii_WindowsVersion =  WINDOWSXP
			CASE ELSE
				ii_WindowsVersion =  WINDOWSELSE
			END CHOOSE 
		Else 
			ii_WindowsVersion =  WINDOWSNT
	End If 
Else 
   CHOOSE CASE le_env.OSMinorRevision 
      CASE 0, 3 
			ii_WindowsVersion =  WINDOWS95
      CASE 1 
         ii_WindowsVersion =  WINDOWS31
      CASE 10 
			ii_WindowsVersion =  WINDOWS98
      CASE 90
			ii_WindowsVersion =  WINDOWSME
   END CHOOSE 
End If

end subroutine

public function boolean of_iswindowsxp ();//********************************************************************************
//	Object:			n_cst_theme
//	Function:		of_IsWindowsXp
//	Arguments:		None
//	Returns:			Boolean
//	Description:	Returns if we are on Xp or higher.
//
//********************************************************************************
// Revision History
// Date			Name					Revision
//--------------------------------------------------------------------------------
// 12-08-2005	Aart Onkenhout		Initial version
//********************************************************************************
// Copyright ©2005 Aart Onkenhout  All Rights Reserved.
//********************************************************************************
Return ( ii_WindowsVersion = WINDOWSXP )
end function

public function long of_lightencolor (double ad_factor, long al_color);//********************************************************************************
//	Object:			n_cst_theme
//	Function:		of_LightenColor
//	Arguments:		Double 		ad_Factor
//						Long			al_Color
//	Returns:			None
//	Description:	Lightens a given color.
//
//********************************************************************************
// Revision History
// Date			Name					Revision
//--------------------------------------------------------------------------------
// 12-08-2005	Aart Onkenhout		Initial version
//********************************************************************************
// Copyright ©2005 Aart Onkenhout  All Rights Reserved.
//********************************************************************************
Integer	li_Red, li_Green, li_Blue, li_RedNew, li_GreenNew, li_BlueNew

li_Blue = al_Color / 65536
li_Green = ( al_Color - li_Blue * 65536 ) / 256
li_Red = al_Color - ( li_Green * 256 ) - ( li_Blue * 65536 )

li_RedNew = (( ad_factor * ( 255 - li_Red ) ) + li_Red )
li_GreenNew = (( ad_factor * ( 255 - li_Green ) ) + li_Green )
li_BlueNew = (( ad_factor * ( 255 - li_Blue ) ) + li_Blue )

Return Rgb( li_RedNew, li_GreenNew, li_BlueNew )

end function

public function long of_darkencolorxp (long al_color);//********************************************************************************
//	Object:			n_cst_theme
//	Function:		of_DarkenColorXp
//	Arguments:		Long			al_Color
//	Returns:			None
//	Description:	Darkens a given color for Xp theme specifically.
//
//********************************************************************************
// Revision History
// Date			Name					Revision
//--------------------------------------------------------------------------------
// 12-08-2005	Aart Onkenhout		Initial version
//********************************************************************************
// Copyright ©2005 Aart Onkenhout  All Rights Reserved.
//********************************************************************************
Integer	li_Red, li_Green, li_Blue, li_RedNew, li_GreenNew, li_BlueNew

li_Blue = al_Color / 65536
li_Green = ( al_Color - li_Blue * 65536 ) / 256
li_Red = al_Color - ( li_Green * 256 ) - ( li_Blue * 65536 )

li_RedNew = MulDiv( li_Red, 7, 10 )
li_GreenNew = MulDiv( li_Green, 7, 10 )
li_BlueNew = MulDiv( li_Blue, 7, 10 )

Return Rgb( li_RedNew, li_GreenNew, li_BlueNew )
end function

public subroutine of_setwindowtheme (unsignedlong aul_handle, string as_subappname, string as_subidlist);Blob			lblb_SubAppName, lblb_SubIdList
Environment	lenv_Current

If Not of_IsWindowsXp() Then Return

If of_IsAppThemed() Then
	of_SetCurrentTheme()
End If

GetEnvironment( lenv_Current )
If lenv_Current.pbmajorrevision <= 9 Then
	lblb_SubAppName = Blob( as_SubAppName ,EncodingUTF16LE!)
	lblb_SubIdList = Blob( as_SubIdList ,EncodingUTF16LE!)
	SetWindowTheme( aul_Handle, lblb_SubAppName, lblb_SubIdList )
Else
	SetWindowTheme( aul_Handle, as_SubAppName, as_SubIdList )
End If


end subroutine

public subroutine of_setcurrenttheme ();//********************************************************************************
//	Object:			n_cst_theme
//	Function:		of_SetCurrentTheme
//	Arguments:		None
//	Returns:			None
//	Description:	Returns the theme the application uses before turning it off (Windows Xp and higher only).
//
//********************************************************************************
// Revision History
// Date			Name					Revision
//--------------------------------------------------------------------------------
// 12-08-2005	Aart Onkenhout		Initial version
//********************************************************************************
// Copyright ©2005 Aart Onkenhout  All Rights Reserved.
//********************************************************************************
String	ls_Null
Blob		lblb_Null, lblb_Theme
Environment	lenv_Current

is_CurrentThemeName = Space( 256 )

GetEnvironment( lenv_Current )
If lenv_Current.pbmajorrevision <= 9 Then
	lblb_Theme = Blob( is_Currentthemename ,EncodingUTF16LE!)
	SetNull( lblb_Null )
	GetCurrentThemeName( lblb_Theme, 100, lblb_Null, 0, lblb_Null, 0 )
	is_Currentthemename = String( lblb_Theme ,EncodingUTF16LE!)
Else
	SetNull( ls_Null )
	GetCurrentThemeName( is_CurrentThemeName, 100, ls_Null, 0, ls_Null, 0 )
End If
end subroutine

public function unsignedlong of_opentheme (string as_classlist);//********************************************************************************
//	Object:			n_cst_theme
//	Function:		of_OpenTheme
//	Arguments:		String 		as_ClassList
//	Returns:			uLong
//	Description:	Returns a handle to a theme (Windows Xp and higher only).
//
//********************************************************************************
// Revision History
// Date			Name					Revision
//--------------------------------------------------------------------------------
// 12-08-2005	Aart Onkenhout		Initial version
//********************************************************************************
// Copyright ©2005 Aart Onkenhout  All Rights Reserved.
//********************************************************************************
uLong			lul_Null, lul_Theme
Blob			lblb_ClassList
Environment	lenv_Current

SetNull( lul_Null )

GetEnvironment( lenv_Current )
If lenv_Current.pbmajorrevision <= 9 Then
	lblb_ClassList = Blob( as_ClassList ,EncodingUTF16LE!)
	lul_Theme = OpenThemeData( lul_Null, lblb_ClassList )
Else
	lul_Theme = OpenThemeData( lul_Null, as_ClassList )
End If

Return lul_Theme
end function

on n_cst_theme.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_theme.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;of_SetWindowsVersion()

If of_GetWindowsVersion() = WINDOWSXP Then of_SetCurrentTheme()

end event

