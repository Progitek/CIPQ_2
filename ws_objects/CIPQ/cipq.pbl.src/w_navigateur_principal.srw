$PBExportHeader$w_navigateur_principal.srw
forward
global type w_navigateur_principal from w_sheet
end type
type ole_web from olecustomcontrol within w_navigateur_principal
end type
type st_1 from statictext within w_navigateur_principal
end type
type st_2 from statictext within w_navigateur_principal
end type
type st_3 from statictext within w_navigateur_principal
end type
type st_4 from statictext within w_navigateur_principal
end type
end forward

global type w_navigateur_principal from w_sheet
integer width = 3625
integer height = 2268
string title = "Navigateur de gestion"
string menuname = "m_navigateur_principal"
windowstate windowstate = maximized!
long backcolor = 16777215
boolean ib_isupdateable = false
ole_web ole_web
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
end type
global w_navigateur_principal w_navigateur_principal

on w_navigateur_principal.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_navigateur_principal" then this.MenuID = create m_navigateur_principal
this.ole_web=create ole_web
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_web
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_4
end on

on w_navigateur_principal.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ole_web)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
end on

event pfc_postopen;call super::pfc_postopen;string ls_nomfichier, ls_fichiertemp

ole_web.resize(this.width,this.height)
ls_nomfichier = string(gnv_app.inv_entrepotglobal.of_retournedonnee("path", FALSE)) + "Navigation.htm"
ls_fichiertemp = LEFT(ls_nomfichier, LEN(ls_nomfichier) - 4) + "_temp.htm"

IF FileExists(ls_fichiertemp) THEN
	ole_web.object.navigate(ls_fichiertemp)
END IF


//Si l'utilisateur est ts ou transfert, ouvrir le menu automatiquement
n_cst_menu	lnv_menu
menu			lm_item, lm_menu

lm_menu = gnv_app.of_getframe().MenuID

IF gnv_app.of_getuserid( ) = "ts" THEN
	IF lnv_menu.of_GetMenuReference (lm_menu,"m_transfertserveur", lm_item) > 0 THEN
		lm_item.event clicked()
	END IF
END IF

IF gnv_app.of_getuserid( ) = "transfert" THEN
	IF lnv_menu.of_GetMenuReference (lm_menu,"m_transfert", lm_item) > 0 THEN
		lm_item.event clicked()
	END IF
END IF
end event

event open;call super::open;//Override
end event

type ole_web from olecustomcontrol within w_navigateur_principal
event statustextchange ( string text )
event progresschange ( long progress,  long progressmax )
event commandstatechange ( long command,  boolean enable )
event downloadbegin ( )
event downloadcomplete ( )
event titlechange ( string text )
event propertychange ( string szproperty )
event beforenavigate2 ( oleobject pdisp,  any url,  any flags,  any targetframename,  any postdata,  any headers,  ref boolean cancel )
event newwindow2 ( ref oleobject ppdisp,  ref boolean cancel )
event navigatecomplete2 ( oleobject pdisp,  any url )
event documentcomplete ( oleobject pdisp,  any url )
event onquit ( )
event onvisible ( boolean ocx_visible )
event ontoolbar ( boolean toolbar )
event onmenubar ( boolean menubar )
event onstatusbar ( boolean statusbar )
event onfullscreen ( boolean fullscreen )
event ontheatermode ( boolean theatermode )
event windowsetresizable ( boolean resizable )
event windowsetleft ( long left )
event windowsettop ( long top )
event windowsetwidth ( long ocx_width )
event windowsetheight ( long ocx_height )
event windowclosing ( boolean ischildwindow,  ref boolean cancel )
event clienttohostwindow ( ref long cx,  ref long cy )
event setsecurelockicon ( long securelockicon )
event filedownload ( ref boolean cancel )
event navigateerror ( oleobject pdisp,  any url,  any frame,  any statuscode,  ref boolean cancel )
event printtemplateinstantiation ( oleobject pdisp )
event printtemplateteardown ( oleobject pdisp )
event updatepagestatus ( oleobject pdisp,  any npage,  any fdone )
event privacyimpactedstatechange ( boolean bimpacted )
string tag = "resize=n"
integer width = 3634
integer height = 2136
integer taborder = 10
boolean border = false
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
string binarykey = "w_navigateur_principal.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

event beforenavigate2(oleobject pdisp, any url, any flags, any targetframename, any postdata, any headers, ref boolean cancel);string ls_url , ls_startup_url
string ls_array[]
string ls_commande
string ls_menuitem
string ls_path

n_cst_menu lnv_menu
menu	lm_item, lm_menu

ls_url = string(url)
ls_path = string(gnv_app.inv_entrepotglobal.of_retournedonnee("path", FALSE))
ls_startup_url = ls_path  + "Navigation_temp.htm"

IF FileExists(ls_startup_url) THEN
	IF trim(lower(ls_url)) <> trim(lower(ls_startup_url)) THEN 
		// selon le URL Tappé on isole la commande
		gnv_app.inv_string.of_parsetoarray(ls_url,"\",ls_array)
		ls_commande = ls_array[upperbound(ls_array)] 
		
		ls_menuitem = ls_commande
		IF ls_menuitem <> "" AND LEFT(ls_menuitem, 2) = "m_" THEN
			//lm_menu = gnv_app.of_getframe().MenuID
			lm_menu = parent.MenuID
			IF lm_menu.visible = TRUE AND lm_menu.enabled = TRUE THEN
				IF lnv_menu.of_GetMenuReference (lm_menu,ls_menuitem, lm_item) > 0 THEN
					IF lm_item.visible = TRUE AND lm_item.enabled = TRUE  THEN
						lm_item.event clicked()
					END IF 
				END IF
			END IF
		END IF 
		
		// Si on est sur la page web de navigation on ne fait pas le cancel
		Cancel = TRUE
	END IF
END IF
end event

type st_1 from statictext within w_navigateur_principal
string tag = "resize=n"
integer width = 4663
integer height = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
long bordercolor = 16777215
boolean focusrectangle = false
end type

type st_2 from statictext within w_navigateur_principal
string tag = "resize=n"
integer width = 41
integer height = 3364
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
long bordercolor = 16777215
boolean focusrectangle = false
end type

type st_3 from statictext within w_navigateur_principal
string tag = "resize=n"
integer y = 2016
integer width = 4663
integer height = 412
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
long bordercolor = 16777215
boolean focusrectangle = false
end type

type st_4 from statictext within w_navigateur_principal
string tag = "resize=n"
integer x = 3525
integer width = 201
integer height = 3368
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
long bordercolor = 16777215
boolean focusrectangle = false
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
04w_navigateur_principal.bin 
2200000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000870e89a001d6c2be00000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f00000000870e89a001d6c2be870e89a001d6c2be000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c0000522a000037310000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c0000522a000037310000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
14w_navigateur_principal.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
