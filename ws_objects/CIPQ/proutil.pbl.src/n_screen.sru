$PBExportHeader$n_screen.sru
forward
global type n_screen from nonvisualobject
end type
end forward

global type n_screen from nonvisualobject autoinstantiate
end type

type prototypes
Function long GetDeviceCaps(ulong hDC, int iCapability) Library "GDI32.DLL" 
Function ulong GetDC (ulong hWnd) Library "USER32.DLL"
end prototypes

forward prototypes
public function long of_getxpixelperinch ()
public function long of_getypixelperinch ()
public function decimal of_getx (string as_typeconv, decimal al_pixel)
public function decimal of_gety (string as_typeconv, decimal al_pixel)
public function decimal of_getxpixel (string as_typeconv, decimal ad_value)
public function decimal of_getypixel (string as_typeconv, decimal ad_value)
end prototypes

public function long of_getxpixelperinch ();long  ll_DC

ll_DC = GetDC(Handle(this))

return GetDeviceCaps(ll_DC, 88) 
end function

public function long of_getypixelperinch ();long  ll_DC

ll_DC = GetDC(Handle(this))

return GetDeviceCaps(ll_DC, 90) 
end function

public function decimal of_getx (string as_typeconv, decimal al_pixel);dec ll_null

if isnull(as_typeconv) or isnull(al_pixel) then
	setnull(ll_null)
end if

CHOOSE CASE lower(as_typeconv)
	CASE 'cm'
		return (al_pixel / dec(of_getXPixelperinch())) * 2.54
	CASE 'mm'
		return (al_pixel / dec(of_getXPixelperinch())) * 25.4
	CASE 'inch'
		return al_pixel / dec(of_getXPixelperinch())
	CASE ELSE
		return -1
END CHOOSE
end function

public function decimal of_gety (string as_typeconv, decimal al_pixel);dec ll_null

if isnull(as_typeconv) or isnull(al_pixel) then
	setnull(ll_null)
end if

CHOOSE CASE as_typeconv
	CASE 'cm'
		return (al_pixel / dec(of_getYPixelperinch())) * 2.54
	CASE 'mm'
		return (al_pixel / dec(of_getYPixelperinch())) * 25.4
	CASE 'inch'
		return al_pixel / dec(of_getYPixelperinch())
	CASE ELSE
		return -1
END CHOOSE
end function

public function decimal of_getxpixel (string as_typeconv, decimal ad_value);dec ld_null

/* Valeur possible pour as_typeconv
'cm'
'mm'
'inch' 

al_value: Veut le nombre de CM, MM, INCH

*/

setnull(ld_null)

if isnull(as_typeconv) or isnull(ad_value) then
	return ld_null
end if

CHOOSE CASE as_typeconv
	CASE 'mm'
		return of_getxpixelperinch() * ad_value / 25.4
	case 'cm' 
		return of_getxpixelperinch() * ad_value / 2.54
	case 'inch'
		return of_getxpixelperinch() * ad_value
	case else
		return -1	
END CHOOSE
end function

public function decimal of_getypixel (string as_typeconv, decimal ad_value);dec ld_null

/* Valeur possible pour as_typeconv
'cm'
'mm'
'inch' 

al_value: Veut le nombre de CM, MM, INCH

*/

setnull(ld_null)

if isnull(as_typeconv) or isnull(ad_value) then
	return ld_null
end if

CHOOSE CASE as_typeconv
	CASE 'mm'
		return of_getypixelperinch() * ad_value / 25.4
	case 'cm' 
		return of_getypixelperinch() * ad_value / 2.54
	case 'inch'
		return of_getypixelperinch() * ad_value
	case else
		return -1	
END CHOOSE
end function

on n_screen.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_screen.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

