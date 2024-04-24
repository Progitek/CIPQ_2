$PBExportHeader$pro_n_cst_dwsrv_linkage.sru
$PBExportComments$(PRO) Extension DataWindow Linkage service
forward
global type pro_n_cst_dwsrv_linkage from pfc_n_cst_dwsrv_linkage
end type
end forward

global type pro_n_cst_dwsrv_linkage from pfc_n_cst_dwsrv_linkage
end type
global pro_n_cst_dwsrv_linkage pro_n_cst_dwsrv_linkage

forward prototypes
public function integer of_undomodified (boolean ab_all)
end prototypes

public function integer of_undomodified (boolean ab_all);//////////////////////////////////////////////////////////////////////////////
//	Protected Function:	of_UndoModified
//	Arguments: 				boolean 		Undo all datawindows in the chain
//	Returns:   				Integer		1 if successful, -1 error
//	Description:  			Performs the necessary actions to loose all changes in the datawindow chain.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History:			Version
//								8.0   Initial version
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
Integer	li_numdetails, li_i, li_rc=1

dwItemStatus le_rowstatus
dwItemStatus le_colstatus

/*  Undo modifications on this DW  */
// 2009-04-28 Sébastien Tremblay - Override pour retourner 1 plutôt que le nb de colonnes modifiées
if of_UndoModified ( ) > 0 then
	li_rc = 1
end if

If ab_all Then 
	// Loop through the valid details and call this function on each detail.
	li_numdetails = UpperBound ( idw_details ) 
	For li_i = 1 to li_numdetails 
		If IsValid ( idw_details[li_i] ) Then
			If IsNull(idw_details[li_i].inv_Linkage) Or Not IsValid ( idw_details[li_i].inv_Linkage ) Then Return FAILURE
			li_rc = idw_details[li_i].inv_Linkage.of_UndoModified (ab_all)
			// If an error occurs, get out now.
			If li_rc <> 1 Then Exit
		End If 
	Next 
End If

Return li_rc
end function

on pro_n_cst_dwsrv_linkage.create
call super::create
end on

on pro_n_cst_dwsrv_linkage.destroy
call super::destroy
end on

