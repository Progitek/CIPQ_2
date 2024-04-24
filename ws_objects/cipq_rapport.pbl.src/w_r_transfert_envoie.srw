$PBExportHeader$w_r_transfert_envoie.srw
forward
global type w_r_transfert_envoie from w_rapport
end type
end forward

global type w_r_transfert_envoie from w_rapport
string title = "Rapport - Transferts exportés"
end type
global w_r_transfert_envoie w_r_transfert_envoie

on w_r_transfert_envoie.create
call super::create
end on

on w_r_transfert_envoie.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;long		ll_nb, ll_cpt, ll_count
string	ls_table, ls_sql
date		ld_trans, ld_datejour

ld_datejour = Date(gnv_app.inv_entrepotglobal.of_retournedonnee("date transfert"))
ll_nb = dw_preview.Retrieve(ld_datejour)
FOR ll_cpt = 1 TO ll_nb
	
	//Mettre la valeur exportée
	ls_table = dw_preview.object.tbltransf[ll_cpt]
	ld_trans = date(dw_preview.object.datetransf[ll_cpt])
	
	CHOOSE CASE lower(ls_table)
		CASE "t_commandeoriginale" //ENV labo
			SELECT 	Count(0) 
			INTO		:ll_count
			FROM 		t_CommandeOriginale 
			WHERE 	date(t_CommandeOriginale.TransDate) = :ld_trans ;
			
		CASE "t_recolte" //ENV labo
			SELECT 	Count(0) 
			INTO		:ll_count
			FROM 		t_RECOLTE 
			WHERE 	date(t_RECOLTE.TransDate) = :ld_trans ;
			
		CASE "t_statfacture" //ENV labo
			SELECT 	Count(0) 
			INTO		:ll_count
			FROM 		T_StatFacture 
			WHERE 	date(T_StatFacture.TransDate) = :ld_trans ;
			
		CASE "t_statfacturedetail" //ENV labo
			SELECT 	Count(0) 
			INTO		:ll_count
			FROM 		t_StatFacture INNER JOIN T_StatFactureDetail
        	ON 		(t_StatFacture.LIV_NO = T_StatFactureDetail.LIV_NO) 
			  			AND (t_StatFacture.CIE_NO = T_StatFactureDetail.CIE_NO)
        	WHERE 	date(t_StatFacture.TransDate) = :ld_trans ;
			  
		CASE "t_alliancematernelle_recolte_gestionlot_verrat"
			SELECT	Count(0)
			INTO		:ll_count
			FROM		t_alliancematernelle_recolte_gestionlot_verrat
			WHERE		date(t_alliancematernelle_recolte_gestionlot_verrat.TransDate) = :ld_trans ;
			
		CASE "t_alliancematernelle_lot_distribue"
			SELECT 	Count(0)
			INTO		:ll_count
			FROM		t_alliancematernelle_lot_distribue
			WHERE 	date(t_alliancematernelle_lot_distribue.TransDate) = :ld_trans ;
				  
		CASE "t_recolte_cote_peremption"
			SELECT 	Count(0)
			INTO		:ll_count
			FROM		t_recolte_cote_peremption
			WHERE 	date(t_recolte_cote_peremption.TransDate) = :ld_trans ;
				  
		CASE ELSE //Pilotage
			ls_sql = "SELECT COUNT(1) FROM " + ls_table
			ll_count = gnv_app.of_dynamic_count( ls_sql )
			dw_preview.object.nbexportable[ll_cpt] = ll_count
			
	END CHOOSE
	
	IF IsNull(ll_count) THEN ll_count = 0
	
	dw_preview.object.nbexportable[ll_cpt] = ll_count
END FOR
end event

type dw_preview from w_rapport`dw_preview within w_r_transfert_envoie
string dataobject = "d_r_transfert_envoie"
end type

