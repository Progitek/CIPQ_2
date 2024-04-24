$PBExportHeader$pro_dyn_menu.sru
$PBExportComments$an NVO used for creating and deleting dynamic menu items.
forward
global type pro_dyn_menu from nonvisualobject
end type
end forward

global type pro_dyn_menu from nonvisualobject
event pro_clicked ( menu m_dynamic )
end type
global pro_dyn_menu pro_dyn_menu

type variables
pro_m_dynamic	im_dynamic[]
pro_m_dynamic	im_dynamic_top_lvl[]
menu			im_dynmenu

end variables

forward prototypes
public subroutine fnvdeleteallmenuitems ()
public subroutine fnvcreatedyntoplvlitem (string as_text, long al_id)
public subroutine fnvrefreshchilditems ()
public function long fnvcreatedyntoplvlitem (string as_text)
public subroutine fnvrefreshtoplevelitems ()
public function long fnvcreatedynmenuitem (string as_text)
public subroutine fnvdeletemenuitem (long al_id)
public subroutine fnvdeletetoplvlitem (long al_id)
public subroutine of_init (menu m_dynmenu)
public function long fnvcreatedynmenuitem (string as_text, long al_id)
end prototypes

public subroutine fnvdeleteallmenuitems ();////////////////////////////////////////////////////////////////////
//
// Function Name:	fnvDeleteAllMenuItems
//
// Of object:	nvo_dyn_menu_item_mgr
//
// Purpose:	will remove the dynamiclly created menu items and free up the memory they
//				consumed. 
//
// Requirements:	
//
// Arguments:	
//
// Return Values:	
//
// Modifications:	
//
////////////////////////////////////////////////////////////////////
integer		li_loop, li_ub
pro_m_dynamic	lm_null[]

/*	get the number of dynamic menu items. */
li_ub = upperbound( im_dynamic[] )

/*	loop through(backward) destroying all items. */
for li_loop = li_ub to 1 step -1
	destroy im_dynamic[li_loop]
next

/*	reinitialize menu item array. */
im_dynamic = lm_null

/*	get the number of dynamic top level menu items. */
li_ub = upperbound( im_dynamic_top_lvl[] )

/*	loop through(backward) destroying all items. */
for li_loop = li_ub to 1 step -1
	destroy im_dynamic_top_lvl[li_loop]
next

/*	reinitialize menu item array. */
im_dynamic_top_lvl = lm_null

end subroutine

public subroutine fnvcreatedyntoplvlitem (string as_text, long al_id);////////////////////////////////////////////////////////////////////
//
// Function Name:	fnvCreateDynTopLvlitem
//
// Of object:	nvo_dyn_menu_item
//
// Purpose:	creates a dynamic menu item
//
// Requirements:	
//
// Arguments:	as_text, the text to display;  al_id, the ID to assign the menu item (if
//					you have a unique id in mind already)
//					
//
// Return Values:	none
//
// Modifications:	
//
////////////////////////////////////////////////////////////////////
integer	li_loop, li_loopmax, li_index, li_ub

/*	get the number of items im_dynamic already. */
li_ub = upperbound( im_dynamic_top_lvl )

/*	add 1 for placement of new m_dynamic instance. */
li_ub++

/*	create dynamic menu item. */		
im_dynamic_top_lvl[li_index] = create pro_m_dynamic
im_dynamic_top_lvl[li_index].setMenu(this)

/*	assign text to the menu item. */
im_dynamic_top_lvl[li_ub].fmSetText( as_text )

/*	assign the item's id. */
im_dynamic_top_lvl[li_ub].fmSetID( al_id )

//////////////////////////////////////////////////////////////////////////////////////
//	now attach the menu item to the menu( I know the right side of the assignment LOOKS
//	wrong, but trust me, it has to be that way).
//////////////////////////////////////////////////////////////////////////////////////

 im_dynmenu.item[UpperBound( im_dynmenu.item[] ) + 1] = im_dynamic_top_lvl[li_ub]

//////////////////////////////////////////////////////////////////////////////////////
//	NOTE:  the above code adds the items to the first cascade.  you can create a second
//	cascade off of the first one simply by referencing an existing item on the first 
//	cascade menu.
//////////////////////////////////////////////////////////////////////////////////////

/*	do a hide and show so new menu item will show up. */

im_dynmenu.item[li_ub].hide()
im_dynmenu.item[li_ub].show()

end subroutine

public subroutine fnvrefreshchilditems ();////////////////////////////////////////////////////////////////////
//
// Function Name:	fnvRefreshChildItems
//
// Of object:	nvo_dyn_menu_item
//
// Purpose:	refreshes the child menu items to the menu
//
// Requirements:	
//
// Arguments:	none
//
// Return Values:	none
//
// Modifications:	
//
////////////////////////////////////////////////////////////////////
integer	li_loop, li_max

/*	how many dynamic children? */
li_max = UpperBound( im_dynamic )

/*	recreate and reattach all the remaining dynamic items. */
for li_loop = 1 to li_max
	////////////////////////////////////////////////////////////////////////////////////
	//	attach new item to visible menu.  NOTE: the syntax is weird, but this will attach
	//	an item as a cascaded item off of the first level cascade.
	////////////////////////////////////////////////////////////////////////////////////
	im_dynmenu.item[li_loop] = im_dynamic[li_loop]
next

/*	do a hide and show so new menu item will show up. */
im_dynmenu.hide()
im_dynmenu.show()

end subroutine

public function long fnvcreatedyntoplvlitem (string as_text);////////////////////////////////////////////////////////////////////
//
// Function Name:	fnvCreateDynTopLvlItem
//
// Of object:	nvo_dyn_menu_item
//
// Purpose:	creates a dynamic top level menu item
//
// Requirements:	
//
// Arguments:	as_text, the text to display;  
//
// Return Values:	long, the ID assigned to this menu item. 
//
// Modifications:	
//
////////////////////////////////////////////////////////////////////
integer	li_loop, li_loopmax, li_ub
long		ll_id

/*	get the number of items im_dynamic already. */
li_ub = upperbound( im_dynamic_top_lvl )

/*	assign an id. */
if li_ub = 0 then
	/*	first item, use '1'. */
	ll_id = 1
else
	/*	get the ID of the last item in the array. */
	ll_id = im_dynamic_top_lvl[li_ub].fmGetID()
	
	/*	increment. */
	ll_id++
end if

/*	add 1 for placement of new m_dynamic instance. */
li_ub++

/*	create dynamic menu item. */		
im_dynamic_top_lvl[li_ub] = create pro_m_dynamic
im_dynamic_top_lvl[li_ub].setMenu(this)

/*	assign text to the menu item. */
im_dynamic_top_lvl[li_ub].fmSetText( as_text )

/*	assign the item's id. */
im_dynamic_top_lvl[li_ub].fmSetID( ll_id )

//////////////////////////////////////////////////////////////////////////////////////
//	now attach the menu item to the menu( I know the right side of the assignment LOOKS
//	wrong, but trust me, it has to be that way).
//////////////////////////////////////////////////////////////////////////////////////

im_dynmenu.item[UpperBound( im_dynmenu.item[] ) + 1] = im_dynamic_top_lvl[li_ub]

//////////////////////////////////////////////////////////////////////////////////////
//	NOTE:  the above code adds the items to the first cascade.  you can create a second
//	cascade off of the first one simply by referencing an existing item on the first 
//	cascade menu.
//////////////////////////////////////////////////////////////////////////////////////

/*	do a hide and show so new menu item will show up. */

im_dynmenu.hide()
im_dynmenu.show()

/*	at this point you could add logic for checking items, etc. */

/*	return the ID of the new menu item. */
return ll_id

end function

public subroutine fnvrefreshtoplevelitems ();////////////////////////////////////////////////////////////////////
//
// Function Name:	fnvRefreshTopLevelItems
//
// Of object:	nvo_dyn_menu_item
//
// Purpose:	refreshes the top level menu items to the menu
//
// Requirements:	
//
// Arguments:	none
//
// Return Values:	none
//
// Modifications:	
//
////////////////////////////////////////////////////////////////////
integer	li_loop, li_max

/*	how many dynamic top levels? */
li_max = UpperBound( im_dynamic_top_lvl )

/*	recreate and reattach all the remaining dynamic items. */
for li_loop = 1 to li_max
	////////////////////////////////////////////////////////////////////////////////////
	//	attach new item to visible menu.  NOTE: the syntax is weird, but this will attach
	//	an item as a cascaded item off of the first level cascade.
	////////////////////////////////////////////////////////////////////////////////////
	im_dynmenu.item[ UpperBound( im_dynmenu.Item[] ) + li_loop ] = im_dynamic_top_lvl[li_loop]
next

/*	do a hide and show so new menu item will show up. */
im_dynmenu.hide()
im_dynmenu.show()

end subroutine

public function long fnvcreatedynmenuitem (string as_text);////////////////////////////////////////////////////////////////////
//
// Function Name:	fnvCreateDynMenuitem
//
// Of object:	nvo_dyn_menu_item
//
// Purpose:	creates a dynamic menu item
//
// Requirements:	
//
// Arguments:	as_text, the text to display;  
//
// Return Values:	long, the ID assigned to this menu item. 
//
// Modifications:	
//
////////////////////////////////////////////////////////////////////
integer	li_loop, li_loopmax, li_ub
long		ll_id

/*	get the number of items im_dynamic already. */
li_ub = upperbound( im_dynamic )

/*	assign an id. */
if li_ub = 0 then
	/*	first item, use '1'. */
	ll_id = 1
else
	/*	get the ID of the last item in the array. */
	ll_id = im_dynamic[li_ub].fmGetID()
	
	/*	increment. */
	ll_id++
end if

/*	add 1 for placement of new m_dynamic instance. */
li_ub++

/*	create dynamic menu item. */		
im_dynamic[li_ub] = create pro_m_dynamic
im_dynamic[li_ub].setMenu(this)

/*	assign text to the menu item. */
im_dynamic[li_ub].fmSetText( as_text )

/*	assign the item's id. */
im_dynamic[li_ub].fmSetID( ll_id )

//////////////////////////////////////////////////////////////////////////////////////
//	now attach the menu item to the menu( I know the right side of the assignment LOOKS
//	wrong, but trust me, it has to be that way).
//////////////////////////////////////////////////////////////////////////////////////

im_dynmenu.item[li_ub] = im_dynamic[li_ub]

//////////////////////////////////////////////////////////////////////////////////////
//	NOTE:  the above code adds the items to the first cascade.  you can create a second
//	cascade off of the first one simply by referencing an existing item on the first 
//	cascade menu.
//////////////////////////////////////////////////////////////////////////////////////

/*	do a hide and show so new menu item will show up. */

im_dynmenu.hide()
im_dynmenu.show()

/*	at this point you could add logic for checking items, etc. */

/*	return the ID of the new menu item. */
return ll_id

end function

public subroutine fnvdeletemenuitem (long al_id);////////////////////////////////////////////////////////////////////
//
// Function Name:	fnvDeleteMenuItem
//
// Of object:	
//
// Purpose:	will remove the menu item specified
//
// Requirements:	none
//
// Arguments:	al_id[], the ID associated with the menu item to remove/delete.
//
// Return Values:	
//
// Modifications:	
//
////////////////////////////////////////////////////////////////////
boolean	lb_delete = false, lb_removed_checked = false
integer	li_loop, li_max, li_index = 0, li_compare
integer	li_index_of_old_chkd_item
pro_m_dynamic	lm_hold[], lm_null[]

/*	get the number of dynamic menu items. */
li_max = upperbound( im_dynamic[] )
		
/*	spin thru im_dynmaic to find the item that matches the arg ID. */
for li_loop = 1 to li_max step 1

	/*	get the ID of the item currently pointed to. */
	li_compare = im_dynamic[li_loop].fmGetID()

	if li_compare = al_id then
		/*	found a match. */
		lb_delete = true
		
		/*	see if removing a checked item. */
		if im_dynamic[li_loop].checked then
			/*	yep.  save off the index of the item in the array for use later.*/
			li_index_of_old_chkd_item = li_loop
			
			/*	set flag. */
			lb_removed_checked = true
		end if
		
	else
		//////////////////////////////////////////////////////////////////////////////
		// not deleting, so save this item in the 'hold' array.  Unfortunately, cannot
		//	just do a straight assignment. 
		//////////////////////////////////////////////////////////////////////////////
		/*	increment the hold index. */
		li_index++
		
		/*	create a new memory block. */
		lm_hold[li_index] = create pro_m_dynamic
		
		/*	set the text. */
		lm_hold[li_index].mfSetText( im_dynamic[li_loop].text )
				
		/*	set the ID. */
		lm_hold[li_index].fmSetID( im_dynamic[li_loop].fmGetID() )
		
		/*	set the checked state. */
		lm_hold[li_index].mfChecked( im_dynamic[li_loop].checked )
	end if
next


/*	this processing will check one of the remaining items if removed a checked item. */
if lb_removed_checked then
	if li_index = 0 then
		/*	removed only item.  fall thru. */
	else
		if li_index >= li_index_of_old_chkd_item then
			/*	check the item that occupies the old chked item's slot. */
			lm_hold[li_index_of_old_chkd_item].fmChecked( true )
		else
			/*	check the last remainingitem. */
			lm_hold[li_index].fmChecked( true )
		end if
	end if
end if

///////////////////////////////////////////////////////////////////////////////////////
//	taking the 'brute force' method for updating the dynamic items:  delete them all and
//	recreate the ones that weren't deleted.
///////////////////////////////////////////////////////////////////////////////////////

/*	destroy all the dynamic menu items. */
for li_loop = li_max to 1 step -1
	destroy im_dynamic[li_loop]
next

/*	reinitialize the menu item array. */
im_dynamic[] = lm_null[]

/*	reduce li_max by 1 since deleted one item. */
li_max = li_max - 1

/*	recreate and reattach all the remaining dynamic items. */
for li_loop = 1 to li_max
	/*	create a new memory block. */
	im_dynamic[li_loop] = create pro_m_dynamic
	
	/*	set the text. */
	im_dynamic[li_loop].fmSetText( lm_hold[li_loop].text )
	
	/*	set the ID. */
	im_dynamic[li_loop].fmSetID( lm_hold[li_loop].fmGetID() )
			
	/*	checked state. */
	im_dynamic[li_loop].fmChecked( lm_hold[li_loop].checked )
next

/*	now spin thru and destroy the placeholders from lm_hold. */
for li_loop = 1 to li_max
	destroy lm_hold[li_loop]
next

/*	free up memory claimed claimed by lm_hold. */
lm_hold = lm_null

/*	call the child item refresh function. */
fnvRefreshChildItems()

end subroutine

public subroutine fnvdeletetoplvlitem (long al_id);////////////////////////////////////////////////////////////////////
//
// Function Name:	fnvDeleteMenuItem
//
// Of object:	
//
// Purpose:	will remove the menu item specified
//
// Requirements:	none
//
// Arguments:	al_id[], the ID associated with the menu item to remove/delete.
//
// Return Values:	
//
// Modifications:	
//
////////////////////////////////////////////////////////////////////
boolean	lb_delete = false, lb_removed_checked = false
integer	li_loop, li_max, li_index = 0, li_compare
integer	li_index_of_old_chkd_item
pro_m_dynamic	lm_hold[], lm_null[]

/*	get the number of dynamic menu items. */
li_max = upperbound( im_dynamic_top_lvl[] )
		
/*	spin thru im_dynmaic to find the item that matches the arg ID. */
for li_loop = 1 to li_max step 1

	/*	get the ID of the item currently pointed to. */
	li_compare = im_dynamic_top_lvl[li_loop].fmGetID()

	if li_compare = al_id then
		/*	found a match. */
		lb_delete = true
		
		/*	see if removing a checked item. */
		if im_dynamic_top_lvl[li_loop].checked then
			/*	yep.  save off the index of the item in the array for use later.*/
			li_index_of_old_chkd_item = li_loop
			
			/*	set flag. */
			lb_removed_checked = true
		end if
		
	else
		//////////////////////////////////////////////////////////////////////////////
		// not deleting, so save this item in the 'hold' array.  Unfortunately, cannot
		//	just do a straight assignment. 
		//////////////////////////////////////////////////////////////////////////////
		/*	increment the hold index. */
		li_index++
		
		/*	create a new memory block. */
		lm_hold[li_index] = create pro_m_dynamic
		
		/*	set the text. */
		lm_hold[li_index].mfSetText( im_dynamic_top_lvl[li_loop].text )
				
		/*	set the ID. */
		lm_hold[li_index].fmSetID( im_dynamic_top_lvl[li_loop].fmGetID() )
		
		/*	set the checked state. */
		lm_hold[li_index].mfChecked( im_dynamic_top_lvl[li_loop].checked )
	end if
next

/*	this processing will check one of the remaining items if removed a checked item. */
if lb_removed_checked then
	if li_index = 0 then
		/*	removed only item.  fall thru. */
	else
		if li_index >= li_index_of_old_chkd_item then
			/*	check the item that occupies the old chked item's slot. */
			lm_hold[li_index_of_old_chkd_item].fmChecked( true )
		else
			/*	check the last remainingitem. */
			lm_hold[li_index].fmChecked( true )
		end if
	end if
end if

///////////////////////////////////////////////////////////////////////////////////////
//	taking the 'brute force' method for updating the dynamic items:  delete them all and
//	recreate the ones that weren't deleted.
///////////////////////////////////////////////////////////////////////////////////////

/*	destroy all the dynamic menu items. */
for li_loop = li_max to 1 step -1
	destroy im_dynamic_top_lvl[li_loop]
next

/*	reinitialize the menu item array. */
im_dynamic_top_lvl[] = lm_null[]

/*	reduce li_max by 1 since deleted one item. */
li_max = UpperBound( lm_hold )

/*	recreate and reattach all the remaining dynamic items. */
for li_loop = 1 to li_max step 1
	/*	create a new memory block. */
	im_dynamic_top_lvl[li_loop] = create pro_m_dynamic
	
	/*	set the text. */
	im_dynamic_top_lvl[li_loop].fmSetText( lm_hold[li_loop].text )
	
	/*	set the ID. */
	im_dynamic_top_lvl[li_loop].fmSetID( lm_hold[li_loop].fmGetID() )
			
	/*	checked state. */
	im_dynamic_top_lvl[li_loop].fmChecked( lm_hold[li_loop].checked )
next

/*	now spin thru and destroy the placeholders from lm_hold. */
for li_loop = 1 to li_max
	destroy lm_hold[li_loop]
next

/*	free up memory claimed claimed by lm_hold. */
lm_hold = lm_null

//w_add_dyn_menu_items.ChangeMenu( m_main )

/*	call the top level item refresh function. */
fnvRefreshTopLevelItems()
/*	call the child item refresh function. */
fnvRefreshChildItems()

end subroutine

public subroutine of_init (menu m_dynmenu);im_dynmenu = m_dynmenu
end subroutine

public function long fnvcreatedynmenuitem (string as_text, long al_id);////////////////////////////////////////////////////////////////////
//
// Function Name:	fnvCreateDynMenuitem
//
// Of object:	nvo_dyn_menu_item
//
// Purpose:	creates a dynamic menu item
//
// Requirements:	
//
// Arguments:	as_text, the text to display;  al_id, the ID to assign the menu item (if
//					you have a unique id in mind already)
//					
//
// Return Values:	none
//
// Modifications:	
//
////////////////////////////////////////////////////////////////////
integer	li_loop, li_max, li_index, li_ub, li_compare, li_index_found_item
long		ll_id

/*	get the number of items im_dynamic already. */
li_ub = upperbound( im_dynamic )

if li_ub = 0 then
	/*	first item, use '1'. */
	ll_id = 1
else
	/*	get the ID of the last item in the array. */
	ll_id = im_dynamic[li_ub].fmGetID()
	
	/*	increment. */
	ll_id++
end if

/*	add 1 for placement of new m_dynamic instance. */
li_ub++

/*	create dynamic menu item. */		
im_dynamic[li_ub] = create pro_m_dynamic
im_dynamic[li_ub].setMenu(this)

/*	assign text to the menu item. */
im_dynamic[li_ub].fmSetText( as_text )

/*	assign the item's id. */
im_dynamic[li_ub].fmSetID( ll_id )

//////////////////////////////////////////////////////////////////////////////////////
// Find the menu item with this ID
//////////////////////////////////////////////////////////////////////////////////////

li_max = upperbound(im_dynmenu.item[])

/*	spin thru im_dynmaic to find the item that matches the arg ID. */
for li_loop = 1 to li_max step 1

	/*	get the ID of the item currently pointed to. */
	li_compare = im_dynamic_top_lvl[li_loop].fmGetID()

	if li_compare = al_id then
		/*	found a match. */
		/*	save off the index of the item in the array for use later.*/
		li_index_found_item = li_loop
	end if
next

/* if the item wasn't found, exit with error code */
if li_index_found_item = 0 then return -1

//////////////////////////////////////////////////////////////////////////////////////
//	now attach the menu item to the menu( I know the right side of the assignment LOOKS
//	wrong, but trust me, it has to be that way).
//////////////////////////////////////////////////////////////////////////////////////

im_dynmenu.item[li_index_found_item].item[upperbound(im_dynmenu.item[li_index_found_item].item[]) + 1] = im_dynamic[li_ub]

//////////////////////////////////////////////////////////////////////////////////////
//	NOTE:  the above code adds the items to the first cascade.  you can create a second
//	cascade off of the first one simply by referencing an existing item on the first 
//	cascade menu.
//////////////////////////////////////////////////////////////////////////////////////

/*	do a hide and show so new menu item will show up. */

im_dynmenu.item[li_index_found_item].hide()
im_dynmenu.item[li_index_found_item].show()

/*	return the ID of the new menu item. */
return ll_id

end function

on pro_dyn_menu.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pro_dyn_menu.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;/*	cleanup memory used by dynamic items. */
fnvDeleteAllMenuItems()

end event

event constructor;im_dynmenu = m_popup
end event

