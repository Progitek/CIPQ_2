$PBExportHeader$w_portail_cie.srw
forward
global type w_portail_cie from w_sheet
end type
type dw_portrait_rappels from u_dw within w_portail_cie
end type
type dw_boite_reception from u_dw within w_portail_cie
end type
type uo_toolbar from u_cst_toolbarstrip within w_portail_cie
end type
type dw_portail_billet from u_dw within w_portail_cie
end type
type p_8 from picture within w_portail_cie
end type
type st_infopat from st_uo_transparent within w_portail_cie
end type
type gb_1 from groupbox within w_portail_cie
end type
type gb_2 from groupbox within w_portail_cie
end type
type gb_3 from groupbox within w_portail_cie
end type
type gb_4 from groupbox within w_portail_cie
end type
type rr_1 from roundrectangle within w_portail_cie
end type
type rr_infopat from roundrectangle within w_portail_cie
end type
end forward

global type w_portail_cie from w_sheet
integer x = 214
integer y = 221
integer width = 4713
integer height = 2744
string title = "Progitek aujourd~'hui"
long backcolor = 15793151
dw_portrait_rappels dw_portrait_rappels
dw_boite_reception dw_boite_reception
uo_toolbar uo_toolbar
dw_portail_billet dw_portail_billet
p_8 p_8
st_infopat st_infopat
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
rr_1 rr_1
rr_infopat rr_infopat
end type
global w_portail_cie w_portail_cie

type variables
string 	is_nom
long		il_no_specialist
end variables

forward prototypes
public subroutine uf_traduction ()
end prototypes

public subroutine uf_traduction ();uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Créer un billet", "C:\ii4net\dentitek\images\facture.ico")
uo_toolbar.of_AddItem("Accéder à la liste de billets", "SelectScript!")
uo_toolbar.of_AddItem("Boîte de réception", "C:\ii4net\dentitek\images\mail.ico")
uo_toolbar.of_AddItem("Écrire un nouveau message", "c:\ii4net\dentitek\images\sent.ico")
uo_toolbar.of_AddItem("Accéder à mon horaire", "c:\ii4net\dentitek\images\horaire.ico")
uo_toolbar.of_AddItem("Accéder aux rappels", "c:\ii4net\dentitek\images\rappel2.ico")

uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)
end subroutine

on w_portail_cie.create
int iCurrent
call super::create
this.dw_portrait_rappels=create dw_portrait_rappels
this.dw_boite_reception=create dw_boite_reception
this.uo_toolbar=create uo_toolbar
this.dw_portail_billet=create dw_portail_billet
this.p_8=create p_8
this.st_infopat=create st_infopat
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.rr_1=create rr_1
this.rr_infopat=create rr_infopat
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_portrait_rappels
this.Control[iCurrent+2]=this.dw_boite_reception
this.Control[iCurrent+3]=this.uo_toolbar
this.Control[iCurrent+4]=this.dw_portail_billet
this.Control[iCurrent+5]=this.p_8
this.Control[iCurrent+6]=this.st_infopat
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.gb_4
this.Control[iCurrent+11]=this.rr_1
this.Control[iCurrent+12]=this.rr_infopat
end on

on w_portail_cie.destroy
call super::destroy
destroy(this.dw_portrait_rappels)
destroy(this.dw_boite_reception)
destroy(this.uo_toolbar)
destroy(this.dw_portail_billet)
destroy(this.p_8)
destroy(this.st_infopat)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.rr_1)
destroy(this.rr_infopat)
end on

event open;call super::open;string	ls_nom, ls_prenom

//Récupérer le nom de la personne loggué

SELECT prenom, nom
INTO :ls_prenom, :ls_nom
from t_users
WHERE id_user = :gl_iduser
USING SQLCA;

//Attente du nouvel horaire
////Récupérer le id_specialist
//SELECT t_specialists.id_specialist
//INTO :il_no_specialist
//FROM t_specialists
//WHERE t_specialists.dr_nom = :ls_nom AND t_specialists.dr_prenom = :ls_prenom;

IF IsNull(ls_prenom) THEN 
	ls_prenom = ""
ELSE
	//Ajouter l'Espace
	ls_prenom += " "
END IF

IF IsNull(ls_nom) THEN ls_nom = ""

is_nom = "%" + ls_prenom + ls_nom + "%"

//dw_boite_reception.Retrieve(is_nom)
//dw_portail_billet.retrieve(gl_iduser)
This.event timer()
timer(10)
end event

event timer;call super::timer;long ll_idraptrait, ll_idspec, i, ll_iduser, ll_setnull
date ldt_date, ldt_daterdv, ldt_date_debut, ldt_date_fin

dw_portail_billet.retrieve(gl_iduser)
dw_boite_reception.Retrieve(is_nom)


setPointer(hourglass!)

setnull(ll_idraptrait)

setnull(ll_idspec)
setnull(ll_iduser)
setnull(ldt_daterdv)
setnull(ll_setnull)
SetNull(ldt_date)
ldt_date_debut= date(today())
ldt_date_fin= date(RelativeDate ( today(), 7 ))

dw_portrait_rappels.Retrieve(ll_idraptrait,ll_idspec,ldt_date,ll_iduser,ll_setnull,ldt_daterdv, ldt_date_debut, ldt_date_fin)
setPointer(arrow!)
end event

event pfc_preopen;call super::pfc_preopen;THIS.WindowState = Maximized!
end event

event activate;call super::activate;THIS.WindowState = Maximized!
end event

type dw_portrait_rappels from u_dw within w_portail_cie
string tag = "resize=n"
integer x = 2094
integer y = 1064
integer width = 1243
integer height = 1264
integer taborder = 30
string dataobject = "d_portail_rappels"
end type

event doubleclicked;call super::doubleclicked;opensheet(w_rappels,w_appframe,2,layered!)
w_rappels.title = "Liste des rappels"		

end event

event clicked;call super::clicked;long	ll_patid

if row > 0 THEN
	IF dwo.name = "nom_complet" THEN
		ll_patid = THIS.object.t_rdv_id_patient[row]
		gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien app dossier patient",string(ll_patid))
		SetPointer(Hourglass!)
		opensheetwithparm(w_dossierpat,ll_patid,w_appframe,2,layered!)
	END IF
	
END IF
end event

type dw_boite_reception from u_dw within w_portail_cie
string tag = "resize=n"
integer x = 2094
integer y = 344
integer width = 2414
integer height = 544
integer taborder = 20
string dataobject = "d_boite_reception"
end type

event doubleclicked;call super::doubleclicked;w_boite_reception lw_fen
opensheet(lw_fen,w_appframe,2,layered!)		

end event

event constructor;call super::constructor;This.of_SetSort(True)
inv_sort.of_Setstyle(INV_SORT.SIMPLE)
inv_sort.of_Setcolumndisplaynamestyle(INV_SORT.HEADER)
inv_sort.of_Setcolumnheader(True)
end event

type uo_toolbar from u_cst_toolbarstrip within w_portail_cie
event destroy ( )
string tag = "resize=n"
integer x = 18
integer y = 2484
integer width = 4635
integer taborder = 40
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;
	
CHOOSE CASE as_button
		
	CASE "Fermer","Close"
		Close(PARENT)
		
	CASE "Accéder à mon horaire"
		s_horedv st_horedv

		st_horedv.adt_rdv = today()
		st_horedv.at_rdv = time('00:00')	
		st_horedv.ai_col = 1
		opensheetwithparm(w_horaire,st_horedv,w_appframe,2,layered!)
		w_horaire.title = "Horaire de Progitek"
		
	CASE "Accéder à la liste de billets"
		w_listebillets lw_sheetb
		opensheet(lw_sheetb,w_appframe,2,layered!)
		
	CASE "Écrire un nouveau message"
		w_envoi_message lw_sheet
		opensheet(lw_sheet,w_appframe,2,layered!)		

	CASE "Boîte de réception"
		w_boite_reception lw_fen
		opensheet(lw_fen,w_appframe,2,layered!)		
		
	CASE "Accéder aux rappels"
		opensheet(w_rappels,w_appframe,2,layered!)
		w_rappels.title = "Liste des rappels"		
		
	CASE "Créer un billet"
		opensheet(w_billets,w_appframe,2,layered!)
		if isvalid(w_billets) then w_billets.title = "Billet"		

END CHOOSE

end event

type dw_portail_billet from u_dw within w_portail_cie
string tag = "resize=n"
integer x = 151
integer y = 344
integer width = 1765
integer height = 1984
integer taborder = 10
string dataobject = "d_portail_billet"
end type

event buttonclicked;call super::buttonclicked;IF DWO.NAME = "b_ouvrir" THEN
	setItem(row,'t_billets_datedebut',datetime(today(),now()))
	THIS.object.t_billets_id_etat[row]  = "1"
ELSEIF DWO.NAME = "b_ferme" THEN
	setItem(row,'t_billets_datefin',datetime(today(),now()))
	THIS.object.t_billets_id_etat[row]  = "4"	
END IF

THIS.update(true,true)

dw_portail_billet.POST retrieve(gl_iduser)

end event

event clicked;call super::clicked;long	ll_billet

//Ouvrir au bon billet

If row > 0 THEN
	if dwo.name = "cf_toute" THEN
		ll_billet = THIS.object.t_billets_id_billet[row]
		opensheetwithparm(w_billets,ll_billet,w_appframe,2,layered!)
	END IF
END IF
end event

type p_8 from picture within w_portail_cie
string tag = "resize=n"
integer x = 69
integer y = 28
integer width = 146
integer height = 144
string picturename = "C:\ii4net\dentitek\images\progitek_i.gif"
boolean focusrectangle = false
end type

type st_infopat from st_uo_transparent within w_portail_cie
string tag = "resize=n"
integer x = 283
integer y = 68
integer width = 1161
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
long backcolor = 67108864
string text = "Progitek aujourd~'hui!"
end type

type gb_1 from groupbox within w_portail_cie
string tag = "resize=n"
integer x = 2034
integer y = 976
integer width = 1371
integer height = 1400
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Mes rappels pour les 7 prochains jours"
end type

type gb_2 from groupbox within w_portail_cie
string tag = "resize=n"
integer x = 3479
integer y = 976
integer width = 1097
integer height = 1400
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Mon horaire aujourd~'hui"
end type

type gb_3 from groupbox within w_portail_cie
string tag = "resize=n"
integer x = 101
integer y = 260
integer width = 1865
integer height = 2116
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Mes billets"
end type

type gb_4 from groupbox within w_portail_cie
string tag = "resize=n"
integer x = 2030
integer y = 260
integer width = 2551
integer height = 684
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Ma boîte de réception"
end type

type rr_1 from roundrectangle within w_portail_cie
string tag = "resize=n"
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15780518
integer x = 18
integer y = 208
integer width = 4626
integer height = 2240
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_infopat from roundrectangle within w_portail_cie
string tag = "resize=n"
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 67108864
integer x = 18
integer y = 16
integer width = 4626
integer height = 172
integer cornerheight = 75
integer cornerwidth = 75
end type

