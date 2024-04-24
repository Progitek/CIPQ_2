$PBExportHeader$n_dwspy_util.sru
forward
global type n_dwspy_util from nonvisualobject
end type
end forward

global type n_dwspy_util from nonvisualobject autoinstantiate
end type

type variables
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This NVO contains utility methods called from w_spy - see http://forum.powerbuilder.us/viewtopic.php?f=4&t=2
// Licence: No licence needed, this utility is absolutely free
// Developer: Michael Zuskin (LinkedIn: http://ca.linkedin.com/in/zuskin)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
end variables

forward prototypes
public function long uf_string_to_array (string as_input_string, string as_delimiter, ref string rs_arr[])
public subroutine uf_replace_all (ref string rs_processed_string, string as_old_frag, string as_new_frag)
public function boolean uf_populated (any aa_val)
public function string uf_get_pb_version ()
public function long uf_sort_array (ref long rl_arr[])
public function datastore uf_ds_from_array (string as_arr[])
public function datastore uf_ds_from_array (long al_arr[])
public function long uf_sort_array (ref string rs_arr[])
public function window uf_get_window (powerobject apo_obj)
public function string uf_get_field_label (datawindow adw, string as_field_name)
public function boolean uf_empty (any aa_val)
public function long uf_row_count (datawindow adw, dwbuffer a_buf)
public function boolean uf_col_exists (datawindow adw, string as_col)
public function string uf_get_pbl_of_class (string as_class_name)
public function string uf_get_proc_of_dataobject (string as_dataobject)
public function boolean uf_col_is_visible (datawindow adw, string as_col_name)
public function string uf_get_item_as_string (datawindow adw, long al_row, string as_field_name, dwbuffer a_buf, boolean ab_orig_val) throws n_ex
public function string uf_get_item_as_string (datawindow adw, long al_row, string as_field_name, dwbuffer a_buf) throws n_ex
public function string uf_get_item_as_string (datawindowchild adwc, integer ai_dwc_row, string as_dwc_field_name, dwbuffer a_buf, boolean ab_orig_val) throws n_ex
public function string uf_get_item_as_string (datawindow adw, long al_row, string as_field_name) throws n_ex
public function string uf_get_item_as_string (datawindow adw, long al_row, string as_field_name, boolean ab_orig_val) throws n_ex
public function string uf_get_item_as_string (datawindowchild adwc, integer ai_dwc_row, string as_dwc_field_name) throws n_ex
public function boolean uf_col_modified (datawindow adw, string as_col, long al_row, dwbuffer a_buf) throws n_ex
public function boolean uf_row_modified (datawindow adw, long al_row, dwbuffer a_buf) throws n_ex
public function boolean uf_row_modified (datawindow adw, long al_row) throws n_ex
end prototypes

public function long uf_string_to_array (string as_input_string, string as_delimiter, ref string rs_arr[]);/**********************************************************************************************************************
Acc:	public
-----------------------------------------------------------------------------------------------------------------------
Dscr:	Splits a list of values, separated by a delimiter, into an array.
		For the opposite operation see uf_array_to_string.
-----------------------------------------------------------------------------------------------------------------------
Arg:	as_input_string
		as_delimiter
 		rs_arr[]		ref	result array
-----------------------------------------------------------------------------------------------------------------------
Ret:	long - the quantity of produced array elements.
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
int    	li_start_pos = 1
int    	li_delimiter_pos
long    	ll_elements_processed = 0
string	ls_temp

as_input_string = as_input_string + as_delimiter
li_delimiter_pos = Pos(as_input_string, as_delimiter, li_start_pos)

do while li_delimiter_pos > 0
	ls_temp = Mid(as_input_string, li_start_pos, li_delimiter_pos - li_start_pos)
	ls_temp = Trim(ls_temp)
	ll_elements_processed++
	rs_arr[ll_elements_processed] = ls_temp
	li_start_pos = li_delimiter_pos + 1
	li_delimiter_pos = Pos(as_input_string, as_delimiter, li_start_pos)
loop

return ll_elements_processed
end function

public subroutine uf_replace_all (ref string rs_processed_string, string as_old_frag, string as_new_frag);/**********************************************************************************************************************
Acc:	public
-----------------------------------------------------------------------------------------------------------------------
Dscr:	Replaces all appearances of a fragment in a string with another fragment.
-----------------------------------------------------------------------------------------------------------------------
Arg:	rs_processed_string (ref) - the string in which replacement should take place.
		as_old_frag - the fragment to be replaced.
		as_new_frag - the fragment to replace with.
-----------------------------------------------------------------------------------------------------------------------
Log:	24aug2011 Michael Zuskin	Initial version
**********************************************************************************************************************/
long	ll_pos
long	ll_old_frag_len
long  ll_new_frag_len

ll_old_frag_len = Len(as_old_frag)
ll_new_frag_len = Len(as_new_frag)

ll_pos = Pos(rs_processed_string, as_old_frag)
do while ll_pos > 0
	rs_processed_string = Replace(rs_processed_string, ll_pos, ll_old_frag_len, as_new_frag)
	ll_pos = Pos(rs_processed_string, as_old_frag, ll_pos + ll_new_frag_len)
loop

return
end subroutine

public function boolean uf_populated (any aa_val);/**********************************************************************************************************************
Acc:	public
-----------------------------------------------------------------------------------------------------------------------
Dscr:	Defines if the passed variable of a primitive data type has a value.

		This function treats default values (empty string for string, 0 for numbers etc. as well as dates before
		HISTORICAL_YEAR) as "no value" (like NULL) and is convenient to validate required parameters.
		
		The default values of boolean and time variables, false and midnight, are legal "not empty" values,
		so for them this finction acts exactly as IsNull().
		
		There is also an opposite function uf_empty (with negative wording).
-----------------------------------------------------------------------------------------------------------------------
Arg:	aa_val (any) - the tested value
-----------------------------------------------------------------------------------------------------------------------
Ret:	boolean (true = the var has a value; false = the var doesn't have any value)
-----------------------------------------------------------------------------------------------------------------------
Log:	08jul2011 Michael Zuskin	Initial version
**********************************************************************************************************************/
string				ls_val
int					li_val
long					ll_val
character			lc_val
datetime				ldt_val
decimal				ldc_val
double				ldb_val
real					lr_val
date					ld_val
unsignedinteger	lui_val
unsignedlong		lul_val

if IsNull(aa_val) then return false

choose case ClassName(aa_val)
case "string"
	ls_val = aa_val
	if Trim(ls_val) = "" then return false
case "long"
	ll_val = aa_val
	if ll_val = 0 then return false
case "integer"
	li_val = aa_val
	if li_val = 0 then return false
case "boolean"
	// no checkings in addition to checking for NULL; for boolean vars, you can use "not IsNull()" instead of "uf_populated()"
case "character"
	lc_val = aa_val
	if Trim(lc_val) = "" then return false
case "datetime"
	ldt_val = aa_val
	if Year(Date(ldt_val)) <= 1900 then return false
case "decimal"
	ldc_val = aa_val
	if ldc_val = 0 then return false
case "double"
	ldb_val = aa_val
	if ldb_val = 0 then return false
case "date"
	ld_val = aa_val
	if Year(ld_val) <= 1900 then return false
case "time"
	// no checkings in addition to checking for NULL; 00:00 (midnight) is a valid value; you can use "not IsNull()" for time vars
case "real"
	lr_val = aa_val
	if lr_val = 0 then return false
case "unsignedinteger"
	lui_val = aa_val
	if lui_val = 0 then return false
case "unsignedlong"
	lul_val = aa_val
	if lul_val = 0 then return false
end choose

return true
end function

public function string uf_get_pb_version ();/*----------------------------------------------------------------------------------------------------------------------
Acc:	public
-----------------------------------------------------------------------------------------------------------------------
Dscr:	returns the major version number of PowerBuilder, for example: "9" (not "9.0"!)
------------------------------------------------------------------------------------------------------------------------
Ret:	PB version as string
----------------------------------------------------------------------------------------------------------------------*/
int			li_rc
string		ls_pb_version
environment	lenv

li_rc = GetEnvironment(ref lenv)
if li_rc <> 1 then return '<<<Error in n_util.uf_get_pb_version>>>'

ls_pb_version = String(lenv.pbmajorrevision)

return ls_pb_version

//Some more fields which can be useful:
//lenv.pbminorrevision
//lenv.pbfixesrevision
//lenv.pbbuildnumber
end function

public function long uf_sort_array (ref long rl_arr[]);/*----------------------------------------------------------------------------------------------------------------------
Acc:	public
-----------------------------------------------------------------------------------------------------------------------
Dscr:	Sorts a long array in ascending order.
------------------------------------------------------------------------------------------------------------------------
Arg:	rl_arr[] - long array to sort
------------------------------------------------------------------------------------------------------------------------
Ret:	the number of elements in the array
------------------------------------------------------------------------------------------------------------------------
Log:	11.12.2001		Michael Zuskin			Created
		04.08.2012		Michael Zuskin			Creation of lds_temp moved to uf_ds_from_array
----------------------------------------------------------------------------------------------------------------------*/
long			ll_upper_bound
DataStore	lds_temp

ll_upper_bound = UpperBound(rl_arr)
if ll_upper_bound = 0 then return 0

lds_temp = uf_ds_from_array(rl_arr)
lds_temp.SetSort("the_col ASC")
lds_temp.Sort()
rl_arr = lds_temp.object.the_col.current

destroy lds_temp

return ll_upper_bound

end function

public function datastore uf_ds_from_array (string as_arr[]);/*----------------------------------------------------------------------------------------------------------------------
Acc:	public
-----------------------------------------------------------------------------------------------------------------------
Dscr:	Gets string array and creates a DS, the only column of which (named "the_col") contains the array's values.
		After the values, previously converted to a DataStore by this function, have been processed, they can be
		easily converted back to an array by accessing the DataStore's property object.the_col.current:
		
		lds_temp = uf_ds_from_array(ls_arr[])
		...massage data in DataStore...
		ls_arr[] = lds_temp.object.the_col.current
------------------------------------------------------------------------------------------------------------------------
Arg:	as_arr[] - string array to convert to DataStore
------------------------------------------------------------------------------------------------------------------------
Ret:	DataStore
------------------------------------------------------------------------------------------------------------------------
Log:	21aug2012 Michael Zuskin	Initial version
----------------------------------------------------------------------------------------------------------------------*/
string		ls_source
string		ls_error
string		ls_pb_version
DataStore	lds

ls_pb_version = uf_get_pb_version()
ls_source = 'release ' + ls_pb_version + '; datawindow() table(column=(type=char(10000) name=the_col dbname="the_col") )'

lds = create DataStore
lds.create(ls_source, ls_error)

if UpperBound(as_arr) > 0 then
	lds.object.the_col.current = as_arr
end if

return lds
end function

public function datastore uf_ds_from_array (long al_arr[]);/*----------------------------------------------------------------------------------------------------------------------
Acc:	public
-----------------------------------------------------------------------------------------------------------------------
Dscr:	Gets decimal array and creates a DS, the only column of which (named 'the_col') contains the array's values.
		After the values, previously converted to a DataStore by this function, have been processed, they can be
		easily converted back to an array by accessing the DataStore's property object.the_col.current:
		
		lds_temp = uf_ds_from_array(ll_arr[])
		...massage data in DataStore...
		ll_arr[] = lds_temp.object.the_col.current
------------------------------------------------------------------------------------------------------------------------
Arg:	al_arr[] - long array to convert to DataStore
------------------------------------------------------------------------------------------------------------------------
Ret:	DataStore
------------------------------------------------------------------------------------------------------------------------
Log:	21aug2012 Michael Zuskin	Initial version
----------------------------------------------------------------------------------------------------------------------*/
string		ls_source
string		ls_error
string		ls_pb_version
DataStore	lds

ls_pb_version = uf_get_pb_version()
ls_source = 'release ' + ls_pb_version + '; datawindow() table(column=(type=decimal(0) name=the_col dbname="the_col") )'

lds = create DataStore
lds.create(ls_source, ls_error)

if UpperBound(al_arr) > 0 then
	lds.object.the_col.current = al_arr
end if

return lds
end function

public function long uf_sort_array (ref string rs_arr[]);/*----------------------------------------------------------------------------------------------------------------------
Dscr:	Sorts a string array in ascending order.
------------------------------------------------------------------------------------------------------------------------
Arg:	rs_arr[] - string array to sort
------------------------------------------------------------------------------------------------------------------------
Ret:	the number of elements in the array
------------------------------------------------------------------------------------------------------------------------
Log:	11.12.2001		Michael Zuskin			Created
		04.08.2012		Michael Zuskin			Creation of lds_temp moved to uf_ds_from_array
----------------------------------------------------------------------------------------------------------------------*/
long			ll_upper_bound
DataStore	lds_temp

ll_upper_bound = UpperBound(rs_arr)
if ll_upper_bound = 0 then return 0

lds_temp = uf_ds_from_array(rs_arr)
lds_temp.SetSort("the_col ASC")
lds_temp.Sort()
rs_arr = lds_temp.object.the_col.current

destroy lds_temp

return ll_upper_bound

end function

public function window uf_get_window (powerobject apo_obj);/**********************************************************************************************************************
Acc:	public
-----------------------------------------------------------------------------------------------------------------------
Dscr:	Determines an object's parent window going through the parenting hierarchy until a window is found.
		Returns an object of the class Window. Use uf_get_window_name() to obtain the parent window's NAME.
-----------------------------------------------------------------------------------------------------------------------
Arg:	apo_obj (PowerObject)
-----------------------------------------------------------------------------------------------------------------------
Ret:	The parent window (Window)
-----------------------------------------------------------------------------------------------------------------------
Log:	24oct2011 Michael Zuskin	R0112 - 10-2100 Thunder Road Family+ (Initial version)
**********************************************************************************************************************/
Window			lw_null
PowerObject 	lpo_parent

if not IsValid(apo_obj) then
	return lw_null
end if

lpo_parent = apo_obj.GetParent()
do while IsValid(lpo_parent)
	if lpo_parent.TypeOf() = Window! then
		return lpo_parent
	end if
	lpo_parent = lpo_parent.GetParent()
loop

return lw_null
end function

public function string uf_get_field_label (datawindow adw, string as_field_name);/**********************************************************************************************************************
Acc:	public
-----------------------------------------------------------------------------------------------------------------------
Dscr:	Gets field name and returns its label (the text of the <field name>_t object).
		The label is returned without not-alphabetic symbols ("&Name:" is returned as "Name") to be ready for messages.
		If <field name>_t object doesn't exist (bad practice, but happens) then does its best to build
		a user-friendly label from the field's name ("first_name" ==>> "First Name") to prevent ugly messages.
-----------------------------------------------------------------------------------------------------------------------
Arg:	adw, as_field_name
-----------------------------------------------------------------------------------------------------------------------
Ret:	string
-----------------------------------------------------------------------------------------------------------------------
Log:	01may2012 Michael Zuskin	Initial version
**********************************************************************************************************************/
string ls_label

ls_label = adw.Describe(as_field_name + "_t.Text")
if iin(ls_label, {"!", "?"}) /* there is NO text object named "<field name>_t" */ then
	// Try to save the situation and return something which can be used as the column's label (like "First Name" for "first_name"):
	ls_label = as_field_name
	uf_replace_all(ref ls_label, "_", " ") // "first_name" ==>> "first name"
	WordCap(ls_label) // "first name" ==>> "First Name"
else // text object, named "<field name>_t", exists
	ls_label = Trim(ls_label)
	// Remove semicolon which exsist in many labels on free-form DW:
	if Right(ls_label, 1) = ":" then
		ls_label = Left(ls_label, Len(ls_label) - 1)
	end if
	// Remove ampersands which mark hot-key symbols, displayed to user underlined:
	uf_replace_all(ref ls_label, "&&", adw.ClassName()) // save double-ampersand (which is displayed as one) from removing by next line
	uf_replace_all(ref ls_label, "&", "")
	uf_replace_all(ref ls_label, adw.ClassName(), "&") // restore the saved ampersand (display it as one)
	// Remove other not-alphabetic symbols which can appear in the label:
	uf_replace_all(ref ls_label, "~n~r", " ")
	uf_replace_all(ref ls_label, "~r~n", " ")
	uf_replace_all(ref ls_label, "~n", " ")
	uf_replace_all(ref ls_label, "~r", " ")
	uf_replace_all(ref ls_label, "~"", "")
end if

return ls_label
end function

public function boolean uf_empty (any aa_val);/**********************************************************************************************************************
Acc:	public
-----------------------------------------------------------------------------------------------------------------------
Dscr:	Defines if the passed variable of a primitive data type has a value.

		This function treats default values (empty string for string, 0 for numbers etc.)
		as "no value" (like NULL) and is convenient to validate required parameters.
		
		Don't use this function to test a var if the data type's default value is an allowed one (lake date and boolean).
		
		There is also an opposite function uf_populated (with positive wording).
-----------------------------------------------------------------------------------------------------------------------
Arg:	aa_val (any) - the tested value
-----------------------------------------------------------------------------------------------------------------------
Ret:	boolean (true = the var doesn't have any value; false = the var has a value)
-----------------------------------------------------------------------------------------------------------------------
Log:	08jul2011 Michael Zuskin	Initial version
**********************************************************************************************************************/
return not uf_populated(aa_val)
end function

public function long uf_row_count (datawindow adw, dwbuffer a_buf);choose case a_buf
case Primary!
	return adw.RowCount()
case Filter!
	return adw.FilteredCount()
case Delete!
	return adw.DeletedCount()
end choose
end function

public function boolean uf_col_exists (datawindow adw, string as_col);/**********************************************************************************************************************
Acc:	public
-----------------------------------------------------------------------------------------------------------------------
Dscr:	Checks if the column exists in the DW. Can be used in a generic script which processes different DWs.
-----------------------------------------------------------------------------------------------------------------------
Arg:	as_col
-----------------------------------------------------------------------------------------------------------------------
Ret:	boolean (true - exists, false - doesnt exist)
-----------------------------------------------------------------------------------------------------------------------
Log:	30nov2011 Michael Zuskin	Initial version
**********************************************************************************************************************/
return (adw.Describe(as_col + '.Name') = as_col)
end function

public function string uf_get_pbl_of_class (string as_class_name);/**********************************************************************************************************************
Dscr:	Returns the PBL the class is stored in.
-----------------------------------------------------------------------------------------------------------------------
Arg:	as_class_name
-----------------------------------------------------------------------------------------------------------------------
Ret:	string
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
string				ls_classes_in_pbl_arr[]
string				ls_pbls_arr[]
string				ls_list_of_classes_in_pbl
string				ls_obj
string				ls_list_of_pbls
int					li_qty_of_pbls
int					li_curr_pbl_idx
int					li_curr_class_idx
int					li_qty_of_classes_in_pbl
int					li_class_name_length
int					li_last_slash_pos
ClassDefinition	lcd

lcd = FindClassDefinition(as_class_name) // returns NULL if the obect is a DataObject ("d_...")
if not IsNull(lcd) /* if not a DataObject ("d_...") */ then return " (" + lcd.LibraryName + ")"
												// If this code reached then it's a DataObject ("d_...").
												// It doesn't have ClassDefinition, so it's more tricky to obtain its PBL...
ls_list_of_pbls = GetLibraryList()
li_qty_of_pbls = uf_string_to_array(ls_list_of_pbls, ",", ls_pbls_arr[])

for li_curr_pbl_idx = 1 to li_qty_of_pbls
	ls_list_of_classes_in_pbl = LibraryDirectory(ls_pbls_arr[li_curr_pbl_idx], DirAll!)
	li_qty_of_classes_in_pbl = uf_string_to_array(ls_list_of_classes_in_pbl, "~n", ls_classes_in_pbl_arr[])
												// Now each element of ls_classes_in_pbl_arr contains a string having not only
												// the class name but also the last change date and time and, possibly, the comment.
												// The date is delimited from the class name by a tab, so lets's extract the names:
	for li_curr_class_idx = 1 to li_qty_of_classes_in_pbl
		ls_obj = Trim(ls_classes_in_pbl_arr[li_curr_class_idx])
		li_class_name_length = Pos(ls_obj, "	") - 1 // until the first tab
		ls_obj = Left(ls_obj, li_class_name_length) // extract class name from the entire string
												// Let's check if it is the class whose PBL we are looking for (as_class_name):
		if Lower(ls_obj) <> Lower(as_class_name) then continue
												// Found!!! Return the current PBL:
		return " (" + ls_pbls_arr[li_curr_pbl_idx] + ")"
	next
next
												// If this code reached, this object is not stored in a PBL (for example,
												// it's a DW which "lives" on a window, so only the window is stored in a PBL):
return ""
end function

public function string uf_get_proc_of_dataobject (string as_dataobject);/**********************************************************************************************************************
Dscr:	Returns name of stored proc which is data source of DataObject.
		If DW has other data source then returns empty string.
-----------------------------------------------------------------------------------------------------------------------
Arg:	as_dataobject	DataObject
-----------------------------------------------------------------------------------------------------------------------
Ret:	string (empty string if the DW's data source is not a stored proc)
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
string		ls_proc
DataStore	lds_temp

lds_temp = create DataStore
lds_temp.DataObject = as_DataObject
ls_proc = lds_temp.Describe("DataWindow.Table.Procedure")
destroy lds_temp

if Len(ls_proc) <= 1 /* "?", "!", or "" */ or IsNull(ls_proc) then
	return ""
end if

ls_proc = Right(ls_proc, (Len(ls_proc) - 10)) // remove "1 execute " from the beginning
ls_proc = Left(ls_proc, (Pos(ls_proc, "") - 1)) // remove proc's parms list
uf_replace_all(ref ls_proc, "dbo", "") // "schema.dbo.sp_XXX" ==>> "schema..sp_XXX"

if Left(ls_proc, 1) = "." /* no schema - looking like ".sp_XXX" */ then
	uf_replace_all(ref ls_proc, ".", "") // remove the leading dot
end if

return ls_proc
end function

public function boolean uf_col_is_visible (datawindow adw, string as_col_name);/*----------------------------------------------------------------------------------------------------------------------
Dscr:	Checks if a column (with or without an expression) is visible or invisible.
------------------------------------------------------------------------------------------------------------------------
Arg:	adw, as_col_name
------------------------------------------------------------------------------------------------------------------------
Ret:	true - visible, false - invisible
------------------------------------------------------------------------------------------------------------------------
Log:	14.05.2003	Michael Zuskin 	Created
----------------------------------------------------------------------------------------------------------------------*/
string	ls_visible_expr
long		li_row = 1

ls_visible_expr = adw.Describe(as_col_name + ".visible") //ls_visible_expr contains '0', '1' or an expression

if Left(ls_visible_expr, 1) = '"' then
	ls_visible_expr = Replace(ls_visible_expr, 2, Pos(ls_visible_expr, "~t") - 1, "")
	ls_visible_expr = adw.Describe("Evaluate(" + ls_visible_expr + ", " + String(li_row) + ")") // populate ls_visible_expr with "0" or "1"
end if

return (ls_visible_expr = "1")
end function

public function string uf_get_item_as_string (datawindow adw, long al_row, string as_field_name, dwbuffer a_buf, boolean ab_orig_val) throws n_ex;/**********************************************************************************************************************
Dscr:	Returns the specified field's value as a string (to be displayed to the user).
-----------------------------------------------------------------------------------------------------------------------
Arg:	adw				DataWindow
		al_row			long
		as_field_name	string
		DWBuffer			a_buf
		ab_orig_val		boolean		true - get ORIGINAL value, false - get CURRENT value
-----------------------------------------------------------------------------------------------------------------------
Ret:	string
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
string	ls_val
string	ls_field_type

constant string EMPTY_STRING = "<<<W_SPYEMPTYSTRING>>>"
		
ls_field_type = Lower(Left(adw.Describe(as_field_name + ".ColType"), 5))

choose case ls_field_type
case "numbe", "long", "ulong", "real", "int", "decim"
	ls_val = String(adw.GetItemNumber(al_row, as_field_name, a_buf, ab_orig_val))
case "char(", "char"
	ls_val = adw.GetItemString(al_row, as_field_name, a_buf, ab_orig_val)
	if not IsNull(ls_val) then
		if ls_val = "" then
			ls_val = EMPTY_STRING
		else
			ls_val = "'" + ls_val + "'"
		end if
	end if
case "datet", "times"
	ls_val = String(adw.GetItemDateTime(al_row, as_field_name, a_buf, ab_orig_val), "dd-mmm-yyyy hh:mm")
case "date"
	ls_val = String(adw.GetItemDate(al_row, as_field_name, a_buf, ab_orig_val), "dd-mmm-yyyy")
case "time"
	ls_val = String(adw.GetItemTime(al_row, as_field_name, a_buf, ab_orig_val), "hh:mm")
case else
	f_throw(PopulateError(0, "Unknown DW field data type " + ls_field_type + "."))
end choose

choose case true
case ls_val = EMPTY_STRING
	ls_val = "''"
case IsNull(ls_val), ls_val = ""
	ls_val = "NULL"
end choose

return ls_val
end function

public function string uf_get_item_as_string (datawindow adw, long al_row, string as_field_name, dwbuffer a_buf) throws n_ex;/**********************************************************************************************************************
Dscr:	Returns the specified field's CURRENT value as a string (to be displayed to the user).
-----------------------------------------------------------------------------------------------------------------------
Arg:	adw				DataWindow
		al_row			long
		as_field_name	string
		DWBuffer			a_buf
-----------------------------------------------------------------------------------------------------------------------
Ret:	string
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
return uf_get_item_as_string(adw, al_row, as_field_name, a_buf, false /* ab_orig_val */)
end function

public function string uf_get_item_as_string (datawindowchild adwc, integer ai_dwc_row, string as_dwc_field_name, dwbuffer a_buf, boolean ab_orig_val) throws n_ex;/**********************************************************************************************************************
Dscr:	Returns the specified field's value as a string (to be displayed to the user).
-----------------------------------------------------------------------------------------------------------------------
Arg:	adwc					DataWindowChild
		ai_dwc_row			long
		as_dwc_field_name	string
		a_buf					DWBuffer
		ab_orig_val			boolean		true - get ORIGINAL value, false - get CURRENT value
-----------------------------------------------------------------------------------------------------------------------
Ret:	string
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
		Michael Zuskin		Dec 05, 2012	Call the overloaded version to avoid code duplication
**********************************************************************************************************************/
DataWindow	ldw_temp

adwc.RowsCopy(1, adwc.RowCount(), a_buf, ldw_temp, 1, a_buf)

return uf_get_item_as_string(ldw_temp, ai_dwc_row, as_dwc_field_name, a_buf, ab_orig_val)
end function

public function string uf_get_item_as_string (datawindow adw, long al_row, string as_field_name) throws n_ex;/**********************************************************************************************************************
Dscr:	Returns the specified field's CURRENT value as a string (to be displayed to the user).
-----------------------------------------------------------------------------------------------------------------------
Arg:	adw				DataWindow
		al_row			long
		as_field_name	string
-----------------------------------------------------------------------------------------------------------------------
Ret:	string
-----------------------------------------------------------------------------------------------------------------------
Dev:	Michael Zuskin		Nov 18, 2010	Initial version
**********************************************************************************************************************/
return uf_get_item_as_string(adw, al_row, as_field_name, Primary!, false /* ab_orig_val */)
end function

public function string uf_get_item_as_string (datawindow adw, long al_row, string as_field_name, boolean ab_orig_val) throws n_ex;// Overload for Primary! buffer

return uf_get_item_as_string(adw, al_row, as_field_name, Primary!, ab_orig_val)
end function

public function string uf_get_item_as_string (datawindowchild adwc, integer ai_dwc_row, string as_dwc_field_name) throws n_ex;// Overload for Primary! buffer and CURRENT value

return uf_get_item_as_string(adwc, ai_dwc_row, as_dwc_field_name, Primary!, false /* ab_orig_val */)
end function

public function boolean uf_col_modified (datawindow adw, string as_col, long al_row, dwbuffer a_buf) throws n_ex;/**********************************************************************************************************************
Acc:	public
-----------------------------------------------------------------------------------------------------------------------
Dscr:	Checks if the column's value has been modified since the retrieval or last save.
		Use adw function instead of checking the columns DWItemStatus (that status remains DataModified! if user changed
		the value and after that returned the original one).
		
		This function makes scripts shorter beacuse it exempts them from:
			1. Declaration and populating of variables for the original and current values.
			2. Processing of NULLs (the value is reported as not modified if both the values, the old and the new,
						are NULLs, and modified if only one of them is NULL).
		
		If the script deals only with the current record of the Primary! buffer (for example, in a FORM DW, or in
		a multi-rows DW with no filtering and deletion) then you can use the overloaded version with 2 arguments.
-----------------------------------------------------------------------------------------------------------------------
Arg:	DataWindow	adw
		long			al_row
		string		as_col
		DWBuffer		a_buf
-----------------------------------------------------------------------------------------------------------------------
Ret:	boolean (true - has been changed, false - has NOT been changed)
-----------------------------------------------------------------------------------------------------------------------
Thr:	n_ex
-----------------------------------------------------------------------------------------------------------------------
Log:	30nov2011 Michael Zuskin	Initial version
**********************************************************************************************************************/
long		ll_row_count
string	ls_col_type
string	ls_old
string	ls_new

ll_row_count = uf_row_count(adw, a_buf)

// Validate parameters:
choose case true
case uf_empty(as_col)
	f_throw(PopulateError(1, "Arg as_col is empty."))
case IsNull(al_row)
	f_throw(PopulateError(2, "Arg al_row is null."))
case adw.DataObject = ''
	f_throw(PopulateError(3, "DW doesn't have DataObject."))
case not uf_col_exists(adw, as_col)
	f_throw(PopulateError(4, "DW doesn't have column '" + as_col + "'."))
case al_row < 0
	f_throw(PopulateError(5, "Arg al_row is negative (" + String(al_row) + ")."))
case al_row > ll_row_count
	f_throw(PopulateError(6, "Arg al_row (" + String(al_row) + ") is greater than the number of rows in DW (" + String(ll_row_count) + ")."))
end choose

// Obtain old (original) and new (current) values:
ls_old = uf_get_item_as_string(adw, al_row, as_col, a_buf, true)
ls_new = uf_get_item_as_string(adw, al_row, as_col, a_buf, false)

// Define if the value has been changed:
if IsNull(ls_old) and IsNull(ls_new) then return false
if IsNull(ls_old) and not IsNull(ls_new) then return true
if not IsNull(ls_old) and IsNull(ls_new) then return true

return (ls_new <> ls_old)
end function

public function boolean uf_row_modified (datawindow adw, long al_row, dwbuffer a_buf) throws n_ex;/**********************************************************************************************************************
Dscr:	Reports if at least one field in the pased row has been updated.
		Field is treated as updated if its value has been changed since row is retrieved or inserted.
		If value was changed and later the original value was restored then it's not updated.
-----------------------------------------------------------------------------------------------------------------------
Arg:	adw				DataWindow
		al_row			long
		DWBuffer			a_buf
-----------------------------------------------------------------------------------------------------------------------
Ret:	boolean
-----------------------------------------------------------------------------------------------------------------------
Log:	05aug2011		Michael Zuskin 	Created
**********************************************************************************************************************/
int		i
int		li_col_count
string	as_col

li_col_count = Integer(adw.Describe("datawindow.column.count"))
for i = 1 to li_col_count
	as_col = adw.Describe("#"+ String(i) + ".name")
	if uf_col_modified(adw, as_col, al_row, a_buf) then
		return true
	end if
next

return false
end function

public function boolean uf_row_modified (datawindow adw, long al_row) throws n_ex;// Overload for Primary! buffer

return uf_row_modified(adw, al_row, Primary!)
end function

on n_dwspy_util.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_dwspy_util.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

