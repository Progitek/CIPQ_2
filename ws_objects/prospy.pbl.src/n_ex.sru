$PBExportHeader$n_ex.sru
forward
global type n_ex from exception
end type
end forward

global type n_ex from exception
end type
global n_ex n_ex

type variables
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// How to use: http://forum.powerbuilder.us/viewtopic.php?f=2&t=1
// Licence: No licence needed, this class is absolutely free
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

protected:

	int		ii_err_num
	int		ii_line
	string	is_class
	string	is_script
end variables

forward prototypes
public subroutine uf_populate (integer ai_err_num, string as_err_msg, string as_class, string as_script, integer ai_line)
public subroutine uf_msg ()
end prototypes

public subroutine uf_populate (integer ai_err_num, string as_err_msg, string as_class, string as_script, integer ai_line);/**********************************************************************************************************************
Acc:	public
-----------------------------------------------------------------------------------------------------------------------
Dscr:	Sets data related to the class and the script the exception is thrown from.
		Called from f_throw().
-----------------------------------------------------------------------------------------------------------------------
Arg:	int		ai_err_num
		string	as_err_msg
		string	as_class
		string	as_script
		int		ai_line
**********************************************************************************************************************/
ii_err_num = ai_err_num
SetMessage(as_err_msg)
is_class = as_class
is_script = as_script
ii_line = ai_line

return
end subroutine

public subroutine uf_msg ();/**********************************************************************************************************************
Acc:	public
-----------------------------------------------------------------------------------------------------------------------
Dscr:	Displays a message with all the exception-related information.
		Should be called for an exception caught in "catch" section of "try...end try" block, for example:
		
		try
			uf_function_which_throws_n_ex()
			f_throw(PopulateError(0, "Oooops..."))
		catch(n_ex e)
			e.uf_msg()
		end try
		
**********************************************************************************************************************/
string	ls_msg
string	ls_header

if ii_err_num > 0 then
	ls_header = "EXCEPTION #" + String(ii_err_num) + " THROWN"
else
	ls_header = "EXCEPTION THROWN"
end if

if Len(is_class) > 0 then ls_msg = "Class: " + is_class + "~r~n"
if Len(is_script) > 0 then ls_msg += "Script: " + is_script + "~r~n"
if ii_line > 0 then ls_msg += "Line: " + String(ii_line) + "~r~n"
if ls_msg <> "" then ls_msg += "~r~n~r~n"

ls_msg += GetMessage()
 
MessageBox(ls_header, ls_msg, StopSign!)

return
end subroutine

on n_ex.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_ex.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

