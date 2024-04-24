$PBExportHeader$n_adapter.sru
forward
global type n_adapter from nonvisualobject
end type
end forward

global type n_adapter from nonvisualobject autoinstantiate
end type

type prototypes
Function ulong GetAdaptersInfo ( &
	Ref blob pAdapterInfo, &
	Ref ulong pOutBufLen &
	) Library "iphlpapi.dll" Alias For "GetAdaptersInfo"

Function ulong GetAdaptersAddresses ( &
	ulong Family, &
	ulong Flags, &
	ulong Reserved, &
	Ref blob AdapterAddresses, &
	Ref ulong SizePointer &
	) Library "iphlpapi.dll" Alias For "GetAdaptersAddresses"

Function ulong FormatMessage( &
	ulong dwFlags, &
	ulong lpSource, &
	ulong dwMessageId, &
	ulong dwLanguageId, &
	Ref string lpBuffer, &
	ulong nSize, &
	ulong Arguments &
	) Library "kernel32.dll" Alias For "FormatMessageW"
end prototypes

forward prototypes
public function string of_tohex (long al_num)
public function string of_hexchar (integer ai_num)
public function string of_geterrormsg (unsignedlong aul_error)
public function boolean of_getadapterinfo (ref string as_macaddress[], ref string as_description[], ref string as_adaptername[], ref string as_ipaddress[])
public function boolean of_getadapteradresses (ref string as_macaddress[], ref string as_description[], ref string as_adaptername[], ref string as_ipaddress[])
public function boolean getmi (ref string as_address)
end prototypes

public function string of_tohex (long al_num);// -----------------------------------------------------------------------------
// SCRIPT:     n_adapter.of_ToHex
//
// PURPOSE:    This function translates a long to string Hex.
//
// ARGUMENTS:  al_num	- Number to convert
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/21/2006	RolandS		Initial coding
// -----------------------------------------------------------------------------

If al_num > 15 Then
	// recursive call to self
	Return of_ToHex(al_num / 16) + &
					of_HexChar(Mod(al_num,16))
Else
	Return of_HexChar(al_num)
End If

end function

public function string of_hexchar (integer ai_num);// -----------------------------------------------------------------------------
// SCRIPT:     n_adapter.of_HexChar
//
// PURPOSE:    This function converts a number from 0-15 to Hex character.
//
// ARGUMENTS:  ai_num	- Number to convert
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/21/2006	RolandS		Initial coding
// -----------------------------------------------------------------------------

String ls_hex

If ai_num < 10 Then
	ls_hex = String(ai_num)
Else
	ls_hex = String(Char(ai_num + 55))
End If

Return ls_hex

end function

public function string of_geterrormsg (unsignedlong aul_error);// -----------------------------------------------------------------------------
// SCRIPT:     n_adapter.of_GetErrorMsg
//
// PURPOSE:    This function returns the error message that goes
//					with the error code from GetLastError.
//
// ARGUMENTS:  aul_error - Error code from GetLastError
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/21/2006	RolandS		Initial coding
// -----------------------------------------------------------------------------

Constant ULong FORMAT_MESSAGE_FROM_SYSTEM = 4096
Constant ULong LANG_NEUTRAL = 0
String ls_buffer
ULong lul_rtn

ls_buffer = Space(200)

lul_rtn = FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, 0, &
				aul_error, LANG_NEUTRAL, ls_buffer, 200, 0)

Return Trim(ls_buffer)

end function

public function boolean of_getadapterinfo (ref string as_macaddress[], ref string as_description[], ref string as_adaptername[], ref string as_ipaddress[]);// -----------------------------------------------------------------------------
// SCRIPT:     n_adapter.of_GetAdapterInfo
//
// PURPOSE:    This function returns information about network adapters.
//
// ARGUMENTS:  as_macaddress	- Array of MAC addresses
//					as_description	- Array of Descriptions
//					as_adaptername	- Array of Adapter names
//					as_ipaddress	- Array of IP addresses
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/21/2006	RolandS		Initial coding
// -----------------------------------------------------------------------------

Constant ULong ERROR_BUFFER_OVERFLOW = 111
Blob lblb_AdapterInfo, lblb_data
ULong lul_rtn, lul_OutBufLen
Integer li_adaptcnt, li_adaptmax, li_addrlen
Integer li_cnt, li_max, li_pos, li_char, li_offset
String ls_errmsg

// call function to get buffer size
lul_rtn = GetAdaptersInfo(lblb_AdapterInfo, lul_OutBufLen)
If lul_rtn = ERROR_BUFFER_OVERFLOW Then
	// allocate buffer
	lblb_AdapterInfo = Blob(Space(lul_OutBufLen/2))
	// call function to get data
	lul_rtn = GetAdaptersInfo(lblb_AdapterInfo, lul_OutBufLen)
	If lul_rtn = 0 Then
		// how many adapters?
		li_adaptmax = lul_OutBufLen / 640
		For li_adaptcnt = 1 To li_adaptmax
			// calculate offset
			li_offset = (640 * (li_adaptcnt - 1))
			// get mac address length
			lblb_data = BlobMid(lblb_AdapterInfo, li_offset + 401, 1)
			li_addrlen = Asc(String(lblb_data, EncodingAnsi!))
			// get mac address
			For li_cnt = 1 To li_addrlen
				li_pos = li_offset + 404 + li_cnt
				lblb_data = BlobMid(lblb_AdapterInfo, li_pos, 1)
				li_char = Asc(Char(String(lblb_data, EncodingAnsi!)))
				If li_char < 16 Then
					as_macaddress[li_adaptcnt] += "0"
				End If
				as_macaddress[li_adaptcnt] += of_ToHex(li_char)
				If li_cnt < li_addrlen Then
					as_macaddress[li_adaptcnt] += "-"
				End If
			Next
			// get description
			lblb_data = BlobMid(lblb_AdapterInfo, li_offset + 269, 132)
			as_description[li_adaptcnt] = String(lblb_data, EncodingAnsi!)
			// get adaptername
			lblb_data = BlobMid(lblb_AdapterInfo, li_offset + 9, 260)
			as_adaptername[li_adaptcnt] = String(lblb_data, EncodingAnsi!)
			// get ip address
			lblb_data = BlobMid(lblb_AdapterInfo, li_offset + 433, 16)
			as_ipaddress[li_adaptcnt] = String(lblb_data, EncodingAnsi!)
		Next
	Else
//		ls_errmsg = of_GetErrorMsg(lul_rtn)
//		MessageBox("Error in of_GetAdapterInfo", &
//						ls_errmsg, StopSign!)
		Return False
	End If
Else
//	ls_errmsg = of_GetErrorMsg(lul_rtn)
//	MessageBox("Error in of_GetAdapterInfo", &
//					ls_errmsg, StopSign!)
	Return False
End If

Return True

end function

public function boolean of_getadapteradresses (ref string as_macaddress[], ref string as_description[], ref string as_adaptername[], ref string as_ipaddress[]);// -----------------------------------------------------------------------------
// SCRIPT:     n_adapter.of_GetAdapterInfo
//
// PURPOSE:    This function returns information about network adapters.
//
// ARGUMENTS:  as_macaddress	- Array of MAC addresses
//					as_description	- Array of Descriptions
//					as_adaptername	- Array of Adapter names
//					as_ipaddress	- Array of IP addresses
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/21/2006	RolandS		Initial coding
// -----------------------------------------------------------------------------

Constant ULong ERROR_BUFFER_OVERFLOW = 111
Blob lblb_AdapterAdr, lblb_data
ULong lul_rtn, lul_OutBufLen, ll_null
Integer li_adaptcnt, li_adaptmax, li_addrlen
Integer li_cnt, li_max, li_pos, li_char, li_offset
String ls_errmsg

setNull(ll_null)

// call function to get buffer size
lul_rtn = GetAdaptersAddresses(0, 0, ll_null, lblb_AdapterAdr, lul_OutBufLen)
If lul_rtn = ERROR_BUFFER_OVERFLOW Then
	// allocate buffer
	lblb_AdapterAdr = Blob(Space(lul_OutBufLen/2))
	// call function to get data
	lul_rtn = GetAdaptersAddresses(0, 0, ll_null, lblb_AdapterAdr, lul_OutBufLen)
	If lul_rtn = 0 Then
		integer li_file
		//fileOpen("c:\test.txt", streamMode!, write!, lockreadwrite!, replace!)
		fileOpen( gnv_app.of_getPathDefault()+gnv_app.of_getODBC()+"\test.txt", streamMode!, write!, lockreadwrite!, replace!)
		fileWrite(li_file, lblb_AdapterAdr)
		fileClose(li_file)
		
		// how many adapters?
		li_adaptmax = lul_OutBufLen / 924
		For li_adaptcnt = 1 To li_adaptmax
			// calculate offset
			li_offset = (924 * (li_adaptcnt - 1))
			// get mac address length
			lblb_data = BlobMid(lblb_AdapterAdr, li_offset + 53, 1)
			li_addrlen = Asc(String(lblb_data, EncodingAnsi!))
			// get mac address
			For li_cnt = 1 To li_addrlen
				li_pos = li_offset + 44 + li_cnt
				lblb_data = BlobMid(lblb_AdapterAdr, li_pos, 1)
				li_char = Asc(Char(String(lblb_data, EncodingAnsi!)))
				If li_char < 16 Then
					as_macaddress[li_adaptcnt] += "0"
				End If
				as_macaddress[li_adaptcnt] += of_ToHex(li_char)
				If li_cnt < li_addrlen Then
					as_macaddress[li_adaptcnt] += "-"
				End If
			Next
//			// get description
//			lblb_data = BlobMid(lblb_AdapterAdr, li_offset + 269, 132)
//			as_description[li_adaptcnt] = String(lblb_data, EncodingAnsi!)
//			// get adaptername
//			lblb_data = BlobMid(lblb_AdapterAdr, li_offset + 9, 260)
//			as_adaptername[li_adaptcnt] = String(lblb_data, EncodingAnsi!)
//			// get ip address
//			lblb_data = BlobMid(lblb_AdapterAdr, li_offset + 433, 16)
//			as_ipaddress[li_adaptcnt] = String(lblb_data, EncodingAnsi!)
		Next
	Else
//		ls_errmsg = of_GetErrorMsg(lul_rtn)
//		MessageBox("Error in of_GetAdapterInfo", &
//						ls_errmsg, StopSign!)
		Return False
	End If
Else
//	ls_errmsg = of_GetErrorMsg(lul_rtn)
//	MessageBox("Error in of_GetAdapterInfo", &
//					ls_errmsg, StopSign!)
	Return False
End If

Return True

end function

public function boolean getmi (ref string as_address);integer li_filenum
n_runandwait luo_run

luo_run.of_run("c:\ii4net\dentitek\gmi.bat",hide! )
li_filenum = FileOpen("c:\ii4net\dentitek\gmi.txt",Linemode!,Read!)
FileRead(li_filenum,as_address)
FileClose(li_filenum)
FileDelete("c:\ii4net\dentitek\gmi.txt")
as_address = mid(as_address,14)

if len(as_address) = 17 then 
	return true
else
	return false
end if
end function

on n_adapter.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_adapter.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

