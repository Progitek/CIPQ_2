$PBExportHeader$w_savefile.srw
forward
global type w_savefile from window
end type
type p_1 from picture within w_savefile
end type
type st_1 from statictext within w_savefile
end type
type uo_toolbar from u_cst_toolbarstrip within w_savefile
end type
type dw_savefile from datawindow within w_savefile
end type
type rr_1 from roundrectangle within w_savefile
end type
type rr_2 from roundrectangle within w_savefile
end type
end forward

global type w_savefile from window
integer width = 4727
integer height = 1956
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 12639424
string icon = "AppIcon!"
boolean center = true
p_1 p_1
st_1 st_1
uo_toolbar uo_toolbar
dw_savefile dw_savefile
rr_1 rr_1
rr_2 rr_2
end type
global w_savefile w_savefile

type variables
string is_codeverrat
string is_cie_no
string is_corrpath
string is_wordpath

end variables

forward prototypes
public subroutine of_importer ()
public subroutine of_delete ()
end prototypes

public subroutine of_importer ();int li_rtn
string ls_docpath, ls_docname, ls_dosscorr

SELECT isnull(corrpath,'') INTO :ls_dosscorr FROM t_parametre;

if right(ls_dosscorr, 1) <> '\' then ls_dosscorr += '\'

li_rtn = GetFileopenName("Select File", ls_docpath, ls_docname, "", "Correspondance (*.DOC; *.PDF; *.JPG; *.JPEG; *.XLS; *.XLSX; *.DOCX; *.OFT; *.OFTX; *.BMP; *.PNG; *.GIF; *.html; *.htm; *.txt;), *.DOC; *.PDF; *.JPG; *.JPEG; *.XLS; *.XLSX; *.DOCX; *.OFT; *.OFTX; *.BMP; *.PNG; *.GIF; *.html; *.htm; *.txt;", "u:\", 18)

if li_rtn = 1 then
	
	if not DirectoryExists(ls_dosscorr + is_cie_no + "-" + is_codeverrat) then CreateDirectory(ls_dosscorr + is_cie_no + "-" + is_codeverrat)
	if not DirectoryExists(ls_dosscorr + is_cie_no + "-" + is_codeverrat + "\scan") then CreateDirectory(ls_dosscorr + is_cie_no + "-" + is_codeverrat + "\scan")
	
	FileCopy(ls_docpath,ls_dosscorr + is_cie_no + "-" + is_codeverrat + "\" + ls_docname,true)
	dw_savefile.event ue_retrieve()
	
end if
end subroutine

public subroutine of_delete ();datetime ldtt_idlettre
long ll_row, ll_nb_fichiers, ll_droit, ll_iduser
string ls_lettre
n_cst_dirattrib lnv_fichiers[]

ll_row = dw_savefile.getrow()

if ll_row > 0 then
	ldtt_idlettre = dw_savefile.getitemDateTime(ll_row,'datecreation')

	ls_lettre = dw_savefile.getitemstring(ll_row,'nom_fichier')
	FileDelete (ls_lettre)

	ll_nb_fichiers = gnv_app.inv_filesrv.of_dirlist(is_corrpath + is_cie_no + "-" + is_codeverrat + '\.*.doc', 3, lnv_fichiers)
	
	for ll_row = 1 to ll_nb_fichiers
		FileDelete ( is_corrpath + is_cie_no + "-" + is_codeverrat + '\' + lnv_fichiers[ll_row].is_filename )
	next
		
	dw_savefile.event ue_retrieve()
end if


end subroutine

on w_savefile.create
this.p_1=create p_1
this.st_1=create st_1
this.uo_toolbar=create uo_toolbar
this.dw_savefile=create dw_savefile
this.rr_1=create rr_1
this.rr_2=create rr_2
this.Control[]={this.p_1,&
this.st_1,&
this.uo_toolbar,&
this.dw_savefile,&
this.rr_1,&
this.rr_2}
end on

on w_savefile.destroy
destroy(this.p_1)
destroy(this.st_1)
destroy(this.uo_toolbar)
destroy(this.dw_savefile)
destroy(this.rr_1)
destroy(this.rr_2)
end on

event open;is_codeverrat = string(gnv_app.inv_entrepotglobal.of_retournedonnee('codeverrat'))
if isnull(is_codeverrat) then
	is_codeverrat = string(gnv_app.inv_entrepotglobal.of_retournedonnee('nolot'))
	is_cie_no = ""
else
	is_cie_no = gnv_app.inv_entrepotglobal.of_retournedonnee('cie_no')
end if

select wordpath into :is_wordpath from t_parametre;
dw_savefile.event ue_retrieve()

end event

type p_1 from picture within w_savefile
integer x = 82
integer y = 64
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "Custom050!"
boolean focusrectangle = false
boolean map3dcolors = true
end type

type st_1 from statictext within w_savefile
integer x = 174
integer y = 64
integer width = 1303
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "Stockage des fichiers"
boolean focusrectangle = false
end type

type uo_toolbar from u_cst_toolbarstrip within w_savefile
string tag = "resize=mbar"
integer y = 1772
integer width = 4718
integer taborder = 20
boolean bringtotop = true
end type

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button		
	CASE "Importer"
		of_importer()
	CASE "Supprimer"
		IF Messagebox("Avertissement","Voulez-vous supprimer ce fichier ?", Exclamation!, YesNo!, 2) = 1 THEN
			of_delete()
		END IF
	CASE "Fermer"
		close(parent)
END CHOOSE
end event

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event constructor;call super::constructor;this.of_settheme("classic")
this.of_DisplayBorder(true)
this.of_AddItem("Importer", "Custom050!")
this.of_AddItem("Supprimer", "Close!")
this.of_AddItem("Fermer", "Exit!")
this.of_displaytext(true)
end event

type dw_savefile from datawindow within w_savefile
event ue_retrieve ( )
integer x = 73
integer y = 220
integer width = 4576
integer height = 1472
integer taborder = 10
string title = "none"
string dataobject = "d_dosspatcorrletter"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_retrieve();long ll_nb,ll_newrow
ulong ll_test
int i, index, li_result
date ldt
time lt
string ls_produit, ls_fichier, ls_a
n_cst_dirattrib lo_dirList[]

reset()
setRedraw(false)
	
	
	select corrpath into :is_corrpath from t_parametre;

	if right(is_corrpath, 1) <> '\' then is_corrpath += '\'
	
	li_result = RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Progitek\CIPQ\Corr", "cheminWord", RegString!, is_wordpath)
	if li_result <> 1 then
		li_result = RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Progitek\CIPQ\Corr", "cheminWord", RegString!, is_wordpath)
	end if
	if li_result <> 1 then
		is_wordpath = "C:\Program Files\Microsoft Office\Office11\winword.exe"
	elseif isNull(is_wordpath) then
		is_wordpath = "C:\Program Files\Microsoft Office\Office11\winword.exe"
	elseif is_wordpath = "" then
		is_wordpath = "C:\Program Files\Microsoft Office\Office11\winword.exe"
	end if
	
	if fileExists(is_corrpath) then
		if gnv_app.of_getLangue() = 'an' then ls_a = ' at ' else ls_a = ' à '
		
		ll_nb = gnv_app.inv_filesrv.of_dirList(is_corrpath + is_cie_no + "-" + is_codeverrat + "\*.doc", 0, lo_dirList)
		
		For i = 1 To ll_nb
			if left(lo_dirList[i].is_FileName,1) <> '.' then
				ls_fichier = is_corrpath + is_cie_no + "-" + is_codeverrat + "\" + lo_dirList[i].is_FileName
				
				ll_newrow = insertrow(0)
				setitem(ll_newrow,'corrletter',lo_dirList[i].is_FileName)
				
				gnv_app.inv_filesrv.of_getcreationdatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'created',string(ldt) + ls_a + string(lt))
				
				setitem(ll_newrow,'datecreation',datetime(ldt,lt))
				
				gnv_app.inv_filesrv.of_getlastwritedatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'modified',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastaccessdate(ls_fichier,ldt)
				setitem(ll_newrow,'accessed',string(ldt))
				
				setitem(ll_newrow,'nom_fichier',ls_fichier)
			
		   	setitem(ll_newrow,'pfile',gnv_app.of_getPathDefault() + "images\file\file-doc.png")
				
			end if
		Next
	
		ll_nb = gnv_app.inv_filesrv.of_dirList(is_corrpath + is_cie_no + "-" + is_codeverrat + "\*.pdf", 0, lo_dirList)
		For i = 1 To ll_nb
			if left(lo_dirList[i].is_FileName,1) <> '.' then
				ls_fichier = is_corrpath + is_cie_no + "-" + is_codeverrat + "\" + lo_dirList[i].is_FileName
				
				ll_newrow = insertrow(0)
				setitem(ll_newrow,'corrletter',lo_dirList[i].is_FileName)
				
				gnv_app.inv_filesrv.of_getcreationdatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'created',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastwritedatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'modified',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastaccessdate(ls_fichier,ldt)
				setitem(ll_newrow,'accessed',string(ldt))
				
				setitem(ll_newrow,'nom_fichier',ls_fichier)
				
				setitem(ll_newrow,'datecreation',datetime(ldt,lt))
				
				setitem(ll_newrow,'pfile',gnv_app.of_getPathDefault() + "images\file\file-pdf.png")
				
			end if
		Next
		
		// lister les .jpg
		ll_nb = gnv_app.inv_filesrv.of_dirList(is_corrpath + is_cie_no + "-" + is_codeverrat + "\scan\*.jpg", 33, lo_dirList)
		For i = 1 To ll_nb
			if left(lo_dirList[i].is_FileName,1) <> '.' then
				ls_fichier = is_corrpath + is_cie_no + "-" + is_codeverrat + "\scan\" + lo_dirList[i].is_FileName
				
				ll_newrow = insertrow(0)
				setitem(ll_newrow,'corrletter',lo_dirList[i].is_FileName)
				
				gnv_app.inv_filesrv.of_getcreationdatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'created',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastwritedatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'modified',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastaccessdate(ls_fichier,ldt)
				setitem(ll_newrow,'accessed',string(ldt))
				
				setitem(ll_newrow,'nom_fichier',ls_fichier)
				
				setitem(ll_newrow,'datecreation',datetime(ldt,lt))
				
				setitem(ll_newrow,'pfile',gnv_app.of_getPathDefault() + "images\file\file-jpg.png")
			end if
		Next
		
		
		// lister les .gif
		ll_nb = gnv_app.inv_filesrv.of_dirList(is_corrpath + is_cie_no + "-" + is_codeverrat + "\*.gif", 33, lo_dirList)
		For i = 1 To ll_nb
			if left(lo_dirList[i].is_FileName,1) <> '.' then
				ls_fichier = is_corrpath + is_cie_no + "-" + is_codeverrat + "\" + lo_dirList[i].is_FileName
				
				ll_newrow = insertrow(0)
				setitem(ll_newrow,'corrletter',lo_dirList[i].is_FileName)
				
				gnv_app.inv_filesrv.of_getcreationdatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'created',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastwritedatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'modified',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastaccessdate(ls_fichier,ldt)
				setitem(ll_newrow,'accessed',string(ldt))
				
				setitem(ll_newrow,'nom_fichier',ls_fichier)
				
				setitem(ll_newrow,'datecreation',datetime(ldt,lt))
				
				setitem(ll_newrow,'pfile',gnv_app.of_getPathDefault() + "images\file\file-jpg.png")
				
			end if
		Next
		
		// lister les .bmp
		ll_nb = gnv_app.inv_filesrv.of_dirList(is_corrpath + is_cie_no + "-" + is_codeverrat + "\*.bmp", 33, lo_dirList)
		For i = 1 To ll_nb
			if left(lo_dirList[i].is_FileName,1) <> '.' then
				ls_fichier = is_corrpath + is_cie_no + "-" + is_codeverrat + "\" + lo_dirList[i].is_FileName
				
				ll_newrow = insertrow(0)
				setitem(ll_newrow,'corrletter',lo_dirList[i].is_FileName)
				
				gnv_app.inv_filesrv.of_getcreationdatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'created',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastwritedatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'modified',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastaccessdate(ls_fichier,ldt)
				setitem(ll_newrow,'accessed',string(ldt))
				
				setitem(ll_newrow,'nom_fichier',ls_fichier)
				
				setitem(ll_newrow,'datecreation',datetime(ldt,lt))
				
				setitem(ll_newrow,'pfile',gnv_app.of_getPathDefault() + "images\file\file-jpg.png")
				
			end if
		Next
		
		
		// lister les .png
		ll_nb = gnv_app.inv_filesrv.of_dirList(is_corrpath + is_cie_no + "-" + is_codeverrat + "\*.png", 33, lo_dirList)
		For i = 1 To ll_nb
			if left(lo_dirList[i].is_FileName,1) <> '.' then
				ls_fichier = is_corrpath + is_cie_no + "-" + is_codeverrat + "\" + lo_dirList[i].is_FileName
				
				ll_newrow = insertrow(0)
				setitem(ll_newrow,'corrletter',lo_dirList[i].is_FileName)
				
				gnv_app.inv_filesrv.of_getcreationdatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'created',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastwritedatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'modified',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastaccessdate(ls_fichier,ldt)
				setitem(ll_newrow,'accessed',string(ldt))
				
				setitem(ll_newrow,'nom_fichier',ls_fichier)
				
				setitem(ll_newrow,'datecreation',datetime(ldt,lt))
				
				setitem(ll_newrow,'pfile',gnv_app.of_getPathDefault() + "images\file\file-jpg.png")
				
			end if
		Next
		
		
		
		// lister les .txt
		ll_nb = gnv_app.inv_filesrv.of_dirList(is_corrpath + is_cie_no + "-" + is_codeverrat + "\*.txt", 33, lo_dirList)
		For i = 1 To ll_nb
			if left(lo_dirList[i].is_FileName,1) <> '.' then
				ls_fichier = is_corrpath + is_cie_no + "-" + is_codeverrat + "\" + lo_dirList[i].is_FileName
				
				ll_newrow = insertrow(0)
				setitem(ll_newrow,'corrletter',lo_dirList[i].is_FileName)
				
				gnv_app.inv_filesrv.of_getcreationdatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'created',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastwritedatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'modified',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastaccessdate(ls_fichier,ldt)
				setitem(ll_newrow,'accessed',string(ldt))
				
				setitem(ll_newrow,'nom_fichier',ls_fichier)
				
				setitem(ll_newrow,'datecreation',datetime(ldt,lt))
				
				setitem(ll_newrow,'pfile',gnv_app.of_getPathDefault() + "images\file\file-txt.png")
				
			end if
		Next
		
		// lister les .html
		ll_nb = gnv_app.inv_filesrv.of_dirList(is_corrpath + is_cie_no + "-" + is_codeverrat + "\*.html", 33, lo_dirList)
		For i = 1 To ll_nb
			if left(lo_dirList[i].is_FileName,1) <> '.' then
				ls_fichier = is_corrpath + is_cie_no + "-" + is_codeverrat + "\" + lo_dirList[i].is_FileName
				
				ll_newrow = insertrow(0)
				setitem(ll_newrow,'corrletter',lo_dirList[i].is_FileName)
				
				gnv_app.inv_filesrv.of_getcreationdatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'created',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastwritedatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'modified',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastaccessdate(ls_fichier,ldt)
				setitem(ll_newrow,'accessed',string(ldt))
				
				setitem(ll_newrow,'nom_fichier',ls_fichier)
				
				setitem(ll_newrow,'datecreation',datetime(ldt,lt))
				
				setitem(ll_newrow,'pfile',gnv_app.of_getPathDefault() + "images\file\file-txt.png")
				
			end if
		Next
		
		// lister les .jpg
		ll_nb = gnv_app.inv_filesrv.of_dirList(is_corrpath + is_cie_no + "-" + is_codeverrat + "\*.jpg", 33, lo_dirList)
		For i = 1 To ll_nb
			if left(lo_dirList[i].is_FileName,1) <> '.' then
				ls_fichier = is_corrpath + is_cie_no + "-" + is_codeverrat + "\" + lo_dirList[i].is_FileName
				
				ll_newrow = insertrow(0)
				setitem(ll_newrow,'corrletter',lo_dirList[i].is_FileName)
				
				gnv_app.inv_filesrv.of_getcreationdatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'created',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastwritedatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'modified',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastaccessdate(ls_fichier,ldt)
				setitem(ll_newrow,'accessed',string(ldt))
				
				setitem(ll_newrow,'nom_fichier',ls_fichier)
				
				setitem(ll_newrow,'datecreation',datetime(ldt,lt))
				
				setitem(ll_newrow,'pfile',gnv_app.of_getPathDefault() + "images\file\file-jpg.png")
				
			end if
		Next
		
		// lister les .jpeg
		ll_nb = gnv_app.inv_filesrv.of_dirList(is_corrpath + is_cie_no + "-" + is_codeverrat + "\*.jpeg", 33, lo_dirList)
		For i = 1 To ll_nb
			if left(lo_dirList[i].is_FileName,1) <> '.' then
				ls_fichier = is_corrpath + is_cie_no + "-" + is_codeverrat + "\" + lo_dirList[i].is_FileName
				
				ll_newrow = insertrow(0)
				setitem(ll_newrow,'corrletter',lo_dirList[i].is_FileName)
				
				gnv_app.inv_filesrv.of_getcreationdatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'created',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastwritedatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'modified',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastaccessdate(ls_fichier,ldt)
				setitem(ll_newrow,'accessed',string(ldt))
				
				setitem(ll_newrow,'nom_fichier',ls_fichier)
				
				setitem(ll_newrow,'datecreation',datetime(ldt,lt))
				
			end if
		Next

		// lister les .tif
		ll_nb = gnv_app.inv_filesrv.of_dirList(is_corrpath + is_cie_no + "-" + is_codeverrat + "\scan\*.tif", 33, lo_dirList)
		For i = 1 To ll_nb
			if left(lo_dirList[i].is_FileName,1) <> '.' then
				ls_fichier = is_corrpath + is_cie_no + "-" + is_codeverrat + "\scan\" + lo_dirList[i].is_FileName
				
				ll_newrow = insertrow(0)
				setitem(ll_newrow,'corrletter',lo_dirList[i].is_FileName)
				
				gnv_app.inv_filesrv.of_getcreationdatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'created',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastwritedatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'modified',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastaccessdate(ls_fichier,ldt)
				setitem(ll_newrow,'accessed',string(ldt))
				
				setitem(ll_newrow,'nom_fichier',ls_fichier)
				
				setitem(ll_newrow,'datecreation',datetime(ldt,lt))
				
			end if
		Next
		
		// lister les .tiff
		ll_nb = gnv_app.inv_filesrv.of_dirList(is_corrpath + is_cie_no + "-" + is_codeverrat + "\scan\*.tiff", 33, lo_dirList)
		For i = 1 To ll_nb
			if left(lo_dirList[i].is_FileName,1) <> '.' then
				ls_fichier = is_corrpath + is_cie_no + "-" + is_codeverrat + "\scan\" + lo_dirList[i].is_FileName
				
				ll_newrow = insertrow(0)
				setitem(ll_newrow,'corrletter',lo_dirList[i].is_FileName)
				
				gnv_app.inv_filesrv.of_getcreationdatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'created',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastwritedatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'modified',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastaccessdate(ls_fichier,ldt)
				setitem(ll_newrow,'accessed',string(ldt))
				
				setitem(ll_newrow,'nom_fichier',ls_fichier)
				
				setitem(ll_newrow,'datecreation',datetime(ldt,lt))
				
			end if
		Next
		
		// lister les .tif
		ll_nb = gnv_app.inv_filesrv.of_dirList(is_corrpath + is_cie_no + "-" + is_codeverrat + "\*.tif", 33, lo_dirList)
		For i = 1 To ll_nb
			if left(lo_dirList[i].is_FileName,1) <> '.' then
				ls_fichier = is_corrpath + is_cie_no + "-" + is_codeverrat + "\" + lo_dirList[i].is_FileName
				
				ll_newrow = insertrow(0)
				setitem(ll_newrow,'corrletter',lo_dirList[i].is_FileName)
				
				gnv_app.inv_filesrv.of_getcreationdatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'created',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastwritedatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'modified',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastaccessdate(ls_fichier,ldt)
				setitem(ll_newrow,'accessed',string(ldt))
				
				setitem(ll_newrow,'nom_fichier',ls_fichier)
				
				setitem(ll_newrow,'datecreation',datetime(ldt,lt))
				
			end if
		Next
		
		// lister les .tiff
		ll_nb = gnv_app.inv_filesrv.of_dirList(is_corrpath + is_cie_no + "-" + is_codeverrat + "\*.tiff", 33, lo_dirList)
		For i = 1 To ll_nb
			if left(lo_dirList[i].is_FileName,1) <> '.' then
				ls_fichier = is_corrpath + is_cie_no + "-" + is_codeverrat + "\" + lo_dirList[i].is_FileName
				
				ll_newrow = insertrow(0)
				setitem(ll_newrow,'corrletter',lo_dirList[i].is_FileName)
				
				gnv_app.inv_filesrv.of_getcreationdatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'created',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastwritedatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'modified',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastaccessdate(ls_fichier,ldt)
				setitem(ll_newrow,'accessed',string(ldt))
				
				setitem(ll_newrow,'nom_fichier',ls_fichier)
				
				setitem(ll_newrow,'datecreation',datetime(ldt,lt))
				
			end if
		Next
		
		// Lister les fichiers Excel
		ll_nb = gnv_app.inv_filesrv.of_dirList(is_corrpath + is_cie_no + "-" + is_codeverrat + "\*.xls", 0, lo_dirList)
		For i = 1 To ll_nb
			if left(lo_dirList[i].is_FileName,1) <> '.' then
				ls_fichier = is_corrpath + is_cie_no + "-" + is_codeverrat + "\" + lo_dirList[i].is_FileName
				
				ll_newrow = insertrow(0)
				setitem(ll_newrow,'corrletter',lo_dirList[i].is_FileName)
				
				gnv_app.inv_filesrv.of_getcreationdatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'created',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastwritedatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'modified',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastaccessdate(ls_fichier,ldt)
				setitem(ll_newrow,'accessed',string(ldt))
				
				setitem(ll_newrow,'nom_fichier',ls_fichier)
				
				setitem(ll_newrow,'datecreation',datetime(ldt,lt))
				
				setitem(ll_newrow,'pfile',gnv_app.of_getPathDefault() + "images\file\file-xls.png")
				
			end if
		Next
		
		ll_nb = gnv_app.inv_filesrv.of_dirList(is_corrpath + is_cie_no + "-" + is_codeverrat + "\*.xlsx", 0, lo_dirList)
		For i = 1 To ll_nb
			if left(lo_dirList[i].is_FileName,1) <> '.' then
				ls_fichier = is_corrpath + is_cie_no + "-" + is_codeverrat + "\" + lo_dirList[i].is_FileName
				
				ll_newrow = insertrow(0)
				setitem(ll_newrow,'corrletter',lo_dirList[i].is_FileName)
				
				gnv_app.inv_filesrv.of_getcreationdatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'created',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastwritedatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'modified',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastaccessdate(ls_fichier,ldt)
				setitem(ll_newrow,'accessed',string(ldt))
				
				setitem(ll_newrow,'nom_fichier',ls_fichier)
				
				setitem(ll_newrow,'datecreation',datetime(ldt,lt))
				
				setitem(ll_newrow,'pfile',gnv_app.of_getPathDefault() + "images\file\file-xls.png")
			end if
		Next
		
		
		ll_nb = gnv_app.inv_filesrv.of_dirList(is_corrpath + is_cie_no + "-" + is_codeverrat + "\*.oft", 0, lo_dirList)
		For i = 1 To ll_nb
			if left(lo_dirList[i].is_FileName,1) <> '.' then
				ls_fichier = is_corrpath + is_cie_no + "-" + is_codeverrat + "\" + lo_dirList[i].is_FileName
				
				ll_newrow = insertrow(0)
				setitem(ll_newrow,'corrletter',lo_dirList[i].is_FileName)
				
				gnv_app.inv_filesrv.of_getcreationdatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'created',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastwritedatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'modified',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastaccessdate(ls_fichier,ldt)
				setitem(ll_newrow,'accessed',string(ldt))
				
				setitem(ll_newrow,'nom_fichier',ls_fichier)
				
				setitem(ll_newrow,'datecreation',datetime(ldt,lt))
				
				setitem(ll_newrow,'pfile',gnv_app.of_getPathDefault() + "images\file\file-txt.png")
			end if
		Next
		
	   ll_nb = gnv_app.inv_filesrv.of_dirList(is_corrpath + is_cie_no + "-" + is_codeverrat + "\*.oftx", 0, lo_dirList)
		For i = 1 To ll_nb
			if left(lo_dirList[i].is_FileName,1) <> '.' then
				ls_fichier = is_corrpath + is_cie_no + "-" + is_codeverrat + "\" + lo_dirList[i].is_FileName
				
				ll_newrow = insertrow(0)
				setitem(ll_newrow,'corrletter',lo_dirList[i].is_FileName)
				
				gnv_app.inv_filesrv.of_getcreationdatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'created',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastwritedatetime(ls_fichier,ldt,lt)
				setitem(ll_newrow,'modified',string(ldt) + ls_a + string(lt))
				
				gnv_app.inv_filesrv.of_getlastaccessdate(ls_fichier,ldt)
				setitem(ll_newrow,'accessed',string(ldt))
				
				setitem(ll_newrow,'nom_fichier',ls_fichier)
				
				setitem(ll_newrow,'datecreation',datetime(ldt,lt))
				
				setitem(ll_newrow,'pfile',gnv_app.of_getPathDefault() + "images\file\file-txt.png")
			end if
		Next
		
		
	else
	//
	end if

setSort("datecreation D")
sort()
setRedraw(true)

end event

event doubleclicked;long ll_respid[], ll_phase, ll_patid[], ll_idtrait[], ll_concat, ll_total, ll_barrerword
string ls_nomdoc, ls_typelettre, ls_cheminimg, ls_password, ls_link
boolean lb_2k3
OLEObject lole_word
n_cst_syncproc luo_sync
string ls_corrletter

if row > 0 then
	ls_corrletter = getitemstring(row,'corrletter')
	ls_nomdoc = getitemstring(row,'nom_fichier')
		
	if match(upper(ls_corrletter),'.GIF$') or match(upper(ls_corrletter),'.PNG$') or match(upper(ls_corrletter),'.BMP$') or match(upper(ls_corrletter),'.JPG$') or match(upper(ls_corrletter),'.JPEG$') or match(upper(ls_corrletter),'.TIF$') or match(upper(ls_corrletter),'.TIFF$') then
		luo_sync = CREATE n_cst_syncproc
		
		luo_sync.of_setwindow('normal')
		luo_sync.of_RunAndWait('"' + ls_nomdoc + '"')
		
		IF IsValid(luo_sync) THEN destroy luo_sync
	elseif match(upper(ls_corrletter),'.OFT$') then
		   Run('"'+ rep(is_wordpath,'WINWORD.EXE','OUTLOOK.EXE') + '" "' + ls_nomdoc + '"')
	elseif match(upper(ls_corrletter),'.TXT$') then
			ls_link = "C:\Windows\System32\NOTEPAD.EXE"
		   Run('"' + ls_link + '" "' + ls_nomdoc + '"')
	elseif match(upper(ls_corrletter),'.HTML$') or match(upper(ls_corrletter),'.HTM$') then
		  	ls_link = "C:\Program Files\Internet Explorer\IEXPLORE.EXE"
		   Run('"' + ls_link + '" "' + ls_nomdoc + '"')
	elseif match(upper(ls_corrletter),'.PDF$') or match(upper(ls_corrletter),'.XLS$') or match(upper(ls_corrletter),'.XLSX$') then
			
		luo_sync = CREATE n_cst_syncproc
		
		luo_sync.of_setwindow('normal')
		luo_sync.of_RunAndWait('"' + ls_nomdoc + '"')
		
		IF IsValid(luo_sync) THEN destroy luo_sync	
	elseif match(upper(ls_corrletter),'.DOC$') or match(upper(ls_corrletter),'.DOCX$') then
			Run('"'+is_wordpath + '" "' + ls_nomdoc + '"')
		end if
end if
end event

event clicked;//if row > 0 then
//	selectrow(0,false)
//	selectrow(row,true)
//end if
end event

event constructor;SetRowFocusIndicator(Hand!)
end event

type rr_1 from roundrectangle within w_savefile
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 1073741824
integer x = 37
integer y = 32
integer width = 4649
integer height = 128
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_2 from roundrectangle within w_savefile
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 1073741824
integer x = 37
integer y = 180
integer width = 4649
integer height = 1548
integer cornerheight = 40
integer cornerwidth = 46
end type

