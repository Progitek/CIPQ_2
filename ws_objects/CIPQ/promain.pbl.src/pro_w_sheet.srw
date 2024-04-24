$PBExportHeader$pro_w_sheet.srw
$PBExportComments$(PRO) Extension Sheet Window class
forward
global type pro_w_sheet from pfc_w_sheet
end type
end forward

global type pro_w_sheet from pfc_w_sheet
integer height = 1560
string menuname = "m_mdi"
long backcolor = 12639424
end type
global pro_w_sheet pro_w_sheet

on pro_w_sheet.create
call super::create
if this.MenuName = "m_mdi" then this.MenuID = create m_mdi
end on

on pro_w_sheet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_controlgotfocus;//////////////////////////////////////////////////////////////////////////////
//
//	Événement:  	pfc_controlgotfocus
//
//	Argument:		adrg_control  - Control which just got focus
//
//	Description:	Display the microhelp stored in the tag value of the current 
//						control
//
//						Note:  The format is MICROHELP=<microhelp to be displayed>
//////////////////////////////////////////////////////////////////////////////

string			ls_columntag, ls_microhelp, ls_colname
datawindow		ldw_control
tab				ltab_control
u_tabpg			ltabpg_control, ltabpg_Courant
n_cst_string 	lnv_string 
boolean			lb_ModeTab

// Request microhelp
if gnv_app.of_GetMicrohelp() then
	// If control with focus is a datawindow, use current column's microhelp
	if adrg_control.TypeOf() = DataWindow! then

		//	Keeps track of last active DataWindow
		If adrg_control.TriggerEvent ("pfc_descendant") = 1 Then
			idw_active = adrg_control
		End If
			
		ldw_control = adrg_control
		ls_colname = ldw_control.GetColumnName()
		if Len (ls_colname) > 0 then
			// Check the column tag for any microhelp information.
			ls_columntag = ldw_control.Describe (ls_colname + ".tag")
			if ls_columntag <> '?' then
				ls_microhelp = ls_columntag
			else
				ls_microhelp = ''
			end if	
		end if
		
	elseif adrg_control.TypeOf() = Tab! then
		
		ltab_control = adrg_control
		ltabpg_control = ltab_control.Control[ltab_control.SelectedTab]		
		
		ls_microhelp = ltabpg_control.tag
		
		if ls_microhelp = '' then
			ls_microhelp = ltab_control.tag
		end if	
		
	else
		// Check the control tag for any microhelp information.
		ls_microhelp = adrg_control.tag
	end if

	// If the microhelp variable is empty make sure it displays "Ready".
	if lnv_string.of_IsEmpty (ls_microhelp) then
		ls_microhelp = ''	
	end If

	// display microhelp
	this.event pfc_microHelp (ls_microhelp)
end if

lb_ModeTab = THIS.of_GetTabPg(ltabpg_Courant) = 1
end event

