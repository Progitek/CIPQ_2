$PBExportHeader$n_verwininfo.sru
forward
global type n_verwininfo from nonvisualobject
end type
end forward

global type n_verwininfo from nonvisualobject autoinstantiate
end type

type prototypes
FUNCTION ulong GetVersionExA(ref osversioninfo lpVersionInfo) LIBRARY "kernel32.dll"
FUNCTION ulong GetSystemMetrics(ulong nIndex) LIBRARY "user32.dll" 

end prototypes

type variables
 private:
CONSTANT integer VER_PLATFORM_WIN32s = 0
CONSTANT integer VER_PLATFORM_WIN32_WINDOWS = 1
CONSTANT integer VER_PLATFORM_WIN32_NT = 2

CONSTANT integer VER_NT_WORKSTATION = 1
CONSTANT integer VER_NT_DOMAIN_CONTROLLER = 2
CONSTANT integer VER_NT_SERVER = 3

CONSTANT integer VER_SUITE_SMALLBUSINESS = 1
CONSTANT integer VER_SUITE_ENTERPRISE = 2
CONSTANT integer VER_SUITE_BACKOFFICE = 4
CONSTANT integer VER_SUITE_TERMINAL = 16
CONSTANT integer VER_SUITE_SMALLBUSINESS_RESTRICTED = 32
CONSTANT integer VER_SUITE_DATACENTER = 128
CONSTANT integer VER_SUITE_PERSONAL =512
CONSTANT integer VER_SUITE_BLADE = 1024
CONSTANT ulong SM_TABLETPC = 86
CONSTANT ulong SM_MEDIACENTER = 87 
end variables

forward prototypes
public function string of_getwinversion ()
public function boolean of_windowsxpplus ()
end prototypes

public function string of_getwinversion ();string ls_os, ls_csd
osversioninfo lstr

lstr.dwOSVersionInfoSize = 148
GetVersionExA(lstr)

ls_csd = Trim(lstr.szCSDVersion)

CHOOSE CASE lstr.dwPlatformID
	CASE VER_PLATFORM_WIN32s
		ls_os = "Microsoft Windows 3.1"

	CASE VER_PLATFORM_WIN32_WINDOWS
 		IF lstr.dwMajorVersion = 4 AND lstr.dwMinorVersion = 0 THEN
  			ls_os = "Microsoft Windows 95"
  			IF Upper(ls_csd) = "B" THEN ls_os += " OSR1"
  			IF Upper(ls_csd) = "C" THEN ls_os += " OSR2"
 		END IF

 		IF lstr.dwMajorVersion = 4 AND lstr.dwMinorVersion = 10 THEN
  			ls_os = "Microsoft Windows 98"
  			IF Upper(ls_csd) = "A" THEN ls_os += " SE"
 		END IF

 		IF lstr.dwMajorVersion = 4 AND lstr.dwMinorVersion = 90 THEN 
			ls_os = "Microsoft Windows Millennium Edition"
		END IF
		
	CASE VER_PLATFORM_WIN32_NT
 		IF lstr.dwMajorVersion = 3 AND lstr.dwMinorVersion = 51 THEN
  			ls_os = "Microsoft Windows NT 3.51"
 		ELSE
  			lstr.dwOSVersionInfoSize = 156
  			GetVersionExA(lstr)

  			ls_csd = Trim(lstr.szCSDVersion)

  			IF lstr.dwMajorVersion = 4 AND lstr.dwMinorVersion = 0 THEN
   			ls_os = "Microsoft Windows NT 4.0"
   			IF Mod(Integer(lstr.suite / VER_SUITE_ENTERPRISE), 2) = 1 THEN
    				ls_os += " Enterprise Edition"
   			ELSEIF lstr.product = Char(VER_NT_WORKSTATION) THEN
   				ls_os += " Workstation"
   			ELSEIF lstr.product = Char(VER_NT_SERVER) OR lstr.product = Char(VER_NT_DOMAIN_CONTROLLER) THEN
    				ls_os += " Server"
   			END IF
  			ELSEIF lstr.dwMajorVersion = 5 AND lstr.dwMinorVersion = 0 THEN
   			ls_os = "Microsoft Windows 2000"
   			IF Mod(Integer(lstr.suite / VER_SUITE_DATACENTER), 2) = 1 THEN
    				ls_os += " Datacenter Server"
  				ELSEIF Mod(Integer(lstr.suite / VER_SUITE_ENTERPRISE), 2) = 1 THEN
    				ls_os += " Advanced Server"
   			ELSEIF lstr.product = Char(VER_NT_WORKSTATION) THEN
    				ls_os += " Professional"
  				ELSEIF lstr.product = Char(VER_NT_SERVER) OR lstr.product = Char(VER_NT_DOMAIN_CONTROLLER) THEN
    				ls_os += " Server"
  				END IF

   			ls_os += " 5.0." + String(lstr.dwBuildNumber)
  			ELSEIF lstr.dwMajorVersion = 5 and lstr.dwMinorVersion = 1 THEN
   			ls_os += "Microsoft Windows XP"
				IF Mod(Integer(lstr.suite / VER_SUITE_PERSONAL), 2) = 1 THEN
					ls_os += " Home Edition"
				ELSEIF lstr.product = Char(VER_NT_WORKSTATION) THEN
					ls_os += " Professional"
				END IF

				ls_os += " 5.1." + String(lstr.dwBuildNumber)

				IF GetSystemMetrics(SM_MEDIACENTER) <> 0 THEN ls_os = "Microsoft Windows XP Media Center Edition"
				IF GetSystemMetrics(SM_TABLETPC) <> 0 THEN ls_os = "Microsoft Tablet PC Edition"
  			ELSEIF lstr.dwMajorVersion = 5 and lstr.dwMinorVersion = 2 THEN
   			ls_os = "Microsoft Windows Server 2003"
   			IF Mod(Integer(lstr.suite / VER_SUITE_DATACENTER), 2) = 1 THEN
    				ls_os += " Web Edition"
  				 ELSEIF Mod(Integer(lstr.suite / VER_SUITE_BLADE), 2) = 1 THEN
    				ls_os += " Datacenter Edition"
   			 ELSEIF Mod(Integer(lstr.suite / VER_SUITE_ENTERPRISE), 2) = 1 THEN
    				ls_os += " Enterprise Edition"
   			END IF

  				 ls_os += " 5.2." + String(lstr.dwBuildNumber)
					
				 
				
  			END IF
		END IF
END CHOOSE

RETURN ls_os 
end function

public function boolean of_windowsxpplus ();string ls_os, ls_csd
osversioninfo lstr

lstr.dwOSVersionInfoSize = 148
GetVersionExA(lstr)

ls_csd = Trim(lstr.szCSDVersion)

CHOOSE CASE lstr.dwPlatformID
	CASE VER_PLATFORM_WIN32s
		return false
		
	CASE VER_PLATFORM_WIN32_NT
 		IF lstr.dwMajorVersion = 3 AND lstr.dwMinorVersion = 51 THEN
  			return false
 		ELSE
			IF lstr.dwMajorVersion = 4 AND lstr.dwMinorVersion = 0 THEN
   			return false
  			ELSEIF lstr.dwMajorVersion = 5 AND lstr.dwMinorVersion = 0 THEN
   			return false	
			ELSEIF lstr.dwMajorVersion = 5 and lstr.dwMinorVersion = 1 THEN
   			return true
			ELSEIF lstr.dwMajorVersion = 5 and lstr.dwMinorVersion = 2 THEN
   			return true
  			END IF
		END IF
END CHOOSE
end function

on n_verwininfo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_verwininfo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

