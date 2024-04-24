$PBExportHeader$uo_syncproc.sru
forward
global type uo_syncproc from nonvisualobject
end type
type os_process_information from structure within uo_syncproc
end type
type os_startupinfo from structure within uo_syncproc
end type
end forward

type os_process_information from structure
	unsignedlong		ul_process
	unsignedlong		ul_thread
	unsignedlong		ul_processid
	unsignedlong		ul_threadid
end type

type os_startupinfo from structure
	ulong		ul_cb
	string		s_reserved
	string		s_desktop
	string		s_title
	ulong		ul_x
	ulong		ul_y
	ulong		ul_xsize
	ulong		ul_ysize
	ulong		ul_xcountchars
	ulong		ul_ycountchars
	ulong		ul_fillattribute
	ulong		ul_flags
	uint		ui_showwindow
	uint		ui_reserved2
	long		l_reserved2
	ulong		ul_stdinput
	ulong		ul_stdoutput
	ulong		ulstderror
end type

global type uo_syncproc from nonvisualobject
end type
global uo_syncproc uo_syncproc

type prototypes
private:
function ulong WaitForSingleObject(ulong handle, ulong milliseconds) library "kernel32.dll"
function boolean CreateProcess(ulong applicationname, string commandline, ulong processattributes, ulong threadattributes, boolean inherithandles, ulong creationflags, ulong environment, string currentdirectory, ref os_startupinfo startupinf, ref os_process_information processinformation) library "kernel32.dll" alias for CreateProcessA
function boolean CloseHandle(ulong object) library "kernel32.dll"
function ulong GetLastError() library "kernel32.dll"
function boolean TerminateProcess(ulong handle, uint exitcode) library "kernel32.dll"

end prototypes

type variables
public:
constant ulong INFINITE = 4294967295
constant ulong NORMAL_PRIORITY_CLASS = 32
constant ulong IDLE_PRIORITY_CLASS = 64
constant ulong HIGH_PRIORITY_CLASS = 128
constant ulong REALTIME_PRIORITY_CLASS = 256
private:
constant ulong STARTF_USESHOWWINDOW = 1
constant ulong STARTF_USESIZE = 2
constant ulong STARTF_USEPOSITION = 4
constant uint SW_HIDE = 0
constant uint SW_NORMAL = 1
constant uint SW_MAXIMIZE = 3
constant uint SW_MINIMIZE = 6
constant ulong WAIT_FAILED = 4294967295
constant ulong WAIT_TIMEOUT = 258
constant double LOG_2 = log(2)
os_startupinfo istr_startupinfo
ulong iul_creationflags = NORMAL_PRIORITY_CLASS
ulong iul_timeout = INFINITE
string is_directory
end variables

forward prototypes
public function integer of_setpriority (unsignedlong aul_priority)
public function integer of_setcurrentdirectory (string as_directory)
public function boolean of_isenabled (unsignedlong aul_feature)
public function integer of_setposition (unsignedlong aul_x, unsignedlong aul_y)
public function integer of_setsize (unsignedlong aul_width, unsignedlong aul_height)
public function integer of_setwindow (string as_windowstate)
public function integer of_runandwait (readonly string as_command)
public function integer of_settimeout (decimal adec_seconds)
end prototypes

public function integer of_setpriority (unsignedlong aul_priority);IF IsNull(aul_priority) THEN RETURN -1 

IF aul_priority <> NORMAL_PRIORITY_CLASS OR &
	aul_priority <> REALTIME_PRIORITY_CLASS OR &
	aul_priority <> HIGH_PRIORITY_CLASS OR &
	aul_priority <> IDLE_PRIORITY_CLASS THEN &
	RETURN -1 
	
THIS.iul_CreationFlags = aul_priority

RETURN 1
end function

public function integer of_setcurrentdirectory (string as_directory);IF Len(as_directory) = 0 THEN SetNull(as_directory)
THIS.is_directory = as_directory

RETURN 1
end function

public function boolean of_isenabled (unsignedlong aul_feature);IF Int(Mod(THIS.istr_startupinfo.ul_flags / ( 2 ^ ( Log( aul_feature ) / LOG_2 ) ), 2 ) ) > 0 THEN
	RETURN TRUE
ELSE 
	RETURN FALSE
END IF
end function

public function integer of_setposition (unsignedlong aul_x, unsignedlong aul_y);IF IsNull(aul_x ) or IsNull( aul_y ) THEN RETURN -1

IF aul_x = 0 and aul_y = 0 THEN 
	IF THIS.of_IsEnabled(STARTF_USEPOSITION) THEN
		THIS.istr_startupinfo.ul_flags -= STARTF_USEPOSITION
	END IF
ELSE
	IF NOT THIS.of_IsEnabled(STARTF_USEPOSITION) THEN
		THIS.istr_startupinfo.ul_flags += STARTF_USEPOSITION
	END IF
	THIS.istr_startupinfo.ul_x = aul_x
	THIS.istr_startupinfo.ul_y = aul_y
END IF

RETURN 1
end function

public function integer of_setsize (unsignedlong aul_width, unsignedlong aul_height);IF IsNull( aul_width ) or IsNull( aul_height ) THEN RETURN -1
IF aul_width = 0 and aul_height = 0 THEN
	IF THIS.of_IsEnabled( STARTF_USESIZE ) THEN
		THIS.istr_startupinfo.ul_flags -= STARTF_USESIZE
	END IF
ELSE
	IF NOT THIS.of_IsEnabled( STARTF_USESIZE ) THEN
		THIS.istr_startupinfo.ul_flags += STARTF_USESIZE
	END IF 
	THIS.istr_startupinfo.ul_xsize = aul_width
	THIS.istr_startupinfo.ul_ysize = aul_height
END IF
	
RETURN 1
end function

public function integer of_setwindow (string as_windowstate);integer li_return = 1

IF NOT THIS.of_IsEnabled ( STARTF_USESHOWWINDOW ) THEN
	THIS.istr_startupinfo.ul_flags += STARTF_USESHOWWINDOW
END IF

CHOOSE CASE Lower( as_windowstate )
	CASE "off"
		THIS.istr_startupinfo.ul_flags -= STARTF_USESHOWWINDOW
	CASE 'normal'
		THIS.istr_startupinfo.ui_showwindow = SW_NORMAL
	CASE 'maximize'
		THIS.istr_startupinfo.ui_showwindow = SW_MAXIMIZE
	CASE "minimize"
		THIS.istr_startupinfo.ui_showwindow = SW_MINIMIZE
	CASE 'hide'
		THIS.istr_startupinfo.ui_showwindow = SW_HIDE		
	CASE ELSE
	li_return = -1 
END CHOOSE

RETURN li_return

end function

public function integer of_runandwait (readonly string as_command);os_process_information lstr_proc
boolean lb_rc
integer li_return = -1
ulong lul_rc
ulong lul_null

SetNull( lul_null )

//Set Size of structure. There are 13 long and 2 integer values, plus three strings.
THIS.istr_startupinfo.ul_cb = ( 13 * 4 ) + ( 2 * 2 ) +  &
Len( THIS.istr_startupinfo.s_reserved ) + &
Len( THIS.istr_startupinfo.s_desktop ) + & 
Len( THIS.istr_startupinfo.s_title ) 

lb_rc = 	CreateProcess( lul_null, as_command, lul_null, lul_null, true, &
			THIS.iul_CreationFlags, lul_null, THIS.is_directory, &
			THIS.istr_startupinfo, lstr_proc)

IF lb_rc THEN 
	lul_rc = WaitForSingleObject( lstr_proc.ul_process, THIS.iul_timeout)
	CHOOSE CASE lul_rc
		CASE WAIT_TIMEOUT
			TerminateProcess( lstr_proc.ul_process, 0 )
		CASE WAIT_FAILED
			lul_rc = GetLastError()
			MessageBox( 'Wait Failed', lul_rc )
	END CHOOSE
ELSE 
	lul_rc = GetLastError()
	MessageBox( 'Create Process Failed', lul_rc )
END IF

lb_rc = CloseHandle( lstr_proc.ul_process )

IF lb_rc THEN li_return = 1
		
		
RETURN li_return

end function

public function integer of_settimeout (decimal adec_seconds);IF IsNull( adec_seconds ) THEN RETURN -1
IF adec_seconds < -1 THEN RETURN -1
IF adec_seconds = INFINITE THEN 
	THIS.iul_timeout = INFINITE
ELSE
	THIS.iul_timeout = adec_seconds * 1000
END IF 

RETURN 1
end function

on uo_syncproc.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_syncproc.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//Initialize unused values according to SDK help file

SetNull(THIS.istr_startupinfo.s_reserved)
SetNull(THIS.istr_startupinfo.s_title)
SetNull(THIS.istr_startupinfo.l_reserved2)
THIS.istr_startupinfo.ui_reserved2 = 0

//Initialize instance variables
SetNull(THIS.is_directory)
end event

