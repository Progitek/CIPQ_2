﻿$PBExportHeader$w_r_plan_verraterie_sommaire.srw
forward
global type w_r_plan_verraterie_sommaire from w_rapport
end type
end forward

global type w_r_plan_verraterie_sommaire from w_rapport
end type
global w_r_plan_verraterie_sommaire w_r_plan_verraterie_sommaire

event pfc_postopen;call super::pfc_postopen;long		ll_nb
date		ld_de

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date", "")

gnv_app.of_dotmpemplacementvide(ld_de )

dw_preview.of_SetTri(TRUE)

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.retrieve(ld_de)

//
//
//dw_preview.retrieve( )


end event

on w_r_plan_verraterie_sommaire.create
call super::create
end on

on w_r_plan_verraterie_sommaire.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_preview from w_rapport`dw_preview within w_r_plan_verraterie_sommaire
string dataobject = "d_r_plan_verraterie_sommaire"
end type

