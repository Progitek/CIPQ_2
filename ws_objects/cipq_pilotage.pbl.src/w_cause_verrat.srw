$PBExportHeader$w_cause_verrat.srw
forward
global type w_cause_verrat from w_sheet_pilotage
end type
end forward

global type w_cause_verrat from w_sheet_pilotage
string tag = "menu=m_causesdesreformesdesverrats"
end type
global w_cause_verrat w_cause_verrat

on w_cause_verrat.create
int iCurrent
call super::create
end on

on w_cause_verrat.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;
//Override

long		ll_retour, ll_cause

ll_cause = long(gnv_app.inv_entrepotglobal.of_retournedonnee( "lien cause"))
IF dw_pilotage.event pfc_retrieve() > 0 THEN
	IF IsNull(ll_cause) = FALSE AND ll_cause <> 0 THEN
		gnv_app.inv_entrepotglobal.of_ajoutedonnee( "lien cause", "")
		ll_retour = dw_pilotage.Find("id_cause = " + string(ll_cause) , 1, dw_pilotage.RowCount())
		IF ll_retour > 0 THEN
			dw_pilotage.SetRow(ll_retour)
			dw_pilotage.ScrollToRow(ll_retour)
		END IF
	END IF
END IF
end event

type p_8 from w_sheet_pilotage`p_8 within w_cause_verrat
integer x = 64
integer y = 32
integer width = 142
integer height = 140
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\reforme.bmp"
end type

type rr_infopat from w_sheet_pilotage`rr_infopat within w_cause_verrat
integer height = 148
end type

type st_title from w_sheet_pilotage`st_title within w_cause_verrat
integer x = 247
integer y = 72
string text = "Causes de réforme des verrats"
end type

type dw_pilotage from w_sheet_pilotage`dw_pilotage within w_cause_verrat
integer y = 220
integer width = 3392
integer height = 1424
string dataobject = "d_cause_verrat"
end type

event dw_pilotage::pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_Verrat_Cause", TRUE)
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar from w_sheet_pilotage`uo_toolbar within w_cause_verrat
end type

type rr_1 from w_sheet_pilotage`rr_1 within w_cause_verrat
integer y = 184
integer height = 1500
end type

