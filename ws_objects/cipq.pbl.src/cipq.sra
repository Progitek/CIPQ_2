$PBExportHeader$cipq.sra
$PBExportComments$Generated Application Object
forward
global type cipq from application
end type
global n_tr sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global n_msg message
end forward

global variables
/*  Application Manager  */
n_cst_cipq_appmanager gnv_app 

string gs_appdata

end variables
global type cipq from application
string appname = "cipq"
string displayname = "CIPQ"
string themepath = "C:\Program Files (x86)\Appeon\PowerBuilder 19.0\IDE\theme"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 2
long richtexteditx64type = 3
long richtexteditversion = 1
string richtexteditkey = ""
string appicon = "C:\ii4net\CIPQ\images\cochon.ico"
string appruntimeversion = "19.2.0.2797"
end type
global cipq cipq

on cipq.create
appname="cipq"
message=create n_msg
sqlca=create n_tr
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on cipq.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;gnv_app = create n_cst_cipq_appmanager

gnv_app.TriggerEvent ( "pfc_open" )

string ls_reg,ls_pathword,ls_produit = "CIPQ"
ulong ll_valeur

select wordpath into :ls_pathword from t_parametre;

RegistryGet("HKEY_CURRENT_USER\Software\Progitek", "Produit", RegString!, ls_reg)
if ls_reg = '' then
	RegistryGet("HKEY_LOCAL_MACHINE\Software\Progitek", "Produit", RegString!, ls_reg)
	if ls_reg = '' then
		RegistrySet("HKEY_LOCAL_MACHINE\Software\Progitek", "Produit", RegString!, ls_produit)
	else
		ls_produit = ls_reg
	end if
else
	ls_produit = ls_reg
end if

RegistryGet("HKEY_CURRENT_USER\Software\Progitek\" + ls_produit + "\corr", "cheminTPL", RegString!, ls_reg)
if ls_reg = '' then
	RegistryGet("HKEY_LOCAL_MACHINE\Software\Progitek\" + ls_produit + "\corr", "cheminTPL", RegString!, ls_reg)
	if ls_reg = '' then
		RegistrySet("HKEY_LOCAL_MACHINE\Software\Progitek\" + ls_produit + "\corr", "cheminWord", RegString!, ls_pathword )
	end if
end if

//gnv_app.of_setUserKey("HKEY_CURRENT_USER\Software\Progitek\" + ls_produit )

if RegistryGet("HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Word\Options","SQLSecurityCheck",ReguLong!,ll_valeur) = -1 then
	RegistrySet("HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Word\Options","SQLSecurityCheck",ReguLong!,0)
end if

if RegistryGet("HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Word\Options","SQLSecurityCheck",ReguLong!,ll_valeur) = -1 then
	RegistrySet("HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Word\Options","SQLSecurityCheck",ReguLong!,0)
end if

if RegistryGet("HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Word\Options","SQLSecurityCheck",ReguLong!,ll_valeur) = -1 then
	RegistrySet("HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Word\Options","SQLSecurityCheck",ReguLong!,0)
end if

if RegistryGet("HKEY_CURRENT_USER\Software\Microsoft\Office\13.0\Word\Options","SQLSecurityCheck",ReguLong!,ll_valeur) = -1 then
	RegistrySet("HKEY_CURRENT_USER\Software\Microsoft\Office\13.0\Word\Options","SQLSecurityCheck",ReguLong!,0)
end if

if RegistryGet("HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word\Options","SQLSecurityCheck",ReguLong!,ll_valeur) = -1 then
	RegistrySet("HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word\Options","SQLSecurityCheck",ReguLong!,0)
end if

if RegistryGet("HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Word\Options","SQLSecurityCheck",ReguLong!,ll_valeur) = -1 then
	RegistrySet("HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Word\Options","SQLSecurityCheck",ReguLong!,0)
end if

if RegistryGet("HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Word\Security","Level",ReguLong!,ll_valeur) = -1 then
	RegistrySet("HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Word\Security","Level",ReguLong!,1)
end if

if RegistryGet("HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Word\Security","Level",ReguLong!,ll_valeur) = -1 then
	RegistrySet("HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Word\Security","Level",ReguLong!,1)
end if

if RegistryGet("HKEY_CURRENT_USER\Software\Microsoft\Office\13.0\Word\Security","Level",ReguLong!,ll_valeur) = -1 then
	RegistrySet("HKEY_CURRENT_USER\Software\Microsoft\Office\13.0\Word\Security","Level",ReguLong!,1)
end if

if RegistryGet("HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word\Security","Level",ReguLong!,ll_valeur) = -1 then
	RegistrySet("HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word\Security","Level",ReguLong!,1)
end if

if RegistryGet("HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Word\Security","Level",ReguLong!,ll_valeur) = -1 then
	RegistrySet("HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Word\Security","Level",ReguLong!,1)
end if

gs_appdata = GetCurrentDirectory( )
If Right(gs_appdata,1) <> "\" Then gs_appdata += "\"

end event

event close;
gnv_app.TriggerEvent ( "pfc_close" )

If IsValid ( gnv_app ) Then Destroy gnv_app

end event

event systemerror;gnv_app.Event pfc_systemerror ( )
end event

event connectionbegin;Return gnv_app.Event pfc_connectionbegin ( userid, password, connectstring )
end event

event connectionend;
gnv_app.Event pfc_connectionend (  )
end event

event idle;gnv_app.Event pfc_idle (  )
end event

