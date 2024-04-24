$PBExportHeader$pro_n_cst_list.sru
$PBExportComments$(PRO) Extension List service
forward
global type pro_n_cst_list from pfc_n_cst_list
end type
end forward

global type pro_n_cst_list from pfc_n_cst_list
end type

forward prototypes
public function integer of_add (n_cst_linkedlistnode anv_newnode)
end prototypes

public function integer of_add (n_cst_linkedlistnode anv_newnode);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Add
//
//	Access:  public
//
//	Arguments :  
//	anv_newnode n_cst_linkedlistnode
//
//	Returns:  integer
//	1 = success
//	-1 = failure (could be duplicate on list that does not allow duplicates)
//
//	Description:  
//	Put a node on list.
//
//	Note:
//	Depending on attributes lists can allow duplicates.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
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
//
//////////////////////////////////////////////////////////////////////////////

integer		li_rc
n_cst_linkedlistnode	lnv_locatenode
n_cst_linkedlistnode	lnv_insertpointnode
n_cst_linkedlistnode	lnv_temp

// Validate arguments.
if isnull(anv_newnode) or not isvalid(anv_newnode) then 
	return FAILURE
end if

// See if this is the first entry.
if isnull(inv_head) or not isvalid(inv_head) then
	// Add it as the new Head.  Use ancestor of_AddHead().
	Return n_cst_linkedlistbase::of_AddHead(anv_newnode)
end if

// If duplicates are not allowed, check for duplicates.
If Not ib_duplicatesallowed Then
	If of_IsInList(anv_newnode) Then
		// A duplicate was encountered.
		return FAILURE
	End If
end if

// Check if the list is not sorted.
If Not ib_sorted Then
	// Add it as the new Tail.  Use ancestor of_AddTail().
	Return n_cst_linkedlistbase::of_AddTail(anv_newnode)
End If

// -- The list is sorted, Need to find the slot for the new entry. --

// There should be a Valid Head and Tail nodes.
If IsNull(inv_head) or Not IsValid(inv_head) Then return FAILURE
If IsNull(inv_tail) or Not IsValid(inv_tail) Then return FAILURE

// If necessary, create the default comparison object.
if isnull(inv_compare) or not isvalid(inv_compare) then
	inv_compare = create n_cst_linkedlistnodecompare
end if

// Check if the new key is Less than the current low key (Head node).
li_rc = inv_compare.of_compare(anv_newnode, inv_head)
If li_rc = inv_compare.FAILURE Then Return FAILURE
If li_rc = inv_compare.LESSTHAN Then
	// Add it as the new Head node.  Use ancestor of_AddHead().
	Return n_cst_linkedlistbase::of_AddHead(anv_newnode)
End If

// Check if the new key is Greater than the current High key (Tail node).
li_rc = inv_compare.of_compare(anv_newnode, inv_tail)
If li_rc = inv_compare.FAILURE Then Return FAILURE
If li_rc = inv_compare.GREATERTHAN Or li_rc = inv_compare.EQUAL Then
	// Add it as the new Tail node.  Use the ancestor of_AddTail().
	Return n_cst_linkedlistbase::of_AddTail(anv_newnode)
End If

// -- The desired slot is somewhere between the Head and the Tail nodes. --

// Set the initial insertion point candidate.
lnv_insertpointnode = inv_head

lnv_insertpointnode.of_GetNext(lnv_temp)
Do While IsValid(lnv_temp)
	li_rc = inv_compare.of_compare(lnv_temp, anv_newnode)
	Choose Case li_rc
		Case inv_compare.EQUAL
			// New insertion point candidate, go get the next node.
			lnv_insertpointnode = lnv_temp
		Case inv_compare.LESSTHAN
			// New insertion point candidate, go get the next node.
			lnv_insertpointnode = lnv_temp
		Case inv_compare.GREATERTHAN
			// The current insertion point is the one.
			Exit
		CASE Else
			Return FAILURE	
	End Choose
	lnv_temp.of_GetNext(lnv_temp)
Loop

Return of_Add(anv_newnode, lnv_insertpointnode)

end function

on pro_n_cst_list.create
call super::create
end on

on pro_n_cst_list.destroy
call super::destroy
end on

