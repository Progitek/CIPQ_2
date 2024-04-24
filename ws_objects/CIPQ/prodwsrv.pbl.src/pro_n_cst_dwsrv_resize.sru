$PBExportHeader$pro_n_cst_dwsrv_resize.sru
$PBExportComments$(PRO) Extension DataWindow Resize service
forward
global type pro_n_cst_dwsrv_resize from pfc_n_cst_dwsrv_resize
end type
end forward

global type pro_n_cst_dwsrv_resize from pfc_n_cst_dwsrv_resize
end type
global pro_n_cst_dwsrv_resize pro_n_cst_dwsrv_resize

forward prototypes
protected function integer of_resize (integer ai_newwidth, integer ai_newheight)
protected function integer of_register (string as_control, boolean ab_scale, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight)
end prototypes

protected function integer of_resize (integer ai_newwidth, integer ai_newheight);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Resize
//
//	Access:  		protected
//
//	Arguments:		
//	ai_newwidth		The new width of the parent object.
//	ai_newheight	The new height of the parent object.
//
//	Returns:  		integer
//						1 if it succeeds and -1 if an error occurs.
//
//	Description:  	Moves or resizes objects that were registered with the service.
//						Performs the actions that were requested via the
//						of_SetOrigSize() and of_Register functions.
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

//////////////////////////////////////////////////////////////////////////////
//Note: For the line control: the width and height variables are
//										used to hold EndX and EndY attributes.
//////////////////////////////////////////////////////////////////////////////

//Local variables
constant integer MINIMUM_SIZE =0

string			ls_control
string			ls_type
integer			li_upperbound
integer			li_rc
integer			li_cnt
integer			li_x, li_y, li_width, li_height
integer			li_deltawidth, li_deltaheight
integer			li_movex, li_movey, li_scalewidth, li_scaleheight
real				lr_ratiowidth, lr_ratioheight
real				lr_move_deltax, lr_move_deltay
real				lr_resize_deltawidth, lr_resize_deltaheight
string			ls_singlemodifyexp, ls_complexmodifyexp
string			ls_modifyret
integer 			li_placewidth, li_placeheight

// Validate the reference.
If IsNull(idw_requestor) or Not IsValid(idw_requestor) Then
	Return -1
End If

//Confirm that the user object has already been initialized
If il_parentprevheight=-1 And il_parentprevwidth=-1 Then
	Return -1
End If

//Check the parameters
If IsNull(ai_newwidth) or IsNull(ai_newheight) Then
	return -1
End If

//Prevent the contents of the windows from resizing past the min width/height
If ai_newwidth < il_parentminimumwidth   Then ai_newwidth = il_parentminimumwidth
If ai_newheight < il_parentminimumheight Then ai_newheight = il_parentminimumheight

//Set the deltas/ratios for the width and height as compared to the previous size
li_deltawidth  = ai_newwidth  - il_parentprevwidth 
li_deltaheight = ai_newheight - il_parentprevheight
If il_parentprevwidth=0 Then il_parentprevwidth=1
If il_parentprevheight=0 Then il_parentprevheight=1	
lr_ratiowidth  = ai_newwidth  / il_parentprevwidth
lr_ratioheight = ai_newheight / il_parentprevheight

//Only continue if the size has changed
If li_deltawidth=0 And li_deltaheight=0 Then Return 1

//Set the new previous size
il_parentprevwidth = ai_newwidth
il_parentprevheight = ai_newheight

///////////////////////////////////////////////////////////////////////////////////////////////
// Loop through all registered controls - Moving and resizing as appropriate
///////////////////////////////////////////////////////////////////////////////////////////////

//Loop trough all controls
li_upperbound = UpperBound (inv_registered[])
For li_cnt = 1 to li_upperbound
	
	//Initialize variables
	li_x = 0
	li_y = 0 
	li_width = 0
	li_height = 0
	lr_move_deltax = 0	
	lr_move_deltay = 0
	lr_resize_deltawidth = 0	
	lr_resize_deltaheight = 0	
	ls_singlemodifyexp = ''
	
	If Len(inv_registered[li_cnt].s_control) > 0 Then
		li_rc = of_GetObjectInformation (inv_registered[li_cnt].s_control, ls_type, li_x, li_y, li_width, li_height)
		If li_rc < 0 then Return -1
		
		//Correct for any ii_rounding or moving/resizing of objects trough
		//any other means
		If abs(inv_registered[li_cnt].r_x - li_x) > ii_rounding Then
			inv_registered[li_cnt].r_x = li_x
		End If				
		If abs(inv_registered[li_cnt].r_y - li_y) > ii_rounding Then
			inv_registered[li_cnt].r_y = li_y
		End If		
		If abs(inv_registered[li_cnt].r_width - li_width) > ii_rounding And &
		   li_width > MINIMUM_SIZE  Then
			inv_registered[li_cnt].r_width = li_width
		End If							
		If abs(inv_registered[li_cnt].r_height - li_height) > ii_rounding And &
		   li_height > MINIMUM_SIZE  Then
			inv_registered[li_cnt].r_height = li_height
		End If			
		
		//Define the deltas for this control:  Move and Resize
		If inv_registered[li_cnt].b_scale Then
			lr_move_deltax = (inv_registered[li_cnt].r_x * lr_ratiowidth) - inv_registered[li_cnt].r_x
			lr_move_deltay = (inv_registered[li_cnt].r_y * lr_ratioheight) - inv_registered[li_cnt].r_y
			lr_resize_deltawidth = (inv_registered[li_cnt].r_width * lr_ratiowidth) - inv_registered[li_cnt].r_width
			lr_resize_deltaheight = (inv_registered[li_cnt].r_height * lr_ratioheight) - inv_registered[li_cnt].r_height
		Else
			// Prevent the weighted value from being overriden.
			If inv_registered[li_cnt].b_movex And inv_registered[li_cnt].i_movex = 0 Then
				inv_registered[li_cnt].i_movex = 100
			End If
			If inv_registered[li_cnt].b_movey And inv_registered[li_cnt].i_movey = 0 Then
				inv_registered[li_cnt].i_movey = 100
			End If
			If inv_registered[li_cnt].b_scalewidth And inv_registered[li_cnt].i_scalewidth=0 Then
				inv_registered[li_cnt].i_scalewidth = 100
			End If
			If inv_registered[li_cnt].b_scaleheight And inv_registered[li_cnt].i_scaleheight=0 Then
				inv_registered[li_cnt].i_scaleheight = 100
			End If			
			
			// Support for weighted movement and sizing of controls.
			If inv_registered[li_cnt].b_movex Then 
				If inv_registered[li_cnt].i_movex > 100 Then 
					li_movex = inv_registered[li_cnt].i_movex - 100
					lr_move_deltax = li_deltawidth * li_movex / 100
				Else
					lr_move_deltax = ((inv_registered[li_cnt].r_x * lr_ratiowidth) - inv_registered[li_cnt].r_x) * inv_registered[li_cnt].i_movex / 100
				End If
			End If
			If inv_registered[li_cnt].b_movey Then 
				If inv_registered[li_cnt].i_movey > 100 Then 
					li_movey = inv_registered[li_cnt].i_movey - 100
					lr_move_deltay = li_deltaheight * li_movey / 100
				Else
					lr_move_deltay = ((inv_registered[li_cnt].r_y * lr_ratioheight) - inv_registered[li_cnt].r_y) * inv_registered[li_cnt].i_movey / 100
				End If
			End If
			If inv_registered[li_cnt].b_scalewidth Then 
				If inv_registered[li_cnt].i_scalewidth > 100 Then 
					li_scalewidth = inv_registered[li_cnt].i_scalewidth - 100
					lr_resize_deltawidth = li_deltawidth * li_scalewidth / 100
				Else
					lr_resize_deltawidth = ((inv_registered[li_cnt].r_width * lr_ratiowidth) - inv_registered[li_cnt].r_width) * inv_registered[li_cnt].i_scalewidth / 100
				End If
			End If
			If inv_registered[li_cnt].b_scaleheight Then 
				If inv_registered[li_cnt].i_scaleheight > 100 Then 
					li_scaleheight = inv_registered[li_cnt].i_scaleheight - 100
					lr_resize_deltaheight = li_deltaheight * li_scaleheight / 100
				Else
					lr_resize_deltaheight = ((inv_registered[li_cnt].r_height * lr_ratioheight) - inv_registered[li_cnt].r_height) * inv_registered[li_cnt].i_scaleheight /100
				End If
			End If
		End If

		//If appropriate move the control along the X and Y attribute.
		If lr_move_deltax <> 0 Or lr_move_deltay <> 0 Then	
			//Save the 'exact' X and Y attributes.
			inv_registered[li_cnt].r_x = inv_registered[li_cnt].r_x + lr_move_deltax		
			inv_registered[li_cnt].r_y = inv_registered[li_cnt].r_y + lr_move_deltay
			
			If Pos(ls_type, LINE) > 0 Then
				inv_registered[li_cnt].r_width = inv_registered[li_cnt].r_width + lr_move_deltax
				inv_registered[li_cnt].r_height = inv_registered[li_cnt].r_height + lr_move_deltay
				ls_singlemodifyexp = ls_singlemodifyexp + &
									inv_registered[li_cnt].s_control+'.X1 = '+string(Integer(inv_registered[li_cnt].r_x))+' '+&
									inv_registered[li_cnt].s_control+'.X2 = '+string(Integer(inv_registered[li_cnt].r_width))+' '+&
									inv_registered[li_cnt].s_control+'.Y1 = '+string(Integer(inv_registered[li_cnt].r_y))+' '+ &
									inv_registered[li_cnt].s_control+'.Y2 = '+string(Integer(inv_registered[li_cnt].r_height))+' '
			Else
				ls_singlemodifyexp = ls_singlemodifyexp + &
									inv_registered[li_cnt].s_control+'.X = '+string(Integer(inv_registered[li_cnt].r_x))+' '+&
									inv_registered[li_cnt].s_control+'.Y = '+string(Integer(inv_registered[li_cnt].r_y))+' '					
			End If
		End If /* Move */
		
		//If appropriate Resize the Width And Height of the control.
		If lr_resize_deltawidth <> 0 Or lr_resize_deltaheight <> 0 Then		
			//Save the 'exact' Width and Height attributes.
			inv_registered[li_cnt].r_width = inv_registered[li_cnt].r_width + lr_resize_deltawidth	
			inv_registered[li_cnt].r_height = inv_registered[li_cnt].r_height + lr_resize_deltaheight		

			// Determine the placement variables.
			If inv_registered[li_cnt].r_width > MINIMUM_SIZE  Then
				li_placewidth = inv_registered[li_cnt].r_width
			Else
				li_placewidth = MINIMUM_SIZE 
			End If
			If inv_registered[li_cnt].r_height > MINIMUM_SIZE  Then
				li_placeheight = inv_registered[li_cnt].r_height
			Else
				li_placeheight = MINIMUM_SIZE 
			End If							
			
			If Pos(ls_type, LINE) > 0 Then
				ls_singlemodifyexp = ls_singlemodifyexp + &
									inv_registered[li_cnt].s_control+'.X2 = '+string(Integer(li_placewidth))+' '+ &
									inv_registered[li_cnt].s_control+'.Y2 = '+string(Integer(li_placeheight))+' '				
			Else
				ls_singlemodifyexp = ls_singlemodifyexp + &
									inv_registered[li_cnt].s_control+'.Width = '+string(Integer(li_placewidth))+' '+ &
									inv_registered[li_cnt].s_control+'.Height = '+string(Integer(li_placeheight))+' '				
			End If			
		End If /* Resize */

		// Batch all into one Large Modify expression.
		If Len(ls_singlemodifyexp) > 0 Then
			ls_complexmodifyexp += '   ' + ls_singlemodifyexp
		End If
		
	End If /* If IsValid(inv_registered[li_cnt].wo_control) Then */
Next /* For li_cnt = 1 to li_upperbound */

// Execute the one Modify expression.
If Len(ls_complexmodifyexp) > 0 Then
	ls_modifyret = idw_requestor.Modify(ls_complexmodifyexp)
	If IsNull(ls_modifyret) or Len(ls_modifyret) > 0 Then	
		Return -1
	End If				
End If

Return 1

end function

protected function integer of_register (string as_control, boolean ab_scale, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Register
//
//	Access:  		protected
//
//	Arguments:		
//	 as_control			The object being registered.
//  ab_scale			If the object should be registered as a Scale type.
//  ai_movex			The percentage to move the object along the x axis.
//  ai_movey			The percentage to move the object along the y axis.
//  ai_scalewidth 	The percentage to scale the object along the x axis.
//  ai_scaleheight	The percentage to scale the object along the y axis.
//
//	Returns:  		integer
//						1 if it succeeds and -1 if an error occurs.
//
//	Description:  	
//	Register a control which needs to either be moved or resized when the parent
//	object is resized.  The action taken on this control depends on the four
//	attributes: ai_movex, ai ai_movey, ai_scalewidth, ai_scaleheight.
//
//	Note:
//	The service object needs to be initialized (of_SetOrigSize()) prior to	
//	any registering (this function) of objects.
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

integer			li_rc
integer			li_x, li_y, li_width, li_height
integer			li_upperbound
integer			li_cnt
integer			li_slot_available
boolean			lb_movex=False, lb_movey=False
boolean			lb_scalewidth=False, lb_scaleheight=False
string			ls_describeret, ls_describeexp
string			ls_type

// Validate the reference.
If IsNull(idw_requestor) or Not IsValid(idw_requestor) Then
	Return -1
End If

//Check parameters
If IsNull(as_control) or Len(Trim(as_control))=0 or &
	IsNull(ab_scale) or &
	IsNull(ai_movex) or ai_movex<0 or ai_movex>200 or &
	IsNull(ai_movey) or ai_movey<0 or ai_movey>200 or &
	IsNull(ai_scalewidth) or ai_scalewidth<0 or ai_scalewidth>200 or & 
	IsNull(ai_scaleheight) or ai_scaleheight<0 or ai_scaleheight>200 Then
	Return -1
End If

// Validate the object.
ls_describeret = idw_requestor.Describe(as_control+'.Attributes')
If IsNull(ls_describeret) or ls_describeret='!' or ls_describeret='?' Then
	Return -1
End If

//Translate parameteters.
If ab_scale Then
	ai_movex = 0
	ai_movey = 0
	ai_scalewidth = 0
	ai_scaleheight = 0
End If
lb_movex = (ai_movex > 0)
lb_movey = (ai_movey > 0)
lb_scalewidth = (ai_scalewidth > 0)
lb_scaleheight = (ai_scaleheight > 0)

//Confirm that the user object has already been initialized
If il_parentprevheight=-1 And il_parentprevwidth=-1 Then
	Return -1
End If

//Get the previous Bound
li_upperbound = UpperBound (inv_registered[])

//Determine if there is an open slot available other than a
//new entry on the array
li_slot_available = 0
For li_cnt = 1 to li_upperbound
	If IsNull(inv_registered[li_cnt].s_control) Or &
		Len(Trim(inv_registered[li_cnt].s_control))=0 Then
		If li_slot_available = 0 Then
			//Get the first slot found
			li_slot_available = li_cnt
		End If
	Else
		//Check if control has already been registered
		If inv_registered[li_cnt].s_control = as_control Then
			Return -1
		End If
	End If
Next

//If an available slot was not found then create a new entry
If li_slot_available = 0 Then
	li_slot_available = li_upperbound + 1
End If

///////////////////////////////////////////////////////////////////////////////////////
//Get the current object information/coordinates
///////////////////////////////////////////////////////////////////////////////////////
li_rc = of_GetObjectInformation (as_control, ls_type, li_x, li_y, li_width, li_height)
If li_rc < 0 then Return -1

///////////////////////////////////////////////////////////////////////////////////////
//Register the new object
///////////////////////////////////////////////////////////////////////////////////////

//Register the actual object
inv_registered[li_slot_available].s_control = as_control
inv_registered[li_slot_available].s_typeof = ls_type	

//Set the behavior attributes
inv_registered[li_slot_available].b_movex = lb_movex
inv_registered[li_slot_available].i_movex = ai_movex
inv_registered[li_slot_available].b_movey = lb_movey
inv_registered[li_slot_available].i_movey = ai_movey
inv_registered[li_slot_available].b_scalewidth = lb_scalewidth
inv_registered[li_slot_available].i_scalewidth = ai_scalewidth
inv_registered[li_slot_available].b_scaleheight = lb_scaleheight
inv_registered[li_slot_available].i_scaleheight = ai_scaleheight
inv_registered[li_slot_available].b_scale = ab_scale

//Set the initial position/size attributes
inv_registered[li_slot_available].r_x = li_x
inv_registered[li_slot_available].r_y = li_y
inv_registered[li_slot_available].r_width = li_width
inv_registered[li_slot_available].r_height = li_height

Return 1

end function

on pro_n_cst_dwsrv_resize.create
call super::create
end on

on pro_n_cst_dwsrv_resize.destroy
call super::destroy
end on

