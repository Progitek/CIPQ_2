﻿$PBExportHeader$n_cst_screencapture.sru
forward
global type n_cst_screencapture from n_base
end type
end forward

global type n_cst_screencapture from n_base autoinstantiate
end type

type prototypes
FUNCTION int ReleaseDC(ulong handle, ulong hDC) LIBRARY "User32.dll"
FUNCTION int OpenClipboard(ulong handle) LIBRARY "User32.dll"
FUNCTION int EmptyClipboard( ) LIBRARY "User32.dll"
FUNCTION ulong SetClipboardData(uint num, ulong handle) Library "User32.dll"
FUNCTION int CloseClipboard( ) LIBRARY "User32.dll"
FUNCTION ulong SelectObject(ulong hDC, ulong hGDIObj) LIBRARY "Gdi32.dll"
FUNCTION int DeleteDC(ulong hDC) LIBRARY "Gdi32.dll"
FUNCTION int BitBlt(ulong hDC, int num, int num, int num, int num, ulong hDC, int num, int num, ulong lParam) LIBRARY "Gdi32.dll"
FUNCTION ulong CreateDCA(ref string str, ref string str, ref string str, ref string str) LIBRARY "Gdi32.dll" alias for "CreateDCA;Ansi"
FUNCTION ulong CreateCompatibleDC(ulong hDC) LIBRARY "Gdi32.dll"
FUNCTION ulong CreateCompatibleBitmap(ulong hDC, int num, int num) LIBRARY "Gdi32.dll"
Function int GETSYSTEMMETRICS(int nIndex) library "user32.dll"
FUNCTION boolean GetWindowRect(ulong handle, ref rectangle RectStruct) LIBRARY "User32.dll" alias for "GetWindowRect;Ansi"
FUNCTION ulong GetActiveWindow( ) LIBRARY "User32.dll"
FUNCTION ulong GetDesktopWindow( ) LIBRARY "User32.dll"
FUNCTION ulong GetDC(ulong handle) LIBRARY "User32.dll"
FUNCTION integer GetClipboardFormatName( UINT  uFormat,string lpszFormatName, integer  cchFormatName)  LIBRARY "User32.dll" alias for "GetClipboardFormatName;Ansi"
subroutine CopyBitmap( blob b, ulong s, long l ) alias for RtlMoveMemory library "kernel32.dll"
subroutine CopyBitmapFileHeader( ref blob b, str_bitmapheader b, long l ) alias for "RtlMoveMemory;Ansi" library "kernel32.dll"
subroutine CopyBitmapInfoHeader( ref blob b, str_bitmapinfoheader b, long l ) alias for "RtlMoveMemory;Ansi" library "kernel32.dll"
subroutine CopyBitmapInfo( ref blob b, str_bitmapinfo b, long l ) alias for "RtlMoveMemory;Ansi" library "kernel32.dll"
function long GetDIBits(ulong hdc, ulong bitmap, ulong start, ulong lines, ref blob bits, ref str_bitmapinfo i, ulong pallete ) library "gdi32.dll" alias for "GetDIBits;Ansi"
function long GetDIBits(ulong hdc, ulong bitmap, ulong start, ulong lines, long bits, ref str_bitmapinfo i, ulong pallete ) library "gdi32.dll" alias for "GetDIBits;Ansi"


end prototypes

type variables

end variables

forward prototypes
public function integer of_filewrite (string as_filename, ref blob abl_data)
public function integer of_capture (window aw_fenetre, ref blob abl_data)
end prototypes

public function integer of_filewrite (string as_filename, ref blob abl_data);

//init_jpeg()
//clip_to_jpeg(as_filename,1,75)

RETURN 1
end function

public function integer of_capture (window aw_fenetre, ref blob abl_data);uLong ll_DeskHwnd,ll_hdc,ll_hdcMem ,ll_hBitmap
uLong ll_fleft, ll_ftop, ll_fwidth , ll_fheight
uLong ll_return

// The GetDesktopWindow function returns the handle of the Windows desktop 
// window. The desktop window covers the entire screen. 
// The desktop window is the area on top of which all icons and
// other windows are painted.  

ll_DeskHwnd = GetDesktopWindow()

// Get in pixel value the x,y,width,height of the window 
// because of the powerbuilder Units (PBU)

ll_fwidth=UnitsToPixels(aw_fenetre.width, XUnitsToPixels!)
ll_fheight=UnitsToPixels(aw_fenetre.height, YUnitsToPixels!)
ll_fleft=UnitsToPixels(aw_fenetre.X, XUnitsToPixels!)
ll_ftop=UnitsToPixels(aw_fenetre.Y, YUnitsToPixels!)

// 
// Get the device context of Desktop and allocate memory
// 

ll_hdc = GetDC(ll_DeskHwnd)
ll_hdcMem = CreateCompatibleDC(ll_hdc)
ll_hBitmap = CreateCompatibleBitmap(ll_hdc, ll_fwidth, ll_fheight)

If ll_hBitmap <> 0 Then
	ll_return = SelectObject(ll_hdcMem, ll_hBitmap)

// 
// Copy the Desktop bitmap to memory location
// 

   ll_return = BitBlt(ll_hdcMem, 0, 0, ll_fwidth, ll_fheight, ll_hdc, ll_fleft, ll_ftop, 13369376)

// 
// try to store the bitmap into a blob so we can save it
//	this does not always work BTW
// 

	long ll_pixels = 1
	
	str_bitmapinfo lstr_Info
	str_bitmapinfo lstr_InfoDummy
	str_bitmapheader lstr_Header
	
	lstr_Info.bmiheader.bisize=40
	lstr_InfoDummy.bmiheader.bisize=40
	
	// Get the bitmapinfo
	
	if GetDIBits(ll_hdcMem, ll_hBitmap, 0, ll_fheight, 0, lstr_Info, 0) > 0 then

		if lstr_Info.bmiheader.biBitCount = 16 or &
			lstr_Info.bmiheader.biBitCount = 32 then
			ll_pixels = lstr_info.bmiheader.biwidth * 	lstr_info.bmiheader.biheight
		end if
		
		lstr_Info.bmiColor[ll_pixels] = 0
		
		abl_data = blob(space(lstr_Info.bmiheader.bisizeimage))

		// get the actual bits

		GetDIBits(ll_hdcMem, ll_hBitmap, 0, ll_fheight, abl_data, lstr_Info, 0) 

		// create a bitmap header

		lstr_Header.bfType[1] = 'B'
		lstr_Header.bfType[2] = 'M'
		lstr_Header.bfSize 	= lstr_Info.bmiheader.bisizeimage
		lstr_Header.bfReserved1 = 0
		lstr_Header.bfReserved2 = 0
		lstr_Header.bfOffBits = 54 + (ll_pixels * 4)

		// copy the header structure to a blob

		blob lbl_header
		lbl_header = blob(space(14))
		CopyBitmapFileHeader(lbl_header, lstr_Header, 14 )

		// copy the info structure to a blob

		blob lbl_info
		lbl_Info = blob(space(40  + ll_pixels * 4) )
		CopyBitmapInfo(lbl_Info, lstr_Info, 40 + ll_pixels * 4 )
		
		// add all together and we have a window bitmap in a blob
		
		abl_Data = lbl_header + lbl_info + abl_Data
		
	end if

//          '---------------------------------------------
//          ' Set up the Clipboard and copy bitmap
//          '---------------------------------------------

   ll_return = OpenClipboard(ll_DeskHwnd)
   ll_return = EmptyClipboard()
   ll_return = SetClipboardData(2, ll_hBitmap)
   ll_return = CloseClipboard()

End If

//       '---------------------------------------------
//       ' Clean up handles
//       '---------------------------------------------
ll_return = DeleteDC(ll_hdcMem)
ll_return = ReleaseDC(ll_DeskHwnd, ll_hdc)


return 1
end function

on n_cst_screencapture.create
call super::create
end on

on n_cst_screencapture.destroy
call super::destroy
end on
