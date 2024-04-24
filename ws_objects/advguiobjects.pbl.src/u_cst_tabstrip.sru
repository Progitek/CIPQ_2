$PBExportHeader$u_cst_tabstrip.sru
forward
global type u_cst_tabstrip from u_canvas
end type
type trackmouseevent from structure within u_cst_tabstrip
end type
end forward

global type trackmouseevent from structure
 unsignedlong  cbSize 
 unsignedlong  dwFlags 
 unsignedlong  hwndTrack 
 unsignedlong  dwHoverTime 
end type

global type u_cst_tabstrip from u_canvas
event mouseenter ( )
event mouseleave ( )
event mousemove pbm_mousemove
event lbuttonup pbm_lbuttonup
end type
global u_cst_tabstrip u_cst_tabstrip

type prototypes
PUBLIC FUNCTION Long SetParent(Long lChild, Long lParent) LIBRARY "user32.dll"
Function ulong SetCapture(ulong hWnd) Library "USER32.DLL"
Function BOOLEAN ReleaseCapture() Library "USER32.DLL"

Function Boolean TrackMouseEvent ( ref trackmouseevent lpTrackMouseEvent ) Library 'user32.dll' alias for "TrackMouseEvent;Ansi"
end prototypes

type variables
Boolean ib_selected
Boolean ib_mousecaptured

u_cst_tabcontrol iuo_parent

n_cst_tooltip 	inv_tooltip

Long il_ID

PRIVATE:
constant ulong WM_MOUSELEAVE = 675 
constant uLong TME_LEAVE = 2 
trackmouseevent istr_TRACKMOUSEEVENT
end variables

forward prototypes
public function integer of_capturemouse ()
public function boolean of_ismousecaptured ()
public function integer of_releasemouse ()
public function integer of_setparent (u_cst_tabcontrol auo_parent)
end prototypes

event mouseenter();TrackMouseEvent(istr_TRACKMOUSEEVENT) 
SetRedraw(TRUE)
end event

event mouseleave();of_ReleaseMouse()
iuo_parent.of_MouseLeave()
end event

event mousemove;Long ll_index

if NOT of_ismousecaptured() then 
	
	of_capturemouse()
	
	this.event mouseenter()
		
else
	
//	if xpos < 0 or ypos < 0 or xpos > width or ypos > height then
//	
//		of_releasemouse()
//		
//		this.event mouseleave()
//	
//	ELSE

		ll_index = iuo_parent.of_IndexFromPoint(xpos, ypos)
		IF iuo_parent.il_index <> ll_index THEN
			iuo_parent.of_MouseOver(ll_index)
			
			IF iuo_parent.il_index > 0 THEN
				IF Len(Trim(iuo_parent.of_GetTipText(iuo_parent.il_index))) > 0 THEN
					Long li_X, li_Y, ll_return
		
					IF il_Id > 0 THEN
						li_X = 0//UnitsToPixels( Integer( X ),XUnitsToPixels! )
						li_Y = 0//UnitsToPixels( Integer( Y ), YUnitsToPixels! )
						inv_tooltip.of_UpdatetipRect( This, il_ID, &
														li_x, li_y, &
														li_x + UnitsToPixels( Integer( Width ), XUnitsToPixels! ), &
														li_y + UnitsToPixels( Integer( Height ), YUnitsToPixels! ) )
							
						
						inv_tooltip.Of_SetTipText( This, il_Id, iuo_parent.of_GetTipText(ll_index)) 
					END IF
				ELSE
					inv_tooltip.of_UpdatetipRect( This, il_ID, &
														0, 0, &
														0, &
														0 )
				END IF
			END IF
		END IF
	//END IF


end if
end event

public function integer of_capturemouse ();
if of_ismousecaptured() then Return -1

//SetCapture(handle(this))

ib_mousecaptured = TRUE

return 1
end function

public function boolean of_ismousecaptured ();return ib_mousecaptured
end function

public function integer of_releasemouse ();
if NOT of_ismousecaptured() then return -1

//ReleaseCapture()

ib_mousecaptured = FALSE

Return 1
end function

public function integer of_setparent (u_cst_tabcontrol auo_parent);iuo_parent = auo_parent

RETURN 1

end function

on u_cst_tabstrip.create
call super::create
end on

on u_cst_tabstrip.destroy
call super::destroy
end on

event constructor;call super::constructor;il_ID = inv_ToolTip.of_AddTool( THIS, "" , inv_ToolTip.TTF_SUBCLASS ) 

istr_TrackMouseEvent.cbSize = 16
istr_TrackMouseEvent.dwFlags = TME_LEAVE
istr_TrackMouseEvent.hwndTrack = Handle (THIS) 
istr_TrackMouseEvent.dwHoverTime = 0
end event

event other;call super::other;CHOOSE CASE Message.Number 
	CASE WM_MOUSELEAVE
		this.Event MouseLeave() 
END CHOOSE
end event

