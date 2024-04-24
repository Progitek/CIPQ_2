$PBExportHeader$pro_n_cst_dwsrv.sru
$PBExportComments$(PRO) Extension Base DataWindow service
forward
global type pro_n_cst_dwsrv from pfc_n_cst_dwsrv
end type
end forward

global type pro_n_cst_dwsrv from pfc_n_cst_dwsrv
end type
global pro_n_cst_dwsrv pro_n_cst_dwsrv

forward prototypes
public function string of_getheadername (string as_column, string as_suffix)
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
// 2007-08-06	Mathieu Gendron	Plus de WordCap, enlevé les :, remis l'apostrophe
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

ls_colhead = lnv_string.of_GlobalReplace ( ls_colhead, ":", "" )

//WordCap string.
//ls_colhead = idw_Requestor.Describe ( "Evaluate('WordCap(~"" + ls_colhead + "~")',0)" )

Return ls_colhead
end function

on pro_n_cst_dwsrv.create
call super::create
end on

on pro_n_cst_dwsrv.destroy
call super::destroy
end on

