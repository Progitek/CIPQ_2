﻿$PBExportHeader$w_r_cote_lot_recolte.srw
forward
global type w_r_cote_lot_recolte from w_rapport
end type
end forward

global type w_r_cote_lot_recolte from w_rapport
integer x = 214
integer y = 221
end type
global w_r_cote_lot_recolte w_r_cote_lot_recolte

on w_r_cote_lot_recolte.create
call super::create
end on

on w_r_cote_lot_recolte.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;date		ld_de, ld_au
long		ll_nb

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de", FALSE))
ld_au = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au", FALSE))

dw_preview.inv_filter.of_setvisibleonly( FALSE)
dw_preview.event pfc_filterdlg()

SetPointer(Hourglass!)

ll_nb = dw_preview.retrieve(ld_de, ld_au )
end event

type dw_preview from w_rapport`dw_preview within w_r_cote_lot_recolte
string dataobject = "d_r_cote_lot_recolte"
end type
