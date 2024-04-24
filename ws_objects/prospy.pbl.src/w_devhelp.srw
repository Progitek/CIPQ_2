$PBExportHeader$w_devhelp.srw
$PBExportComments$DW Spy
forward
global type w_devhelp from window
end type
type sle_gs_appdata from singlelineedit within w_devhelp
end type
type st_gs_appdata from statictext within w_devhelp
end type
type st_fieldinfo2 from statictext within w_devhelp
end type
type cb_eval2 from commandbutton within w_devhelp
end type
type cb_eval1 from commandbutton within w_devhelp
end type
type cb_stop_profiler from commandbutton within w_devhelp
end type
type cb_start_profiler from commandbutton within w_devhelp
end type
type cb_print from commandbutton within w_devhelp
end type
type st_disable_bind from statictext within w_devhelp
end type
type cb_saveas from commandbutton within w_devhelp
end type
type sle_evaluate_result from singlelineedit within w_devhelp
end type
type sle_evaluate from singlelineedit within w_devhelp
end type
type st_dw_readonly from statictext within w_devhelp
end type
type st_readonly from statictext within w_devhelp
end type
type st_updatetable from statictext within w_devhelp
end type
type st_2 from statictext within w_devhelp
end type
type st_1 from statictext within w_devhelp
end type
type sle_file_name from singlelineedit within w_devhelp
end type
type sle_block_name from singlelineedit within w_devhelp
end type
type cb_stop from commandbutton within w_devhelp
end type
type cb_start from commandbutton within w_devhelp
end type
type sle_trace_filename from singlelineedit within w_devhelp
end type
type st_filename from statictext within w_devhelp
end type
type st_directory from statictext within w_devhelp
end type
type sle_trace_directory from singlelineedit within w_devhelp
end type
type st_debug_log from statictext within w_devhelp
end type
type st_sql_spy from statictext within w_devhelp
end type
type st_dw_props from statictext within w_devhelp
end type
type st_show_dw_size_and_coordinates from statictext within w_devhelp
end type
type st_deleted_data from statictext within w_devhelp
end type
type st_show_window_size_and_coordinates from statictext within w_devhelp
end type
type st_filtered_data from statictext within w_devhelp
end type
type st_updated_fields from statictext within w_devhelp
end type
type st_row_status from statictext within w_devhelp
end type
type st_field_info from statictext within w_devhelp
end type
type st_show_dddw_data from statictext within w_devhelp
end type
type st_sort_expr from statictext within w_devhelp
end type
type st_filter_expr from statictext within w_devhelp
end type
type st_invisible_fields from statictext within w_devhelp
end type
type st_data_src from statictext within w_devhelp
end type
type st_menu from statictext within w_devhelp
end type
type st_classes_hierarchy from statictext within w_devhelp
end type
type cb_copy_to_clipboard from commandbutton within w_devhelp
end type
type cb_close from commandbutton within w_devhelp
end type
type gb_window from groupbox within w_devhelp
end type
type gb_tracing from groupbox within w_devhelp
end type
type gb_clicked_row from groupbox within w_devhelp
end type
type dw_display from datawindow within w_devhelp
end type
type gb_clicked_field from groupbox within w_devhelp
end type
type gb_pfc_services from groupbox within w_devhelp
end type
type dw_data from datawindow within w_devhelp
end type
type mle_display from multilineedit within w_devhelp
end type
type dw_messages_lang_lkp from u_dw within w_devhelp
end type
type tab_preview from tab within w_devhelp
end type
type tabpage_dw_spy from userobject within tab_preview
end type
type tabpage_dw_spy from userobject within tab_preview
end type
type tabpage_data from userobject within tab_preview
end type
type tabpage_data from userobject within tab_preview
end type
type tabpage_messages from userobject within tab_preview
end type
type tabpage_messages from userobject within tab_preview
end type
type tab_preview from tab within w_devhelp
tabpage_dw_spy tabpage_dw_spy
tabpage_data tabpage_data
tabpage_messages tabpage_messages
end type
type dw_messages_lkp from u_dw within w_devhelp
end type
type gb_datawindow2 from groupbox within w_devhelp
end type
type gb_1 from groupbox within w_devhelp
end type
end forward

shared variables
int	si_instances_counter = 0
end variables

global type w_devhelp from window
integer width = 5143
integer height = 3492
boolean titlebar = true
string title = "DataWindow Spy"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
sle_gs_appdata sle_gs_appdata
st_gs_appdata st_gs_appdata
st_fieldinfo2 st_fieldinfo2
cb_eval2 cb_eval2
cb_eval1 cb_eval1
cb_stop_profiler cb_stop_profiler
cb_start_profiler cb_start_profiler
cb_print cb_print
st_disable_bind st_disable_bind
cb_saveas cb_saveas
sle_evaluate_result sle_evaluate_result
sle_evaluate sle_evaluate
st_dw_readonly st_dw_readonly
st_readonly st_readonly
st_updatetable st_updatetable
st_2 st_2
st_1 st_1
sle_file_name sle_file_name
sle_block_name sle_block_name
cb_stop cb_stop
cb_start cb_start
sle_trace_filename sle_trace_filename
st_filename st_filename
st_directory st_directory
sle_trace_directory sle_trace_directory
st_debug_log st_debug_log
st_sql_spy st_sql_spy
st_dw_props st_dw_props
st_show_dw_size_and_coordinates st_show_dw_size_and_coordinates
st_deleted_data st_deleted_data
st_show_window_size_and_coordinates st_show_window_size_and_coordinates
st_filtered_data st_filtered_data
st_updated_fields st_updated_fields
st_row_status st_row_status
st_field_info st_field_info
st_show_dddw_data st_show_dddw_data
st_sort_expr st_sort_expr
st_filter_expr st_filter_expr
st_invisible_fields st_invisible_fields
st_data_src st_data_src
st_menu st_menu
st_classes_hierarchy st_classes_hierarchy
cb_copy_to_clipboard cb_copy_to_clipboard
cb_close cb_close
gb_window gb_window
gb_tracing gb_tracing
gb_clicked_row gb_clicked_row
dw_display dw_display
gb_clicked_field gb_clicked_field
gb_pfc_services gb_pfc_services
dw_data dw_data
mle_display mle_display
dw_messages_lang_lkp dw_messages_lang_lkp
tab_preview tab_preview
dw_messages_lkp dw_messages_lkp
gb_datawindow2 gb_datawindow2
gb_1 gb_1
end type
global w_devhelp w_devhelp

type variables
/**********************************************************************************************************************
How To Use: 	To open the Spy, press Alt+F1 and right-click on a DataWindow in a running application.
					To get information about a row or a field, right-click just on that row/field.
***********************************************************************************************************************
More details:	http://forum.powerbuilder.us/viewtopic.php?f=2&t=3
***********************************************************************************************************************
Version date:	23-APR-2013
***********************************************************************************************************************
Licence:			No licence needed, this utility is absolutely free.
***********************************************************************************************************************
Developer:		Michael Zuskin - http://ca.linkedin.com/in/zuskin
***********************************************************************************************************************
Like in FB!		https://www.facebook.com/pages/DataWindow-Spy/101422093306662
**********************************************************************************************************************/

string			is_form_id, is_export_path

public:
	
	constant string PARM_NAME__DW = "dw"
	constant string PARM_NAME__ROW = "row"
	constant string PARM_NAME__COL = "col_name"

private:

	long il_row
	long il_row_count
	long il_filtered_count
	long il_deleted_count
	string is_spy_win_title
	string is_field_name
	string is_field_label
	string is_sort_expr
	string is_prev_sort_expr_of_dw_display
	string is_filter_expr
	string is_updated_fields
	string is_data_source_stored_proc
	string is_data_source_sql_select
	boolean ib_clicked_on_row
	boolean ib_clicked_on_field
	boolean ib_field_has_dddw
	boolean ib_dw_has_retrieval_args
	boolean ib_dw_has_rows
	boolean ib_invisible_fields_exist
	boolean ib_window_menu_exists
	
	boolean ib_iswin

	Menu im
	Window iw
	u_dw idw
	StaticText ist_prev_clicked
	
	n_dwspy_util inv_util
	
	constant long COLOR__BLACK = 0
	constant long COLOR__RED = 255
	constant long COLOR__YELLOW = 65535
	constant long COLOR__GREY = 11053224
	constant long COLOR__BLUE = 16711680
	constant long COLOR__BROWN = 328896
	constant long COLOR__FOR_NEXT_INSTANCES = COLOR__BROWN
end variables

forward prototypes
private function string wf_get_updatable_frag (string as_field_name)
private subroutine wf_format_sql (ref string rs_sql)
private function string wf_get_field_type (string as_field_name)
private function string wf_get_field_type (datawindowchild adwc, string as_field_name)
private function string wf_get_field_path ()
private function string wf_get_code_table_frag ()
private function any wf_string_to_any (string as_value, string as_type)
private subroutine wf_show_row_status ()
private subroutine wf_init_instance_vars ()
private subroutine wf_show_dddw_data ()
private subroutine wf_display_in_static_text (string as_msg)
private subroutine wf_display_dw ()
private function string wf_ornament_as_subheader (string as_orig_string)
private subroutine wf_sort_dw_display_by_column (string as_col_name)
private function boolean wf_dw_is_external ()
private subroutine wf_show_window_info ()
private subroutine wf_show_data_in_buffer (dwbuffer a_buffer)
private function boolean wf_invisible_fields_exist (datawindow adw)
private subroutine wf_get_computed_fields (datawindow adw, ref string rs_computed_field_names_arr[], ref integer ri_computed_fields_qty)
private subroutine wf_init_next_instances ()
private subroutine wf_show_size_and_coordinates (datawindow adw)
private subroutine wf_show_size_and_coordinates (window aw)
private subroutine wf_show_size_and_coordinates (integer ai_x, integer ai_y, integer ai_width, integer ai_height)
private subroutine wf_disable_static_text (statictext ast_to_disable, string as_text)
private subroutine wf_disable_static_text (statictext ast_to_disable)
private function boolean wf_property_defined (string as_property_value)
private subroutine wf_init_visual_appearance () throws n_ex
private function string wf_get_inheritance_chain (graphicobject ago) throws n_ex
private subroutine wf_show_classes_hierarchy () throws n_ex
private subroutine wf_show_menu () throws n_ex
private subroutine wf_static_text_clicked (statictext ast_clicked) throws n_ex
private function string wf_get_retrieval_args_frag (powerobject apo) throws n_ex
private subroutine wf_show_data_src () throws n_ex
private function string wf_get_data_source_of_dddw_frag (datawindowchild adwc, string as_dddw_dataobject) throws n_ex
private function string wf_get_dddw_frag (string as_val) throws n_ex
private subroutine wf_show_field_info () throws n_ex
private function string wf_get_field_status_as_string (string as_field_name) throws n_ex
private subroutine wf_show_invisible_fields () throws n_ex
private function string wf_get_val_frag (string as_field_name) throws n_ex
private function string wf_get_field_info (string as_field_name) throws n_ex
private function string wf_get_invisible_computed_fields_frag () throws n_ex
private function string wf_get_updated_fields () throws n_ex
public subroutine of_debuglog ()
public subroutine of_sqlspy ()
private function string wf_get_retrieval_args_frag (powerobject apo, ref string arg[]) throws n_ex
public subroutine wf_get_all_field_info (datawindow adw)
end prototypes

private function string wf_get_updatable_frag (string as_field_name);/**********************************************************************************************************************
Dscr:	Returns the message fragment describing if the field is updatable.
-----------------------------------------------------------------------------------------------------------------------
Arg:	as_field_name
-----------------------------------------------------------------------------------------------------------------------
Ret:	string
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Dec 23, 2010	Initial version
**********************************************************************************************************************/
string	ls_update_expr

ls_update_expr = idw.Describe(as_field_name + ".Update")

choose case ls_update_expr
case "yes"
	return "Updatable"
case "no"
	return "Not Updatable"
case "!" // irrelevant
	return ""
case else // dynamic expression
	return "Update Expr='" + ls_update_expr + "'"
end choose
end function

private subroutine wf_format_sql (ref string rs_sql);/**********************************************************************************************************************
Dscr:	Gets SQL statement and changes all its keywords to upper case
		and the rest of the words - to lower case.
-----------------------------------------------------------------------------------------------------------------------
Arg:	rs_sql	ref	SQL statement to process
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
inv_util.uf_replace_all(ref rs_sql, "~"","")
inv_util.uf_replace_all(ref rs_sql, "select", "SELECT")
//inv_util.uf_replace_all(ref rs_sql, "from	", "~r~nFROM	")
//inv_util.uf_replace_all(ref rs_sql, "from ", "~r~nFROM ")
//inv_util.uf_replace_all(ref rs_sql, "from~r~n", "~r~nFROM~r~n")
//inv_util.uf_replace_all(ref rs_sql, "where", "~r~nWHERE")
//inv_util.uf_replace_all(ref rs_sql, "order by", "~r~nORDER BY")
//inv_util.uf_replace_all(ref rs_sql, "group by", "~r~nGROUP BY")
//inv_util.uf_replace_all(ref rs_sql, "union", "~r~nUNION~r~n")
inv_util.uf_replace_all(ref rs_sql, "from	", "FROM	")
inv_util.uf_replace_all(ref rs_sql, "from ", "FROM ")
inv_util.uf_replace_all(ref rs_sql, "from", "FROM")
inv_util.uf_replace_all(ref rs_sql, "where", "WHERE")
inv_util.uf_replace_all(ref rs_sql, "order by", "ORDER BY")
inv_util.uf_replace_all(ref rs_sql, "group by", "GROUP BY")
inv_util.uf_replace_all(ref rs_sql, "union", "UNION")
inv_util.uf_replace_all(ref rs_sql, " and", " AND")
inv_util.uf_replace_all(ref rs_sql, "and ", "AND ")
inv_util.uf_replace_all(ref rs_sql, "or ", "OR ")
inv_util.uf_replace_all(ref rs_sql, " or", " OR")
inv_util.uf_replace_all(ref rs_sql, "in ", "IN ")
inv_util.uf_replace_all(ref rs_sql, " in", " IN")
inv_util.uf_replace_all(ref rs_sql, "in(", " IN(")
inv_util.uf_replace_all(ref rs_sql, "not ", "NOT ")
inv_util.uf_replace_all(ref rs_sql, " not", " NOT")
inv_util.uf_replace_all(ref rs_sql, "is null", "IS NULL")
inv_util.uf_replace_all(ref rs_sql, "is not null", "IS NOT NULL")
inv_util.uf_replace_all(ref rs_sql, "exists", "EXISTS")
inv_util.uf_replace_all(ref rs_sql, "between", "BETWEEN")

return
end subroutine

private function string wf_get_field_type (string as_field_name);/**********************************************************************************************************************
Dscr:	Returns field's datatype as string.
-----------------------------------------------------------------------------------------------------------------------
Arg:	as_field_name
-----------------------------------------------------------------------------------------------------------------------
Ret:	string
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
string	ls_field_type

ls_field_type = idw.Describe(as_field_name + ".ColType")
																// "char(50)" ==>> "char 50":
inv_util.uf_replace_all(ref ls_field_type, "(", " ")
inv_util.uf_replace_all(ref ls_field_type, ")", "")

return ls_field_type
end function

private function string wf_get_field_type (datawindowchild adwc, string as_field_name);/**********************************************************************************************************************
Dscr:	Returns DataWindowChild field's datatype as string.
-----------------------------------------------------------------------------------------------------------------------
Arg:	adwc (DataWindowChild)
		as_field_name
-----------------------------------------------------------------------------------------------------------------------
Ret:	string
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
string	ls_field_type

ls_field_type = adwc.Describe(as_field_name + ".ColType")
																// "char(50)" ==>> "char 50":
inv_util.uf_replace_all(ref ls_field_type, "(", " ")
inv_util.uf_replace_all(ref ls_field_type, ")", "")

return ls_field_type
end function

private function string wf_get_field_path ();/**********************************************************************************************************************
Dscr:	Returns the ckicked field's path (like w_xxx.tab_xxx.tabpage_xxx.dw_xxx.field_name[3])
-----------------------------------------------------------------------------------------------------------------------
Ret:	string
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Dec 23, 2010	Initial version
**********************************************************************************************************************/
string			ls_path
string			ls_objects_arr[]
int				i
int				li_qty_of_objects
GraphicObject	lgo_curr

ls_objects_arr[1] = "object." + Lower(is_field_name) +  "[" + String(il_row) + "]"
																		// Fill ls_objects_arr with objects names from DW to Window:
lgo_curr = idw
i = 2
do while true
	ls_objects_arr[i] = lgo_curr.ClassName()
	lgo_curr = lgo_curr.GetParent()
	if not IsValid(lgo_curr) /* the window is reached */ then
		exit
	end if
	i++
loop
																		// Build the pass moving from Window to Field:
li_qty_of_objects = UpperBound(ls_objects_arr)
for i = li_qty_of_objects to 1 step -1
	ls_path += ls_objects_arr[i] + "."
next
ls_path = Left(ls_path, Len(ls_path) - 1) // remove the last "."

return ls_path
end function

private function string wf_get_code_table_frag ();/**********************************************************************************************************************
Dscr:	Returns to wf_show_field_info the fragment with code table info ("" if no code table)
-----------------------------------------------------------------------------------------------------------------------
Ret:	string
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Mar 11, 2011	Initial version
**********************************************************************************************************************/
string	ls_frag

ls_frag = idw.Describe(is_field_name + ".Values")
if not wf_property_defined(ls_frag) then return ""
												// Display Code Table as pairs 'Displayed Value' - 'Stored Value':
inv_util.uf_replace_all(ref ls_frag, "	", "' - '")
inv_util.uf_replace_all(ref ls_frag, "/", "'~r~n'")
ls_frag = "'" + ls_frag + "'"
inv_util.uf_replace_all(ref ls_frag, "'' - ", "'<No Displayed Value - Stored is displayed>' - ") // no description - display code only
inv_util.uf_replace_all(ref ls_frag, " - ''", " - '<No Stored Value - Displayed is stored>'") // no code - display description only
ls_frag = Left(ls_frag, Len(ls_frag) - 4) // remove "'~r~n'" from the end

//ls_frag = "~r~n~r~n########## Code Table:~r~n~r~n'Displayed Value' - 'Stored Value'~r~n~r~n==================================~r~n" + ls_frag
ls_frag = "~r~n~r~n########## Code Table:~r~n~r~n'Displayed Value' - 'Stored Value'~r~n~r~n==================================" + ls_frag

return ls_frag
end function

private function any wf_string_to_any (string as_value, string as_type);choose case as_type
case "date"
	return Date(as_value)
case "datetime"
	return DateTime(as_value)
case "time"
	return Time(as_value)
case "integer","int"
	return Integer(as_value)
case "double"
	return Double(as_value)
case "dec", "decimal"
	return Dec(as_value)
case "number"
	return Dec(as_value)
case "long"
	return Long(as_value)
case else
	return as_value
end choose
end function

private subroutine wf_show_row_status ();/**********************************************************************************************************************
Dscr:	Displays DWItemStatus of the clicked row.
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Mar 23, 2011	Initial version
**********************************************************************************************************************/
DWItemStatus	l_row_status
string			ls_row_status, ls_info

l_row_status = idw.GetItemStatus(il_row, 0, Primary!)

choose case l_row_status
case New!
	ls_row_status = "New!"
case NewModified!
	ls_row_status = "NewModified!"
case NotModified!
	ls_row_status = "NotModified!"
case DataModified!
	ls_row_status = "DataModified!"
end choose

ls_info = 'Dataobject = "' + idw.dataobject + '"~r~n' + & 
			"-------------------------------------------------------------------------------------------------~r~n" + ls_row_status

//wf_display_in_static_text(ls_row_status)
wf_display_in_static_text(ls_info)

return
end subroutine

private subroutine wf_init_instance_vars ();/**********************************************************************************************************************
Dscr:	Initializes instance variables.
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
string	ls_data_col
string	ls_field_type
string	ls_dddw_data_col
string	ls_retrieval_args

ib_clicked_on_row = (il_row > 0)
if ib_clicked_on_row then
	ls_field_type = idw.Describe(is_field_name + ".ColType")
	ib_clicked_on_field = wf_property_defined(ls_field_type)
else
	ib_clicked_on_field = false
end if

if ib_clicked_on_field then
	is_field_label = inv_util.uf_get_field_label(idw, is_field_name)
	ls_data_col = idw.Describe(is_field_name + ".DDDW.DataColumn")
	ib_field_has_dddw = wf_property_defined(ls_data_col)
else
	ib_field_has_dddw = false
end if

iw = inv_util.uf_get_window(idw)
im = iw.MenuID
ib_window_menu_exists = IsValid(im)

ib_dw_has_rows = (idw.RowCount() > 0)

ls_retrieval_args = idw.Describe("DataWindow.Table.Arguments")
ib_dw_has_retrieval_args = (ls_retrieval_args <> "?")

ib_invisible_fields_exist = wf_invisible_fields_exist(idw)

is_sort_expr = idw.object.datawindow.table.sort

is_filter_expr = idw.object.datawindow.table.filter
inv_util.uf_replace_all(ref is_filter_expr, " AND ", "~r~nAND~r~n")
inv_util.uf_replace_all(ref is_filter_expr, " and ", "~r~nAND~r~n")
inv_util.uf_replace_all(ref is_filter_expr, "( ", "(")
inv_util.uf_replace_all(ref is_filter_expr, " )", ")")

il_row_count = idw.RowCount()
il_filtered_count = idw.FilteredCount()
il_deleted_count = idw.DeletedCount()

return
end subroutine

private subroutine wf_show_dddw_data ();/**********************************************************************************************************************
Dscr:	Shows DDDW's data in dw_display
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Oct 05, 2011	Initial version
**********************************************************************************************************************/
int					li_fields_qty
int					i
long					ll_filtered_count
long					ll_deleted_count
string				ls_err
string				ls_col_name
string				ls_which_rows // possible values: "filtered", "deleted", "filtered and deleted"
string				ls_which_button // possible values: "Filtered Rows", "Deleted Rows", "Filtered Rows / Deleted Rows"
DataWindowChild	ldwc

wf_display_dw()

idw.GetChild(is_field_name, ref ldwc)
dw_display.DataObject = idw.Describe(is_field_name + ".DDDW.Name")

ldwc.RowsCopy(1, ldwc.RowCount(), Primary!, dw_display, 1, Primary!)

// Process invisible fields of DDDW:
if wf_invisible_fields_exist(dw_display) then
	MessageBox("DW Spy", "Investigated DDDW has invisible fields.~r~nTo see them, perform next steps:" + &
				"~r~n~r~n1. Open new instance of Spy for DW you currently see in already open Spy." + &
				"~r~n~r~n2. In opened new Spy instance, highlight row invisible fields of which you want to see." + &
				"~r~n~r~n3. Click button Invisible Fields.")
end if

// Process filtered rows of DDDW:
ll_filtered_count = ldwc.FilteredCount()
if ll_filtered_count > 0 then
	ldwc.RowsCopy(1, ll_filtered_count, Filter!, dw_display, 1, Filter!)
	ls_which_rows = "filtered"
	ls_which_button = "Filtered Rows"
end if

// Process deleted rows of DDDW:
ll_deleted_count = ldwc.DeletedCount()
if ll_deleted_count > 0 then
	ldwc.RowsCopy(1, ll_deleted_count, Delete!, dw_display, 1, Delete!)
	if ls_which_button <> "" then
		ls_which_rows += " and "
		ls_which_button += " / "
	end if
	ls_which_rows += "deleted"
	ls_which_button +=  "Deleted Rows"
end if

if ll_filtered_count > 0 or ll_deleted_count > 0 then
	MessageBox("DW Spy", "Investigated DDDW has " + ls_which_rows + " rows.~r~nTo see them, perform next steps:" + &
				"~r~n~r~n1. Open new instance of Spy for DW you currently see in already open Spy." + &
				"~r~n~r~n2. In opened new Spy instance, click button " + ls_which_button + ".")
end if

return
end subroutine

private subroutine wf_display_in_static_text (string as_msg);/**********************************************************************************************************************
Dscr:	Displays message in mle_display.
-----------------------------------------------------------------------------------------------------------------------
Arg:	as_msg - to be displayed in mle_display
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Oct 05, 2011	Initial version
**********************************************************************************************************************/
dw_display.Hide()
mle_display.Show()
cb_copy_to_clipboard.Enabled = true

mle_display.Text = as_msg

return
end subroutine

private subroutine wf_display_dw ();/**********************************************************************************************************************
Dscr:	Displays message in dw_display.
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Oct 05, 2011	Initial version
**********************************************************************************************************************/
dw_display.Show()
mle_display.Hide()
cb_copy_to_clipboard.Enabled = false

return
end subroutine

private function string wf_ornament_as_subheader (string as_orig_string);//Left("###### " + as_orig_string + ": ############################################", 50) + "~r~n~r~n"
//return Left("###### " + as_orig_string + ": ############################################", 50) + "~r~n"
return Left("#####  " + as_orig_string + "  #####", 50) + "~r~n"
end function

private subroutine wf_sort_dw_display_by_column (string as_col_name);/**********************************************************************************************************************
Dscr:	Sorts DW by a double-clicked column.
-----------------------------------------------------------------------------------------------------------------------
Arg:	as_col_name
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Oct 19, 2011	Initial version
**********************************************************************************************************************/
string	ls_db_name
string	ls_new_sort_expr_of_dw_display
string	ls_prev_sort_col

if dw_display.RowCount() = 1 then return

if Right(as_col_name, 2) = "_t" /* user double-clicked on a column's header */ then
	as_col_name = Left(as_col_name, Len(as_col_name) - 2) // remove "_t"
end if

ls_db_name = dw_display.Describe(as_col_name + '.DBName')
if not wf_property_defined(ls_db_name) /* no such column - the header in NOT named by the "<column name>_t" pattern */ then
	MessageBox("DW Spy - Sort by Column", "Double-click on the field itself~r~n(in one of the rows), NOT on its header.")
	return
end if

if is_prev_sort_expr_of_dw_display = as_col_name + " A" /* has been previously sorted in ASC order */ then
	ls_new_sort_expr_of_dw_display = as_col_name + " D" // change sort order to DESC
	dw_display.Modify(as_col_name + ".Color=" + String(COLOR__RED))
else
	ls_new_sort_expr_of_dw_display = as_col_name + " A"
	dw_display.Modify(as_col_name + ".Color=" + String(COLOR__BLUE))
end if

dw_display.SetSort(ls_new_sort_expr_of_dw_display)
dw_display.Sort()

if is_prev_sort_expr_of_dw_display <> "" /* this function has already been called */ then
	// return black color to the column the previous sort was made by:
	ls_prev_sort_col = Left(is_prev_sort_expr_of_dw_display, Len(is_prev_sort_expr_of_dw_display) - 2) // remove " A" or " D"
	if as_col_name <> ls_prev_sort_col /* this function is called for a different column than in the previous time */ then
		dw_display.Modify(ls_prev_sort_col + ".Color=0")
	end if
end if

is_prev_sort_expr_of_dw_display = ls_new_sort_expr_of_dw_display

return
end subroutine

private function boolean wf_dw_is_external ();/**********************************************************************************************************************
Dscr:	Reports if the DW is external.
-----------------------------------------------------------------------------------------------------------------------
Ret:	boolean: true - external, false - has a data source (SQL SELECT or stored proc)
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 17, 2011	Initial version
**********************************************************************************************************************/
is_data_source_sql_select = idw.GetSQLSelect()
if is_data_source_sql_select <> "" then
	wf_format_sql(ref is_data_source_sql_select)
	return false
end if

is_data_source_stored_proc = inv_util.uf_get_proc_of_dataobject(idw.DataObject)
if is_data_source_stored_proc <> "" then
	return false
end if

return true
end function

private subroutine wf_show_window_info ();/**********************************************************************************************************************
Dscr:	Displays the window's size and coordinates.
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		May 17, 2012	Initial version
**********************************************************************************************************************/
string	ls_window_info

ls_window_info = "X = " + String(iw.X) + "~r~n" + &
						"Y = " + String(iw.Y) + "~r~n" + &
						"Width = " + String(iw.Width) + "~r~n" + &
						"Height = " + String(iw.Height)

wf_display_in_static_text(ls_window_info)

return
end subroutine

private subroutine wf_show_data_in_buffer (dwbuffer a_buffer);wf_display_dw()
dw_display.DataObject = idw.DataObject

choose case a_buffer
case Filter!
	dw_display.Object.Data.primary = idw.Object.Data.filter
case Delete!
	dw_display.Object.Data.primary = idw.Object.Data.delete
case Primary!
	dw_display.Object.Data.primary = idw.Object.Data.primary
end choose

return

end subroutine

private function boolean wf_invisible_fields_exist (datawindow adw);/**********************************************************************************************************************
Dscr:	Reports if there is at least one invisible field in the DW.
-----------------------------------------------------------------------------------------------------------------------
Ret:	boolean
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
string	ls_field_name
string	ls_computed_field_names[]
int		li_fields_qty
int		i
												// Process invisible computed fields:
wf_get_computed_fields(adw, ref ls_computed_field_names[], ref li_fields_qty)
for i = 1 to li_fields_qty
	ls_field_name = ls_computed_field_names[i]
	if not inv_util.uf_col_is_visible(adw, ls_field_name) then return true
next
												// Process regular (not computed) invisible fields:
li_fields_qty = Integer(adw.Describe("DataWindow.Column.Count"))
for i = 1 to li_fields_qty
	ls_field_name = Upper(adw.Describe("#"+ String(i) + ".Name"))
	if not inv_util.uf_col_is_visible(adw, ls_field_name) then return true
next

return false
end function

private subroutine wf_get_computed_fields (datawindow adw, ref string rs_computed_field_names_arr[], ref integer ri_computed_fields_qty);/**********************************************************************************************************************
Dscr:	Returns array of computed fields (visible and invisible) contained in idw.
-----------------------------------------------------------------------------------------------------------------------
Arg:	rs_computed_field_names_arr[] - BY REF
-----------------------------------------------------------------------------------------------------------------------
Ret:	the number of returned computed fields (int)
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Jul 22, 2011	Initial version
**********************************************************************************************************************/
int		li_start_pos = 1
int		li_tab_pos
string	ls_list_of_all_objects
string	ls_obj_name

ls_list_of_all_objects = Describe(idw, "datawindow.objects")
ri_computed_fields_qty = 0

li_tab_pos = Pos(ls_list_of_all_objects, "~t", li_start_pos)
do while li_tab_pos > 0
	ls_obj_name = Mid(ls_list_of_all_objects, li_start_pos, (li_tab_pos - li_start_pos))
	if Describe(idw, ls_obj_name + ".type") = "compute" then
		ri_computed_fields_qty++
		rs_computed_field_names_arr[ri_computed_fields_qty] = ls_obj_name
	end if
	li_start_pos = li_tab_pos + 1
	li_tab_pos = Pos(ls_list_of_all_objects, "~t", li_start_pos)
loop

return
end subroutine

private subroutine wf_init_next_instances ();/**********************************************************************************************************************
Dscr:	If this instance is open for dw_display (i.e. user pressed Ctrl+F1 and double-clicked on an already open instance of the Spy),
		this function changes back color to red to remind user that the explored DW doesn't belong to the application.
		Called from wf_init_visual_appearance.
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		08aug2012	Initial version
**********************************************************************************************************************/
int			i
GroupBox		lgb_arr[]

if si_instances_counter = 1 then return // it's the first instance, not a next

this.BackColor = COLOR__FOR_NEXT_INSTANCES

lgb_arr[1] = gb_window
lgb_arr[2] = gb_datawindow2
lgb_arr[3] = gb_clicked_field
lgb_arr[4] = gb_clicked_row

for i = 1 to 4
	lgb_arr[i].BackColor = COLOR__FOR_NEXT_INSTANCES
	lgb_arr[i].TextColor = COLOR__YELLOW
next

post MessageBox("Attention!", &
			"This is instance #" + String(si_instances_counter) + &
			" of the DW Spy. It shows information, contained in the DW of the previous (#" + &
			String(si_instances_counter - 1) + ") instance of the Spy, NOT in the application!")
			
return
end subroutine

private subroutine wf_show_size_and_coordinates (datawindow adw);/**********************************************************************************************************************
Dscr:	Displays the DW's size and coordinates.
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Aug 17, 2012	Initial version
**********************************************************************************************************************/

wf_show_size_and_coordinates(adw.X, adw.Y, adw.Width, adw.Height)

return
end subroutine

private subroutine wf_show_size_and_coordinates (window aw);/**********************************************************************************************************************
Dscr:	Displays the Window's size and coordinates.
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Aug 17, 2012	Initial version
**********************************************************************************************************************/

wf_show_size_and_coordinates(aw.X, aw.Y, aw.Width, aw.Height)

return
end subroutine

private subroutine wf_show_size_and_coordinates (integer ai_x, integer ai_y, integer ai_width, integer ai_height);/**********************************************************************************************************************
Dscr:	Displays the object's size and coordinates.
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Aug 17, 2012	Initial version
**********************************************************************************************************************/
string	ls_info

if 	ib_iswin then
	ls_info = 'Title = "' + trim(iw.title) + '"~r~n' + & 
				"-------------------------------------------------------------------------------------------------" + "~r~n" 
else
	ls_info = 'Dataobject = "' + idw.dataobject + '"~r~n' + & 
				"-------------------------------------------------------------------------------------------------" + "~r~n" 
end if

ls_info = ls_info + "~r~n" + & 
				"X = " + String(ai_x) + "~r~n" + &
				"Y = " + String(ai_y) + "~r~n" + &
				"Width = " + String(ai_width) + "~r~n" + &
				"Height = " + String(ai_height)

wf_display_in_static_text(ls_info)

return
end subroutine

private subroutine wf_disable_static_text (statictext ast_to_disable, string as_text);/**********************************************************************************************************************
Dscr:	Disables st visually.
-----------------------------------------------------------------------------------------------------------------------
Arg:	ast_to_disable (StaticText)
		as_text (string) - the text to put on the disabled StaticText; pass empty string to keep the existing text.
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Oct 06, 2011	Initial version
**********************************************************************************************************************/
ast_to_disable.TextColor = COLOR__GREY
ast_to_disable.Enabled = false

if as_text <> '' then
	ast_to_disable.Text = as_text
end if

return
end subroutine

private subroutine wf_disable_static_text (statictext ast_to_disable);/**********************************************************************************************************************
Dscr:	Disables st visually.
-----------------------------------------------------------------------------------------------------------------------
Arg:	ast_clicked (StaticText)
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Oct 06, 2011	Initial version
**********************************************************************************************************************/
wf_disable_static_text(ast_to_disable, '' /* empty string means keeping the existing text */)

return
end subroutine

private function boolean wf_property_defined (string as_property_value);if as_property_value = "!" then return false
if as_property_value = "?" then return false

return true
end function

private subroutine wf_init_visual_appearance () throws n_ex;/**********************************************************************************************************************
Dscr:	Enables/sets text of command buttons
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
SetRedraw(false)
												/////////////////////////////////
												// Frame "Inheritance Chains": //
												/////////////////////////////////
												
												// Disable some static texts to prevent displaying of the Spy's info:
if si_instances_counter > 1 then
//	gb_window.Enabled = false
	wf_disable_static_text(st_classes_hierarchy)
	wf_disable_static_text(st_show_window_size_and_coordinates)
	wf_disable_static_text(st_show_dw_size_and_coordinates)
end if
												// st_menu:
if not ib_window_menu_exists then
	wf_disable_static_text(st_menu, "No menu in window")
end if
												/////////////////////////
												// Frame "DataWindow": //
												/////////////////////////
												
												// st_data_src:
if wf_dw_is_external() then
	wf_disable_static_text(st_data_src, "External DW - No Data Source")
else
	if ib_dw_has_retrieval_args then
		st_data_src.Text = "Data Source and Arguments"
	end if
end if
												// st_invisible_fields:
if not ib_invisible_fields_exist then
	wf_disable_static_text(st_invisible_fields, "No Invisible Fields")
end if
												// st_filter_expr
if not wf_property_defined(is_filter_expr) then
	wf_disable_static_text(st_filter_expr, "No Filter Applied")
end if

												// st_filtered_data
if il_filtered_count > 0 then
	st_filtered_data.Text = "Filtered Rows (" + String(il_filtered_count) + ")"
else
	wf_disable_static_text(st_filtered_data, "No Filtered Rows")
end if
												// st_deleted_data
if il_deleted_count > 0 then
	st_deleted_data.Text = "Deleted Rows (" + String(il_deleted_count) + ")"
else
	wf_disable_static_text(st_deleted_data, "No Deleted Rows")
end if
												// st_sort_expr
if not wf_property_defined(is_sort_expr) then
	wf_disable_static_text(st_sort_expr, "No Sort Applied")
end if
												////////////////////////////
												// Frame "Clicked Field": //
												////////////////////////////
												
												// The frame:
gb_clicked_field.Enabled = ib_clicked_on_field
gb_clicked_field.Text = "Field " + iif(ib_clicked_on_field, "~"" + is_field_label + "~"", "(click on a field to activate)")
												// st_field_info:
if not ib_clicked_on_field then
	wf_disable_static_text(st_field_info)
end if
												// st_show_dddw_data:
if not ib_field_has_dddw then
	if ib_clicked_on_field then
		st_show_dddw_data.Text = "No DDDW in the Field"
	end if
	wf_disable_static_text(st_show_dddw_data)
end if
												//////////////////////////
												// Frame "Clicked Row": //
												//////////////////////////

												// The frame:
gb_clicked_row.Enabled = ib_clicked_on_row
if ib_clicked_on_row then
	gb_clicked_row.Text = "Row"
	if il_row_count > 1 then gb_clicked_row.Text += " #" + String(il_row)
else
	gb_clicked_row.Text = "Row (click on a row to activate)"
end if
												// st_updated_fields, st_row_status:
if ib_clicked_on_row then
	if not inv_util.uf_row_modified(idw, il_row) then
		wf_disable_static_text(st_updated_fields, "No Updated Fields in the Row")
	end if
else
	wf_disable_static_text(st_updated_fields)
	wf_disable_static_text(st_row_status)
end if
												///////////////////
												// Window Title: //
												///////////////////

is_spy_win_title = "DW Spy for: " 
if si_instances_counter = 1 then
	is_spy_win_title += idw.ClassName() + " (" + idw.DataObject + ")"
else
	is_spy_win_title += idw.DataObject
end if

if ib_clicked_on_field then
	is_spy_win_title += " *** FIELD: ~"" + is_field_label + "~" (" + is_field_name + ")"
end if

if ib_clicked_on_row then
	is_spy_win_title += " *** ROW #" + String(il_row) + " of " + String(il_row_count)
end if

this.Title = is_spy_win_title

												////////////
												// Other: //
												////////////

wf_init_next_instances()
SetRedraw(true)

return
end subroutine

private function string wf_get_inheritance_chain (graphicobject ago) throws n_ex;/**********************************************************************************************************************
Dscr:	Returns inheritance chain of the passed control.
		The chain begins with the name of the control itself
		(as it appears on the containing window, tab or other user object)
		and ends with the PB built-in class (like DataWindow, UserObject etc.)
		The rest of the inheritance is not included because it is obvious.
		Example: if a pointer to dw_cust is passed then the function will return something like
		"dw_cust -> dw_cust (cust.pbl) -> u_dw (pfemain.pbl) -> pfc_u_dw (pfcmain.pbl) -> DataWindow"
-----------------------------------------------------------------------------------------------------------------------
Arg:	ago	GraphicObject
-----------------------------------------------------------------------------------------------------------------------
Ret:	string
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
string				ls_base_pb_class	// the first reached PB's built-in class (like DataWindow, Tab etc.)
												//	it will be the last class shown in the chain,
												// we don't want to continue until PowerObject
string				ls_built_chain
string				ls_indents_accumulator
Object				lo_type_of_arg
Window				lw
DataWindow			ldw
UserObject			luo
Tab					ltab
Menu					lm
ClassDefinition	lcd
																	// Begin building the chain with the passed class itself:
ls_built_chain = ago.ClassName()
ls_built_chain += inv_util.uf_get_pbl_of_class(ls_built_chain)
																	// Obtain the ClassDefinition and the last class in chain
																	// (the first built-in PB class) for the passed class:
lo_type_of_arg = ago.TypeOf()
choose case lo_type_of_arg
case Window!
	ls_base_pb_class = "Window"
	lw = ago // cast from GraphicObject to Window
	lcd = lw.ClassDefinition
case DataWindow!
	ls_base_pb_class = "DataWindow"
	ldw = ago // cast from GraphicObject to DataWindow
	lcd = ldw.ClassDefinition
case UserObject! // including tabpage
	ls_base_pb_class = "UserObject"
	luo = ago // cast from GraphicObject to UserObject
	lcd = luo.ClassDefinition
case Tab!
	ls_base_pb_class = "Tab"
	ltab = ago // cast from GraphicObject to Tab
	lcd = ltab.ClassDefinition
case Menu!
	ls_base_pb_class = "Menu"
	lm = ago // cast from GraphicObject to Menu
	lcd = lm.ClassDefinition
case else
	f_throw(PopulateError(0, "Unknown type of control " + ago.ClassName()))
end choose
																	// Loop through hierarchy of ancestor ClassDefinitions:
do while true
	lcd = lcd.Ancestor
	if lcd.Name = Lower(ls_base_pb_class) /* we have reached the first PB built-in class */ then exit
	ls_indents_accumulator += "    " // accumulate one more indent to manage stairs-style indenting
	ls_built_chain += "~r~n" + ls_indents_accumulator /*+ DELIMITER*/ + lcd.Name + inv_util.uf_get_pbl_of_class(lcd.Name)
loop

if ls_built_chain = "" then return ""

ls_built_chain = wf_ornament_as_subheader(Upper(ls_base_pb_class)) + ls_built_chain

return ls_built_chain
end function

private subroutine wf_show_classes_hierarchy () throws n_ex;/**********************************************************************************************************************
Dscr:	Displays objects visible on the window (like Menu -> Window -> Tab -> TabPage -> DW -> DataObject)
		Each level is presented as an inheritance chain (if the object is inherited).
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
int				i // index var for both ls_class_names[] and lgo_objects[]
int				li_classes_qty
string			ls_class_info
string			ls_hierarchy
string			ls_class_names[]
string			ls_control_kinds[]
Window			lw
GraphicObject	lgo_objects[]
GraphicObject	lgo_curr

SetPointer(HourGlass!)
												//////////////////////
												// Populate arrays: //
												//////////////////////
																	
												// Populate DW's stored proc (like "sp_XXX"):
ls_class_names[1] = is_data_source_stored_proc
ls_control_kinds[1] = iif(is_data_source_stored_proc = '', '', "STORED PROCEDURE (DW'S DATA SOURCE)")
SetNull(lgo_objects[1]) // irrelevant
												// Populate DataObject (like "d_XXX"):
ls_class_names[2] = idw.DataObject
ls_control_kinds[2] = "DATAOBJECT"
SetNull(lgo_objects[2]) // irrelevant
												// Populate the DW userobject (like "dw_XXX"):
ls_class_names[3] = idw.ClassName()
ls_control_kinds[3] = "DATAWINDOW"
lgo_objects[3] = idw
												// Loop getting the parent of the object until the window is reached:
lgo_curr = idw
i = 3
do while true
	lgo_curr = lgo_curr.GetParent()
	if not IsValid(lgo_curr) /* the window is reached */ then
		exit // now ls_class_names[] and lgo_objects[] contains all objects of hierarchy (names and pointers)
	end if
	i++
	ls_class_names[i] = lgo_curr.ClassName()
	ls_control_kinds[i] = Upper(ls_class_names[i])
	lgo_objects[i] = lgo_curr
loop
												//////////////////////////
												// Build result string: //
												//////////////////////////
li_classes_qty = UpperBound(ls_class_names[])
for i = li_classes_qty to 1 step -1 // loop back to diplay window first and proc (if no proc then DataObject) last
	//***** Obtain class info of current class:
	choose case i
	case 1 // stored proc
		ls_class_info = ls_class_names[1] // only name, no additional info
	case 2 // DataObject ("d_..."):
		ls_class_info = ls_class_names[i] + inv_util.uf_get_pbl_of_class(ls_class_names[i])
	case li_classes_qty // Window - the last object in the array:
		ls_class_info = wf_get_inheritance_chain(lgo_objects[i])
		// Get window"s title:
		lw = lgo_objects[i]
	case else // UserObject (visual custom or TabPage) or Tab
		ls_class_info = wf_get_inheritance_chain(lgo_objects[i])
	end choose
	//***** Add currently processed object to result string:
	if ls_hierarchy <> "" then ls_hierarchy += "~r~n~r~n"
	
	choose case i
	case 1
		if ls_control_kinds[1] <> "" /* the DW's data source is "Stored Procedure" */ then
			ls_hierarchy += wf_ornament_as_subheader(ls_control_kinds[1])
		end if
	case 2
		ls_hierarchy += wf_ornament_as_subheader(ls_control_kinds[2])
	case else
		// kind of control has been added by wf_get_inheritance_chain
	end choose
	ls_hierarchy += ls_class_info
next
												/////////////////////
												// Display result: //
												/////////////////////
SetPointer(Arrow!)

wf_display_in_static_text(ls_hierarchy)

//// MicPaul: 2018/06/26 - Debug trace code
//if gnv_app.of_getdbenvironment() = 'DEV' then
//	gnv_app.of_displayLog(ls_hierarchy)
//	gnv_app.of_displayLog('LINE')
//end if	

return
end subroutine

private subroutine wf_show_menu () throws n_ex;/**********************************************************************************************************************
Dscr:	Displays the window menu with inheritance chain and PBL of each object.
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
string	ls_menu_info

ls_menu_info = wf_get_inheritance_chain(im)
wf_display_in_static_text(ls_menu_info)

return
end subroutine

private subroutine wf_static_text_clicked (statictext ast_clicked) throws n_ex;/**********************************************************************************************************************
Dscr:	1. Changes the clicked StaticText's text appearance so user easily sees which "button"
				has been clicked last (and, accordingly, what information is currently shown).
		2. Calls spy's functionality depending on the clicked st.
-----------------------------------------------------------------------------------------------------------------------
Arg:	ast_clicked (StaticText)
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Oct 06, 2011	Initial version
**********************************************************************************************************************/
string	ls_text
string	ls_updated_fields

constant int NORMAL = 400
constant int BOLD = 700

if ast_clicked = ist_prev_clicked /* one more click on a same st */ then
	return
end if

if IsValid(ist_prev_clicked) then
	ist_prev_clicked.BorderStyle = StyleRaised!
	ist_prev_clicked.Weight = NORMAL
	ist_prev_clicked.TextColor = COLOR__BLACK
end if

ist_prev_clicked = ast_clicked // remember that this StaticText was clicked

ast_clicked.BorderStyle = StyleLowered!
ast_clicked.Weight = BOLD
ast_clicked.TextColor = COLOR__BROWN 

ls_text = ast_clicked.Text

//////////////////
// Window frame //
//////////////////
choose case ast_clicked
case st_classes_hierarchy
	wf_show_classes_hierarchy()
case st_menu
	wf_show_menu()
case st_show_window_size_and_coordinates
	inv_util.uf_replace_all(ref ls_text, "&&", "&")
	wf_show_size_and_coordinates(iw)

//////////////////////
// DataWindow frame //
//////////////////////
case st_data_src
	wf_show_data_src()
case st_invisible_fields
	wf_show_invisible_fields()
case st_sort_expr
	wf_display_in_static_text(is_sort_expr)
case st_filter_expr
	wf_display_in_static_text(is_filter_expr)
case st_filtered_data
	wf_show_data_in_buffer(Filter!)
case st_deleted_data
	wf_show_data_in_buffer(Delete!)

///////////////
// Row frame //
///////////////
case st_field_info
	wf_show_field_info()
case st_fieldinfo2
	wf_get_all_field_info(idw)
case st_show_dddw_data
	wf_show_dddw_data()
case st_show_dw_size_and_coordinates
	inv_util.uf_replace_all(ref ls_text, "&&", "&")
	wf_show_size_and_coordinates(idw)

/////////////////
// Field frame //
/////////////////
case st_row_status
	wf_show_row_status()
case st_updated_fields
	ls_updated_fields = wf_get_updated_fields()
	wf_display_in_static_text(ls_updated_fields)

case else
	f_throw(PopulateError(0, "StaticText '" + ls_text + "' has no 'case' in 'choose case'."))
end choose

// Reflect clicked StaticText in the window's title:
this.Title = is_spy_win_title + " *** " + ls_text

return
end subroutine

private function string wf_get_retrieval_args_frag (powerobject apo) throws n_ex;/**********************************************************************************************************************
Dscr:	returns a message fragment which lists idw's retrieval arguments and their values.
-----------------------------------------------------------------------------------------------------------------------
Arg:	apo (PowerObject) - pointer to DataWindow or DataWindowChild.
-----------------------------------------------------------------------------------------------------------------------
Ret:	string - retrieval arguments ready to be displayed to user, in a multirow format like
			arg_name1 = arg_value1 (datatype1)
			arg_name2 = arg_value2 (datatype2)
			...
			arg_nameN = arg_valueN (datatypeN)
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Mar 18, 2011	Initial version
**********************************************************************************************************************/
string				ls_arg_name
string				ls_arg_val
string				ls_arg_datatype 
string				ls_retrieval_args_frag
string				ls_args_arr[]
string				ls_retrieval_args
string				ls_frag_header
int					li_args_qty
int					i
int					li_tab_pos
Object				lo_type_of_arg
DataWindow			ldw
DataWindowChild	ldwc

constant char TAB = "~t"
constant char NEW_LINE = "~n"
												// Define if apo points to DW or DWC and perform proper initial actions:
lo_type_of_arg = apo.TypeOf()
choose case lo_type_of_arg
case DataWindow!
	if not ib_dw_has_retrieval_args then return ""
	ldw = apo // cast to DataWindow
	ls_retrieval_args = ldw.Describe("DataWindow.Table.Arguments")
//	ls_frag_header = "~r~n~r~n########## Retrieval Arguments and their Values:~r~n~r~n"
	ls_frag_header = "~r~n~r~n########## Retrieval Arguments and their Values:~r~n"
case DataWindowChild!
	ldwc = apo // cast to DataWindowChild
	ls_retrieval_args = ldwc.Describe("DataWindow.Table.Arguments")
	if ls_retrieval_args = "?" /* no ret. args. */ then return ""
//	ls_frag_header = "~r~n~r~n########## DDDW's Retrieval Arguments and their Values:~r~n~r~n"
	ls_frag_header = "~r~n~r~n########## DDDW's Retrieval Arguments and their Values:~r~n"
case else
	f_throw(PopulateError(0, "Unknown type of control " + apo.ClassName()))
end choose
												// ls_retrieval_args contains now the list of the ret. args in the format,
												// returned by Describe("DataWindow.Table.Arguments"), like
												// "arg_name1[TAB]datatype1[NEW_LINE]...arg_nameN[TAB]datatypeN"
												// Convert it to array like "arg_name[TAB]datatype1" ... "arg_nameN[TAB]datatypeN":
li_args_qty = inv_util.uf_string_to_array(ls_retrieval_args, NEW_LINE, ref ls_args_arr[])
												// Process each retrieval arg:
for i = 1 to li_args_qty
	li_tab_pos = Pos(ls_args_arr[i], TAB)
	ls_arg_name = Left(ls_args_arr[i], li_tab_pos - 1)
	ls_arg_datatype = Right(ls_args_arr[i], Len(ls_args_arr[i]) - li_tab_pos)
	
	choose case lo_type_of_arg
	case DataWindow!
		ls_arg_val = ldw.Describe("Evaluate('" + ls_arg_name + "',  1) " )
	case DataWindowChild!
		ls_arg_val = ldwc.Describe("Evaluate('" + ls_arg_name + "',  1) " )
	end choose
	
	if IsNull(ls_arg_val) then
		ls_arg_val = "<NULL>"
	else
		choose case Left(ls_arg_datatype, 4)
		case "char", "stri"
			ls_arg_val = "'" + ls_arg_val + "'"
		end choose
	end if
		
	ls_arg_val = " = " + ls_arg_val
	ls_retrieval_args_frag += ls_arg_name + ls_arg_val + " (" + ls_arg_datatype + ")~r~n"	
next

return ls_frag_header + ls_retrieval_args_frag
end function

private subroutine wf_show_data_src () throws n_ex;/**********************************************************************************************************************
Dscr:	Displays the DW's Data Source (SELECT, Stored Proc or "External DW, no data source.").
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
string	ls_retrieval_args_frag
String	arg[], ls_newarg
Long		i

//ls_retrieval_args_frag = wf_get_retrieval_args_frag(idw)
ls_retrieval_args_frag = wf_get_retrieval_args_frag(idw, arg)

choose case true
case is_data_source_sql_select <> ""
	For i = 1 to UpperBound(arg)
		ls_newarg =  Rep(arg[i], ":", "@")
		is_data_source_sql_select = Rep(is_data_source_sql_select, arg[i], ls_newarg)
	Next
	wf_display_in_static_text(IIf(UpperBound(arg) = 0, "", ls_retrieval_args_frag) + is_data_source_sql_select + IIf(UpperBound(arg) = 0, "","~r~nEND~r~n"))


//	wf_display_in_static_text(is_data_source_sql_select + ls_retrieval_args_frag)
	
//	// MicPaul: 2018/06/26 - Debug trace code
//	if gnv_app.of_getdbenvironment() = 'DEV' then
//		gnv_app.of_displayLog(is_data_source_sql_select + ls_retrieval_args_frag)
//		gnv_app.of_displayLog('LINE')
//	end if	

case is_data_source_stored_proc <> ""
	wf_display_in_static_text(is_data_source_stored_proc + ls_retrieval_args_frag)

//	// MicPaul: 2018/06/26 - Debug trace code
//	if gnv_app.of_getdbenvironment() = 'DEV' then
//		gnv_app.of_displayLog(is_data_source_stored_proc + ls_retrieval_args_frag)
//		gnv_app.of_displayLog('LINE')
//	end if	
case else
	wf_display_in_static_text("DW Spy Error - Unknown data source in w_devhelp.wf_show_data_src :-(")
end choose

return
end subroutine

private function string wf_get_data_source_of_dddw_frag (datawindowchild adwc, string as_dddw_dataobject) throws n_ex;/**********************************************************************************************************************
Dscr:	Displays the DW's Data Source (SELECT, Stored Proc or 'External DW, no data source.').
-----------------------------------------------------------------------------------------------------------------------
Arg:	adwc (DataWindowChild)
		as_dddw_dataobject
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 21, 2010	Initial version
**********************************************************************************************************************/
string	ls_sql
string	ls_proc
string	ls_retrieval_args_frag
															// Prepare "Retrieval Arguments" fragment of message:

ls_retrieval_args_frag = wf_get_retrieval_args_frag(adwc)
															// If data source is SQL SELECT...
ls_sql = adwc.GetSQLSelect()
if ls_sql <> "" /* the data source is an SQL SELECT */ then
	wf_format_sql(ref ls_sql)
//	"~r~n~r~n########## DDDW's SQL Select:~r~n~r~n" + ls_sql + ls_retrieval_args_frag
	return "~r~n~r~n########## DDDW's SQL Select:~r~n" + ls_sql + ls_retrieval_args_frag
end if
															// If data source is Stored Procedure...
ls_proc = inv_util.uf_get_proc_of_dataobject(as_dddw_dataobject)
if ls_proc <> "" /* the data source is a stored proc */ then
	// "~r~n~r~n########## DDDW's Stored Procedure:~r~n~r~n" + ls_proc + ls_retrieval_args_frag
	return "~r~n~r~n########## DDDW's Stored Procedure:~r~n" + ls_proc + ls_retrieval_args_frag
end if
															// If this code reached - externoal dw:
return "~r~n~r~n########## DDDW's Data Source:~r~n~r~nExternal DW, no data source." + ls_retrieval_args_frag
end function

private function string wf_get_dddw_frag (string as_val) throws n_ex;/**********************************************************************************************************************
Dscr:	Returns to wf_show_field_info the fragment with DDDW info ("" if no DDDW)
-----------------------------------------------------------------------------------------------------------------------
Arg:	as_val - the displayed value
-----------------------------------------------------------------------------------------------------------------------
Ret:	string
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Mar 11, 2011	Initial version
**********************************************************************************************************************/
int					li_dwc_row
string				ls_data_source_of_dddw_frag
string				ls_dddw_dataobject
string				ls_pbl
string				ls_display_col
string				ls_data_col
string				ls_data_and_display_cols_msg
string				ls_search_expr
string				ls_val_of_display_col
string				ls_dddw_frag
DataWindowChild	ldwc

if not ib_field_has_dddw then return ""
																	// Initial actions - populate local vars:
ls_data_col = Upper(idw.Describe(is_field_name + ".DDDW.DataColumn"))
ls_display_col = Upper(idw.Describe(is_field_name + ".DDDW.DisplayColumn"))
ls_dddw_dataobject = idw.Describe(is_field_name + ".DDDW.Name")
ls_pbl = inv_util.uf_get_pbl_of_class(ls_dddw_dataobject)
idw.GetChild(is_field_name, ref ldwc)
ls_data_source_of_dddw_frag = wf_get_data_source_of_dddw_frag(ldwc, ls_dddw_dataobject)
																	// Define Data and Display Column and their values:
if ls_data_col = ls_display_col /* same field is used as Data Column and Display Column */ then
	ls_data_and_display_cols_msg = &
		"~r~nData/Display Column = " + ls_data_col + " (Value" + as_val + &
									", Type = " + wf_get_field_type(ldwc, ls_data_col) + ")"
else // different fields are used as Data Column and Display Column
	ls_search_expr = "String(" + ls_data_col + ") = String(" + as_val +")"
	li_dwc_row = ldwc.Find(ls_search_expr, 1, ldwc.RowCount())
	if li_dwc_row > 0 then
		
		ls_val_of_display_col = inv_util.uf_get_item_as_string(ldwc, li_dwc_row, ls_display_col)
		ls_data_and_display_cols_msg = &
			"~r~nData Column = " + ls_data_col + " (Value = " + as_val + &
										", Type = " + wf_get_field_type(ldwc, ls_data_col) + ")" + &
			"~r~nDisplay Column = " + ls_display_col + " (Value = " + ls_val_of_display_col + &
										", Type = " + wf_get_field_type(ldwc, ls_display_col) + ")"
	end if
end if
																	// Build the whole DDDW fragment of message:
ls_dddw_frag = "~r~n~r~n########## DDDW Info:" + &
					"~r~n~r~nDataObject = ~"" + ls_dddw_dataobject + "~"" + ls_pbl + &
					ls_data_and_display_cols_msg + &
					ls_data_source_of_dddw_frag

return ls_dddw_frag
end function

private subroutine wf_show_field_info () throws n_ex;/**********************************************************************************************************************
Dscr:	Displays the field info (names in DW and DB, status, type etc.)
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
boolean	lb_field_is_computed
int		i
int		li_attributes_qty
string	ls_attributes_arr[]
string	ls_attribute_val
string	ls_field_type
string	ls_field_name_in_db
string	ls_result_msg
string	ls_enabled_expr
string	ls_protect_expr
string	ls_updatable_frag
string	ls_field_status
string	ls_filter
string	ls_val
string	ls_expr

SetPointer(HourGlass!)
																	/////////////////////////////////////////////////////
																	// Get basic field info (DB name, datatype etc.): //
																	/////////////////////////////////////////////////////
ls_val = inv_util.uf_get_item_as_string(idw, il_row, is_field_name)
ls_field_type = wf_get_field_type(is_field_name)
ls_field_name_in_db = Upper(idw.Describe(is_field_name + ".DBName"))
ls_enabled_expr = idw.Describe(is_field_name + ".Enabled")
ls_protect_expr = idw.Describe(is_field_name + ".Protect")

lb_field_is_computed = not wf_property_defined(ls_field_name_in_db)
																	////////////////////////////////////////
																	// Create and display result message: //
																	////////////////////////////////////////
if lb_field_is_computed then
	ls_expr = idw.Describe(is_field_name + ".Expression")
	ls_result_msg += "########## Computed Field~r~n~r~nField Name = " + is_field_name + &
			"~r~nData Type = " + ls_field_type
else
	ls_field_status = wf_get_field_status_as_string(is_field_name)
	ls_result_msg += "Field Name = " + is_field_name
	if ls_field_name_in_db <> is_field_name then
		ls_result_msg += "~r~nDB Name = " + ls_field_name_in_db
	end if
	ls_result_msg += "~r~nData Type = " + ls_field_type + "~r~n~r~nDWItemStatus = " + ls_field_status
end if

ls_val = wf_get_val_frag(is_field_name)
ls_result_msg += "~r~nValue" + ls_val

ls_result_msg += "~r~n~r~n" + wf_get_updatable_frag(is_field_name)

if wf_property_defined(ls_enabled_expr) then
	ls_result_msg += "~r~nEnabled = '" + ls_enabled_expr + "'"
end if
	
if ls_protect_expr <> "!" and ls_protect_expr <> "0" then
	inv_util.uf_replace_all(ref ls_protect_expr, "0	", "")
	ls_result_msg += "~r~nProtect = " + ls_protect_expr
end if

if lb_field_is_computed then
//	ls_result_msg += "~r~n~r~n########## Computed Expression:~r~n~r~n" + ls_expr
	ls_result_msg += "~r~n~r~n########## Computed Expression:~r~n" + ls_expr
end if

ls_result_msg += wf_get_dddw_frag(ls_val) // returns empty string if the field doesn't have a DDDW
ls_result_msg += wf_get_code_table_frag() // returns empty string if the field doesn't have a code table

if si_instances_counter = 1 then
//	ls_result_msg += "~r~n~r~n########## Dot Notation Path:~r~n~r~n" + wf_get_field_path()
	ls_result_msg += "~r~n~r~n########## Dot Notation Path:~r~n" + wf_get_field_path()
end if

//ls_result_msg += "~r~n~r~n########## Attributes:~r~n~r~n"
ls_result_msg += "~r~n~r~n########## Attributes:~r~n"

ls_attribute_val = idw.Describe(is_field_name + ".Attributes")
li_attributes_qty = inv_util.uf_string_to_array(ls_attribute_val, "	", ref ls_attributes_arr)

for i = 1 to li_attributes_qty
	choose case ls_attributes_arr[i]
	case "attributes", "name", "dbname", "type", "update", "coltype"
		continue
	end choose
	
	ls_attribute_val = idw.Describe(is_field_name + "." + ls_attributes_arr[i])
	if not wf_property_defined(ls_attribute_val) then continue
	
	ls_result_msg += ls_attributes_arr[i] + " = " + ls_attribute_val + "~r~n"
next

SetPointer(Arrow!)
																	// Display!
wf_display_in_static_text(ls_result_msg)

return
end subroutine

private function string wf_get_field_status_as_string (string as_field_name) throws n_ex;/**********************************************************************************************************************
Dscr:	Returns the specified field's status as a string (to be displayed to the user).
-----------------------------------------------------------------------------------------------------------------------
Arg:	as_field_name
-----------------------------------------------------------------------------------------------------------------------
Ret:	string
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
DWItemStatus	l_field_status

l_field_status = idw.GetItemStatus(il_row, as_field_name, Primary!)

choose case l_field_status
case NotModified!
	return "NotModified!"
case DataModified!
	return "DataModified!"
end choose

f_throw(PopulateError(0, "Unknown DWItemStatus."))

return ""
end function

private subroutine wf_show_invisible_fields () throws n_ex;/**********************************************************************************************************************
Dscr:	Displays invisible fields info.
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
		Michael Zuskin		Dec 18, 2012	Show invisible fields SORTED
**********************************************************************************************************************/
boolean	lb_all_fields_have_same_status
boolean	lb_all_fields_have_same_updatable_frag
string	ls_dwitemstatus_of_all_fields = ""
string	ls_update_property_of_all_fields = ""
string	ls_row_info
string	ls_result_msg
string	ls_curr_field_name
string	ls_field_info
string	ls_field_info_arr[]
string	ls_field_status_arr[]
string	ls_updatable_frag_arr[]
string	ls_display_arr[]
int		li_fields_qty
int		li_all_fields_idx
int		li_prev_idx
int		li_invisible_fields_idx = 0
int		li_invisible_fields_qty

if ib_clicked_on_row then
	ls_row_info = "in Row #" + String(il_row)
end if

												//////////////////////////////////////////////////////
												// Process regular (not computed) invisible fields: //
												//////////////////////////////////////////////////////
												
												// Populate arrays of invisible columns information:
li_fields_qty = Integer(idw.Describe("DataWindow.Column.Count"))
for li_all_fields_idx = 1 to li_fields_qty
	ls_curr_field_name = Upper(idw.Describe("#"+ String(li_all_fields_idx) + ".Name"))
	if inv_util.uf_col_is_visible(idw, ls_curr_field_name) then continue
	
	li_invisible_fields_idx++
	ls_field_info_arr[li_invisible_fields_idx] = wf_get_field_info(ls_curr_field_name)
	ls_field_status_arr[li_invisible_fields_idx] = wf_get_field_status_as_string(ls_curr_field_name)
	ls_updatable_frag_arr[li_invisible_fields_idx] = wf_get_updatable_frag(ls_curr_field_name)
next
li_invisible_fields_qty = li_invisible_fields_idx
												// If the click was not on a row - display short message and exit script:
if not ib_clicked_on_row then
	for li_invisible_fields_idx = 1 to li_invisible_fields_qty
		ls_result_msg += ls_field_info_arr[li_invisible_fields_idx] + "~r~n"
	next
	ls_result_msg = Left(ls_result_msg, Len(ls_result_msg) - 2) // remove the last "~r~n"
	wf_display_in_static_text(ls_result_msg)
	return
end if
												// Define if invisible fields have same or different statuses and updatable frags:
lb_all_fields_have_same_status = true
lb_all_fields_have_same_updatable_frag = true
for li_invisible_fields_idx = 2 to li_invisible_fields_qty
	li_prev_idx = li_invisible_fields_idx - 1
	if ls_field_status_arr[li_invisible_fields_idx] <> ls_field_status_arr[li_prev_idx] then
		lb_all_fields_have_same_status = false
	end if
	if ls_updatable_frag_arr[li_invisible_fields_idx] <> ls_updatable_frag_arr[li_prev_idx] then
		lb_all_fields_have_same_updatable_frag = false
	end if
next
												// Build the result message:
if idw.RowCount() > 0 then
	ls_result_msg = "INVISIBLE FIELDS AND THEIR VALUES IN ROW #" + String(il_row)
	ls_result_msg += "~r~n" + Fill("*", Len(ls_result_msg)) + "~r~n~r~n"
end if

if lb_all_fields_have_same_status then
	ls_result_msg += "All invisible fields have DWItemStatus " + ls_field_status_arr[1] + "~r~n"
end if

if lb_all_fields_have_same_updatable_frag then
	ls_result_msg += "All invisible fields are " + ls_updatable_frag_arr[1] + "~r~n"
end if

if ls_result_msg <> "" then
	ls_result_msg += "~r~n"
end if

for li_invisible_fields_idx = 1 to li_invisible_fields_qty
	ls_display_arr[li_invisible_fields_idx] = ls_field_info_arr[li_invisible_fields_idx]
	if not lb_all_fields_have_same_status then
		ls_display_arr[li_invisible_fields_idx] += ", " + ls_field_status_arr[li_invisible_fields_idx]
	end if
	if not lb_all_fields_have_same_updatable_frag then
		ls_display_arr[li_invisible_fields_idx] += ", " + ls_updatable_frag_arr[li_invisible_fields_idx]
	end if
next

inv_util.uf_sort_array(ref ls_display_arr)

for li_invisible_fields_idx = 1 to li_invisible_fields_qty
	ls_result_msg += ls_display_arr[li_invisible_fields_idx] + "~r~n"
next

ls_result_msg = Left(ls_result_msg, Len(ls_result_msg) - 2) // remove the last "~r~n"
												// Process invisible computed fields:
ls_result_msg += wf_get_invisible_computed_fields_frag()
												// Display detailed message:
wf_display_in_static_text(ls_result_msg)

return
end subroutine

private function string wf_get_val_frag (string as_field_name) throws n_ex;/**********************************************************************************************************************
Dscr:	Returns field's CURRENT value and (if the value has been changed) the ORIGINAL value.
-----------------------------------------------------------------------------------------------------------------------
Arg:	as_field_name
-----------------------------------------------------------------------------------------------------------------------
Ret:	string
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
string	ls_orig_val
string	ls_curr_val
string	ls_val_frag

if not ib_clicked_on_row then return ''

ls_orig_val = inv_util.uf_get_item_as_string(idw, il_row, as_field_name, Primary!, true /* ab_orig_val */)
ls_curr_val = inv_util.uf_get_item_as_string(idw, il_row, as_field_name, Primary!, false /* ab_orig_val */)

if IsNull(ls_orig_val) then ls_orig_val = "NULL"
if IsNull(ls_curr_val) then ls_curr_val = "NULL"

ls_val_frag = " = " + ls_curr_val

if ls_curr_val <> ls_orig_val then
	ls_val_frag += " (Orig: " + ls_orig_val + ")"
end if

return ls_val_frag
end function

private function string wf_get_field_info (string as_field_name) throws n_ex;/**********************************************************************************************************************
Dscr:	Returns field info.
		Called from wf_show_invisible_fields in loop for each invisible field.
-----------------------------------------------------------------------------------------------------------------------
Arg:	as_field_name
-----------------------------------------------------------------------------------------------------------------------
Ret:	string
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
boolean	lb_field_is_computed
boolean	lb_expr_is_set_dynamically
boolean	lb_label_exists // true = there is a text object named as the field + "_t" AND its text is not empty string
string	ls_field_info
string	ls_computed_field_expr
string	ls_field_db_name
string	ls_field_type
string	ls_val_frag
string	ls_field_label

ls_field_type = " (" + wf_get_field_type(as_field_name) + ")"
ls_val_frag = wf_get_val_frag(as_field_name)
ls_field_db_name = Upper(idw.Describe(as_field_name + ".dbname"))
lb_field_is_computed = not wf_property_defined(ls_field_db_name)

ls_field_label = idw.Describe(as_field_name + "_t.Text")
lb_label_exists = (wf_property_defined(ls_field_label) and Trim(ls_field_label) <> '')
ls_field_label = iif(lb_label_exists, ' ("' + ls_field_label + '")', '')

if lb_field_is_computed then
	ls_computed_field_expr = idw.Describe(is_field_name + ".Expression")
	lb_expr_is_set_dynamically = not wf_property_defined(ls_computed_field_expr)
	ls_computed_field_expr = iif(lb_expr_is_set_dynamically, '', "Comp Expr = '" + ls_computed_field_expr + "'")
	ls_field_db_name = ''
else
	ls_computed_field_expr = ''
	ls_field_db_name = iif(ls_field_db_name = as_field_name, '', "DB Name = " + ls_field_db_name)
end if

if ls_field_db_name <> '' then ls_field_db_name = ", " + ls_field_db_name
if ls_computed_field_expr <> "" then ls_computed_field_expr = ", " + ls_computed_field_expr

ls_field_info = as_field_name + &
						 ls_field_label + &
						 ls_val_frag + &
						 ls_field_type + &
						 ls_field_db_name + &
						 ls_computed_field_expr

return ls_field_info
end function

private function string wf_get_invisible_computed_fields_frag () throws n_ex;/**********************************************************************************************************************
Dscr:	Builds Invisible Computed Fields message fragment.
-----------------------------------------------------------------------------------------------------------------------
Ret:	string
-----------------------------------------------------------------------------------------------------------------------
Log:	09Aug2012	Michael Zuskin		Initial version
**********************************************************************************************************************/
int		i
int		li_fields_qty
string	ls_field_names[]
string	ls_expr
string	ls_frag // the result to return

wf_get_computed_fields(idw, ref ls_field_names[], ref li_fields_qty)
for i = 1 to li_fields_qty
	if inv_util.uf_col_is_visible(idw, ls_field_names[i]) then continue
	ls_frag += "~r~n" + wf_get_field_info(ls_field_names[i])
	ls_expr = idw.Describe(ls_field_names[i] + ".Expression")
	inv_util.uf_replace_all(ref ls_expr, "~~", "")
	ls_frag += ", expression: " + ls_expr
next

if ls_frag = '' then return ''

return "~r~n~r~nInvisible Computed Fields:~r~n" + ls_frag
end function

private function string wf_get_updated_fields () throws n_ex;/**********************************************************************************************************************
Dscr:	Returns list of fields whose values have been changed.
-----------------------------------------------------------------------------------------------------------------------
Ret:	boolean
-----------------------------------------------------------------------------------------------------------------------
Log:	05aug2011		Michael Zuskin 	Created
**********************************************************************************************************************/
int		i
int		li_col_count
string	ls_col_name
string	ls_orig_val
string	ls_curr_val
string	ls_field_label
string	ls_updated_fields

if il_row = 0 then
	return ''
end if

li_col_count = Integer(idw.Describe("datawindow.column.count"))
for i = 1 to li_col_count
	ls_col_name = idw.Describe("#"+ String(i) + ".name")
	ls_orig_val = inv_util.uf_get_item_as_string(idw, il_row, ls_col_name, true)
	ls_curr_val = inv_util.uf_get_item_as_string(idw, il_row, ls_col_name, false)
	if nvl(ls_curr_val, '') = nvl(ls_orig_val, '') then continue
	ls_field_label = inv_util.uf_get_field_label(idw, ls_col_name)
	ls_col_name += " (~"" + ls_field_label + "~")"
	ls_updated_fields += ls_col_name + ': old=' + nvl(ls_orig_val, 'NULL') + ', new=' + nvl(ls_curr_val, 'NULL') + '~r~n'
next

return ls_updated_fields
end function

public subroutine of_debuglog ();// posting
if isValid(w_debugLog) then
	st_debug_log.text = 'Close Debug Log'
else
	st_debug_log.text = 'Open Debug Log'
end if
end subroutine

public subroutine of_sqlspy ();// posting
if isValid(w_sqlspy) then
	st_sql_spy.text = 'Close SQL Spy'
else
	st_sql_spy.text = 'Open SQL Spy'
end if
end subroutine

private function string wf_get_retrieval_args_frag (powerobject apo, ref string arg[]) throws n_ex;/**********************************************************************************************************************
Dscr:	returns a message fragment which lists idw's retrieval arguments and their values.
-----------------------------------------------------------------------------------------------------------------------
Arg:	apo (PowerObject) - pointer to DataWindow or DataWindowChild.
-----------------------------------------------------------------------------------------------------------------------
Ret:	string - retrieval arguments ready to be displayed to user, in a multirow format like
			arg_name1 = arg_value1 (datatype1)
			arg_name2 = arg_value2 (datatype2)
			...
			arg_nameN = arg_valueN (datatypeN)
-----------------------------------------------------------------------------------------------------------------------
Dev:	unknown		Mar 18, 2011	Initial version
**********************************************************************************************************************/
string				ls_arg_name
string				ls_arg_val
string				ls_arg_datatype 
string				ls_retrieval_args_frag
string				ls_args_arr[]
string				ls_retrieval_args
string				ls_frag_header
int					li_args_qty
int					i
int					li_tab_pos
Object				lo_type_of_arg
DataWindow			ldw
DataWindowChild	ldwc
String				ls_declare = "BEGIN~r~n"
String				ls_set

constant char TAB = "~t"
constant char NEW_LINE = "~n"
												// Define if apo points to DW or DWC and perform proper initial actions:
lo_type_of_arg = apo.TypeOf()
choose case lo_type_of_arg
case DataWindow!
	if not ib_dw_has_retrieval_args then return ""
	ldw = apo // cast to DataWindow
	ls_retrieval_args = ldw.Describe("DataWindow.Table.Arguments")
	ls_frag_header = "~r~n--########## Retrieval Arguments and their Values:~r~n~r~n"
case DataWindowChild!
	ldwc = apo // cast to DataWindowChild
	ls_retrieval_args = ldwc.Describe("DataWindow.Table.Arguments")
	if ls_retrieval_args = "?" /* no ret. args. */ then return ""
	ls_frag_header = "~r~n--########## DDDW's Retrieval Arguments and their Values:~r~n~r~n"
case else
	gf_throw(PopulateError(0, "Unknown type of control " + apo.ClassName()))
end choose
												// ls_retrieval_args contains now the list of the ret. args in the format,
												// returned by Describe("DataWindow.Table.Arguments"), like
												// "arg_name1[TAB]datatype1[NEW_LINE]...arg_nameN[TAB]datatypeN"
												// Convert it to array like "arg_name[TAB]datatype1" ... "arg_nameN[TAB]datatypeN":
li_args_qty = inv_util.uf_string_to_array(ls_retrieval_args, NEW_LINE, ref ls_args_arr[])
												// Process each retrieval arg:
for i = 1 to li_args_qty
	li_tab_pos = Pos(ls_args_arr[i], TAB)
	ls_arg_name = Left(ls_args_arr[i], li_tab_pos - 1)
	ls_arg_datatype = Right(ls_args_arr[i], Len(ls_args_arr[i]) - li_tab_pos)
	
	choose case lo_type_of_arg
	case DataWindow!
		ls_arg_val = ldw.Describe("Evaluate('" + ls_arg_name + "',  1) " )
	case DataWindowChild!
		ls_arg_val = ldwc.Describe("Evaluate('" + ls_arg_name + "',  1) " )
	end choose
	
	if IsNull(ls_arg_val) or Trim(ls_arg_val) = "" then
		ls_arg_val = "NULL"
	else
		choose case Left(ls_arg_datatype, 4)
		case "char", "stri", "date"
			ls_arg_val = "'" + ls_arg_val + "'"
		end choose
	end if
		Choose Case Lower(Left(ls_arg_datatype, 4))
			Case "numb"				; ls_arg_datatype = "Integer"
			Case "stri", "char"	; ls_arg_datatype = "VarChar(500)"
			Case	Else				; ls_arg_datatype = ls_arg_datatype
		End Choose
	arg[UpperBound(arg) + 1] = ":" + ls_arg_name
	ls_declare += "DECLARE @" + ls_arg_name + " " + ls_arg_datatype + ";~r~n"
	ls_arg_val = " = " + ls_arg_val
	ls_set += "SET @" + ls_arg_name + ls_arg_val + ";~r~n" 
next

//return ls_frag_header + ls_declare + "~r~n" +"~r~n~r~nEND~r~n*/"
Return ls_declare + "~r~n" + ls_set + "~r~n" + ls_frag_header + "~r~n"

end function

public subroutine wf_get_all_field_info (datawindow adw);String	ls_msg, ls_Obj, ls_item, ls_Type, ls_ColType, ls_child, ls_tmp
Long		ll_Loop, ll_ret
DataWindowChild dwc, ldwc
n_cst_string	icst_string

ls_msg += adw.ClassName()

ls_Obj = adw.Describe("DataWindow.Objects")

do while ls_Obj <> ""
	ls_item = icst_string.of_gettoken(ls_obj,"	")
	ls_msg += "~r~n~t" + ls_item
	ls_Type = adw.Describe(ls_item + ".type")
	ls_msg += "	" + ls_Type
	ls_ColType = adw.Describe(ls_item + ".coltype")
	ls_msg += IIf(ls_ColType <> "!", "	" + ls_ColType, "")
	Choose Case ls_Type
		Case "column"
			ll_ret = adw.GetChild(ls_Item, dwc)
			If ll_ret = 1 Then
				ls_child = adw.Describe(ls_Item + ".dddw.name")
				ls_msg += "	DDDW	" + ls_child + "~r~n"
				ls_child = adw.Describe(ls_Item + ".dddw.DataColumn")
				ls_msg += "~t" + ls_item + "	DataColumn	" + ls_child + "~r~n"
				ls_child = adw.Describe(ls_Item + ".dddw.DisplayColumn")
				ls_msg += "~t" + ls_item + "	DisplayColumn	" + ls_child
			End If
		Case "text"
			ls_tmp = adw.Describe( ls_item + ".Text")
			ls_msg += "	" + ls_tmp
		Case "groupbox"
			ls_tmp = adw.Describe( ls_item + ".Text")
			ls_msg += "	" + ls_tmp
		Case "checkbox"
			ls_tmp = adw.Describe( ls_item + ".values")
			ls_msg += "	" + ls_tmp
	End Choose
loop

mle_display.Text = ls_msg
dw_display.DataObject = "d_devhelp_dwinfo"
dw_display.ImportString(ls_msg)
wf_display_dw()
cb_copy_to_clipboard.Enabled = True


end subroutine

on w_devhelp.create
this.sle_gs_appdata=create sle_gs_appdata
this.st_gs_appdata=create st_gs_appdata
this.st_fieldinfo2=create st_fieldinfo2
this.cb_eval2=create cb_eval2
this.cb_eval1=create cb_eval1
this.cb_stop_profiler=create cb_stop_profiler
this.cb_start_profiler=create cb_start_profiler
this.cb_print=create cb_print
this.st_disable_bind=create st_disable_bind
this.cb_saveas=create cb_saveas
this.sle_evaluate_result=create sle_evaluate_result
this.sle_evaluate=create sle_evaluate
this.st_dw_readonly=create st_dw_readonly
this.st_readonly=create st_readonly
this.st_updatetable=create st_updatetable
this.st_2=create st_2
this.st_1=create st_1
this.sle_file_name=create sle_file_name
this.sle_block_name=create sle_block_name
this.cb_stop=create cb_stop
this.cb_start=create cb_start
this.sle_trace_filename=create sle_trace_filename
this.st_filename=create st_filename
this.st_directory=create st_directory
this.sle_trace_directory=create sle_trace_directory
this.st_debug_log=create st_debug_log
this.st_sql_spy=create st_sql_spy
this.st_dw_props=create st_dw_props
this.st_show_dw_size_and_coordinates=create st_show_dw_size_and_coordinates
this.st_deleted_data=create st_deleted_data
this.st_show_window_size_and_coordinates=create st_show_window_size_and_coordinates
this.st_filtered_data=create st_filtered_data
this.st_updated_fields=create st_updated_fields
this.st_row_status=create st_row_status
this.st_field_info=create st_field_info
this.st_show_dddw_data=create st_show_dddw_data
this.st_sort_expr=create st_sort_expr
this.st_filter_expr=create st_filter_expr
this.st_invisible_fields=create st_invisible_fields
this.st_data_src=create st_data_src
this.st_menu=create st_menu
this.st_classes_hierarchy=create st_classes_hierarchy
this.cb_copy_to_clipboard=create cb_copy_to_clipboard
this.cb_close=create cb_close
this.gb_window=create gb_window
this.gb_tracing=create gb_tracing
this.gb_clicked_row=create gb_clicked_row
this.dw_display=create dw_display
this.gb_clicked_field=create gb_clicked_field
this.gb_pfc_services=create gb_pfc_services
this.dw_data=create dw_data
this.mle_display=create mle_display
this.dw_messages_lang_lkp=create dw_messages_lang_lkp
this.tab_preview=create tab_preview
this.dw_messages_lkp=create dw_messages_lkp
this.gb_datawindow2=create gb_datawindow2
this.gb_1=create gb_1
this.Control[]={this.sle_gs_appdata,&
this.st_gs_appdata,&
this.st_fieldinfo2,&
this.cb_eval2,&
this.cb_eval1,&
this.cb_stop_profiler,&
this.cb_start_profiler,&
this.cb_print,&
this.st_disable_bind,&
this.cb_saveas,&
this.sle_evaluate_result,&
this.sle_evaluate,&
this.st_dw_readonly,&
this.st_readonly,&
this.st_updatetable,&
this.st_2,&
this.st_1,&
this.sle_file_name,&
this.sle_block_name,&
this.cb_stop,&
this.cb_start,&
this.sle_trace_filename,&
this.st_filename,&
this.st_directory,&
this.sle_trace_directory,&
this.st_debug_log,&
this.st_sql_spy,&
this.st_dw_props,&
this.st_show_dw_size_and_coordinates,&
this.st_deleted_data,&
this.st_show_window_size_and_coordinates,&
this.st_filtered_data,&
this.st_updated_fields,&
this.st_row_status,&
this.st_field_info,&
this.st_show_dddw_data,&
this.st_sort_expr,&
this.st_filter_expr,&
this.st_invisible_fields,&
this.st_data_src,&
this.st_menu,&
this.st_classes_hierarchy,&
this.cb_copy_to_clipboard,&
this.cb_close,&
this.gb_window,&
this.gb_tracing,&
this.gb_clicked_row,&
this.dw_display,&
this.gb_clicked_field,&
this.gb_pfc_services,&
this.dw_data,&
this.mle_display,&
this.dw_messages_lang_lkp,&
this.tab_preview,&
this.dw_messages_lkp,&
this.gb_datawindow2,&
this.gb_1}
end on

on w_devhelp.destroy
destroy(this.sle_gs_appdata)
destroy(this.st_gs_appdata)
destroy(this.st_fieldinfo2)
destroy(this.cb_eval2)
destroy(this.cb_eval1)
destroy(this.cb_stop_profiler)
destroy(this.cb_start_profiler)
destroy(this.cb_print)
destroy(this.st_disable_bind)
destroy(this.cb_saveas)
destroy(this.sle_evaluate_result)
destroy(this.sle_evaluate)
destroy(this.st_dw_readonly)
destroy(this.st_readonly)
destroy(this.st_updatetable)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_file_name)
destroy(this.sle_block_name)
destroy(this.cb_stop)
destroy(this.cb_start)
destroy(this.sle_trace_filename)
destroy(this.st_filename)
destroy(this.st_directory)
destroy(this.sle_trace_directory)
destroy(this.st_debug_log)
destroy(this.st_sql_spy)
destroy(this.st_dw_props)
destroy(this.st_show_dw_size_and_coordinates)
destroy(this.st_deleted_data)
destroy(this.st_show_window_size_and_coordinates)
destroy(this.st_filtered_data)
destroy(this.st_updated_fields)
destroy(this.st_row_status)
destroy(this.st_field_info)
destroy(this.st_show_dddw_data)
destroy(this.st_sort_expr)
destroy(this.st_filter_expr)
destroy(this.st_invisible_fields)
destroy(this.st_data_src)
destroy(this.st_menu)
destroy(this.st_classes_hierarchy)
destroy(this.cb_copy_to_clipboard)
destroy(this.cb_close)
destroy(this.gb_window)
destroy(this.gb_tracing)
destroy(this.gb_clicked_row)
destroy(this.dw_display)
destroy(this.gb_clicked_field)
destroy(this.gb_pfc_services)
destroy(this.dw_data)
destroy(this.mle_display)
destroy(this.dw_messages_lang_lkp)
destroy(this.tab_preview)
destroy(this.dw_messages_lkp)
destroy(this.gb_datawindow2)
destroy(this.gb_1)
end on

event open;/**********************************************************************************************************************
Dscr:	Accepts window and fires windows initialization.

		//====================================================================================
		// EXAMPLE OF RBUTTONDOWN EVENT'S SCRIPT WHICH OPENS THE SPY AND PASSES THE PARAMETER:
		//====================================================================================
		
		//------------------------ Open DW Spy ------------------------ BEGIN
		n_parm	lnv_parm
		
		if KeyDown(KeyAlt!) and KeyDown(KeyF1!) then
			if Handle(GetApplication()) = 0 /* running from PB, NOT as a standalone executable */ then
				lnv_parm.uf_set(w_devhelp.PARM_NAME__DW, iuo_dw)
				lnv_parm.uf_set(w_devhelp.PARM_NAME__ROW, row)
				lnv_parm.uf_set(w_devhelp.PARM_NAME__COL, dwo.name)
				OpenWithParm(w_devhelp, lnv_parm)
			end if
		end if
		//------------------------ Open DW Spy ------------------------ END
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
n_parm	lnv_parm
lnv_parm = Message.PowerObjectParm
string	ls_find
long		ll_foundRow
integer li_cr


if lnv_parm.uf_get_msgid() <> '' then
	tab_preview.tabpage_dw_spy.enabled =FALSE
	tab_preview.tabpage_data.enabled =FALSE
//	tab_preview.tabpage_dw_display.enabled =FALSE

//	dw_display.visible = false
//	dw_data.visible = false
//	mle_display.visible = false
//	dw_messages_lkp.visible = true
//	dw_messages_lang_lkp.visible = true
//	
//	dw_messages_lkp.retrieve()
//	dw_messages_lkp.of_SetSort(True)
//	dw_messages_lkp.inv_sort.of_SetStyle(3) //Drop down list box style
//	dw_messages_lkp.inv_sort.of_SetColumnNameSource(2)
//	dw_messages_lkp.inv_sort.of_SetUseDisplay(True)
//	dw_messages_lkp.inv_sort.of_SetVisibleOnly(True) // Set the sort to use visible columns only
//	dw_messages_lkp.inv_sort.of_SetColumnHeader(TRUE)
//	
//	//Enable Row Selection
//	//dw_messages_lkp.of_SetRowSelect(True)
//	//dw_messages_lkp.inv_rowselect.of_SetStyle(0)  // Set the style to allow single row selection only
//	dw_messages_lkp.setrowfocusindicator(hand!)
	tab_preview.selectedTab =4
	ls_find = "msgid='" + lower(trim(lnv_parm.uf_get_msgid())) + "'"
	ll_foundRow =dw_messages_lkp.find( ls_find, 1, 9999 )
	if ll_foundRow > 0 then
//		dw_messages_lkp.setrow(ll_foundRow)
		li_cr =dw_messages_lkp.scrolltorow(ll_foundRow)
	end if
	
else

	try
		
		si_instances_counter++
		idw = lnv_parm.uf_get(PARM_NAME__DW)
		
		st_updatetable.text = idw.Object.DataWindow.Table.UpdateTable
		st_dw_readonly.text = idw.Object.DataWindow.ReadOnly
		
		il_row = lnv_parm.uf_get(PARM_NAME__ROW)
		is_field_name = lnv_parm.uf_get(PARM_NAME__COL)
		
		this.Height = cb_close.Y + cb_close.Height + 185 //125
		this.Width = cb_close.X + cb_close.Width + 60
		
		wf_init_instance_vars() // populate the rest of instance variables
		wf_init_visual_appearance() // enable/set text of command buttons and window title
	catch(n_ex e)
		e.uf_msg()
	end try
	
	try
		this.wf_static_text_clicked(st_classes_hierarchy)
	catch(n_ex ee)
		e.uf_msg()
	end try

end if

this.of_debugLog()

if isvalid(w_sqlspy) then
	messagebox('isvalid(w_sqlspy)','')
end if

return
end event

event close;si_instances_counter --
end event

type sle_gs_appdata from singlelineedit within w_devhelp
integer x = 1179
integer y = 36
integer width = 2245
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event constructor;this.text = gs_appdata
end event

type st_gs_appdata from statictext within w_devhelp
integer x = 891
integer y = 48
integer width = 293
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "gs_AppData :"
boolean focusrectangle = false
end type

type st_fieldinfo2 from statictext within w_devhelp
integer x = 4421
integer y = 1980
integer width = 608
integer height = 96
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Field Info 2"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;try
	parent.wf_static_text_clicked(this)
catch(n_ex e)
	e.uf_msg()
end try

return

end event

type cb_eval2 from commandbutton within w_devhelp
integer x = 3794
integer y = 2948
integer width = 110
integer height = 88
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Go"
end type

event clicked;string ls_evalExp, ls_descString

//ls_evalExp ='Evaluate("' + sle_evaluate.text + '",' + string(idw.getrow()) + ')'	 
// Fetch the background color
sle_evaluate_result.text = idw.Describe(sle_evaluate.text)

//sle_evaluate_result.backcolor = long(sle_evaluate_result.text)
end event

type cb_eval1 from commandbutton within w_devhelp
integer x = 3794
integer y = 2756
integer width = 110
integer height = 88
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Go"
end type

event clicked;string ls_evalExp, ls_descString

ls_evalExp ='Evaluate("' + sle_evaluate.text + '",' + string(idw.getrow()) + ')'	 
// Fetch the background color
sle_evaluate_result.text = idw.Describe(ls_evalExp)


sle_evaluate_result.backcolor = long(sle_evaluate_result.text)
end event

type cb_stop_profiler from commandbutton within w_devhelp
boolean visible = false
integer x = 471
integer y = 28
integer width = 402
integer height = 104
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stop Profiler"
end type

event clicked;//invo_profiler.of_Stop()
//f_EndTrace()
end event

type cb_start_profiler from commandbutton within w_devhelp
boolean visible = false
integer x = 46
integer y = 28
integer width = 402
integer height = 104
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Start Profiler"
end type

event clicked;//if not isValid(invo_profiler) then
//	invo_profiler = CREATE n_Profiler
//end if
//
//invo_profiler.of_Register(Parent, 0)
//invo_profiler.of_Start()
end event

type cb_print from commandbutton within w_devhelp
integer x = 3429
integer y = 28
integer width = 256
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Print"
end type

event clicked;if	dw_display.visible then dw_display.print()
//if	dw_data.visible then dw_data.print()
//if mle_display.visible then mle_display.print()

//if dw_messages_lkp.visible then dw_message_lkp.print()
//		dw_messages_lang_lkp.visible = false

end event

type st_disable_bind from statictext within w_devhelp
integer x = 4475
integer y = 2412
integer width = 553
integer height = 100
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Disable Bind"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;//if gnv_app.of_getdbenvironment() = 'DEV' then
	sqlca.dbparm = 'DisableBind=1'
//end if
end event

type cb_saveas from commandbutton within w_devhelp
boolean visible = false
integer x = 3296
integer y = 168
integer width = 398
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Save As"
end type

event clicked;dw_data.saveAs("c:\_frms\Unit Test C76 - 2019\data", xlsx!,false)	
end event

type sle_evaluate_result from singlelineedit within w_devhelp
integer x = 3918
integer y = 2756
integer width = 1147
integer height = 172
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_evaluate from singlelineedit within w_devhelp
integer x = 3918
integer y = 2948
integer width = 1147
integer height = 172
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_dw_readonly from statictext within w_devhelp
integer x = 4169
integer y = 652
integer width = 859
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_readonly from statictext within w_devhelp
integer x = 3794
integer y = 652
integer width = 379
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "ReadOnly: "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_updatetable from statictext within w_devhelp
integer x = 4169
integer y = 556
integer width = 859
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_2 from statictext within w_devhelp
integer x = 3794
integer y = 560
integer width = 379
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "UpdateTable: "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_devhelp
string tag = "Start Tag:"
boolean visible = false
integer x = 3831
integer y = 3060
integer width = 402
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Block name:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_file_name from singlelineedit within w_devhelp
boolean visible = false
integer x = 4265
integer y = 2972
integer width = 763
integer height = 72
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event constructor;string ls_today_time
ls_today_time = string(today(),'yyyy/mm/dd') // + string(time()), 'hh:mm:ss')
this.text = 'Tracing : ' + ls_today_time
end event

type sle_block_name from singlelineedit within w_devhelp
boolean visible = false
integer x = 4265
integer y = 3060
integer width = 763
integer height = 72
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
boolean border = false
end type

type cb_stop from commandbutton within w_devhelp
boolean visible = false
integer x = 4439
integer y = 2760
integer width = 590
integer height = 96
integer taborder = 60
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stop"
end type

event clicked;TraceEnd()
TraceClose()


end event

type cb_start from commandbutton within w_devhelp
boolean visible = false
integer x = 3794
integer y = 2760
integer width = 590
integer height = 96
integer taborder = 60
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Start"
end type

event clicked;ErrorReturn le_err
integer li_key
TimerKind ltk_kind


//CHOOSE CASE ddlb_timerkind.Text
//   CASE "None"
//      ltk_kind = TimerNone!
//   CASE "Clock"
//      ltk_kind = Clock!
//   CASE "Process"
      ltk_kind = Process!
//   CASE "Thread"
//      ltk_kind = Thread!
//END CHOOSE

// Open the trace file and return an error message
// if the open fails
le_err = TraceOpen( sle_trace_directory.Text + '\' + sle_trace_filename.text, ltk_kind )
IF le_err <> Success! THEN 
   //of_errmsg(le_err, 'TraceOpen failed')
   messagebox('TraceOpen', 'failed')
   RETURN
END IF

// Enable trace activities. Enabling ActLine!
// enables ActRoutine! implicitly
TraceEnableActivity(ActESQL!)
TraceEnableActivity(ActUser!)
TraceEnableActivity(ActError!)
TraceEnableActivity(ActLine!)
TraceEnableActivity(ActObjectCreate!)
TraceEnableActivity(ActObjectDestroy!)
TraceEnableActivity(ActGarbageCollect!)

TraceBegin(sle_block_name.text)
// first block of code to be traced
// this block has the label Trace_block_1








end event

type sle_trace_filename from singlelineedit within w_devhelp
boolean visible = false
integer x = 4265
integer y = 2972
integer width = 763
integer height = 72
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "TraceTemp"
borderstyle borderstyle = stylelowered!
end type

type st_filename from statictext within w_devhelp
boolean visible = false
integer x = 3781
integer y = 2972
integer width = 453
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "File/block name:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_directory from statictext within w_devhelp
boolean visible = false
integer x = 3781
integer y = 2884
integer width = 274
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Directory:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_trace_directory from singlelineedit within w_devhelp
boolean visible = false
integer x = 4073
integer y = 2880
integer width = 951
integer height = 72
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "C:\Users\Public\Documents\trace"
borderstyle borderstyle = stylelowered!
end type

type st_debug_log from statictext within w_devhelp
integer x = 3794
integer y = 2524
integer width = 1234
integer height = 96
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Open Debug Log"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;if not isValid(gnv_app.inv_debug) then
	gnv_app.of_setDebug(true)
	gnv_app.inv_debug.of_setalwaysontop( true )
end if	
	
if st_debug_log.text = 'Close Debug Log' then
	close (w_debugLog)
else
	gnv_app.inv_debug.of_openLog(TRUE)
end if

parent.of_DebugLog()

// Example
// gnv_app.inv_debug.of_message("Show this in the debug log")
end event

type st_sql_spy from statictext within w_devhelp
integer x = 3794
integer y = 2412
integer width = 645
integer height = 96
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Open SQL Spy"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;sqlca.dbparm = sqlca.dbparm + 'DisableBind=1' 
if not isValid(gnv_app.inv_debug) then
	gnv_app.of_setDebug(true)
	gnv_app.inv_debug.of_setalwaysontop( true )
end if	

if st_sql_spy.text = 'Close SQL Spy' then
	st_sql_spy.text = 'Open SQL Spy'
	gnv_app.inv_debug.inv_sqlspy.of_opensqlspy(FALSE)
//	close (w_sqlspy)
else
	st_sql_spy.text = 'Close SQL Spy'
	gnv_app.inv_debug.of_setSQLSpy(TRUE)
	gnv_app.inv_debug.inv_sqlspy.of_opensqlspy(TRUE)
	
	//gnv_app.inv_debug.inv_sqlspy.iw_sqlspy.of_getwidth() = 3822
	//gnv_app.inv_debug.inv_sqlspy.iw_sqlspy.height= 2456
	
	sqlca.dbparm = 'DisableBind=1'
end if

//parent.post of_SQLSpy()


//if not isValid(gnv_app.inv_debug) then
//	gnv_app.of_setDebug(true)
//end if	
//
//if not IsValid(gnv_app.inv_debug.inv_sqlspy) then
//	gnv_app.inv_debug.of_setSQLSpy(TRUE)
//end if
//
//gnv_app.inv_debug.inv_sqlspy.of_opensqlspy(TRUE)

//gnv_app.inv_debug.inv_sqlspy.of_setlogfile(“c:\wip\temp\sqlspy.log”)

end event

type st_dw_props from statictext within w_devhelp
integer x = 3794
integer y = 2300
integer width = 1234
integer height = 96
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "DataWindow Properties"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;integer li_rc
if not isValid(gnv_app.inv_debug) then
	gnv_app.of_setDebug(true)
	gnv_app.inv_debug.of_setalwaysontop( true )
end if	

If IsValid(gnv_app.inv_debug) Then
	
	If not gnv_app.inv_debug.of_IsDWProperty()  Then
		// Since it is on, turn it off.
			li_rc =gnv_app.inv_debug.of_SetDWProperty (TRUE)
			idw.event dynamic pfc_debug()
			Return
		else
			li_rc =gnv_app.inv_debug.of_SetDWProperty (FALSE)
	End If

end if
//
//// Since it is not already on, turn it on.
//gnv_app.of_SetDebug(True)
//li_rc =gnv_app.inv_debug.of_SetDWProperty (True)
//gnv_app.inv_debug.of_openLog (True)



end event

type st_show_dw_size_and_coordinates from statictext within w_devhelp
integer x = 3794
integer y = 1420
integer width = 1234
integer height = 96
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Size && Coordinates"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;try
	ib_iswin = FALSE
	parent.wf_static_text_clicked(this)
catch(n_ex e)
	e.uf_msg()
end try

return
end event

type st_deleted_data from statictext within w_devhelp
integer x = 3794
integer y = 1308
integer width = 1234
integer height = 96
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_show_window_size_and_coordinates from statictext within w_devhelp
integer x = 3794
integer y = 324
integer width = 1234
integer height = 96
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Size && Coordinates"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;try
	ib_iswin = TRUE
	parent.wf_static_text_clicked(this)
catch(n_ex e)
	e.uf_msg()
end try

return
end event

type st_filtered_data from statictext within w_devhelp
integer x = 3794
integer y = 1196
integer width = 1234
integer height = 96
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;try
	parent.wf_static_text_clicked(this)
catch(n_ex e)
	e.uf_msg()
end try

return
end event

type st_updated_fields from statictext within w_devhelp
integer x = 3794
integer y = 1756
integer width = 1234
integer height = 96
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Updated Fields"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;try
	parent.wf_static_text_clicked(this)
catch(n_ex e)
	e.uf_msg()
end try

return
end event

type st_row_status from statictext within w_devhelp
integer x = 3794
integer y = 1648
integer width = 1234
integer height = 96
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Row Status"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;try
	parent.wf_static_text_clicked(this)
catch(n_ex e)
	e.uf_msg()
end try

return
end event

type st_field_info from statictext within w_devhelp
integer x = 3794
integer y = 1980
integer width = 608
integer height = 96
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Field Info"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;try
	parent.wf_static_text_clicked(this)
catch(n_ex e)
	e.uf_msg()
end try

return
end event

type st_show_dddw_data from statictext within w_devhelp
integer x = 3794
integer y = 2084
integer width = 1234
integer height = 96
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "DDDW~'s Data"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;try
	parent.wf_static_text_clicked(this)
catch(n_ex e)
	e.uf_msg()
end try

return
end event

type st_sort_expr from statictext within w_devhelp
integer x = 3794
integer y = 972
integer width = 1234
integer height = 96
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Sort Expression"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;try
	parent.wf_static_text_clicked(this)
catch(n_ex e)
	e.uf_msg()
end try

return
end event

type st_filter_expr from statictext within w_devhelp
integer x = 3794
integer y = 1084
integer width = 1234
integer height = 96
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Filter Expression"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;try
	parent.wf_static_text_clicked(this)
catch(n_ex e)
	e.uf_msg()
end try

return
end event

type st_invisible_fields from statictext within w_devhelp
integer x = 3794
integer y = 860
integer width = 1234
integer height = 96
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Invisible Fields"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;try
	parent.wf_static_text_clicked(this)
catch(n_ex e)
	e.uf_msg()
end try

return
end event

type st_data_src from statictext within w_devhelp
integer x = 3794
integer y = 748
integer width = 1234
integer height = 96
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Data Source"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;try
	parent.wf_static_text_clicked(this)
catch(n_ex e)
	e.uf_msg()
end try

return
end event

type st_menu from statictext within w_devhelp
integer x = 3794
integer y = 216
integer width = 1234
integer height = 96
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Window~'s Menu"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;try
	parent.wf_static_text_clicked(this)
catch(n_ex e)
	e.uf_msg()
end try

return
end event

type st_classes_hierarchy from statictext within w_devhelp
integer x = 3794
integer y = 108
integer width = 1234
integer height = 96
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "On-Window Hierarchy"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;try
	parent.wf_static_text_clicked(this)
catch(n_ex e)
	e.uf_msg()
end try

return
end event

type cb_copy_to_clipboard from commandbutton within w_devhelp
integer x = 3744
integer y = 3180
integer width = 795
integer height = 112
integer taborder = 10
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "<< Copy to Clipboard"
end type

event clicked;Clipboard(mle_display.Text)
end event

type cb_close from commandbutton within w_devhelp
integer x = 4658
integer y = 3180
integer width = 425
integer height = 112
integer taborder = 20
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close Spy"
end type

event clicked;close(parent)
end event

type gb_window from groupbox within w_devhelp
integer x = 3744
integer y = 32
integer width = 1339
integer height = 432
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Window"
end type

type gb_tracing from groupbox within w_devhelp
boolean visible = false
integer x = 3744
integer y = 2672
integer width = 1339
integer height = 480
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Tracing"
end type

type gb_clicked_row from groupbox within w_devhelp
integer x = 3744
integer y = 1584
integer width = 1339
integer height = 312
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Row"
end type

type dw_display from datawindow within w_devhelp
integer x = 32
integer y = 168
integer width = 3662
integer height = 3068
integer taborder = 30
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rbuttondown;n_parm	lnv_parm
w_devhelp		lw_one_more_spy

if KeyDown(KeyAlt!) and KeyDown(KeyF1!) then
	lnv_parm.uf_set(PARM_NAME__DW, this)
	lnv_parm.uf_set(PARM_NAME__ROW, row)
	lnv_parm.uf_set(PARM_NAME__COL, dwo.name)
	OpenWithParm(lw_one_more_spy, lnv_parm)
end if

return
end event

event clicked;parent.wf_sort_dw_display_by_column(dwo.name)
end event

type gb_clicked_field from groupbox within w_devhelp
integer x = 3744
integer y = 1908
integer width = 1339
integer height = 304
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Field"
end type

type gb_pfc_services from groupbox within w_devhelp
integer x = 3744
integer y = 2680
integer width = 1339
integer height = 468
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Evaluate"
end type

type dw_data from datawindow within w_devhelp
integer x = 32
integer y = 168
integer width = 3662
integer height = 3068
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rbuttondown;n_parm	lnv_parm
w_devhelp		lw_one_more_spy

if KeyDown(KeyAlt!) and KeyDown(KeyF1!) then
	lnv_parm.uf_set(PARM_NAME__DW, this)
	lnv_parm.uf_set(PARM_NAME__ROW, row)
	lnv_parm.uf_set(PARM_NAME__COL, dwo.name)
	OpenWithParm(lw_one_more_spy, lnv_parm)
end if

return
end event

type mle_display from multilineedit within w_devhelp
integer x = 32
integer y = 168
integer width = 3662
integer height = 3064
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Consolas"
long backcolor = 553648127
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_messages_lang_lkp from u_dw within w_devhelp
integer x = 32
integer y = 2716
integer width = 3662
integer height = 540
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_messages_lang_lkp"
end type

event constructor;call super::constructor;this.settransobject(sqlca)
end event

event buttonclicked;call super::buttonclicked;// MicPaul 2019/07/28

choose case dwo.name
	case 'b_view'
		gnv_app.inv_error.of_message(this.getitemstring(this.getrow(), 'msgid'))
end choose



end event

type tab_preview from tab within w_devhelp
integer x = 32
integer y = 16
integer width = 837
integer height = 148
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_dw_spy tabpage_dw_spy
tabpage_data tabpage_data
tabpage_messages tabpage_messages
end type

on tab_preview.create
this.tabpage_dw_spy=create tabpage_dw_spy
this.tabpage_data=create tabpage_data
this.tabpage_messages=create tabpage_messages
this.Control[]={this.tabpage_dw_spy,&
this.tabpage_data,&
this.tabpage_messages}
end on

on tab_preview.destroy
destroy(this.tabpage_dw_spy)
destroy(this.tabpage_data)
destroy(this.tabpage_messages)
end on

event selectionchanged;//string	ls_select
string	ls_where
string	ls_dwsyntax
string	ls_err

integer	li_pos
string	ls_winName, ls_form_id

choose case newindex
	case 1
//		dw_display.visible = false
		dw_data.visible = false
		mle_display.visible = true
		dw_messages_lkp.visible = false
		dw_messages_lang_lkp.visible = false
		cb_saveas.visible = false
		cb_print.visible = false
	case 2
//		dw_display.visible = false
		dw_data.visible = true
		mle_display.visible = false
		dw_messages_lkp.visible = false
		dw_messages_lang_lkp.visible = false
		
		dw_data.dataobject = idw.dataobject
		
		idw.sharedata(dw_data)
		
//		dw_data.SetTransObject ( SQLCA )
//		dw_data.Retrieve()
		
		cb_saveas.visible = false
		cb_print.visible = false
		
//	case 3
//		dw_display.visible = true
//		dw_data.visible = false
//		mle_display.visible = false
//		dw_messages_lkp.visible = false
//		dw_messages_lang_lkp.visible = false
//		
//		ls_winName =iw.classname()
//		li_pos =pos(ls_winName, '_part')
//		
//		if li_pos > 0 then
//			ls_winName = mid (ls_winName, 4)
//		end if
//		
//		li_pos = pos(ls_winName, '_part')
//		if li_pos > 0 then
//			is_form_id = mid (ls_winName, 1, (li_pos - 1) )
//		end if
//		dw_display.dataobject ="d_fr_form_field_def_efr"
//		dw_display.settransobject(sqlca)
//		dw_display.retrieve(is_form_id)
//		cb_saveas.visible = false
//		cb_print.visible = true

	case 3
//		dw_display.visible = false
		dw_data.visible = false
		mle_display.visible = false
		dw_messages_lkp.visible = true
		dw_messages_lang_lkp.visible = true
		
		if dw_messages_lkp.rowcount() =0 then
			dw_messages_lkp.retrieve()
			dw_messages_lkp.of_SetSort(True)
			dw_messages_lkp.inv_sort.of_SetStyle(3) //Drop down list box style
			dw_messages_lkp.inv_sort.of_SetColumnNameSource(2)
			dw_messages_lkp.inv_sort.of_SetUseDisplay(True)
			dw_messages_lkp.inv_sort.of_SetVisibleOnly(True) // Set the sort to use visible columns only
			dw_messages_lkp.inv_sort.of_SetColumnHeader(TRUE)
	
			dw_messages_lkp.of_setUpdateable(TRUE)
			dw_messages_lkp.of_setFilter(true)
			dw_messages_lkp.of_setRowManager(true)	
			dw_messages_lkp.setrowfocusindicator(hand!)
			cb_saveas.visible = false
			cb_print.visible = false

		end if

end choose

end event

type tabpage_dw_spy from userobject within tab_preview
integer x = 18
integer y = 112
integer width = 800
integer height = 20
long backcolor = 67108864
string text = "DWSpy"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type tabpage_data from userobject within tab_preview
integer x = 18
integer y = 112
integer width = 800
integer height = 20
long backcolor = 67108864
string text = "Data"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type tabpage_messages from userobject within tab_preview
integer x = 18
integer y = 112
integer width = 800
integer height = 20
long backcolor = 67108864
string text = "Messages"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type dw_messages_lkp from u_dw within w_devhelp
integer x = 32
integer y = 164
integer width = 3662
integer height = 2544
integer taborder = 40
string dataobject = "d_messages_lkp"
end type

event constructor;call super::constructor;this.settransobject(sqlca)

end event

event rowfocuschanged;call super::rowfocuschanged;dw_messages_lang_lkp.retrieve( this.getitemstring(this.getrow(), 'msgid'))
end event

type gb_datawindow2 from groupbox within w_devhelp
integer x = 3744
integer y = 480
integer width = 1339
integer height = 1088
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Datawindow"
end type

type gb_1 from groupbox within w_devhelp
integer x = 3744
integer y = 2228
integer width = 1339
integer height = 432
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "PFC Services"
end type

