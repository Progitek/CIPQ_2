﻿$PBExportHeader$pro_resize.sru
forward
global type pro_resize from nonvisualobject
end type
end forward

global type pro_resize from nonvisualobject autoinstantiate
end type

type prototypes

end prototypes

forward prototypes
public subroutine uf_resizew (w_master win, long x, long y)
public subroutine uf_resizetab (w_master win, tab ao_tab)
public subroutine uf_resizeuotab (u_tabpg auo_tab, long x, long y)
public subroutine uf_resizeuotabt (u_tabpg auo_tab, tab ao_tab)
public subroutine uf_resizedw (u_dw dwo)
public subroutine uf_unresizedw (u_dw dwo)
end prototypes

public subroutine uf_resizew (w_master win, long x, long y);long i
integer li_x, li_y, li_w, li_h
string ls_type
n_cst_string lnv_str

win.of_setResize(TRUE)

win.inv_resize.of_setOrigSize(win.width, win.height)
win.inv_resize.of_SetMinSize(x, y)

for i = 1 to upperbound(win.control[])
	ls_type = lower(lnv_str.of_getKeyValue(win.control[i].tag, 'resize', '|'))
	
	if ls_type = '' then
		win.inv_resize.of_Register(win.control[i], win.inv_resize.SCALE)
	elseif ls_type <> 'n' then
		choose case ls_type
			case 'fr', 'frsr', 'frsb', 'frsrb', 'frar', 'frab', 'frarb', &
				  'frb', 'frbsr', 'frbsb', 'frbsrb', 'frbar', 'frbab', 'frbarb'
				li_x = 100
			case 'mr', 'mrsr', 'mrsb', 'mrsrb', 'mrar', 'mrab', 'mrarb', &
				  'mrb', 'mrbsr', 'mrbsb', 'mrbsrb', 'mrbar', 'mrbab', 'mrbarb'
				li_x = 200
			case else
				li_x = 0
		end choose
		choose case ls_type
			case 'fb', 'fbsr', 'fbsb', 'fbsrb', 'fbar', 'fbab', 'fbarb', &
				  'frb', 'frbsr', 'frbsb', 'frbsrb', 'frbar', 'frbab', 'frbarb'
				li_y = 100
			case 'mb', 'mbsr', 'mbsb', 'mbsrb', 'mbar', 'mbab', 'mbarb', &
				  'mrb', 'mrbsr', 'mrbsb', 'mrbsrb', 'mrbar', 'mrbab', 'mrbarb'
				li_y = 200
			case else
				li_y = 0
		end choose
		choose case ls_type
			case 'sr', 'frsr', 'fbsr', 'frbsr', 'mrsr', 'mbsr', 'mrbsr', &
				  'srb', 'frsrb', 'fbsrb', 'frbsrb', 'mrsrb', 'mbsrb', 'mrbsrb'
				li_w = 100
			case 'ar', 'frar', 'fbar', 'frbar', 'mrar', 'mbar', 'mrbar', &
				  'arb', 'frarb', 'fbarb', 'frbarb', 'mrarb', 'mbarb', 'mrbarb'
				li_w = 200
			case else
				li_w = 0
		end choose
		choose case ls_type
			case 'sb', 'frsb', 'fbsb', 'frbsb', 'mrsb', 'mbsb', 'mrbsb', &
				  'srb', 'frsrb', 'fbsrb', 'frbsrb', 'mrsrb', 'mbsrb', 'mrbsrb'
				li_h = 100
			case 'ab', 'frab', 'fbab', 'frbab', 'mrab', 'mbab', 'mrbab', &
				  'arb', 'frarb', 'fbarb', 'frbarb', 'mrarb', 'mbarb', 'mrbarb'
				li_h = 200
			case else
				li_h = 0
		end choose
		
		win.inv_resize.of_Register(win.control[i], li_x, li_y, li_w, li_h)
	end if
	
	if win.control[i].typeOf() = Tab! then
		uf_resizetab(win,win.control[i])
	end if
next

end subroutine

public subroutine uf_resizetab (w_master win, tab ao_tab);string ls_type
long i,j
integer li_x, li_y, li_w, li_h
n_cst_string lnv_str

for i = 1 to upperbound(ao_tab.control[])
	for j = 1 to upperbound(ao_tab.control[i].control[])
		ls_type = lower(lnv_str.of_getKeyValue(ao_tab.control[i].control[j].tag, 'resize', '|'))
		
		if ls_type = '' then
			win.inv_resize.of_Register(ao_tab.control[i].control[j], win.inv_resize.SCALE)
		elseif ls_type <> 'n' then
			choose case ls_type
				case 'fr', 'frsr', 'frsb', 'frsrb', 'frar', 'frab', 'frarb', &
					  'frb', 'frbsr', 'frbsb', 'frbsrb', 'frbar', 'frbab', 'frbarb'
					li_x = 100
				case 'mr', 'mrsr', 'mrsb', 'mrsrb', 'mrar', 'mrab', 'mrarb', &
					  'mrb', 'mrbsr', 'mrbsb', 'mrbsrb', 'mrbar', 'mrbab', 'mrbarb'
					li_x = 200
				case else
					li_x = 0
			end choose
			choose case ls_type
				case 'fb', 'fbsr', 'fbsb', 'fbsrb', 'fbar', 'fbab', 'fbarb', &
					  'frb', 'frbsr', 'frbsb', 'frbsrb', 'frbar', 'frbab', 'frbarb'
					li_y = 100
				case 'mb', 'mbsr', 'mbsb', 'mbsrb', 'mbar', 'mbab', 'mbarb', &
					  'mrb', 'mrbsr', 'mrbsb', 'mrbsrb', 'mrbar', 'mrbab', 'mrbarb'
					li_y = 200
				case else
					li_y = 0
			end choose
			choose case ls_type
				case 'sr', 'frsr', 'fbsr', 'frbsr', 'mrsr', 'mbsr', 'mrbsr', &
					  'srb', 'frsrb', 'fbsrb', 'frbsrb', 'mrsrb', 'mbsrb', 'mrbsrb'
					li_w = 100
				case 'ar', 'frar', 'fbar', 'frbar', 'mrar', 'mbar', 'mrbar', &
					  'arb', 'frarb', 'fbarb', 'frbarb', 'mrarb', 'mbarb', 'mrbarb'
					li_w = 200
				case else
					li_w = 0
			end choose
			choose case ls_type
				case 'sb', 'frsb', 'fbsb', 'frbsb', 'mrsb', 'mbsb', 'mrbsb', &
					  'srb', 'frsrb', 'fbsrb', 'frbsrb', 'mrsrb', 'mbsrb', 'mrbsrb'
					li_h = 100
				case 'ab', 'frab', 'fbab', 'frbab', 'mrab', 'mbab', 'mrbab', &
					  'arb', 'frarb', 'fbarb', 'frbarb', 'mrarb', 'mbarb', 'mrbarb'
					li_h = 200
				case else
					li_h = 0
			end choose
			
			win.inv_resize.of_Register(ao_tab.control[i].control[j], li_x, li_y, li_w, li_h)
		end if
		
		if ao_tab.control[i].control[j].typeOf() = Tab! then
			uf_resizetab(win,ao_tab.control[i].control[j])
		end if
	next
next
end subroutine

public subroutine uf_resizeuotab (u_tabpg auo_tab, long x, long y);long i
integer li_x, li_y, li_w, li_h
string ls_type
n_cst_string lnv_str

auo_tab.of_setResize(TRUE)

auo_tab.inv_resize.of_setOrigSize(auo_tab.width, auo_tab.height)
auo_tab.inv_resize.of_SetMinSize(x, y)

for i = 1 to upperbound(auo_tab.control[])
	ls_type = lower(lnv_str.of_getKeyValue(auo_tab.control[i].tag, 'resize', '|'))
	
	if ls_type = '' then
		auo_tab.inv_resize.of_Register(auo_tab.control[i], auo_tab.inv_resize.SCALE)
	elseif ls_type <> 'n' then
		choose case ls_type
			case 'fr', 'frsr', 'frsb', 'frsrb', 'frar', 'frab', 'frarb', &
				  'frb', 'frbsr', 'frbsb', 'frbsrb', 'frbar', 'frbab', 'frbarb'
				li_x = 100
			case 'mr', 'mrsr', 'mrsb', 'mrsrb', 'mrar', 'mrab', 'mrarb', &
				  'mrb', 'mrbsr', 'mrbsb', 'mrbsrb', 'mrbar', 'mrbab', 'mrbarb'
				li_x = 200
			case else
				li_x = 0
		end choose
		choose case ls_type
			case 'fb', 'fbsr', 'fbsb', 'fbsrb', 'fbar', 'fbab', 'fbarb', &
				  'frb', 'frbsr', 'frbsb', 'frbsrb', 'frbar', 'frbab', 'frbarb'
				li_y = 100
			case 'mb', 'mbsr', 'mbsb', 'mbsrb', 'mbar', 'mbab', 'mbarb', &
				  'mrb', 'mrbsr', 'mrbsb', 'mrbsrb', 'mrbar', 'mrbab', 'mrbarb'
				li_y = 200
			case else
				li_y = 0
		end choose
		choose case ls_type
			case 'sr', 'frsr', 'fbsr', 'frbsr', 'mrsr', 'mbsr', 'mrbsr', &
				  'srb', 'frsrb', 'fbsrb', 'frbsrb', 'mrsrb', 'mbsrb', 'mrbsrb'
				li_w = 100
			case 'ar', 'frar', 'fbar', 'frbar', 'mrar', 'mbar', 'mrbar', &
				  'arb', 'frarb', 'fbarb', 'frbarb', 'mrarb', 'mbarb', 'mrbarb'
				li_w = 200
			case else
				li_w = 0
		end choose
		choose case ls_type
			case 'sb', 'frsb', 'fbsb', 'frbsb', 'mrsb', 'mbsb', 'mrbsb', &
				  'srb', 'frsrb', 'fbsrb', 'frbsrb', 'mrsrb', 'mbsrb', 'mrbsrb'
				li_h = 100
			case 'ab', 'frab', 'fbab', 'frbab', 'mrab', 'mbab', 'mrbab', &
				  'arb', 'frarb', 'fbarb', 'frbarb', 'mrarb', 'mbarb', 'mrbarb'
				li_h = 200
			case else
				li_h = 0
		end choose
		
		auo_tab.inv_resize.of_Register(auo_tab.control[i], li_x, li_y, li_w, li_h)
	end if

	if auo_tab.control[i].typeOf() = Tab! then
//		uf_resizeuotabt(auo_tab, auo_tab.control[i])
	end if
next
end subroutine

public subroutine uf_resizeuotabt (u_tabpg auo_tab, tab ao_tab);long i,j
integer li_x, li_y, li_w, li_h
string ls_type
n_cst_string lnv_str

for i = 1 to upperbound(ao_tab.control[])
	for j = 1 to upperbound(ao_tab.control[i].control[])
		ls_type = lower(lnv_str.of_getKeyValue(ao_tab.control[i].control[j].tag, 'resize', '|'))
		
		if ls_type = '' then
			auo_tab.inv_resize.of_Register(ao_tab.control[i].control[j], auo_tab.inv_resize.SCALE)
		elseif ls_type <> 'n' then
			choose case ls_type
				case 'fr', 'frsr', 'frsb', 'frsrb', 'frar', 'frab', 'frarb', &
					  'frb', 'frbsr', 'frbsb', 'frbsrb', 'frbar', 'frbab', 'frbarb'
					li_x = 100
				case 'mr', 'mrsr', 'mrsb', 'mrsrb', 'mrar', 'mrab', 'mrarb', &
					  'mrb', 'mrbsr', 'mrbsb', 'mrbsrb', 'mrbar', 'mrbab', 'mrbarb'
					li_x = 200
				case else
					li_x = 0
			end choose
			choose case ls_type
				case 'fb', 'fbsr', 'fbsb', 'fbsrb', 'fbar', 'fbab', 'fbarb', &
					  'frb', 'frbsr', 'frbsb', 'frbsrb', 'frbar', 'frbab', 'frbarb'
					li_y = 100
				case 'mb', 'mbsr', 'mbsb', 'mbsrb', 'mbar', 'mbab', 'mbarb', &
					  'mrb', 'mrbsr', 'mrbsb', 'mrbsrb', 'mrbar', 'mrbab', 'mrbarb'
					li_y = 200
				case else
					li_y = 0
			end choose
			choose case ls_type
				case 'sr', 'frsr', 'fbsr', 'frbsr', 'mrsr', 'mbsr', 'mrbsr', &
					  'srb', 'frsrb', 'fbsrb', 'frbsrb', 'mrsrb', 'mbsrb', 'mrbsrb'
					li_w = 100
				case 'ar', 'frar', 'fbar', 'frbar', 'mrar', 'mbar', 'mrbar', &
					  'arb', 'frarb', 'fbarb', 'frbarb', 'mrarb', 'mbarb', 'mrbarb'
					li_w = 200
				case else
					li_w = 0
			end choose
			choose case ls_type
				case 'sb', 'frsb', 'fbsb', 'frbsb', 'mrsb', 'mbsb', 'mrbsb', &
					  'srb', 'frsrb', 'fbsrb', 'frbsrb', 'mrsrb', 'mbsrb', 'mrbsrb'
					li_h = 100
				case 'ab', 'frab', 'fbab', 'frbab', 'mrab', 'mbab', 'mrbab', &
					  'arb', 'frarb', 'fbarb', 'frbarb', 'mrarb', 'mbarb', 'mrbarb'
					li_h = 200
				case else
					li_h = 0
			end choose
			
			auo_tab.inv_resize.of_Register(ao_tab.control[i].control[j], li_x, li_y, li_w, li_h)
		end if

		if ao_tab.control[i].control[j].typeOf() = Tab! then
			uf_resizeuotabt(auo_tab,ao_tab.control[i].control[j])
		end if
	next
next
end subroutine

public subroutine uf_resizedw (u_dw dwo);string ls_object, ls_objname, ls_objtype, ls_coltype, ls_rstype
long ll_nbcol, i, ll_tab, ll_height, ll_y, ll_pos
double ldb_parm
integer li_x, li_y, li_w, li_h
n_cst_string lnv_str

dwo.of_setResize(TRUE)
ls_object = dwo.object.datawindow.objects
DO
	ll_pos = pos(ls_object,'~t')
	if ll_pos = 0 then
		ls_objname = ls_object
	else
		ls_objname = left(ls_object, ll_pos - 1)
		ls_object = mid(ls_object, ll_pos + 1)
	end if

	ls_rstype = lower(lnv_str.of_getKeyValue(dwo.describe(ls_objname+".tag"), 'resize', '|'))
	
	if ls_rstype = '' then
		dwo.inv_resize.of_Register(ls_objname, dwo.inv_resize.SCALE)
	elseif ls_rstype <> 'n' then
		choose case ls_rstype
			case 'fr', 'frsr', 'frsb', 'frsrb', 'frar', 'frab', 'frarb', &
				  'frb', 'frbsr', 'frbsb', 'frbsrb', 'frbar', 'frbab', 'frbarb'
				li_x = 100
			case 'mr', 'mrsr', 'mrsb', 'mrsrb', 'mrar', 'mrab', 'mrarb', &
				  'mrb', 'mrbsr', 'mrbsb', 'mrbsrb', 'mrbar', 'mrbab', 'mrbarb'
				li_x = 200
			case else
				li_x = 0
		end choose
		choose case ls_rstype
			case 'fb', 'fbsr', 'fbsb', 'fbsrb', 'fbar', 'fbab', 'fbarb', &
				  'frb', 'frbsr', 'frbsb', 'frbsrb', 'frbar', 'frbab', 'frbarb'
				li_y = 100
			case 'mb', 'mbsr', 'mbsb', 'mbsrb', 'mbar', 'mbab', 'mbarb', &
				  'mrb', 'mrbsr', 'mrbsb', 'mrbsrb', 'mrbar', 'mrbab', 'mrbarb'
				li_y = 200
			case else
				li_y = 0
		end choose
		choose case ls_rstype
			case 'sr', 'frsr', 'fbsr', 'frbsr', 'mrsr', 'mbsr', 'mrbsr', &
				  'srb', 'frsrb', 'fbsrb', 'frbsrb', 'mrsrb', 'mbsrb', 'mrbsrb'
				li_w = 100
			case 'ar', 'frar', 'fbar', 'frbar', 'mrar', 'mbar', 'mrbar', &
				  'arb', 'frarb', 'fbarb', 'frbarb', 'mrarb', 'mbarb', 'mrbarb'
				li_w = 200
			case else
				li_w = 0
		end choose
		choose case ls_rstype
			case 'sb', 'frsb', 'fbsb', 'frbsb', 'mrsb', 'mbsb', 'mrbsb', &
				  'srb', 'frsrb', 'fbsrb', 'frbsrb', 'mrsrb', 'mbsrb', 'mrbsrb'
				li_h = 100
			case 'ab', 'frab', 'fbab', 'frbab', 'mrab', 'mbab', 'mrbab', &
				  'arb', 'frarb', 'fbarb', 'frbarb', 'mrarb', 'mbarb', 'mrbarb'
				li_h = 200
			case else
				li_h = 0
		end choose
	
		dwo.inv_resize.of_Register(ls_objname, li_x, li_y, li_w, li_h)
	end if
LOOP WHILE ll_pos <> 0

ll_nbcol = long(dwo.describe("datawindow.column.count"))

for i = 1 to ll_nbcol
	ll_tab = dwo.setTaborder(i,1)
	dwo.setColumn(i)
	ls_objname = dwo.getColumnname()
	ls_rstype = lower(lnv_str.of_getKeyValue(dwo.describe(ls_objname+".tag"), 'resize', '|'))

	if ls_rstype = '' then
		dwo.inv_resize.of_Register(ls_objname, dwo.inv_resize.SCALE)
	elseif ls_rstype <> 'n' then
		choose case ls_rstype
			case 'fr'
				li_x = 100
				li_y = 0
				li_w = 0
				li_h = 0
			case 'fb'
				li_x = 0
				li_y = 100
				li_w = 0
				li_h = 0
			case 'frb'
				li_x = 100
				li_y = 100
				li_w = 0
				li_h = 0
			case 'sr'
				li_x = 0
				li_y = 0
				li_w = 100
				li_h = 0
			case 'sb'
				li_x = 0
				li_y = 0
				li_w = 0
				li_h = 100
			case 'srb'
				li_x = 0
				li_y = 0
				li_w = 100
				li_h = 100
			case 'frsr'
				li_x = 100
				li_y = 0
				li_w = 100
				li_h = 0
			case 'fbsb'
				li_x = 0
				li_y = 100
				li_w = 0
				li_h = 100
			case 'frsb'
				li_x = 100
				li_y = 0
				li_w = 0
				li_h = 100
			case 'fbsr'
				li_x = 0
				li_y = 100
				li_w = 100
				li_h = 0
			case 'fbsrb'
				li_x = 0
				li_y = 100
				li_w = 100
				li_h = 100
			case 'frsrb'
				li_x = 100
				li_y = 0
				li_w = 100
				li_h = 100
			case 'frbsb'
				li_x = 100
				li_y = 100
				li_w = 0
				li_h = 100
			case 'frbsr'
				li_x = 100
				li_y = 100
				li_w = 100
				li_h = 0
		end choose
	
		dwo.inv_resize.of_Register(ls_objname, li_x, li_y, li_w, li_h)
	end if
	
	dwo.setTaborder(i,ll_tab)
next

end subroutine

public subroutine uf_unresizedw (u_dw dwo);string ls_object, ls_objname, ls_objtype, ls_coltype
long ll_nbcol, i, ll_tab, ll_height, ll_y, ll_pos
double ldb_parm

dwo.of_setResize(TRUE)
ls_object = dwo.object.datawindow.objects
DO
	ll_pos = pos(ls_object,'~t')
	if ll_pos = 0 then
		ls_objname = ls_object
	else
		ls_objname = left(ls_object, ll_pos - 1)
		ls_object = mid(ls_object, ll_pos + 1)
	end if

	ls_objtype = dwo.Describe(ls_objname+".Type")
	if ls_objtype = 'line' then
		ll_height = dwo.height
		ll_y = long(dwo.describe(ls_objname+".Y1"))
		ll_height = ll_y / ll_height * 100
		dwo.inv_resize.of_unregister(ls_objname)
	else
		dwo.inv_resize.of_unregister(ls_objname)
	end if
LOOP WHILE ll_pos <> 0

ll_nbcol = long(dwo.describe("datawindow.column.count"))

for i = 1 to ll_nbcol
	ll_tab = dwo.setTaborder(i,1)
	dwo.setColumn(i)
	ls_objname = dwo.getColumnname()
	dwo.inv_resize.of_unregister(ls_objname)
	dwo.setTaborder(i,ll_tab)
next

end subroutine

on pro_resize.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pro_resize.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

