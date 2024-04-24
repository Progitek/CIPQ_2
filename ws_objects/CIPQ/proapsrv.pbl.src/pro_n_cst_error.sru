﻿$PBExportHeader$pro_n_cst_error.sru
$PBExportComments$(PRO) Extension Message (error) service
forward
global type pro_n_cst_error from pfc_n_cst_error
end type
end forward

global type pro_n_cst_error from pfc_n_cst_error
end type
global pro_n_cst_error pro_n_cst_error

type variables

end variables

forward prototypes
public function boolean of_sqlerror ()
end prototypes

public function boolean of_sqlerror ();if (SQLCA.sqlCode <> 0) then
	CHOOSE CASE SQLCA.SQLDBCode
		CASE -210
		CASE ELSE	
			messagebox(string(today()) + ',' + string(now()) + string(SQLCA.SQLDBCode) ,SQLCA.SQLErrText)
	END CHOOSE
	return false
else
	return true
end if
end function

on pro_n_cst_error.create
call super::create
end on

on pro_n_cst_error.destroy
call super::destroy
end on

