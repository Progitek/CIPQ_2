$PBExportHeader$w_saisie_etat_physique.srw
forward
global type w_saisie_etat_physique from w_sheet_frame
end type
type dw_etat_physique from u_dw within w_saisie_etat_physique
end type
type uo_toolbar from u_cst_toolbarstrip within w_saisie_etat_physique
end type
type rr_1 from roundrectangle within w_saisie_etat_physique
end type
end forward

global type w_saisie_etat_physique from w_sheet_frame
string tag = "menu=m_lotsdeverratsenisolement"
dw_etat_physique dw_etat_physique
uo_toolbar uo_toolbar
rr_1 rr_1
end type
global w_saisie_etat_physique w_saisie_etat_physique

type variables
Protected:

long il_nolot, il_prepose
date idt_date_ep
end variables

event open;call super::open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)

uo_toolbar.of_AddItem("Ajouter", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar.of_AddItem("Enregistrer", "Save!")
//uo_toolbar.of_AddItem("Rechercher...", "Search!")
uo_toolbar.of_AddItem("Imprimer", "Print!")
uo_toolbar.of_AddItem("Fermer", "Exit!")

uo_toolbar.of_displaytext(true)

THIS.Title = st_title.text
end event

event pfc_preopen;call super::pfc_preopen;il_nolot = long(gnv_app.inv_entrepotglobal.of_retournedonnee("lien lot"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien lot", "")

dw_etat_physique.retrieve(il_nolot)
end event

on w_saisie_etat_physique.create
int iCurrent
call super::create
this.dw_etat_physique=create dw_etat_physique
this.uo_toolbar=create uo_toolbar
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_etat_physique
this.Control[iCurrent+2]=this.uo_toolbar
this.Control[iCurrent+3]=this.rr_1
end on

on w_saisie_etat_physique.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_etat_physique)
destroy(this.uo_toolbar)
destroy(this.rr_1)
end on

type st_title from w_sheet_frame`st_title within w_saisie_etat_physique
string text = "Saisie des états physiques"
end type

type p_8 from w_sheet_frame`p_8 within w_saisie_etat_physique
integer height = 64
string picturename = "Cursor!"
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_saisie_etat_physique
end type

type dw_etat_physique from u_dw within w_saisie_etat_physique
integer x = 46
integer y = 208
integer width = 4498
integer height = 1968
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_saisie_etat_physique"
boolean ib_maj_ligne_par_ligne = false
end type

event pfc_preupdate;call super::pfc_preupdate;IF ancestorreturnvalue <> SUCCESS THEN
	RETURN ancestorreturnvalue
END IF

long ll_rangee, ll_nb_etat, ll_rangee_trouvee
dwItemStatus lenum_status

ll_nb_etat = this.rowCount()

for ll_rangee = 1 to ll_nb_etat
	lenum_status = this.getItemStatus(ll_rangee, 0, Primary!)
	
	// S'il n'y a pas déjà de rangée dans la BD
	if isNull(this.object.tatouage[ll_rangee]) then
		// Si l'utilisateur a fait au moins un changement (sinon, on n'enregistre pas cette rangée)
		if lenum_status = NewModified! or lenum_status = DataModified! then
			this.object.tatouage[ll_rangee] = this.object.t_isolementverrat_tatouage[ll_rangee]
			
			// Si c'est une rangée qui a été récupérée par le retrieve (au moins une évaluation existe pour ce lot à cette date dans la BD)
			if lenum_status = DataModified! then
				ll_rangee_trouvee = this.find("date(dateexamenetatphysique) = date('" + string(this.object.dateexamenetatphysique[ll_rangee], "yyyy-mm-dd") + "') and lookupdisplay(prepose) = cp_prepose", 1, ll_nb_etat)
				
				if ll_rangee_trouvee > 0 then this.object.prepose[ll_rangee] = this.object.prepose[ll_rangee_trouvee]
				
				this.setItemStatus(ll_rangee, 0, Primary!, NewModified!)
			end if
		end if
	elseif lenum_status = New! then
		this.setItemStatus(ll_rangee, 0, Primary!, DataModified!)
		this.setItemStatus(ll_rangee, 0, Primary!, NotModified!)
	end if
next
end event

event pfc_insertrow;call super::pfc_insertrow;if ancestorReturnValue <= 0 then return ancestorReturnValue

n_ds lnv_tatouage
long ll_row_ds, ll_row_dw, ll_nb_verrats

this.setRedraw(false)

ll_row_dw = ancestorReturnValue

lnv_tatouage = create n_ds

lnv_tatouage.dataobject = "ds_tatouage_lot"
lnv_tatouage.setTransObject(SQLCA)
ll_nb_verrats = lnv_tatouage.retrieve(il_nolot)

for ll_row_ds = 1 to ll_nb_verrats
	if ll_row_ds > 1 then ll_row_dw = this.insertRow(0)
	
	this.object.nolot[ll_row_dw] = il_nolot
	this.object.dateexamenetatphysique[ll_row_dw] = datetime(idt_date_ep)
	this.object.prepose[ll_row_dw] = il_prepose
	this.object.norang[ll_row_dw] = lnv_tatouage.object.norang[ll_row_ds]
	
	this.object.t_isolementverrat_tatouage[ll_row_dw] = lnv_tatouage.object.tatouage[ll_row_ds]
	
	this.setItemStatus(ll_row_dw, 0, Primary!, NotModified!)
next

this.sort()
this.groupCalc()

// Scroll
ll_row_dw = this.find("date(dateexamenetatphysique) = date('" + string(idt_date_ep, "yyyy-mm-dd") + "') and t_isolementverrat_tatouage = '" + string(lnv_tatouage.object.tatouage[1]) + "'", 1, this.rowCount())

if ll_row_dw > 0 then scrollToRow(ll_row_dw)

destroy lnv_tatouage

this.setRedraw(true)
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;if ancestorReturnValue <> CONTINUE_ACTION then return ancestorReturnValue

w_critere_date_etat_phys lw_window
long ll_rangee_find
string ls_date_retour

gnv_app.inv_entrepotglobal.of_ajoutedonnee("rapport date", "w_saisie_etat_physique")
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lot isolement date", il_nolot)
Open(lw_window, gnv_app.of_GetFrame())

ls_date_retour = gnv_app.inv_entrepotglobal.of_retournedonnee("lien date")
if not isDate(ls_date_retour) then return PREVENT_ACTION

il_prepose = gnv_app.inv_entrepotglobal.of_retournedonnee("lien prepose")
idt_date_ep = date(ls_date_retour)

return CONTINUE_ACTION
end event

event itemchanged;call super::itemchanged;string ls_critere, ls_val

ls_critere = lower(dwo.name)

ls_val = right(ls_critere, 1)
ls_critere = left(ls_critere, len(ls_critere) - 1)

if (ls_val = 'n' or ls_val = 'f') and data = '1' then
	if ls_val = 'n' then ls_val = 'f' else ls_val = 'n'
	
	if this.getItemNumber(row, ls_critere + ls_val) = 1 then this.setItem(row, ls_critere + ls_val, 0)
end if
end event

event sqlpreview;// Override - Pour empêcher le bogue lorsqu'on sauve plusieurs rangées à la fois
end event

type uo_toolbar from u_cst_toolbarstrip within w_saisie_etat_physique
event destroy ( )
string tag = "resize=frbsr"
integer x = 23
integer y = 2220
integer width = 4544
integer taborder = 60
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	CASE "Add","Ajouter"
		if parent.event pfc_save() >= 0 then
			dw_etat_physique.event pfc_insertrow()
		end if
			
	CASE "Save", "Sauvegarder", "Sauvegarde", "Enregistrer"
		parent.event pfc_save()
		
	CASE "Rechercher..."
		IF parent.event pfc_save() >= 0 THEN
			IF dw_etat_physique.RowCount() > 0 THEN
				dw_etat_physique.SetRow(1)
				dw_etat_physique.ScrollToRow(1)
				dw_etat_physique.event pfc_finddlg()
			END IF
		END IF
		
	CASE "Imprimer"
		w_r_liste_etat_physique	lw_window
		
		IF parent.event pfc_save() >= 0 THEN
			gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien lot", string(il_nolot))
			OpenSheet(lw_window, gnv_app.of_GetFrame(), 6, layered!)
		END IF
		
	CASE "Fermer", "Close"		
		parent.event pfc_Close()

END CHOOSE
end event

type rr_1 from roundrectangle within w_saisie_etat_physique
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 23
integer y = 188
integer width = 4549
integer height = 2016
integer cornerheight = 40
integer cornerwidth = 46
end type

