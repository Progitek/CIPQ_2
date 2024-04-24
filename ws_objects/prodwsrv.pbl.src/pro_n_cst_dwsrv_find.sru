﻿$PBExportHeader$pro_n_cst_dwsrv_find.sru
$PBExportComments$(PRO) Extension DataWindow Find/Replace service
forward
global type pro_n_cst_dwsrv_find from pfc_n_cst_dwsrv_find
end type
end forward

global type pro_n_cst_dwsrv_find from pfc_n_cst_dwsrv_find
end type
global pro_n_cst_dwsrv_find pro_n_cst_dwsrv_find

forward prototypes
protected function integer of_buildcolumnnames (boolean ab_replacelist)
end prototypes

protected function integer of_buildcolumnnames (boolean ab_replacelist);//////////////////////////////////////////////////////////////////////////////
//	Protected Function:	of_BuildColumnNames
//	Arguments:				ab_replacelist	Replace list of column names flag.
//	Returns:  				Integer:
//								The number of columns
//								-1 if an error is encountered.
//	Description: 			Populate the array with the column names to use for the find or find/replace dialog window. 
//								The list is different depending if it will be used with the find dialog, or if	it will be used
//								with the find/replace dialog.	This will be used with an index that is set when the user selects
//								the header label name from the dialog window.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History				Version
//								5.0   Initial version
//								8.0	   Check Option to include computes in Find Dialog List
//////////////////////////////////////////////////////////////////////////////
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//////////////////////////////////////////////////////////////////////////////
integer	li_objects
integer	li_count=0
integer	li_i
string	ls_headernm
string	ls_obj_column[]
string	ls_oldlookdata
string	ls_oldfind
string	ls_oldreplacewith
string	ls_editstyle, ls_tag, ls_lookdata_tempo[], ls_lookdisplay_tempo[]
string ls_type

//Check required.
If IsNull(idw_requestor) Or Not IsValid(idw_requestor) Then
	Return -1
end If

//Store the previous current look data (if any)
If inv_findattrib.ii_lookindex > 0 And &
	UpperBound(inv_findattrib.is_lookdata) >= inv_findattrib.ii_lookindex Then
	ls_oldlookdata = inv_findattrib.is_lookdata[inv_findattrib.ii_lookindex]
	ls_oldfind = inv_findattrib.is_find
	ls_oldreplacewith = inv_findattrib.is_replacewith
End If

//Reset the current index, find, and replace information.
inv_findattrib.ii_lookindex = 0
inv_findattrib.is_find = ''
inv_findattrib.is_replacewith = ''
inv_findattrib.is_lookdata = ls_obj_column[]
inv_findattrib.is_lookdisplay = ls_obj_column[]

//////////////////////////////////////////////////////////////////////////////
// populate string array for the user to select column from.
//////////////////////////////////////////////////////////////////////////////

//First get the Visible column names to use in search.
If (not ab_replacelist) and ib_includecomputes Then
	li_objects = of_GetObjects ( ls_obj_column, "*", "*", True )
Else
	li_objects = of_GetObjects ( ls_obj_column, "column", "*", True )
End If

//Get a list of all text objects associated with the column labels
FOR li_i=1 TO li_objects
	ls_type = idw_requestor.Describe(ls_obj_column[li_i]+".Type")
	If (not ab_replacelist) and ib_includecomputes Then
		If ( ls_type <> "column") And ( ls_type <> "compute") Then Continue
	End If
	//Determine if the column is of unwanted type.
	ls_editstyle = idw_requestor.Describe(ls_obj_column[li_i]+".Edit.Style")
	If ls_editstyle='checkbox' or ls_editstyle='radiobuttons' Then
		Continue
	End If
	
	//If the list is being costructed for Replace then do not show 
	//DropDownDataWindow, DropDownListBoxes, Tab=0 Columns, or Display 
	//only columns.   Protected columns will still be 
	//shown since it could be a row dependendent.
	If ab_replacelist Then
		If ls_editstyle='dddw' or &
			ls_editstyle='ddlb' or &
			idw_requestor.Describe(ls_obj_column[li_i]+".TabSequence") = "0" or &
			idw_requestor.Describe(ls_obj_column[li_i]+".Edit.DisplayOnly") = "yes" Then
			Continue
		End If
	End If
	
	// Vérifier si exclure_mr
	ls_tag = lower(idw_requestor.Describe(ls_obj_column[li_i] + "_t.Tag"))
	IF POS(ls_tag, "exclure_mr") = 0 THEN
		//Add the column name and column label to the array	
		li_count ++
		ls_headernm= of_GetHeaderName ( ls_obj_column[li_i] )
		inv_findattrib.is_lookdata[li_count] = ls_obj_column[li_i]
		inv_findattrib.is_lookdisplay[li_count] = ls_headernm
	
		//Reset the Index value (if any)
		If ls_oldlookdata = inv_findattrib.is_lookdata[li_count] Then
			inv_findattrib.ii_lookindex = li_count
			inv_findattrib.is_find = ls_oldfind
			inv_findattrib.is_replacewith = ls_oldreplacewith	
		End If
	END IF
NEXT

//Remettre tout ca dans l'ordre alpha
long 		ll_j
string	ls_temp
FOR li_i=UpperBound(inv_findattrib.is_lookdata) To 1 STEP -1
	for ll_j = 2 TO li_i
		IF inv_findattrib.is_lookdisplay[ll_j - 1] > inv_findattrib.is_lookdisplay[ll_j] THEN
			
			ls_temp = inv_findattrib.is_lookdisplay[ll_j - 1]
			inv_findattrib.is_lookdisplay[ll_j - 1] = inv_findattrib.is_lookdisplay[ll_j]
			inv_findattrib.is_lookdisplay[ll_j] = ls_temp
			
			ls_temp = inv_findattrib.is_lookdata[ll_j - 1]
			inv_findattrib.is_lookdata[ll_j - 1] = inv_findattrib.is_lookdata[ll_j]
			inv_findattrib.is_lookdata[ll_j] = ls_temp
			
		END IF
	end for
END FOR

Return li_count
end function

on pro_n_cst_dwsrv_find.create
call super::create
end on

on pro_n_cst_dwsrv_find.destroy
call super::destroy
end on
