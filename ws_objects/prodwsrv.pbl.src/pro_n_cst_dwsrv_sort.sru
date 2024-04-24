$PBExportHeader$pro_n_cst_dwsrv_sort.sru
$PBExportComments$(PRO) Extension DataWindow Sort service
forward
global type pro_n_cst_dwsrv_sort from pfc_n_cst_dwsrv_sort
end type
end forward

global type pro_n_cst_dwsrv_sort from pfc_n_cst_dwsrv_sort
end type
global pro_n_cst_dwsrv_sort pro_n_cst_dwsrv_sort

forward prototypes
public function string of_getheadername (string as_column, string as_suffix)
protected function integer of_buildsortattrib (ref n_cst_sortattrib anv_sortattrib)
end prototypes

public function string of_getheadername (string as_column, string as_suffix);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetHeaderName (FORMAT 2) 
//
//	Access:    Public
//
//	Arguments:
//   as_column   A datawindow columnname
//	  as_suffix   The suffix used on column header text
//
//	Returns:  String
//	  The formatted column header for the column specified
//
//	Description:  Extracts a formatted (underscores, carriage return/line
//					  feeds and quotes removed) column header.
//					  If no column header found, then the column name is
//					  formatted (no underscores and Word Capped).
//
//  *NOTE: Use this format when column header text does NOT
//	  use the default header suffix
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0    Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string ls_colhead
n_cst_string	lnv_string

//Try using the column header.
ls_colhead = idw_Requestor.Describe ( as_column + as_suffix + ".Text" )
If ls_colhead = "!" Then
	//No valid column header, use column name.
	ls_colhead = as_column
End If	

//Remove undesired characters.
ls_colhead = lnv_string.of_GlobalReplace ( ls_colhead, "~r~n", " " ) 
ls_colhead = lnv_string.of_GlobalReplace ( ls_colhead, "~t", " " ) 
ls_colhead = lnv_string.of_GlobalReplace ( ls_colhead, "~r", " " ) 
ls_colhead = lnv_string.of_GlobalReplace ( ls_colhead, "~n", " " ) 
ls_colhead = lnv_string.of_GlobalReplace ( ls_colhead, "_", " " ) 
ls_colhead = lnv_string.of_GlobalReplace ( ls_colhead, "~"", "" ) 
//ls_colhead = lnv_string.of_GlobalReplace ( ls_colhead, "~'", "" ) 
ls_colhead = lnv_string.of_GlobalReplace ( ls_colhead, "~~", "" )
//enlever les :
ls_colhead = lnv_string.of_GlobalReplace ( ls_colhead, ":", "" )

//WordCap string.
//ls_colhead = idw_Requestor.Describe ( "Evaluate('WordCap(~"" + ls_colhead + "~")',0)" )
Return ls_colhead
end function

protected function integer of_buildsortattrib (ref n_cst_sortattrib anv_sortattrib);integer			li_numcols, li_i, li_j, li_k, li_numcomputes, li_exclude
string			ls_computes[], ls_dbname, ls_sortcolumns_all[]	// Hold all sort columns prior to any exclusions.
string			ls_sortcolumns_exc[]	// Hold sort columns after excluding appropriate ones.
boolean			lb_exclude
n_cst_string	lnv_string

// Validate dw reference.
If IsNull(idw_Requestor) Or Not IsValid(idw_Requestor) Then Return -1

// Get the current sort for the datawindow.
anv_sortattrib.is_sort = of_GetSort()

// Remove space after the comma(s) (convert ', ' to ',').
anv_sortattrib.is_sort = lnv_string.of_GlobalReplace (anv_sortattrib.is_sort, ', ', ',')

// Parse the original sort into separate elements.
of_ParseSortAttrib ( anv_sortattrib.is_sort, anv_sortattrib )

// Get all the column names on the datawindow.
//2006-11-09 - Mettre les colonne invisible aussi pour les rapports perso
IF idw_Requestor.getparent().classname() = "w_rapport_simple" THEN
	li_numcols = of_GetObjects(ls_sortcolumns_all, "column", "detail", FALSE) 	
ELSE
	li_numcols = of_GetObjects(ls_sortcolumns_all, "column", "*", ib_visibleonly) 
END IF


// Get all the computed column names on the datawindow and add them to the array.
/*li_numcomputes =  of_GetObjects( ls_computes, "compute", "*", ib_visibleonly)
FOR li_i = 1 to li_numcomputes
	li_numcols++
	ls_sortcolumns_all[li_numcols] = ls_computes[li_i] 
NEXT */

// See if any columns were set to be excluded from the sort display
//	and create a new list of sort columns.
li_exclude  = UpperBound(is_excludecolumns) 
FOR li_j = 1 to li_numcols
	lb_exclude = FALSE
	FOR li_i = 1 to li_exclude
		IF Lower(is_excludecolumns [li_i]) = Lower(ls_sortcolumns_all[li_j]) THEN
			lb_exclude = TRUE
			EXIT
		END IF
	NEXT
	IF Not lb_exclude THEN 
		li_k++
		ls_sortcolumns_exc[li_k] = ls_sortcolumns_all[li_j]
	END IF
NEXT 

// Copy the list of appropriate sort columns to the nvo.
anv_sortattrib.is_sortcolumns = ls_sortcolumns_exc
li_numcols = UpperBound(anv_sortattrib.is_sortcolumns)
			
// Get the column displayname.
CHOOSE CASE of_GetColumnnameSource ( )
	CASE 0			
		//  Use dw Column Names
		FOR li_i = 1 to li_numcols
			anv_sortattrib.is_colnamedisplay[li_i] = anv_sortattrib.is_sortcolumns[li_i]
		NEXT

	CASE 1			
		//  Use Database Names
		FOR li_i = 1 to li_numcols
			ls_dbname = idw_Requestor.Describe ( anv_sortattrib.is_sortcolumns[li_i] + ".DbName" )
			IF ls_dbname = "" OR ls_dbname = "!" THEN ls_dbname = anv_sortattrib.is_sortcolumns[li_i]
			anv_sortattrib.is_colnamedisplay[li_i] = ls_dbname
		NEXT
			
	CASE 2			
		//  Use Column Headers
		FOR li_i = 1 to li_numcols
			anv_sortattrib.is_colnamedisplay[li_i] = &
					of_GetHeaderName ( anv_sortattrib.is_sortcolumns[li_i] )
		NEXT
END CHOOSE

// Determine if LookUpDisplay should automatically be added when creating sort strings
// using the PFC SetSort Dialogs.
FOR li_i = 1 to li_numcols
	IF of_GetUseDisplay() THEN 
		anv_sortattrib.ib_usedisplay[li_i] = of_UsesDisplayValue(anv_sortattrib.is_sortcolumns[li_i])
	ELSE
		anv_sortattrib.ib_usedisplay[li_i] = FALSE
	END IF 
NEXT

Return 1

end function

on pro_n_cst_dwsrv_sort.create
call super::create
end on

on pro_n_cst_dwsrv_sort.destroy
call super::destroy
end on

