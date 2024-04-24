$PBExportHeader$n_parm.sru
forward
global type n_parm from nonvisualobject
end type
end forward

global type n_parm from nonvisualobject autoinstantiate
end type

type variables
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// How to use: http://forum.powerbuilder.us/viewtopic.php?f=4&t=2
// Licence: No licence needed, this utility is absolutely free
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

public:
	
	// Fields for requently passed parameters:
	string	is_passed_from
	boolean	ib_positive_response
string is_msgid

private:

	any		ia_values[] // parameters' values
	string	is_names[] // parameters' names
	boolean	ib_is_object[] // its N-th element flags if N-th element of ia_values contains reference to object (true) or value of primitive type (false)
	uint		iui_upper_bound = 0 // size of three the arrays; eliminates multiple using of UpperBound() function
end variables

forward prototypes
public subroutine uf_set (string as_name, any aa_value)
public function any uf_get (string as_name)
public subroutine uf_set (string as_name, powerobject apo_val)
public function boolean uf_exists (string as_name)
public subroutine uf_set_msgid (string as_msgid)
public function string uf_get_msgid ()
end prototypes

public subroutine uf_set (string as_name, any aa_value);/*******************************************************************************************
Acc: public
--------------------------------------------------------------------------------------------
Dsc: adds parameter of a PRIMITIVE type to be transported
--------------------------------------------------------------------------------------------
Arg: as_name (string)- parameter's name
	  aa_value (any) - parameter's value
*******************************************************************************************/
uint i

if IsNull(as_name) or Trim(as_name) = '' then
	return
end if

// If this parm already exists then update it with the new (passed) value:
for i = 1 to iui_upper_bound
	if is_names[i] = as_name then
		ia_values[i] = aa_value
		ib_is_object[i] = false
		return
	end if
next

// If this code reached then this parm doesn't exist; add it:
iui_upper_bound++
is_names[iui_upper_bound] = as_name
ia_values[iui_upper_bound] = aa_value
ib_is_object[iui_upper_bound] = false

return
end subroutine

public function any uf_get (string as_name);/*******************************************************************************************
Acc: public
--------------------------------------------------------------------------------------------
Dsc: returns value of transported parameter by its name.

	  If there is a chance that the parameter will not exist (i.e. is not mandatory) then
	  use uf_exists before calling uf_get to prevent possible run-time error:
	  
	  if lnv_parm.uf_exists("ds_details") then
		  lds_details = lnv_parm.uf_get("ds_details")
	  end if
--------------------------------------------------------------------------------------------
Arg: as_name - parameter's name
--------------------------------------------------------------------------------------------
Ret: (any) - parameter's value
*******************************************************************************************/
uint i
any la_empty
PowerObject lpo_empty

as_name = Lower(Trim(as_name))

for i = 1 to iui_upper_bound
	if is_names[i] = as_name then
		if IsNull(ia_values[i]) and ib_is_object[i] then
			// App fails when "any" var with NULL of type, inherited from PowerObject,
			// assigned to another "any" var, so return empty PowerObject:
			return lpo_empty
		else
			return ia_values[i]
		end if
	end if
next

return la_empty
end function

public subroutine uf_set (string as_name, powerobject apo_val);/*******************************************************************************************
Acc: public
--------------------------------------------------------------------------------------------
Dsc: adds parameter of an OBJECT (REFERENCE) type to be transported
--------------------------------------------------------------------------------------------
Arg: as_name (string)- parameter's name
	  apo_val (PowerObject) - parameter's value
*******************************************************************************************/
uint i

if IsNull(as_name) or Trim(as_name) = '' then
	return
end if

// If this parm already exists then update it with the new (passed) value:
for i = 1 to iui_upper_bound
	if is_names[i] = as_name then
		ia_values[i] = apo_val
		ib_is_object[i] = true
		return
	end if
next

// If this code reached then this parm doesn't exist; add it:
iui_upper_bound++
is_names[iui_upper_bound] = as_name
ia_values[iui_upper_bound] = apo_val
ib_is_object[iui_upper_bound] = true

return
end subroutine

public function boolean uf_exists (string as_name);/*******************************************************************************************
Acc: public
--------------------------------------------------------------------------------------------
Dsc: reports if parameter with requested name exists and is not null.

	  If there is a chance that the parameter will not exist (i.e. is not mandatory) then
	  use this function before calling uf_get to prevent possible run-time error:
	  
	  if lnv_parm.uf_exists("ds_details") then
		  lds_details = lnv_parm.uf_get("ds_details")
	  end if
--------------------------------------------------------------------------------------------
Arg: as_name - parameter's name
--------------------------------------------------------------------------------------------
Ret: (boolean) - parameter's existence
*******************************************************************************************/
uint i

as_name = Lower(Trim(as_name))

for i = 1 to iui_upper_bound
	if is_names[i] = as_name then
		return not IsNull(ia_values[i]) // found but is null
	end if
next

return false // not found
end function

public subroutine uf_set_msgid (string as_msgid);/*******************************************************************************************
MicPaul 2018/01/21
*******************************************************************************************/
uint i

if IsNull(as_msgid) or Trim(as_msgid) = '' then
	return
end if

is_msgid =as_msgid 

return
end subroutine

public function string uf_get_msgid ();/*******************************************************************************************
MicPaul 2018/01/21
*******************************************************************************************/

return is_msgid 

end function

on n_parm.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_parm.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

