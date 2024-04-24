$PBExportHeader$n_cst_array.sru
forward
global type n_cst_array from n_base
end type
end forward

global type n_cst_array from n_base autoinstantiate
end type

forward prototypes
public function integer of_sort (ref any aa_list[], integer ai_order)
public function integer of_sort (ref any aa_list[])
public function integer of_insert (ref any aa_list[], any aa_element, long al_position)
public function integer of_add (ref any aa_list[], any aa_element)
public function integer of_remove (ref any aa_list[], long al_position)
public function integer of_remove (ref any aa_list[], long al_pos, long al_len)
public function long of_find (ref any aa_list[], any aa_element, long al_start, long al_end)
public function long of_find (ref any aa_list[], any aa_element, long al_start)
public function long of_find (ref any aa_list[], any aa_element)
end prototypes

public function integer of_sort (ref any aa_list[], integer ai_order);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Sort (Ref any aa_list[], integer ai_order)
//
//	Access: 			public
//
//	Arguments:
//	ref any aa_list[]  	An array of data to be sorted 
//	Integer ai_order		0 - ascending;  1 - descending
//
//	Returns: 		Integer
//						1	Sort successfully
//						-1  If any arguments are invalid
//						0	 No action has been taken
//
//	Description:   Sort a list of sortable data 
//
//////////////////////////////////////////////////////////////////////////////
//	Author:	Lijun Yang (Lijun.Yang@worldnet.att.net )
//
//	Date:		10/1/97
//
//=============================================================================
//
//	Revision History
//
//	Date			Initials		Description of Change
//	----   		--------		--------------------
//	10/1/97		L.Y.			Initial creation
//=============================================================================


long ll_bound,  ll_i, ll_len, ll_max, ll_pos
string ls_type
datastore lds_1

//Check argument
If IsNull (ai_order) or ai_order > 1 or ai_order < 0 Then Return -1

ll_bound = UpperBound(aa_list[])

Choose Case ll_bound
	Case 0
		return -1
	Case 1
		Return 0
End Choose

ls_type = ClassName (aa_list[1])

Choose Case ls_type
	Case 'string' //string
		//Determine that maximum length of string
		For ll_i = 1 to ll_bound
			ll_len = len (string(aa_list[ll_i]))
			If ll_len > ll_max Then ll_max = ll_len
		Next
		ls_type = 'char(' + string(ll_max) + ')'
	Case 'integer','unsignedinteger', 'number', &
		'long', 'ulong', 'unsignedlong','decimal' //numerical data promoted to decimal
		//Determine that maximum number of decimal places
		For ll_i = 1 to ll_bound
			ll_pos = pos (string(aa_list[ll_i]), '.')
			If ll_pos > 0 Then ll_len = len (string(aa_list[ll_i])) - ll_pos
			If ll_pos > ll_max Then ll_max = ll_pos
		Next
		ls_type = 'decimal(' + string (ll_max) + ')'
		
	Case 'date', 'datetime', 'real', 'time'
		//Legitimate Data type
	Case Else //unsortable or unsuported data type
		Return -1
End Choose

lds_1 = create datastore

// Generate data object
lds_1.Create('release 5; datawindow() table(column=(type=' + & 
				ls_type + ' name=dummy dbname="dummy" ))')
			
//Assign data to datastore				
lds_1.Object.dummy.Primary = aa_list				

//set sort order
If ai_order = 0 Then
	lds_1.SetSort("#1 A")
Else
	lds_1.SetSort("#1 D")
End If
	
lds_1.Sort()

//Get data from datastore
aa_list = lds_1.Object.dummy.Primary

destroy lds_1

return 1

end function

public function integer of_sort (ref any aa_list[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Sort (Ref any aa_list[])
//
//	Access: 			public
//
//	Arguments:
//	ref any aa_list[]  	An array of data to be sorted 
//
//	Returns: 		Integer
//						1	Sort successfully
//						-1  If any arguments are invalid
//						0	 No action has been taken
//
//	Description:   Sort a list of sortable data in ascending order
//
//////////////////////////////////////////////////////////////////////////////
//	Author:	Lijun Yang (Lijun.Yang@worldnet.att.net )
//
//	Date:		10/1/97
//
//=============================================================================
//
//	Revision History
//
//	Date			Initials		Description of Change
//	----   		--------		--------------------
//	10/1/97		L.Y.			Initial creation
//=============================================================================

Return of_sort (aa_list, 0)

end function

public function integer of_insert (ref any aa_list[], any aa_element, long al_position);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_insert (Ref any aa_list[], Any aa_element
//											long al_position)
//
//	Access: 			public
//
//	Arguments:
//	ref any aa_list[]  	The specified array
//	any	aa_element		The content of the element or an array
//	long al_position		The position where to insert the element,
//								If al_position = 0 or greater then the upper bound then
//								append the element to the array
//
//	Returns: 		Integer
//						1	 insert successfully
//						-1  failed to insert the element
//
//	Description:   insert an element or array into an array
//
//////////////////////////////////////////////////////////////////////////////
//	Author:	Lijun Yang (Lijun.Yang@worldnet.att.net or Yangl@sprintmail.com)
//
//	Date:		10/1/97
//
//=============================================================================
//
//	Revision History
//
//	Date			Initials		Description of Change
//	----   		--------		--------------------
//	10/1/97		L.Y.			Initial creation
// 1/8/97		L.Y.			Handle the situation of one array interting into
//									another
//=============================================================================

long	ll_bound1, ll_bound2, ll_i, ll_j
any la_element[]

//Check argument
If IsNull (aa_list[]) or &
	IsNull (al_position) or al_position < 0 Then Return -1
	
If classname (aa_element) = 'any' Then
	la_element = aa_element
Else
	la_element[1] = aa_element
End If

ll_bound1 = UpperBound(aa_list[])
ll_bound2 = UpperBound(la_element[])

If al_position = 0 Then al_position = ll_bound1 + 1

If al_position < ll_bound1 Then
	
	//move the seocnd portion of list1 to the end
	ll_bound1 = ll_bound1 + ll_bound2
	ll_j = al_position + ll_bound2
	For ll_i = ll_bound1 To ll_j Step -1	
		aa_list[ll_i ] = aa_list[ll_i - ll_bound2 ]
	Next
	
End If 	

//Assing elements of list2 to list1
al_position = al_position - 1
For ll_i = 1 To ll_bound2		
	aa_list[al_position + ll_i ] = la_element[ll_i]
Next

Return 1


end function

public function integer of_add (ref any aa_list[], any aa_element);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_add (Ref any aa_list[], Any aa_element)
//
//	Access: 			public
//
//	Arguments:
//	ref any aa_list[]  	The specified array
//	any	aa_element		The content of the element to be added
//
//	Returns: 		Integer
//						1	 add the element successfully
//						-1  failed to insert the element
//
//	Description:   add an element to an array
//
//////////////////////////////////////////////////////////////////////////////
//	Author:	Lijun Yang (Lijun.Yang@worldnet.att.net )
//
//	Date:		10/1/97
//
//=============================================================================
//
//	Revision History
//
//	Date			Initials		Description of Change
//	----   		--------		--------------------
//	10/1/97		L.Y.			Initial creation
//=============================================================================

Return of_insert (aa_list, aa_element, upperbound (aa_list[]) + 1)

end function

public function integer of_remove (ref any aa_list[], long al_position);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_remove (Ref any aa_list[], long al_position)
//
//	Access: 			public
//
//	Arguments:
//	ref any aa_list[]  	The specified array
//	long al_position		The position where the element to be removed
//								
//	Returns: 		Integer
//						1	 remove successfully
//						-1  failed to remove the element
//
//	Description:   remove an element from an array
//
//////////////////////////////////////////////////////////////////////////////
//	Author:	Lijun Yang (Lijun.Yang@worldnet.att.net )
//
//	Date:		10/1/97
//
//=============================================================================
//
//	Revision History
//
//	Date			Initials		Description of Change
//	----   		--------		--------------------
//	10/1/97		L.Y.			Initial creation
//=============================================================================

return of_remove (aa_list, al_position, 1)
end function

public function integer of_remove (ref any aa_list[], long al_pos, long al_len);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_remove (Ref any aa_list[], long al_pos, long al_len)
//
//	Access: 			public
//
//	Arguments:
//	ref any aa_list[]  	The specified array
//	long al_pos			The position of the first element to be removed
//	long al_len			The length of elements to be removed
//
//	Returns: 		Integer
//						1	 remove successfully
//						0   no action has been taken
//						-1  failed to remove the element
//
//	Description:   remove array elements from position1 to position2
//
//////////////////////////////////////////////////////////////////////////////
//	Author:	Lijun Yang (Lijun.Yang@worldnet.att.net )
//
//	Date:		10/1/97
//
//=============================================================================
//
//	Revision History
//
//	Date			Initials		Description of Change
//	----   		--------		--------------------
//	10/1/97		L.Y.			Initial creation
//=============================================================================

long	ll_bound,  ll_i
any 	la_list[]

//Check argument
If IsNull (aa_list[]) or IsNull (al_pos) or al_pos <= 0 or &
	IsNull (al_len) or al_len <= 0 Then Return -1

ll_bound = upperbound (aa_list[])

If al_pos > ll_bound then return 0

// Get the elements before al_pos
al_pos --
For ll_i = 1 to al_pos
	la_list[ll_i] = aa_list [ll_i]
Next

//Set the position to the last removed element
al_pos = al_pos + al_len

If al_pos < ll_bound Then

	//Redefine the upper bound
	ll_bound = ll_bound - al_len
	//get the remaining elements
	For ll_i = ll_i To ll_bound
		al_pos ++
		la_list[ll_i] = aa_list[al_pos]
	Next
End If 	

aa_list = la_list
Return 1

end function

public function long of_find (ref any aa_list[], any aa_element, long al_start, long al_end);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_insert (Ref any aa_list[], Any aa_element
//											long al_start, long al_end)
//
//	Access: 			public
//
//	Arguments:
//	ref any aa_list[]  	The specified array
//	any	aa_element		The content of the element
//	long al_start			The starting position
//	long al_end 			The ending position
//
//	Returns: 		long
//						the poisiton of the found element
//						0 	the element is not found
//						-1  error
//
//	Description:   find an element in an array between two positions
//
//////////////////////////////////////////////////////////////////////////////
//	Author:	Lijun Yang (Lijun.Yang@worldnet.att.net )
//
//	Date:		11/10/97
//
//=============================================================================
//
//	Revision History
//
//	Date			Initials		Description of Change
//	----   		--------		--------------------
//	11/10/97		L.Y.			Initial creation
//=============================================================================

long	ll_bound, ll_i

//Check argument
If IsNull (aa_list[]) or IsNull (aa_element)  &
	Or IsNull (al_start) or al_start <= 0 &
	Or IsNull (al_end) or al_end <= 0 &
	Then Return -1

ll_bound = UpperBound(aa_list[])

If al_end < al_start Then
	//Swap al_start and al_end
	ll_i = al_start
	al_start = al_end
	al_end = ll_i
End IF 

//check the range of starting position
If al_start > ll_bound then return 0

//check the range of the ending position
IF al_end > ll_bound Then al_end = ll_bound 

For ll_i = al_start to al_end
	If aa_list[ll_i] = aa_element Then Return ll_i
Next

Return 0

end function

public function long of_find (ref any aa_list[], any aa_element, long al_start);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_insert (Ref any aa_list[], Any aa_element
//											long al_start)
//
//	Access: 			public
//
//	Arguments:
//	ref any aa_list[]  	The specified array
//	any	aa_element		The content of the element
//	long al_start			The starting position
//
//	Returns: 		long
//						the poisiton of the found element
//						0 	the element is not found
//						-1  error
//
//	Description:   find an element in an array from the starting position
//
//////////////////////////////////////////////////////////////////////////////
//	Author:	Lijun Yang (Lijun.Yang@worldnet.att.net )
//
//	Date:		11/10/97
//
//=============================================================================
//
//	Revision History
//
//	Date			Initials		Description of Change
//	----   		--------		--------------------
//	11/10/97		L.Y.			Initial creation
//=============================================================================

return of_find (ref aa_list[], aa_element, al_start, upperbound (aa_list[]))
end function

public function long of_find (ref any aa_list[], any aa_element);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_insert (Ref any aa_list[], Any aa_element)
//
//	Access: 			public
//
//	Arguments:
//	ref any aa_list[]  	The specified array
//	any	aa_element		The content of the element
//
//	Returns: 		long
//						the poisiton of the found element
//						0 	the element is not found
//						-1  error
//
//	Description:   find an element in an array in the whole range
//
//////////////////////////////////////////////////////////////////////////////
//	Author:	Lijun Yang (Lijun.Yang@worldnet.att.net )
//
//	Date:		11/10/97
//
//=============================================================================
//
//	Revision History
//
//	Date			Initials		Description of Change
//	----   		--------		--------------------
//	11/10/97		L.Y.			Initial creation
//=============================================================================

return of_find (ref aa_list[], aa_element, 1, upperbound (aa_list[]))
end function

on n_cst_array.create
TriggerEvent( this, "constructor" )
end on

on n_cst_array.destroy
TriggerEvent( this, "destructor" )
end on

