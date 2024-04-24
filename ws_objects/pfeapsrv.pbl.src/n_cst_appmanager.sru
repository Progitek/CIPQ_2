﻿$PBExportHeader$n_cst_appmanager.sru
$PBExportComments$Extension Application Manager service
forward
global type n_cst_appmanager from pro_n_cst_appmanager
end type
end forward

global type n_cst_appmanager from pro_n_cst_appmanager
end type
global n_cst_appmanager n_cst_appmanager

type variables
protected:
long ll_spec
end variables

forward prototypes
public function long of_getspecid ()
public function integer of_setspecid (long al_specid)
end prototypes

public function long of_getspecid ();return ll_spec

end function

public function integer of_setspecid (long al_specid);//Check arguments
If IsNull(al_specid) Then
	Return -1
End If

ll_spec = al_specid
Return 1
end function

on n_cst_appmanager.create
call super::create
end on

on n_cst_appmanager.destroy
call super::destroy
end on

