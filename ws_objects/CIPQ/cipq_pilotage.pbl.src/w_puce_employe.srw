$PBExportHeader$w_puce_employe.srw
forward
global type w_puce_employe from w_sheet_pilotage
end type
end forward

global type w_puce_employe from w_sheet_pilotage
string tag = "menu=m_puceselectroniquesdesemployes"
integer x = 214
integer y = 221
end type
global w_puce_employe w_puce_employe

on w_puce_employe.create
int iCurrent
call super::create
end on

on w_puce_employe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type p_8 from w_sheet_pilotage`p_8 within w_puce_employe
integer y = 36
integer width = 105
integer height = 84
boolean originalsize = false
string picturename = "C:\ii4net\CIPQ\images\contact.gif"
end type

type rr_infopat from w_sheet_pilotage`rr_infopat within w_puce_employe
end type

type st_title from w_sheet_pilotage`st_title within w_puce_employe
integer x = 201
integer width = 1390
string text = "Puces électroniques des employés"
end type

type dw_pilotage from w_sheet_pilotage`dw_pilotage within w_puce_employe
string dataobject = "d_puce_employe"
end type

event dw_pilotage::constructor;call super::constructor;THIS.of_SetPremiereColonneInsertion("no_carte")
end event

event dw_pilotage::pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

IF THIS.GetRow() > 0 THEN
	gnv_app.inv_transfert_centre_adm.of_updatetransfertref( "t_puce_employe", TRUE)
END IF

RETURN AncestorReturnValue
end event

event dw_pilotage::itemchanged;call super::itemchanged;long		ll_rowdddw
string	ls_id, ls_centre

IF Row > 0 THEN
	IF dwo.name = "t_puce_employe_no_employe" THEN 
		//Mettre le id dans usager modif
		datawindowchild ldwc_code
		
		THIS.GetChild('t_puce_employe_no_employe', ldwc_code)
		ldwc_code.setTransObject(SQLCA)
		ll_rowdddw = ldwc_code.Find("t_preprecolte_prepcode = " + data + "", 1, ldwc_code.RowCount())		
		//Vérifier s'il fait partie de la liste
		IF ll_rowdddw > 0 THEN
			ls_id = string(ldwc_code.GetItemNumber(ll_rowdddw,"t_preprecolte_prepid"))
			THIS.object.t_puce_employe_usager_modif[row] = ls_id
			
			//2008-12-23 Mathieu Gendron Mettre aussi le centre
			ls_centre = ldwc_code.GetItemString(ll_rowdddw,"t_prepcentre_cie")
			THIS.object.commentaire[row] = ls_centre
			
		END IF	
	END IF
END IF
end event

event dw_pilotage::pfc_insertrow;call super::pfc_insertrow;IF AncestorReturnValue > 0 THEN
	//Mettre la date du jour
	THIS.object.date_emis[AncestorReturnValue] = date(today())
END IF

RETURN AncestorReturnValue
end event

type uo_toolbar from w_sheet_pilotage`uo_toolbar within w_puce_employe
integer taborder = 20
end type

type rr_1 from w_sheet_pilotage`rr_1 within w_puce_employe
end type

