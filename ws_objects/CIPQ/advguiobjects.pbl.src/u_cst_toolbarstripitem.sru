$PBExportHeader$u_cst_toolbarstripitem.sru
forward
global type u_cst_toolbarstripitem from u_canvas
end type
end forward

global type u_cst_toolbarstripitem from u_canvas
end type
global u_cst_toolbarstripitem u_cst_toolbarstripitem

forward prototypes
public function integer of_displaytext (boolean ab_display)
public function string of_gettext ()
public function integer of_setenabled (boolean ab_switch)
public function integer of_setstyle (long al_style)
public function integer of_setimage (string as_image)
public function string of_getimage ()
end prototypes

public function integer of_displaytext (boolean ab_display);RETURN 1
end function

public function string of_gettext ();RETURN ''
end function

public function integer of_setenabled (boolean ab_switch);RETURN 1
end function

public function integer of_setstyle (long al_style);RETURN 1
end function

public function integer of_setimage (string as_image);RETURN 0
end function

public function string of_getimage ();RETURN ''
end function

on u_cst_toolbarstripitem.create
call super::create
end on

on u_cst_toolbarstripitem.destroy
call super::destroy
end on

