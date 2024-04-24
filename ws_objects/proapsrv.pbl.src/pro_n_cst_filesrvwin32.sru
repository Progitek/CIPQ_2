$PBExportHeader$pro_n_cst_filesrvwin32.sru
$PBExportComments$(PRO) Extension Win32 File handler service
forward
global type pro_n_cst_filesrvwin32 from pfc_n_cst_filesrvwin32
end type
end forward

global type pro_n_cst_filesrvwin32 from pfc_n_cst_filesrvwin32
end type
global pro_n_cst_filesrvwin32 pro_n_cst_filesrvwin32

type prototypes
FUNCTION long GetModuleFileNameW(ulong hModule, ref string lpFilename, ulong nSize) Library "kernel32.dll" 
end prototypes

forward prototypes
public function string of_getexecutablename ()
end prototypes

public function string of_getexecutablename ();string	ls_exec

int ll_len
string ls_mod_file_name, ls_appl_path
char lc_mod_name[257]

ls_mod_file_name = Space(256)
ll_len = This.GetModuleFileNameW(Handle(GetApplication()), ls_mod_file_name, 256)

IF ll_len > 0 THEN
  lc_mod_name = ls_mod_file_name
  DO
		ll_len --
  LOOP WHILE lc_mod_name[ll_len] <> '\' AND ll_len > 0
  ls_appl_path = Left(ls_mod_file_name, ll_len)
END IF 

RETURN ls_exec


end function

on pro_n_cst_filesrvwin32.create
call super::create
end on

on pro_n_cst_filesrvwin32.destroy
call super::destroy
end on

