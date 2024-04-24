$PBExportHeader$w_recolte_commande_produit_detail.srw
forward
global type w_recolte_commande_produit_detail from w_response
end type
type dw_r_recolte_commande_produitdetail from u_dw within w_recolte_commande_produit_detail
end type
type uo_toolbar2 from u_cst_toolbarstrip within w_recolte_commande_produit_detail
end type
type rr_1 from roundrectangle within w_recolte_commande_produit_detail
end type
end forward

global type w_recolte_commande_produit_detail from w_response
integer width = 1143
integer height = 1248
string title = "Détail"
boolean controlmenu = false
long backcolor = 12639424
dw_r_recolte_commande_produitdetail dw_r_recolte_commande_produitdetail
uo_toolbar2 uo_toolbar2
rr_1 rr_1
end type
global w_recolte_commande_produit_detail w_recolte_commande_produit_detail

type variables
string	is_codeverrat = ""
end variables

on w_recolte_commande_produit_detail.create
int iCurrent
call super::create
this.dw_r_recolte_commande_produitdetail=create dw_r_recolte_commande_produitdetail
this.uo_toolbar2=create uo_toolbar2
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_r_recolte_commande_produitdetail
this.Control[iCurrent+2]=this.uo_toolbar2
this.Control[iCurrent+3]=this.rr_1
end on

on w_recolte_commande_produit_detail.destroy
call super::destroy
destroy(this.dw_r_recolte_commande_produitdetail)
destroy(this.uo_toolbar2)
destroy(this.rr_1)
end on

event pfc_postopen;call super::pfc_postopen;long 	ll_nbrow, ll_row
string ls_ciecentre, ls_sql, ls_odbc
ls_ciecentre = message.stringparm
transaction CIPQTRANS

CHOOSE CASE ls_ciecentre
	CASE '110'
		ls_odbc = "cipq_admin"
	CASE '111'
		ls_odbc = "cipq_stlambert"
	CASE '112'
		ls_odbc = "cipq_roxton"
	CASE '113'
		ls_odbc = "cipq_stcuthbert"
	CASE '116'
		ls_odbc = "cipq_stpatrice"
END CHOOSE
			
CIPQTRANS = CREATE transaction

CIPQTRANS.DBMS       = 'ODBC'
CIPQTRANS.AutoCommit = True
CIPQTRANS.LOCK		  = "0"
CIPQTRANS.DbParm  = "ConnectString='DSN=" + ls_odbc + ";UID=dba;PWD=sql',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT'"
connect using CIPQTRANS;

if CIPQTRANS.sqlcode <> 0 then
	
	CHOOSE CASE ls_ciecentre
		CASE '110'
			MessageBox ("Erreur de communication", "La communication avec l'administration est impossible veuillez corriger la situation",Information!, Ok!)
		CASE '111'
			MessageBox ("Erreur de communication", "La communication avec St-Lambert est impossible veuillez corriger la situation",Information!, Ok!)
		CASE '112'
			MessageBox ("Erreur de communication", "La communication avec Roxton est impossible veuillez corriger la situation",Information!, Ok!)
		CASE '113'
			MessageBox ("Erreur de communication", "La communication avec St-Cuthbert est impossible veuillez corriger la situation",Information!, Ok!)
		CASE '116'
			MessageBox ("Erreur de communication", "La communication avec St-St-Patrice est impossible veuillez corriger la situation",Information!, Ok!)
	END CHOOSE

else
	
	// Authentifier la connection pour la version 11

	ls_sql = "SET TEMPORARY OPTION CONNECTION_AUTHENTICATION='Company=Progitek;Application=Progitek;Signature=000fa55157edb8e14d818eb4fe3db41447146f1571g7cf6b1c162e7a4e4925570fc8104c82ac6d466c6'"
	execute immediate :ls_sql using CIPQTRANS;
	if CIPQTRANS.sqlcode <> 0 then
		MessageBox ("Validation d'authentification", CIPQTRANS.sqlerrtext)
	end if
	
end if

//Lancer le retrieve
dw_r_recolte_commande_produitdetail.settransobject(CIPQTRANS)
ll_nbrow  = dw_r_recolte_commande_produitdetail.retrieve()


uo_toolbar2.of_settheme("classic")
uo_toolbar2.of_DisplayBorder(true)

uo_toolbar2.of_AddItem("Fermer", "Exit!")
uo_toolbar2.of_displaytext(true)
end event

type dw_r_recolte_commande_produitdetail from u_dw within w_recolte_commande_produit_detail
integer x = 64
integer y = 64
integer width = 992
integer height = 876
integer taborder = 10
string dataobject = "d_r_recolte_commande_produitdetail"
boolean vscrollbar = false
boolean livescroll = false
end type

type uo_toolbar2 from u_cst_toolbarstrip within w_recolte_commande_produit_detail
event destroy ( )
integer x = 603
integer y = 1036
integer width = 507
integer taborder = 10
boolean bringtotop = true
end type

on uo_toolbar2.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_clicked_anywhere;call super::ue_clicked_anywhere;string ls_sql

ls_sql = "drop table #Tmp_Recolte_Commande_ProduitDetail"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;

Close(Parent)
end event

type rr_1 from roundrectangle within w_recolte_commande_produit_detail
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 32
integer y = 28
integer width = 1079
integer height = 944
integer cornerheight = 40
integer cornerwidth = 46
end type

