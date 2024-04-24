﻿$PBExportHeader$pro_n_cst_dwsrv_dropdownsearch.sru
$PBExportComments$(PRO) Extension DataWindow DropDownSearch service
forward
global type pro_n_cst_dwsrv_dropdownsearch from pfc_n_cst_dwsrv_dropdownsearch
end type
end forward

global type pro_n_cst_dwsrv_dropdownsearch from pfc_n_cst_dwsrv_dropdownsearch
event type integer pro_itemchanged ( long al_row,  ref dwobject adwo_obj,  string as_data )
end type
global pro_n_cst_dwsrv_dropdownsearch pro_n_cst_dwsrv_dropdownsearch

type variables
boolean 	ib_AllowForeignValue
boolean 	ib_LastFound
string 	is_LastFound[]
end variables

forward prototypes
public function integer of_messagevaleuretrangere ()
public subroutine of_permetvaleuretrangere (boolean ab_switch)
end prototypes

event type integer pro_itemchanged(long al_row, ref dwobject adwo_obj, string as_data);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pro_itemchanged
//
//	Arguments:		al_row 	- row number
//						adwo_obj	- DataWindow object passed by reference
//						as_data 	- The current data on the column.  (The search text)
//
//	Retourne:   	Rien
//
//	Description:	Gestion du DropDownSerach sur itemchanged
//
//////////////////////////////////////////////////////////////////////////////
//	
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

string		ls_SearchText,	ls_dddw_datacol, ls_Findexp, ls_displaydata_value, &
				ls_searchcolname
integer		li_ddlb_index				
long			ll_FindRow,	ll_dddw_rowcount
boolean		lb_Matchfound

// Vérifie argument
If IsNull(adwo_obj) or Not IsValid(adwo_obj) Then return 0

// Confirm that the search capabilities are valid for this column.
if ib_performsearch = False or ii_currentindex <= 0 THEN return 0

// Get information on the column and text.
ls_searchtext = as_data
ls_searchcolname = adwo_obj.Name

// ******************
// DROPDOWNDATAWINDOW
// ******************

If inv_columns[ii_currentindex].s_editstyle = 'dddw' Then

	ls_dddw_datacol = adwo_obj.dddw.datacolumn		
	ls_findexp = "Lower(" + ls_dddw_datacol + ") = '" + Lower (ls_searchtext) + "'"

	// Perform the Search on the dddw.
	ll_dddw_rowcount = inv_columns[ii_currentindex].dwc_object.rowcount()
	ll_findrow = inv_columns[ii_currentindex].dwc_object.Find (ls_findexp, 0, ll_dddw_rowcount)

	// Determine if a match was found on the dddw.
	lb_matchfound = (ll_findrow > 0)
	
	If not lb_matchfound and len(ls_searchtext) > 0 Then
		THIS.of_MessageValeurEtrangere()
		if UpperBound(is_lastFound[]) > 0 then
			if len(is_LastFound[ii_currentindex]) > 0 then				
				adwo_obj.Primary[al_row] = is_LastFound[ii_currentindex]
			else
				adwo_obj.Primary[al_row] = inv_columns[ii_currentindex].dwc_object.GetItemString(1,ls_dddw_datacol)
			end if	
		else		
			adwo_obj.Primary[al_row] = inv_columns[ii_currentindex].dwc_object.GetItemString(1,ls_dddw_datacol)
		end if			
	end if	
end if	

//****************
// DROPDOWNLISTBOX
//****************

If inv_columns[ii_currentindex].s_editstyle = 'ddlb' Then
		
	Do
		li_ddlb_index	++
		ls_displaydata_value = idw_requestor.GetValue(ls_searchcolname, li_ddlb_index)
		If ls_displaydata_value = '' Then 
			// No more entries on the Code Table.
			Exit
		End If
	
		// Determine if a match has been found on the ddlb.
		If ib_LastFound then
			lb_matchfound = true
		else	
			lb_matchfound = ( Lower(ls_searchtext) = Lower(Left (ls_displaydata_value, Pos(ls_displaydata_value,'~t') -1)	) )
		End if	
	Loop Until lb_matchfound
	
	If not lb_matchfound and len(ls_searchtext) > 0 Then
		THIS.of_MessageValeurEtrangere()
		If UpperBound(is_lastFound[]) > 0 then
			If len(is_LastFound[ii_currentindex]) > 0 then
				idw_Requestor.SetText(is_LastFound[ii_currentindex])
				ib_LastFound = true
			End if			
		Else
			idw_Requestor.SetText("")
			ib_LastFound = false
		End if		
	End if

End if

// For either dddw or ddlb, check if a match was found.
If not lb_matchfound and len(ls_searchtext) > 0 Then	
	//Selectionne le text
	idw_Requestor.SelectText(1,len(ls_searchtext))
	//Empêche l'affichage d'une erreur de validation
	idw_Requestor.ib_suppression_message_itemerror = TRUE
	return 1
end if

return 0
end event

public function integer of_messagevaleuretrangere ();//////////////////////////////////////////////////////////////////////////////
//
//	Fonction:  		of_MessageValeurEtrangere()
//
//	Accès:  			Public
//
//	Argument:		Aucun
//
//	Retourne:  		1
//
//	Description:	Affiche un message d'erreur
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

// Choix invalide
gnv_app.inv_error.of_Message("PRO0011")
return 1
end function

public subroutine of_permetvaleuretrangere (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Méthode:  		of_PermetValeurEtrangere
//
//	Accès:  			Public
//
//	Argument:		ab_switch - Permet oui ou non l'utilisation de données non 
//										contenu dans la liste.
//
//	Retourne:  		Rien
//
//	Description:	Permet oui ou non l'utilisation de données non contenu dans 
//						la liste.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Historique
//
//	Date			Programmeur		Description
//
//////////////////////////////////////////////////////////////////////////////

ib_AllowForeignValue = ab_switch
end subroutine

on pro_n_cst_dwsrv_dropdownsearch.create
call super::create
end on

on pro_n_cst_dwsrv_dropdownsearch.destroy
call super::destroy
end on

event pfc_editchanged;//////////////////////////////////////////////////////////////////////////////
//
//	Événement: 		pfc_editchanged
//
//	Arguments:		al_row  	- row number
//						adwo_obj - DataWindow object passed by reference
//						as_data  - The current data on the column.  (The search text)
//
//	Description:	This event should be mapped to the editchanged
//			   		event of a DataWindow. When is event is "fired", it will use
//						instance variables (set in the pfc_itemfocuschanged) to access
//						items in the instance structure.
//						The instance structure contains information about the dddw and 
//						ddlb columns this service uses.
//
//////////////////////////////////////////////////////////////////////////////
//	
// Historique
//
//	Date			Programmeur			Description
//
//////////////////////////////////////////////////////////////////////////////

integer		li_searchtextlen
long			ll_findrow, ll_dddw_rowcount, ll_ddlb_index = 0, ll_cursorPosition
string		ls_dddw_displaycol, ls_foundtext, ls_findexp, ls_searchcolname, ls_newvalue, &
				ls_displaydata_value, ls_searchtext
boolean		lb_matchfound = False

// Check requirements.
If IsNull(adwo_obj) or Not IsValid(adwo_obj) Then Return

// Confirm that the search capabilities are valid for this column.
if ib_performsearch=False or ii_currentindex <= 0 THEN return

// Get information on the column and text.
ls_searchcolname = adwo_obj.Name
ls_searchtext = as_data
li_searchtextlen = Len (ls_searchtext)

// If the user performed a delete operation, do not perform the search.
// If the text entered is the same as the last search, do not perform another search.
If (li_searchtextlen < Len(is_textprev)) or &
	(Lower (ls_searchtext) = Lower (is_textprev)) Then
	// Store the previous text information.
	is_textprev = ''
	ib_LastFound = false
	Return 
End If

// Store the previous text information.
is_textprev = ls_searchtext

If inv_columns[ii_currentindex].s_editstyle = 'dddw' Then
	// *** DropDownDatawindow Search ***
	// Build the find expression to search the dddw for the text 
	// entered in the parent datawindow column.
	ls_dddw_displaycol = adwo_obj.dddw.displaycolumn
	ls_findexp = "Lower (Left (" + ls_dddw_displaycol + ", " + &
		String (li_searchtextlen) + ")) = '" + Lower (ls_searchtext) + "'"

	// Perform the Search on the dddw.
	ll_dddw_rowcount = inv_columns[ii_currentindex].dwc_object.rowcount()
	ll_findrow = inv_columns[ii_currentindex].dwc_object.Find (ls_findexp, 0, ll_dddw_rowcount)

	// Determine if a match was found on the dddw.
	lb_matchfound = (ll_findrow > 0)

	// Set the found text if found on the dddw.
	if lb_matchfound then
		// Get the text found.
		ls_foundtext =	inv_columns[ii_currentindex].dwc_object.GetItemString (&
									ll_findrow, ls_dddw_displaycol)
		is_LastFound[ii_currentindex] = ls_foundtext
	End If
	
	
ElseIf inv_columns[ii_currentindex].s_editstyle = 'ddlb' Then
	// *** DropDownListBox Search ***
	// Loop around the entire Code Table until a match is found (if any).
	Do
		ll_ddlb_index	++
		ls_displaydata_value = idw_requestor.GetValue(ls_searchcolname, ll_ddlb_index)
		If ls_displaydata_value = '' Then 
			// No more entries on the Code Table.
			Exit
		End If
	
		// Determine if a match has been found on the ddlb.
		lb_matchfound = ( Lower(ls_searchtext) = Lower( Left(ls_displaydata_value, Len(ls_searchtext))) )
	Loop Until lb_matchfound


	// Check if a match was found on the ddlb.
	If lb_matchfound Then
		// Get the text found by discarding the data value (just keep the display value).
		ls_foundtext = Left (ls_displaydata_value, Pos(ls_displaydata_value,'~t') -1)	
		is_LastFound[ii_currentindex] = ls_foundtext
		ib_LastFound = true
	else
		ib_LastFound = false
	End If
End If

// For either dddw or ddlb, check if a match was found.
If lb_matchfound Then
	
	// Set the text.
	idw_requestor.SetText (ls_foundtext)

	// Determine what to highlight or where to move the cursor..
	if li_searchtextlen = len(ls_foundtext) THEN
		// Move the cursor to the end
		idw_requestor.SelectText (Len (ls_foundtext)+1, 0)
	else
		// Hightlight the portion the user has not actually typed.
		idw_requestor.SelectText (li_searchtextlen + 1, Len (ls_foundtext))
	end if
else
	// Reset the field with the old value
	if not ib_AllowForeignValue then
		ll_cursorPosition = idw_requestor.position()
		if ll_cursorPosition > -1 then
			ls_newvalue = left(as_data, ll_cursorPosition - 2) + mid(as_data, ll_cursorPosition)
		else
			ls_newvalue = left(as_data, len(as_data) - 1)
		end if
		idw_requestor.SetText(ls_newvalue)		
		idw_requestor.SelectText (Len (ls_newvalue)+1, 0)
		is_textprev = ls_newvalue
	end if
end if
end event

