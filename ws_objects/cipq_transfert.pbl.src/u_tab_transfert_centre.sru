$PBExportHeader$u_tab_transfert_centre.sru
forward
global type u_tab_transfert_centre from u_tab
end type
type tabpage_transfert from u_tabpg_transfert within u_tab_transfert_centre
end type
type tabpage_transfert from u_tabpg_transfert within u_tab_transfert_centre
end type
type tabpage_transfert_archive from u_tabpg_transfert_archive within u_tab_transfert_centre
end type
type tabpage_transfert_archive from u_tabpg_transfert_archive within u_tab_transfert_centre
end type
end forward

global type u_tab_transfert_centre from u_tab
long backcolor = 12639424
tabpage_transfert tabpage_transfert
tabpage_transfert_archive tabpage_transfert_archive
end type
global u_tab_transfert_centre u_tab_transfert_centre

on u_tab_transfert_centre.create
this.tabpage_transfert=create tabpage_transfert
this.tabpage_transfert_archive=create tabpage_transfert_archive
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_transfert
this.Control[iCurrent+2]=this.tabpage_transfert_archive
end on

on u_tab_transfert_centre.destroy
call super::destroy
destroy(this.tabpage_transfert)
destroy(this.tabpage_transfert_archive)
end on

type tabpage_transfert from u_tabpg_transfert within u_tab_transfert_centre
integer x = 18
integer y = 100
integer width = 859
integer height = 496
end type

type tabpage_transfert_archive from u_tabpg_transfert_archive within u_tab_transfert_centre
integer x = 18
integer y = 100
integer width = 859
integer height = 496
end type

