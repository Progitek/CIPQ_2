﻿$PBExportHeader$w_r_frequence_recolte_famille_ajout.srw
forward
global type w_r_frequence_recolte_famille_ajout from w_rapport
end type
end forward

global type w_r_frequence_recolte_famille_ajout from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Ajout de famille(s) par centre pour la fréquence des récoltes"
end type
global w_r_frequence_recolte_famille_ajout w_r_frequence_recolte_famille_ajout

forward prototypes
public subroutine of_calculertotaux (long al_row)
end prototypes

public subroutine of_calculertotaux (long al_row);
end subroutine

on w_r_frequence_recolte_famille_ajout.create
call super::create
end on

on w_r_frequence_recolte_famille_ajout.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;long		ll_nbligne, ll_nbdose

ll_nbdose = gnv_app.of_getnbdosesmoyenne( )

ll_nbligne = dw_preview.retrieve(ll_nbdose)
end event

type dw_preview from w_rapport`dw_preview within w_r_frequence_recolte_famille_ajout
string dataobject = "d_r_frequence_recolte_famille_ajout"
end type

event dw_preview::retrieveend;call super::retrieveend;//Faire le tour des rangées pour mettre les computed

long	ll_cpt

FOR ll_cpt = 1 TO rowcount
	
	
END FOR
end event

