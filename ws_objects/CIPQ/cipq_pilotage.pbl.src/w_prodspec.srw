$PBExportHeader$w_prodspec.srw
forward
global type w_prodspec from w_sheet_frame
end type
type st_5 from statictext within w_prodspec
end type
type st_4 from statictext within w_prodspec
end type
type st_3 from statictext within w_prodspec
end type
type st_2 from statictext within w_prodspec
end type
type st_1 from statictext within w_prodspec
end type
type uo_toolbar from u_cst_toolbarstrip within w_prodspec
end type
type dw_prodspec from datawindow within w_prodspec
end type
type rr_1 from roundrectangle within w_prodspec
end type
type rr_2 from roundrectangle within w_prodspec
end type
type rr_3 from roundrectangle within w_prodspec
end type
end forward

global type w_prodspec from w_sheet_frame
integer x = 214
integer y = 221
integer width = 4357
integer height = 2460
windowtype windowtype = child!
windowstate windowstate = maximized!
string icon = "AppIcon!"
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
uo_toolbar uo_toolbar
dw_prodspec dw_prodspec
rr_1 rr_1
rr_2 rr_2
rr_3 rr_3
end type
global w_prodspec w_prodspec

forward prototypes
public subroutine of_update ()
end prototypes

public subroutine of_update ();integer i,j
string ls_classe[], ls_codehebergeur,ls_sql, ls_noclasse, ls_nosch, ls_eco, ls_codeverrat
long ll_economie
dec{2} ld_prix

For i = 1 To dw_prodspec.rowcount( )
	
	If dw_prodspec.getitemnumber( i, 'utiliser') = 1 Then
		
		ls_codehebergeur = dw_prodspec.getitemstring( i, 'codehebergeur')
		ls_codeverrat = dw_prodspec.getitemstring( i, 'codeverrat')
		ld_prix = dw_prodspec.getitemdecimal( i, 'prix')
		ll_economie = dw_prodspec.getitemnumber( i, 'economie')
		ls_nosch = dw_prodspec.getitemstring( i, 'souscodehebergeur')
		ls_classe = split(dw_prodspec.getitemstring( i, 'noclasse'),';')

		// CLASSE
		If Not isnull(ls_classe[1]) THEN
			
			For j = 1 To Upperbound(ls_classe)
	
				Choose Case Mid(ls_classe[j],1,1)
					Case '='
						ls_noclasse = ls_noclasse + " t_verrat.classe = '" + Mid(ls_classe[j],2,Len(ls_classe[j])) + "' AND "
					Case '<'
						ls_noclasse = ls_noclasse + " t_verrat.classe <> '" + Mid(ls_classe[j],3,Len(ls_classe[j])) + "' AND "
				End Choose
				
			Next
			
			ls_noclasse = left(ls_noclasse,Len(ls_noclasse)-4)
			If isnull(ls_noclasse) Or ls_noclasse = '' THEN
				ls_noclasse = ''
			Else
				ls_noclasse = " AND " + ls_noclasse 
			End If
		End If

		// ECONOMIE
		IF isnull(ll_economie) THEN 
			ls_eco = ", noeconomievolume = null"
		ELSE
			ls_eco = ", noeconomievolume = '" + string(ll_economie) + "'"
		END IF
		
		//CODEVERRAT
		If isnull(ls_codeverrat) Or ls_codeverrat = '' Then
			ls_codeverrat = ''
		Else
			Choose Case Mid(ls_codeverrat,1,1)
				Case '.'
					ls_codeverrat = " AND SUBSTR(t_verrat.codeverrat,2,1)  = " + Mid(ls_codeverrat,2,1)
				Case '!'
					ls_codeverrat = " AND SUBSTR(t_verrat.codeverrat,2,1)  <> " + Mid(ls_codeverrat,2,1) 
			End Choose
		End If
		
		ls_sql = "UPDATE t_produit " + &
					"INNER JOIN t_verrat ON t_produit.noproduit = 'HEB-' + t_verrat.codeverrat " + &
					"SET prixunitaire = " + string(ld_prix) + ", prixunitairesp = " + string(ld_prix) + ls_eco +", no_sch = '" + string(ls_nosch) +"' " + &
					"WHERE t_produit.codehebergeur = '" + ls_codehebergeur + "' " + ls_noclasse + ls_codeverrat

		Execute Immediate :ls_sql USING SQLCA;
		
		If SQLCA.sqlcode = 0 then
			COMMIT USING SQLCA;
		Else
			ROLLBACK USING SQLCA;
		End if
	
	End If
	
Next


messagebox("CIPQ","Mise à jour effectuer !")




end subroutine

on w_prodspec.create
int iCurrent
call super::create
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.uo_toolbar=create uo_toolbar
this.dw_prodspec=create dw_prodspec
this.rr_1=create rr_1
this.rr_2=create rr_2
this.rr_3=create rr_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_5
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.uo_toolbar
this.Control[iCurrent+7]=this.dw_prodspec
this.Control[iCurrent+8]=this.rr_1
this.Control[iCurrent+9]=this.rr_2
this.Control[iCurrent+10]=this.rr_3
end on

on w_prodspec.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.uo_toolbar)
destroy(this.dw_prodspec)
destroy(this.rr_1)
destroy(this.rr_2)
destroy(this.rr_3)
end on

event open;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Ajouter", "C:\ii4net\CIPQ\images\ajouter.ico")
uo_toolbar.of_AddItem("Supprimer", "C:\ii4net\CIPQ\images\supprimer.ico")
uo_toolbar.of_AddItem("Enregistrer", "Save!")
uo_toolbar.of_AddItem("Mettre à jour", "Update!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

dw_prodspec.setTransObject( SQLCA )
dw_prodspec.retrieve()
end event

type st_title from w_sheet_frame`st_title within w_prodspec
end type

type p_8 from w_sheet_frame`p_8 within w_prodspec
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_prodspec
end type

type st_5 from statictext within w_prodspec
string tag = "resize=frbsr"
integer x = 2414
integer y = 2012
integer width = 974
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "~' <> ~' est différent( classe du verrat)"
boolean focusrectangle = false
end type

type st_4 from statictext within w_prodspec
string tag = "resize=frbsr"
integer x = 1458
integer y = 2012
integer width = 873
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "~' = ~' est égale ( classe du verrat)"
boolean focusrectangle = false
end type

type st_3 from statictext within w_prodspec
string tag = "resize=frbsr"
integer x = 526
integer y = 2012
integer width = 864
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "~' . ~' commence par (codeverrat) "
boolean focusrectangle = false
end type

type st_2 from statictext within w_prodspec
string tag = "resize=frbsr"
integer x = 114
integer y = 2004
integer width = 517
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "Légende :"
boolean focusrectangle = false
end type

type st_1 from statictext within w_prodspec
string tag = "resize=frbsr"
integer x = 178
integer y = 48
integer width = 1275
integer height = 88
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "Liste de prix d~'hébergement"
boolean focusrectangle = false
end type

type uo_toolbar from u_cst_toolbarstrip within w_prodspec
event destroy ( )
string tag = "resize=mbar"
integer x = 37
integer y = 2152
integer width = 4274
integer taborder = 20
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	CASE "Add","Ajouter"
		dw_prodspec.insertrow(0)
	CASE "Save","Enregistrer"
		dw_prodspec.update( )
	CASE "Delete","Supprimer"
		dw_prodspec.deleterow( dw_prodspec.getrow( ) )
	CASE "Mettre à jour"
		of_update()
	CASE "Close","Fermer"
		Close(parent)
END CHOOSE

end event

type dw_prodspec from datawindow within w_prodspec
integer x = 64
integer y = 188
integer width = 4233
integer height = 1780
integer taborder = 10
string title = "none"
string dataobject = "d_prodspec"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;SetRowFocusindicator(Hand!)
end event

type rr_1 from roundrectangle within w_prodspec
string tag = "resize=frbsr"
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 1073741824
integer x = 37
integer y = 28
integer width = 4270
integer height = 120
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_2 from roundrectangle within w_prodspec
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 37
integer y = 168
integer width = 4279
integer height = 1956
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_3 from roundrectangle within w_prodspec
string tag = "resize=frbsr"
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 69
integer y = 1984
integer width = 4206
integer height = 116
integer cornerheight = 40
integer cornerwidth = 46
end type

