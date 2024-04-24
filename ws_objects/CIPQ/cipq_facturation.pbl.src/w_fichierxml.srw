$PBExportHeader$w_fichierxml.srw
forward
global type w_fichierxml from w_sheet
end type
type rb_bon from radiobutton within w_fichierxml
end type
type rb_date from radiobutton within w_fichierxml
end type
type uo_fermer from u_cst_toolbarstrip within w_fichierxml
end type
type st_5 from statictext within w_fichierxml
end type
type lb_files from u_lb within w_fichierxml
end type
type uo_creerxml from u_cst_toolbarstrip within w_fichierxml
end type
type uo_rechercher from u_cst_toolbarstrip within w_fichierxml
end type
type st_4 from statictext within w_fichierxml
end type
type st_3 from statictext within w_fichierxml
end type
type st_2 from statictext within w_fichierxml
end type
type st_1 from statictext within w_fichierxml
end type
type sle_fin from singlelineedit within w_fichierxml
end type
type sle_deb from singlelineedit within w_fichierxml
end type
type em_debut from editmask within w_fichierxml
end type
type em_fin from editmask within w_fichierxml
end type
type dw_fichierxmlbon from u_dw within w_fichierxml
end type
type rr_1 from roundrectangle within w_fichierxml
end type
end forward

global type w_fichierxml from w_sheet
integer width = 1673
integer height = 2356
boolean ib_isupdateable = false
rb_bon rb_bon
rb_date rb_date
uo_fermer uo_fermer
st_5 st_5
lb_files lb_files
uo_creerxml uo_creerxml
uo_rechercher uo_rechercher
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
sle_fin sle_fin
sle_deb sle_deb
em_debut em_debut
em_fin em_fin
dw_fichierxmlbon dw_fichierxmlbon
rr_1 rr_1
end type
global w_fichierxml w_fichierxml

forward prototypes
public subroutine uf_traduction ()
end prototypes

public subroutine uf_traduction ();uo_rechercher.of_settheme("classics")
uo_rechercher.of_displayborder(true)
uo_rechercher.of_addItem("Rechercher","Search!")
uo_rechercher.of_displaytext(true)

uo_creerxml.of_settheme("classics")
uo_creerxml.of_displayborder(true)
uo_creerxml.of_addItem("Créer fichier XML","PasteSQL5!")
uo_creerxml.of_displaytext(true)

uo_fermer.of_settheme("classics")
uo_fermer.of_displayborder(true)
uo_fermer.of_addItem("Fermer","Exit!")
uo_fermer.of_displaytext(true)


end subroutine

on w_fichierxml.create
int iCurrent
call super::create
this.rb_bon=create rb_bon
this.rb_date=create rb_date
this.uo_fermer=create uo_fermer
this.st_5=create st_5
this.lb_files=create lb_files
this.uo_creerxml=create uo_creerxml
this.uo_rechercher=create uo_rechercher
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_fin=create sle_fin
this.sle_deb=create sle_deb
this.em_debut=create em_debut
this.em_fin=create em_fin
this.dw_fichierxmlbon=create dw_fichierxmlbon
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_bon
this.Control[iCurrent+2]=this.rb_date
this.Control[iCurrent+3]=this.uo_fermer
this.Control[iCurrent+4]=this.st_5
this.Control[iCurrent+5]=this.lb_files
this.Control[iCurrent+6]=this.uo_creerxml
this.Control[iCurrent+7]=this.uo_rechercher
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.sle_fin
this.Control[iCurrent+13]=this.sle_deb
this.Control[iCurrent+14]=this.em_debut
this.Control[iCurrent+15]=this.em_fin
this.Control[iCurrent+16]=this.dw_fichierxmlbon
this.Control[iCurrent+17]=this.rr_1
end on

on w_fichierxml.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_bon)
destroy(this.rb_date)
destroy(this.uo_fermer)
destroy(this.st_5)
destroy(this.lb_files)
destroy(this.uo_creerxml)
destroy(this.uo_rechercher)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_fin)
destroy(this.sle_deb)
destroy(this.em_debut)
destroy(this.em_fin)
destroy(this.dw_fichierxmlbon)
destroy(this.rr_1)
end on

event open;call super::open;em_debut.text = string(today())
em_fin.text = string(today())
lb_files.event ue_fill()
end event

type rb_bon from radiobutton within w_fichierxml
integer x = 466
integer y = 32
integer width = 430
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12639424
string text = "Intervalle de bon"
end type

type rb_date from radiobutton within w_fichierxml
integer x = 27
integer y = 32
integer width = 375
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12639424
string text = "Intervalle date"
boolean checked = true
end type

type uo_fermer from u_cst_toolbarstrip within w_fichierxml
integer x = 1065
integer y = 2056
integer taborder = 40
end type

on uo_fermer.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;close(parent)
end event

type st_5 from statictext within w_fichierxml
integer x = 37
integer y = 572
integer width = 498
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12639424
string text = "Numéro de compagnie"
boolean focusrectangle = false
end type

type lb_files from u_lb within w_fichierxml
event ue_fill ( )
integer x = 37
integer y = 636
integer width = 480
integer height = 1392
integer taborder = 30
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Tahoma"
boolean multiselect = true
boolean extendedselect = true
end type

event ue_fill();string ls_cie

DECLARE listcie CURSOR FOR
	select cie from t_centrecipq;
	
OPEN listcie;

FETCH listcie INTO :ls_cie;

DO WHILE SQLCA.SQLCode = 0
	
	of_additem( ls_cie, ls_cie)

	FETCH listcie INTO :ls_cie;

LOOP

CLOSE listcie;
 
end event

type uo_creerxml from u_cst_toolbarstrip within w_fichierxml
integer x = 530
integer y = 2056
integer taborder = 30
end type

on uo_creerxml.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;string ls_xml, ls_cieno, ls_ligneno, ls_prodno, ls_descrip, ls_livno, ls_melange, ls_regagr, ls_ampm,ls_credit
string ls_messageliv, ls_boncommande, ls_groupe, ls_transporteur, ls_nomeleveur, ls_adresseeleveur
string ls_rueeleveur, ls_villeeleveur, ls_conteeleveur, ls_provinceeleveur, ls_codposteleveur
string ls_telephoneeleveur, ls_adresseeleveur_a, ls_villeeleveur_a, ls_codposteleveur_a
string ls_telephoneeleveur_a, ls_conteeleveur_a, ls_sousgroupe
long ll_qtecomm, ll_qteexp, ll_qteinit
datetime ldtt_livdate
date ldt_debut, ldt_fin
long ll_debut, ll_fin, i
string ls_path, ls_file
int li_rc


em_debut.getdata(ldt_debut)
em_fin.getdata(ldt_fin)

ll_debut = long(sle_deb.text)
ll_fin =  long(sle_fin.text)

ls_xml += "<?xml version=~"1.0~"?>"  + "~r~n"
ls_xml += "<bibliotheque>" + "~r~n"

for i = 1 to dw_fichierxmlbon.rowcount()
	
	ls_cieno = dw_fichierxmlbon.getItemString(i,"t_statfacture_cie_no")
	ls_livno = dw_fichierxmlbon.getItemString(i,"t_statfacture_liv_no")
	ls_xml += "<cie_no id=~"" + ls_cieno + "~">~r~n"
	ls_xml += "<liv_no id=~"" + ls_livno + "~">~r~n"
	
	
	DECLARE liststat CURSOR FOR
		select  	 t_statfacturedetail.cie_no,
					  t_statfacturedetail.liv_no,
					  t_statfacturedetail.ligne_no,
					  t_statfacturedetail.prod_no,
					  t_statfacturedetail.qte_comm,
					  t_statfacturedetail.qte_exp,
					  t_statfacturedetail.description,
					  t_statfacturedetail.melange,
					  t_statfacturedetail.qteinit,
					  t_statfacture.reg_agr,
					  t_statfacture.liv_date,
					  t_statfacture.ampm, 
					  t_statfacture.credit,
					  t_statfacture.message_liv,
					  t_statfacture.boncommandeclient,
					  t_eleveur_group.description,
					  t_eleveur_groupsecondaire.nomgroupsecondaire,
					  t_transporteur.secteur,
					  t_eleveur.nom,
					  t_eleveur.adresse,
					  t_eleveur.rue,
					  t_eleveur.ville,
					  t_eleveur.conte,
					  t_eleveur.province,
					  t_eleveur.code_post,
					  t_eleveur.telephone,
					  t_eleveur.liv_adr_a,
					  t_eleveur.liv_vil_a,
					  t_eleveur.liv_cod_a,
					  t_eleveur.liv_tel_a,
					  t_eleveur.liv_conte
		from t_statfacture  INNER JOIN t_statfacturedetail ON t_statfacture.cie_no = t_statfacturedetail.cie_no and t_statfacture.liv_no = t_statfacturedetail.liv_no
								  LEFT OUTER JOIN t_eleveur ON t_eleveur.no_eleveur = t_statfacture.no_eleveur
								  LEFT OUTER JOIN t_transporteur ON t_transporteur.idtransporteur = t_statfacture.idtransporteur
								  LEFT OUTER JOIN t_eleveur_group ON t_eleveur_group.idgroup = t_statfacture.groupe
								  LEFT OUTER JOIN t_eleveur_groupsecondaire ON t_eleveur_groupsecondaire.idgroup = t_statfacture.groupesecondaire
		where     t_statfacture.cie_no = :ls_cieno AND
					 t_statfacture.liv_no = :ls_livno;
					 
	OPEN liststat;
	
	FETCH liststat 	into	:ls_cieno,
									 :ls_livno,
									 :ls_ligneno,
									 :ls_prodno,
									 :ll_qtecomm,
									 :ll_qteexp,
									 :ls_descrip,
									 :ls_melange,
									 :ll_qteinit,
									 :ls_regagr,
									 :ldtt_livdate,
									 :ls_ampm,
									 :ls_credit,
									 :ls_messageliv,
									 :ls_boncommande,
									 :ls_groupe,
									 :ls_sousgroupe,
									 :ls_transporteur,
									 :ls_nomeleveur,
									 :ls_adresseeleveur,
									 :ls_rueeleveur,
									 :ls_villeeleveur,
									 :ls_conteeleveur,
									 :ls_provinceeleveur,
									 :ls_codposteleveur,
									 :ls_telephoneeleveur,
									 :ls_adresseeleveur_a,
									 :ls_villeeleveur_a,
									 :ls_codposteleveur_a,
									 :ls_telephoneeleveur_a,
									 :ls_conteeleveur_a;
									 
	DO WHILE SQLCA.SQLCode = 0
	
		
	
	//	ls_xml += "<cie_no>" + ls_cieno + "</cie_no>" + "~r~n"
	//	ls_xml += "<liv_no>" + ls_livno + "</liv_no>" + "~r~n"
		ls_xml += "<bonlivraison>" + "~r~n"
		if isnull(ls_ligneno) then ls_ligneno  = ""
		ls_xml += "<ligne_no>" + ls_ligneno + "</ligne_no>" + "~r~n"
		if isnull(ls_prodno) then ls_prodno  = ""
		ls_xml += "<prod_no>" + ls_prodno + "</prod_no>" + "~r~n"
		if isnull(ll_qtecomm) then ll_qtecomm  = 0
		ls_xml += "<qte_comm>" + string(ll_qtecomm) + "</qte_comm>" + "~r~n"
		if isnull(ll_qteexp) then ll_qteexp  = 0
		ls_xml += "<qte_exp>" + string(ll_qteexp) + "</qte_exp>" + "~r~n"
		if isnull(ls_descrip) then ls_descrip  = ""
		ls_xml += "<description>" + ls_descrip + "</description>" + "~r~n"
		if isnull(ls_melange) then ls_melange  = ""
		ls_xml += "<melange>" + ls_melange + "</melange>" + "~r~n"
		if isnull(ll_qteinit) then ll_qteinit  = 0
		ls_xml += "<qteinit>" + string(ll_qteinit) + "</qteinit>" + "~r~n"
		if isnull(ls_regagr) then ls_regagr  = ""
		ls_xml += "<reg_agr>" + ls_regagr + "</reg_agr>" + "~r~n"
		ls_xml += "<liv_date>" + string(ldtt_livdate,"dd-mm-yyyy") + "</liv_date>" + "~r~n"
		if isnull(ls_ampm) then ls_ampm  = ""
		ls_xml += "<ampm>" + ls_ampm + "</ampm>" + "~r~n"
		if isnull(ls_credit) then ls_credit  = ""
		ls_xml += "<credit>" + ls_credit + "</credit>" + "~r~n"
		if isnull(ls_messageliv) then ls_messageliv  = ""
		ls_xml += "<message_liv>" + ls_messageliv + "</message_liv>" + "~r~n"
		if isnull(ls_boncommande) then ls_boncommande  = ""
		ls_xml += "<boncommande>" + ls_boncommande + "</boncommande>" + "~r~n"
		if isnull(ls_groupe) then ls_groupe  = ""
		ls_xml += "<groupe>" + ls_groupe + "</groupe>" + "~r~n"
		if isnull(ls_sousgroupe) then ls_sousgroupe  = ""
		ls_xml += "<sousgroupe>" + ls_sousgroupe + "</sousgroupe>" + "~r~n"
		if isnull(ls_transporteur) then ls_transporteur  = ""
		ls_xml += "<transporteur>" + ls_transporteur + "</transporteur>" + "~r~n"
		if isnull(ls_nomeleveur) then ls_nomeleveur  = ""
		ls_xml += "<nomeleveur><![CDATA[" + ls_nomeleveur + "]]></nomeleveur>" + "~r~n"
		if isnull(ls_adresseeleveur) then ls_adresseeleveur  = ""
		ls_xml += "<adresseeleveur>" + ls_adresseeleveur + "</adresseeleveur>" + "~r~n"
		if isnull(ls_rueeleveur) then ls_rueeleveur  = ""
		ls_xml += "<rueeleveur>" + ls_rueeleveur + "</rueeleveur>" + "~r~n"
		if isnull(ls_villeeleveur) then ls_villeeleveur  = ""
		ls_xml += "<villeeleveur>" + ls_villeeleveur + "</villeeleveur>" + "~r~n"
		if isnull(ls_conteeleveur) then ls_conteeleveur  = ""
		ls_xml += "<conteeleveur>" + ls_conteeleveur + "</conteeleveur>" + "~r~n"
		if isnull(ls_provinceeleveur) then ls_provinceeleveur  = ""
		ls_xml += "<provinceeleveur>" + ls_provinceeleveur + "</provinceeleveur>" + "~r~n"
		if isnull(ls_codposteleveur) then ls_codposteleveur  = ""
		ls_xml += "<codeposteleveur>" + ls_codposteleveur + "</codeposteleveur>" + "~r~n"
		if isnull(ls_telephoneeleveur) then ls_telephoneeleveur  = ""
		ls_xml += "<telephoneeleveur>" + ls_telephoneeleveur + "</telephoneeleveur>" + "~r~n"
		if isnull(ls_adresseeleveur_a) then ls_adresseeleveur_a  = ""
		ls_xml += "<adresseeleveur_a>" + ls_adresseeleveur_a + "</adresseeleveur_a>" + "~r~n"
		if isnull(ls_villeeleveur_a) then ls_villeeleveur_a  = ""
		ls_xml += "<villeeleveur_a>" + ls_villeeleveur_a + "</villeeleveur_a>" + "~r~n"
		if isnull(ls_codposteleveur_a) then ls_codposteleveur_a  = ""
		ls_xml += "<codeposteleveur_a>" + ls_codposteleveur_a + "</codeposteleveur_a>" + "~r~n"
		if isnull(ls_telephoneeleveur_a) then ls_telephoneeleveur_a  = ""
		ls_xml += "<telephoneeleveur_a>" + ls_telephoneeleveur_a + "</telephoneeleveur_a>" + "~r~n"
		if isnull(ls_conteeleveur_a) then ls_conteeleveur_a  = ""
		ls_xml += "<conteeleveur_a>" + ls_conteeleveur_a + "</conteeleveur_a>" + "~r~n"
		ls_xml += "</bonlivraison>" + "~r~n"
		
		FETCH liststat 	into	:ls_cieno,
										 :ls_livno,
										 :ls_ligneno,
										 :ls_prodno,
										 :ll_qtecomm,
										 :ll_qteexp,
										 :ls_descrip,
										 :ls_melange,
										 :ll_qteinit,
										 :ls_regagr,
										 :ldtt_livdate,
										 :ls_ampm,
										 :ls_credit,
										 :ls_messageliv,
										 :ls_boncommande,
										 :ls_groupe,
										 :ls_sousgroupe,
										 :ls_transporteur,
										 :ls_nomeleveur,
										 :ls_adresseeleveur,
										 :ls_rueeleveur,
										 :ls_villeeleveur,
										 :ls_conteeleveur,
										 :ls_provinceeleveur,
										 :ls_codposteleveur,
										 :ls_telephoneeleveur,
										 :ls_adresseeleveur_a,
										 :ls_villeeleveur_a,
										 :ls_codposteleveur_a,
										 :ls_telephoneeleveur_a,
										 :ls_conteeleveur_a;
										 
			
		
	LOOP
	
	CLOSE liststat;
	
	ls_xml += "</liv_no>~r~n"
	ls_xml += "</cie_no>~r~n"
	
	
next

ls_xml += "</bibliotheque>" 

long ll_file
ls_path = "c:\ii4net\cipq"
if not directoryexists(ls_path) then
	createdirectory(ls_path)
end if
ls_path += "\curl"
if not directoryexists(ls_path) then
	createdirectory(ls_path)
end if

ls_path +="\text.xml"

ll_file = fileopen(ls_path,textmode!,write!,LockReadWrite!, Replace!, EncodingUTF8!)

filewriteex(ll_file,ls_xml)
fileclose(ll_file)

long ll_run
n_cst_syncproc luo_sync
luo_sync = CREATE n_cst_syncproc
			
luo_sync.of_setwindow('Minimized!')
luo_sync.of_RunAndWait('"' + "C:\ii4net\cipq\curl\curl_request.bat" + '"')



//ll_run = run("C:\ii4net\cipq\curl\curl_request.bat",Normal!)
//messagebox('run',ll_run)

// c:\ii4net\cipq\curl\bin\curl.exe 

//ls_path = "C:\Bon de livraison"
//li_rc = GetFileSaveName ( "Sauvegarder le fichier", ls_path, ls_file, "XML",  "Fichier XML (*.*),*.xml" , "C:\My Documents", 32770) 
//
//gnv_app.inv_filesrv.of_filewrite(ls_file, ls_xml, false)
end event

type uo_rechercher from u_cst_toolbarstrip within w_fichierxml
integer x = 5
integer y = 2056
integer taborder = 20
end type

on uo_rechercher.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;date ldt_debut, ldt_fin
long ll_debut, ll_fin,  ll_insertrow, ll_ret, i, ll_state, j, k
string ls_livno, ls_cie[], ls_cietemp, ls_cieno

dw_fichierxmlbon.of_reset()

em_debut.getData(ldt_debut)
em_fin.getData(ldt_fin)

 ll_debut  =  long(sle_deb.text)
 ll_fin =  long(sle_fin.text)

if rb_date.checked then
	ll_ret = 0
else
	ll_ret = 1
end if

j = 1

for i = 1 to lb_files.totalitems()
	
	ll_state = lb_files.state(i)
	if ll_state = 1 then
		ls_cie[j] = lb_files.text(i)
		j++
	end if
	
next

DECLARE listbon CURSOR FOR
	select  	DISTINCT t_statfacturedetail.cie_no , t_statfacturedetail.liv_no 
	from t_statfacture  INNER JOIN t_statfacturedetail ON t_statfacture.cie_no = t_statfacturedetail.cie_no and t_statfacture.liv_no = t_statfacturedetail.liv_no
	where (:ll_ret = 0 and date(liv_date) between :ldt_debut and :ldt_fin) or
			  (:ll_ret = 1 and CAST(t_statfacturedetail.liv_no AS INTEGER) between :ll_debut and :ll_fin);

OPEN listbon;

FETCH listbon INTO :ls_cieno, :ls_livno;

DO WHILE SQLCA.SQLCode = 0

	ls_cietemp = ""
	for k = 1 to upperbound(ls_cie)
		
		if ls_cieno = ls_cie[k] then
			
			ll_insertrow = dw_fichierxmlbon.insertRow(0)
			dw_fichierxmlbon.setItem(ll_insertrow, 't_statfacture_liv_no', ls_livno)
			dw_fichierxmlbon.setItem(ll_insertrow, 't_statfacture_cie_no', ls_cieno)
			
		end if
		
	next
	
	FETCH listbon INTO :ls_cieno, :ls_livno;
	
LOOP

CLOSE listbon;
end event

type st_4 from statictext within w_fichierxml
integer x = 32
integer y = 456
integer width = 160
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "au:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_fichierxml
integer x = 32
integer y = 352
integer width = 160
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Du:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_fichierxml
integer x = 32
integer y = 240
integer width = 160
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "au:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_fichierxml
integer x = 32
integer y = 136
integer width = 160
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Du:"
boolean focusrectangle = false
end type

type sle_fin from singlelineedit within w_fichierxml
integer x = 229
integer y = 456
integer width = 219
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "0"
boolean border = false
end type

type sle_deb from singlelineedit within w_fichierxml
integer x = 229
integer y = 352
integer width = 219
integer height = 80
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "0"
boolean border = false
end type

type em_debut from editmask within w_fichierxml
integer x = 229
integer y = 136
integer width = 411
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "none"
boolean border = false
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type em_fin from editmask within w_fichierxml
integer x = 229
integer y = 240
integer width = 411
integer height = 80
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
boolean border = false
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type dw_fichierxmlbon from u_dw within w_fichierxml
integer x = 997
integer y = 52
integer width = 562
integer height = 1888
integer taborder = 10
string dataobject = "d_fichierxmlbon"
end type

type rr_1 from roundrectangle within w_fichierxml
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 1073741824
integer x = 983
integer y = 32
integer width = 594
integer height = 1924
integer cornerheight = 40
integer cornerwidth = 46
end type

