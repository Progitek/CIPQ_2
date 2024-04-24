$PBExportHeader$w_r_frequence_recolte_famille.srw
forward
global type w_r_frequence_recolte_famille from w_rapport
end type
end forward

global type w_r_frequence_recolte_famille from w_rapport
integer x = 214
integer y = 221
string title = "Rapport - Mise à jour des fréquences de récoltes des verrats selon leur famille"
end type
global w_r_frequence_recolte_famille w_r_frequence_recolte_famille

forward prototypes
public subroutine of_calculertotaux (long al_row)
end prototypes

public subroutine of_calculertotaux (long al_row);
end subroutine

on w_r_frequence_recolte_famille.create
call super::create
end on

on w_r_frequence_recolte_famille.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;long		ll_nbligne

ll_nbligne = dw_preview.retrieve()
end event

type dw_preview from w_rapport`dw_preview within w_r_frequence_recolte_famille
string dataobject = "d_r_verrat_famille_frequence_recolte_global"
end type

event dw_preview::retrieveend;call super::retrieveend;//Faire le tour des rangées pour mettre les computed

long	ll_cpt

FOR ll_cpt = 1 TO rowcount
	
	
END FOR
end event

