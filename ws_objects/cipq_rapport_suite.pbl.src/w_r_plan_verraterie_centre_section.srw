$PBExportHeader$w_r_plan_verraterie_centre_section.srw
forward
global type w_r_plan_verraterie_centre_section from w_rapport
end type
end forward

global type w_r_plan_verraterie_centre_section from w_rapport
integer x = 214
integer y = 221
end type
global w_r_plan_verraterie_centre_section w_r_plan_verraterie_centre_section

event pfc_postopen;call super::pfc_postopen;long		ll_nb
date		ld_de

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.retrieve(ld_de)
end event

on w_r_plan_verraterie_centre_section.create
call super::create
end on

on w_r_plan_verraterie_centre_section.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_preview from w_rapport`dw_preview within w_r_plan_verraterie_centre_section
string dataobject = "d_r_plan_verraterie_centre_section"
end type

