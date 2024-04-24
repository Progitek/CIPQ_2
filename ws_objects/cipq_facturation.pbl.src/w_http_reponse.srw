$PBExportHeader$w_http_reponse.srw
forward
global type w_http_reponse from w_response
end type
type st_2 from statictext within w_http_reponse
end type
type uo_toolbar from u_cst_toolbarstrip within w_http_reponse
end type
type uo_fermer from u_cst_toolbarstrip within w_http_reponse
end type
type st_1 from statictext within w_http_reponse
end type
type hpb_1 from hprogressbar within w_http_reponse
end type
type dw_detail from u_dw within w_http_reponse
end type
type st_3 from statictext within w_http_reponse
end type
type rr_1 from roundrectangle within w_http_reponse
end type
type dw_list from u_dw within w_http_reponse
end type
end forward

global type w_http_reponse from w_response
string tag = "exclure_securite"
integer width = 5550
integer height = 1680
string title = "Envoyer Factures"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
long backcolor = 12639424
boolean center = false
st_2 st_2
uo_toolbar uo_toolbar
uo_fermer uo_fermer
st_1 st_1
hpb_1 hpb_1
dw_detail dw_detail
st_3 st_3
rr_1 rr_1
dw_list dw_list
end type
global w_http_reponse w_http_reponse

type variables
string is_xml_facture[]
datastore ids_fact_print
string is_qr_chemin[]
end variables

forward prototypes
public subroutine of_log (string as_log)
public subroutine uf_traduction ()
public function long of_xml_explication (string as_xml)
public subroutine of_http_post (string as_xml, ref string as_code_qr)
public subroutine of_send ()
public subroutine of_print ()
public subroutine of_print_pdf ()
end prototypes

public subroutine of_log (string as_log);//
string ls_corrpath
long ll_file
string ls_cie_compagnie
ls_corrpath='C:\Progra~~2\ii4net\'

ls_cie_compagnie = gnv_app.of_getcompagniedefaut( )
				
select 
	isnull(chemin_img,'N/A')//,isnull(chemin_img,'N/A') 
	into :ls_corrpath//,:ls_chemin_img 
from t_centrecipq 
where cie = :ls_cie_compagnie;

if ls_corrpath = 'N/A' then ls_corrpath = GetCurrentDirectory ( ) + "\codeqr\"

				
/*if ls_corrpath = 'N/A' then
	ls_corrpath = "C:\Progra~~2\ii4net\"
end if
if right(ls_corrpath,1)<>'\' then
	ls_corrpath +='\'
end if

if not directoryexists(ls_corrpath) then
	createdirectory(ls_corrpath)
end if

if not directoryexists(ls_corrpath) then
	messagebox("Avertissement!", "Le dossier de correspondance n'existe pas")
end if	
*/

	
ls_corrpath+='log\'
if not directoryexists(ls_corrpath) then
	createdirectory(ls_corrpath)
end  if
if not directoryexists(ls_corrpath) then
	messagebox("Avertissement!", "Le dossier de logs n'existe pas")
end if

ls_corrpath +=string(today(),'yyyymmdd')+'\'
if not directoryexists(ls_corrpath) then
	createdirectory(ls_corrpath)
end if
if not directoryexists(ls_corrpath) then
	messagebox("Avertissement!", "Creation de la date du jour")
end if

ls_corrpath +=string(today(),'yyyy-mm-dd')+".txt" 

ll_file = fileopen(ls_corrpath,TextMode!, Write!, LockReadWrite!, Append!)
filewriteex(ll_file,as_log)
fileclose(ll_file)

end subroutine

public subroutine uf_traduction ();uo_toolbar.of_settheme("classics")
uo_toolbar.of_displayborder(true)
uo_fermer.of_settheme("classics")
uo_fermer.of_displayborder(true)

uo_fermer.of_addItem("Fermer","Exit!")
uo_toolbar.of_addItem("Envoyer","Continue!")
uo_toolbar.of_addItem("Imprimer","print!")
uo_toolbar.of_addItem('Imprimer PDF',"print!")

uo_fermer.of_displaytext(true)
uo_toolbar.of_displaytext(true)


end subroutine

public function long of_xml_explication (string as_xml);/*
//wei create 2022-05-26
long ll_row
string ls_explication 
pbdom_builder builder
pbdom_document doc
pbdom_object data[]
pbdom_object bibliotheque[]
pbdom_object response[]
long i,j,k,m,n
string ls_array_extdata[]
string ls_extdata
string ls_array_transdata[]
string ls_transdata
n_cst_string lnv_string
string ls_temp
ll_row = dw_1.insertrow(0)
ls_explication = "";
TRY
	builder = create pbdom_builder
	doc = builder.buildfromstring(trim(as_xml))
	if isvalid(doc) then
		if doc.getcontent(data) then
			for i = 1 to upperbound(data)
					
				if data[i].getname( ) = "bibliotheque" then
					if data[i].getcontent(bibliotheque) then
						for j = 1 to upperbound(bibliotheque)
							if bibliotheque[j].getname()="cie_no" then
								bibliotheque[j].
								
								
								
								
								if xmp[j].getcontent( response) then
									if as_langue = 'A' then
										ls_explication = "Date of payment : " + String(now(),"dd/MM/yyyy HH：mm") + '~r~n'
									else
										ls_explication = "Date de paiement : " + String(now(),"dd/MM/yyyy HH：mm") + '~r~n'
									end if
									for k = 1 to upperbound(response)
										if response[k].getname() = "Message" then
											if as_langue = 'A' then
												ls_explication += "Payment result : " + response[k].gettext() + '~r~n'
											else
												ls_explication += "Résultat de paiement : " + response[k].gettext() + '~r~n'
											end if
										end if
										if response[k].getname() = "RespMSG" then
											ls_explication += "Transaction detail : " + response[k].gettext() + '~r~n'
										end if
										
										if response[k].getname() = "TID" then
											ls_explication += "TID : " + response[k].gettext() + '~r~n'
										end if
										if response[k].getname() = "MID" then
											ls_explication += "MID : " + response[k].gettext() + '~r~n'
										end if
										if response[k].getname() = "SN" then
											ls_explication += "SN : " + response[k].gettext() + '~r~n'
										end if
										
										if response[k].getname() = "ExtData" then
											ls_extdata = response[k].gettext()
											lnv_string.of_parsetoarray( ls_extdata,',',ls_array_extdata)
											if upperbound(ls_array_extdata)>0 then
												for m = 1 to upperbound(ls_array_extdata)
													if pos(ls_array_extdata[m],'Amount=')>0 then
														if as_langue = 'A' then
															if pos(ls_explication,'Amount : ') = 0 then
																ls_explication +="Amount : $" + mid(ls_array_extdata[m],8) + '~r~n'
															end if
														else
															if pos(ls_explication,'Montant : ') = 0 then
																ls_explication +="Montant : $" + + mid(ls_array_extdata[m],8) + '~r~n'		
															end if
														end if
													end if
													if pos(ls_array_extdata[m],'CardType=')>0 then
														ls_temp = mid(ls_array_extdata[m],10)
														if as_langue = 'A' then
															ls_explication +="Card name : " + ls_temp + '~r~n'
														else
															ls_explication +="Nom de carte : " + ls_temp + '~r~n'		
														end if
														if ls_temp = "AMEX" then
															is_card = "AMERICAN EXPRESS"
														else
															is_card = ls_temp
														end if
													end if
													if pos(ls_array_extdata[m],'BatchNum=')>0 then
														ls_temp = mid(ls_array_extdata[m],10)
														if as_langue = 'A' then
															ls_explication +="Batch number : " + ls_temp + '~r~n'
														else
															ls_explication +="Numéro de lot : " + ls_temp + '~r~n'		
														end if
													end if
													if pos(ls_array_extdata[m],'AcntLast4=')>0 then
														ls_temp = mid(ls_array_extdata[m],11)
														if as_langue = 'A' then
															ls_explication +="Card number : ************" + ls_temp + '~r~n'
														else
															ls_explication +="Numéro de carte : ************" + ls_temp + '~r~n'		
														end if
													end if
													if pos(ls_array_extdata[m],'BIN=')>0 then
														ls_temp = mid(ls_array_extdata[m],5)
														if pos(ls_explication, 'BIN : ') = 0 then
															ls_explication +="BIN : " + ls_temp + '~r~n'		
														end if
													end if													
												next
											end if
										end if										
									next	
								end if
								exit
							end if
						next
					end if
					exit
				end if
			next
		else
			ls_explication = "Panda explication failed, Xml is not valid"
		end if
	else
		ls_explication = "Panda explication failed, Xml is not valid"
	end if
	return ls_explication
catch ( PBDOM_Exception pbde )
    //MessageBox( "PBDOM Exception", pbde.getMessage() )
	ls_explication = "Panda explicatioin failed " + pbde.getMessage()
	return ls_explication
catch ( PBXRuntimeError re )
   //MessageBox( "PBNI Exception", re.getMessage() )
	ls_explication = "Panda explicatioin failed " + re.getMessage()
	return ls_explication
end try
*/
return 1


end function

public subroutine of_http_post (string as_xml, ref string as_code_qr);
//wei create 2022-05-19
httpclient lnv_client
string ls_url
integer li_rc
string ls_api_token
string ls_reponse
string ls_log
string ls_cie_compagnie
ls_log = '*****************************************************************************************~r~n'
ls_log+="CIPQ operation " + string(now(),"yyyy-mm-dd hh:mm:ss") + '~r~n'
ls_log +='Request xml~r~n' + as_xml + '~r~n'

//ls_url = 'https://test7.cybercat.ca/cipq/livraison/bons/envoyer?token=794yPT7RPTc7K4k5Rv7x6BBVjpmdsSTT'
//ls_url = 'https://cipq-api.dev.cybercat.ca/cipq/api/laboratoire/nouvellelivraison'
//Authorization: Basic Y2lwcS1saXZyYWlzb246NmIzcjQ=

ls_cie_compagnie = gnv_app.of_getcompagniedefaut( )
			
select isnull(api_token,'N/A'),isnull(url_http,'N/A') into :ls_api_token,:ls_url 
from t_centrecipq 
where cie = :ls_cie_compagnie

;
if ls_api_token = 'N/A' or ls_url = 'N/A' then
	messagebox('Avertissement','Il manque la valeur de api_token or url')
	return
end if


lnv_client = create httpclient
try
	ls_api_token= "Basic "+ls_api_token
	
	lnv_client.SetRequestHeader("Authorization",ls_api_token)
	
//	messagebox('autho',lnv_client.getrequestheader("Authorization"))
//	messagebox('url',ls_url)
	lnv_client.SetRequestHeader("Content-Type", "application/xml")
	li_rc = lnv_client.SendRequest("POST",ls_url,as_xml)
	lnv_client.GetResponseBody(ls_reponse)
	if isnull(ls_reponse) then ls_reponse = ""
	as_code_qr = ls_reponse
	if ls_reponse = "" then
		ls_reponse = "On ne reçoit aucune donnée de L'API"
	end if
	
	ls_log +='Reponse ~r~n' + ls_reponse + '~r~n'
	
//	messagebox('',lnv_client.getresponsestatuscode( ))
	of_log(ls_log)
	as_code_qr = ls_reponse
	destroy lnv_client
catch(runtimeerror er)
    destroy lnv_client
	ls_log +='Error ~r~n' + er.getmessage() +'~r~n'
	of_log(ls_log)
end try	
end subroutine

public subroutine of_send ();long ll_is_mod
long i
long ll_step
string ls_code
string ls_chemin
long ll_rc
blob lblob_qr
string ls_liv_no
string ls_cie_no
int li_return
long ll_flag
long ll_is_qr
long ll_count
n_runandwait luo_run
integer li_filenum
long ll_bytes
string ls_chemin_exe
string ls_cie_compagnie
string ls_chemin_img
long ll_is_strikeout
string ls_imagefile
ls_code = ''

for i = 1 to dw_list.rowcount()
	ll_flag = dw_list.getitemnumber(i,'flag')
	/*
	ll_is_qr = dw_list.getitemnumber(i,'is_qr')
	//cocher et pas de image qr.
	if ll_flag = 1 and ll_is_qr = 0 then
		ll_count+=1
	end if	
	*/
	//la ligne cocher.
	if ll_flag = 1 then
		ll_count+=1
	end if
next
if ll_count>0 then
//	st_2.text = 'Total envoyé : ' + string(ll_count)
//	ll_step = long(100/dw_list.rowcount())
	for i = 1 to dw_list.rowcount()
		hpb_1.position = 0
		ll_flag = dw_list.getitemnumber(i,'flag')
		//ll_is_qr = dw_list.getitemnumber(i,'is_qr')
		//if ll_flag = 1 and ll_is_qr = 0 then
		if ll_flag = 1 then
			hpb_1.position = 10
			dw_detail.scrolltorow(i)
			dw_detail.setfocus()
			dw_list.scrolltorow(i)
			dw_list.setfocus()
			dw_list.setrowfocusindicator(hand!)
			ls_liv_no = dw_list.getitemstring(i,'liv_no')
			
			if pos(ls_liv_no,'(M)')>0 then
				ls_liv_no = mid(ls_liv_no,1,len(ls_liv_no) - 3)
			end if
			
			ls_cie_no = dw_list.getitemstring(i,'cie_no')
			ll_is_qr = dw_list.getitemnumber(i,'is_qr')
			ll_is_mod = dw_list.getitemnumber(i,'is_mod')
			ll_is_strikeout = dw_list.getitemnumber(i,'is_strikeout')
			ls_imagefile = dw_detail.getitemstring(i,'imagefile')
			
			if ll_is_strikeout = 1 and (isnull(ls_imagefile) or ls_imagefile = '') then
				messagebox('Avertissement','On ne peut pas envoyer cette ligne, il manque les détails.')
			else
				st_2.text = 'En train d"envoyer pour ' + ls_liv_no + '# et ' + ls_cie_no+'#'
				hpb_1.position = 20
				of_http_post(is_xml_facture[i],ls_code)
				hpb_1.position = 50
				//ls_chemin = 'c:\ii4net\cipq\'+ls_liv_no+'_'+ls_cie_no+'_'+string(today(),'yyyy-mm-dd-hh-mm-ss')+'.png'
				//ls_chemin = "C:\Progra~~2\ii4net\"+ls_liv_no+"_"+ls_cie_no+"_"+string(today(),"yyyy-mm-dd-hh-mm-ss")+".png"
				//ll_rc = luo_run.of_run( 'C:\ii4net\cipq\CIPQCodeQR.exe '+ls_code + ' ' + ls_chemin, Hide!)
				//ll_rc = luo_run.of_run( "C:\Progra~~2\ii4net\CIPQCodeQR.exe ~""+ls_code + '" ""' + ls_chemin + "~"", Hide!)
				
				if ls_code = "" then
				
				else
				
					ls_cie_compagnie = gnv_app.of_getcompagniedefaut( )
				
					select isnull(chemin_exe,'N/A'),isnull(chemin_img,'N/A') into :ls_chemin_exe,:ls_chemin_img 
					from t_centrecipq 
					where cie = :ls_cie_compagnie;
					
					if ls_chemin_exe = 'N/A' then
						ls_chemin_exe = GetCurrentDirectory() + "\codeqr\"
					end if
					if right(ls_chemin_exe,1)<>'\' then
						ls_chemin_exe +='\'
					end if
					ls_chemin_exe = ls_chemin_exe + 'CIPQCodeQR.exe'
					
					if fileExists(ls_chemin_exe) = false then
						messagebox("Avertissement","Le chemin du programme CIPQCodeQR.exe n'est pas correctement installé " + ls_chemin_exe)
					end if
					
					if ls_chemin_img = 'N/A' then
						ls_chemin_img = GetCurrentDirectory() + "\codeqr\"
					end if
					if right(ls_chemin_img,1)<>'\' then
						ls_chemin_img+='\'
					end if
					
					if fileExists(ls_chemin_img) = false then
						messagebox("Avertissement","Le chemin ou sont copié les images n'est pas correctement installé " + ls_chemin_img)
					end if
					
					ls_chemin = ls_chemin_img+ls_liv_no+"_"+ls_cie_no+"_"+string(today(),"yyyy-mm-dd-hh-mm-ss")+".png"
					if len(ls_code) <= 15 then
						ll_rc = luo_run.of_run( ls_chemin_exe+" ~""+ls_code + '" ""' + ls_chemin + "~"", Hide!)
					else
						ll_rc = -100
					end if
					
					hpb_1.position = 60
					if ll_rc = 0 then
						is_qr_chemin[upperbound(is_qr_chemin) + 1]=ls_chemin
						dw_detail.setItem(i, "imagefile", ls_chemin)
						//pour modifier
						
						if ll_is_qr = 0 then
							if ll_is_mod = 100 then
								dw_list.setitem(i,'is_qr',1)
							else
								dw_list.setitem(i,'is_qr',2)
							end if
						else
							dw_list.setitem(i,'is_qr',2)
						end if
						dw_list.setitem(i,'flag',0)	
						
						dw_list.setitem(i,'liv_no',ls_liv_no)
						
						
						
						//ll_is_qr = 0 ---- pas de image et n'est pas envoye.
						//donc insert image dans la table t_imgcodeqr
						hpb_1.position = 70
						if ll_is_qr = 0 then
							
							if ll_is_mod =100 then
								//permier fois envoyer et jamais modify.
								li_filenum = FileOpen(ls_chemin,StreamMode!,read!)
								ll_bytes = FileReadEx(li_filenum, lblob_qr)
								FileClose(li_filenum)
							
								sleep(1) 
								//FileDelete(ls_chemin)
			
								insert into t_imgcodeqr (liv_no,cie_no,mod) values(:ls_liv_no,:ls_cie_no,0);
								if SQLCA.SQLCode = 0 then
									commit using SQLCA;
								else
									messagebox("insert imgcodeqr failed",sqlca.sqlerrtext)
									rollback using SQLCA;
								end if
			
								updateblob t_imgcodeqr set imgcodeqr = :lblob_qr 
								where liv_no = :ls_liv_no and  cie_no = :ls_cie_no
								;
								if SQLCA.SQLCode = 0 then
									commit using SQLCA;
								else
									messagebox("updateblob imgcodeqr failed",sqlca.sqlerrtext)
									rollback using SQLCA;
								end if
								insert into t_imgcodeqrlog(logdate,cie_no,liv_no,action) 
								values(now(),:ls_cie_no,:ls_liv_no,'add')
								;
								if SQLCA.SQLCode = 0 then
									commit using SQLCA;
								else
									messagebox("insert imgcodeqrlog failed",sqlca.sqlerrtext)
									rollback using SQLCA;
								end if
							elseif ll_is_mod = 1 then
								//pour modifier
								update t_imgcodeqr set mod = 0 
								where liv_no = :ls_liv_no and  cie_no = :ls_cie_no
								;
								insert into t_imgcodeqrlog(logdate,cie_no,liv_no,action) 
								values(now(),:ls_cie_no,:ls_liv_no,'mod')
								;
								if SQLCA.SQLCode = 0 then
									commit using SQLCA;
								else
									messagebox("Update failed",sqlca.sqlerrtext)
									rollback using SQLCA;
								end if
							end if
						//ll_is_qr <>0 --- on a deja envoye cette facture et on a l'image.
						// on seulement insert dans la table log.
						else
							insert into t_imgcodeqrlog(logdate,cie_no,liv_no,action) 
							values(now(),:ls_cie_no,:ls_liv_no,'mod')
							;
							if SQLCA.SQLCode = 0 then
								commit using SQLCA;
							else
								messagebox("Update failed",sqlca.sqlerrtext)
								rollback using SQLCA;
							end if
						end if
						hpb_1.position = 100
					
			//		end if
					
				else
					hpb_1.position = 100
					messagebox('Avertissement',"Aucun code QR n'a été créé pour ce bon de commande")
					/*
					//pour le test,maintenant le site ne marche pas,donc je donne QR statique pour tester le print. 
					if i = 1 then
						ls_chemin = "C:\ii4net\cipq\2022-06-22-15-16-37-1.png"
					elseif i = 2 then
						ls_chemin = 'C:\ii4net\cipq\2022-06-22-15-16-38-2.png'
					elseif i = 3 then
						ls_chemin =  'C:\ii4net\cipq\2022-06-22-15-16-39-3.png'
					else
						ls_chemin = 'C:\ii4net\cipq\2022-06-22-15-16-39-4.png'
					end if
					*/
				end if
			end if
		end if		
		
	end if
	next
	hpb_1.position = 0
	dw_list.scrolltorow(1)
	dw_list.setfocus()
	dw_list.setrowfocusindicator(hand!)
	
	
	if st_3.text = 'Desélectionner tout' then
		st_3.text = 'Sélectionner tout'
	end if
	st_2.text = 'Total : '+ string(dw_list.rowcount())
else
	messagebox('Avertissement',"Vous devez sélectionner la ligne correspondante pour l'envoie.")
end if

end subroutine

public subroutine of_print ();//wei create 2022-06-27
/*
datastore lds_print
lds_print = create datastore
lds_print.dataobject = 'd_facture_print'
lds_print.setTransobject(SQLCA)
lds_print.retrieve()
*/
long i,j,k
string ls_liv_no
string ls_cie_no
string ls_temp
string ls_liv_no_detail
string ls_cie_no_detail
string ls_liv_no_temp
string ls_cie_no_temp
string ls_image
long ll_flag
long job
long ll_count


for i = 1 to dw_list.rowcount()
	ll_flag = dw_list.getitemnumber(i,'flag')
	/*
	ll_is_qr = dw_list.getitemnumber(i,'is_qr')
	//cocher et pas de image qr.
	if ll_flag = 1 and ll_is_qr = 0 then
		ll_count+=1
	end if	
	*/
	//la ligne cocher.
	if ll_flag = 1 then
		ll_count+=1
	end if
next
if ll_count = 0 then
	messagebox('Avertissement',"Vous devez sélectionner la ligne correspondante pour l'impression")
	return
end if
job = PrintOpen( "Bon de commande", true)
// Each DataWindow starts printing on a new page.


for i = 1 to dw_list.rowcount( )
	ll_flag = dw_list.getitemnumber(i,'flag')
	if ll_flag = 1 then
		dw_detail.scrolltorow(i)
		dw_detail.setfocus()
		dw_list.scrolltorow(i)
		dw_list.setfocus()
		dw_list.setrowfocusindicator(hand!)
		dw_list.setitem(i,'flag',0)
		ls_liv_no = dw_list.getitemstring(i,'liv_no')
		if pos(ls_liv_no,'(M)')>0 then
			ls_liv_no = mid(ls_liv_no,1,len(ls_liv_no) - 3)
		end if
		
		
		ls_cie_no = dw_list.getitemstring(i,'cie_no')
		for j = 1 to ids_fact_print.rowcount()
			ls_liv_no_temp = ids_fact_print.getitemstring(j,'liv_no')
			ls_cie_no_temp = ids_fact_print.getitemstring(j,'cie_no')
			if ls_liv_no_temp = ls_liv_no and ls_cie_no_temp = ls_cie_no then
				ids_fact_print.setfilter("liv_no='"+ls_liv_no+"' and cie_no='"+ls_cie_no+"'")
				ids_fact_print.Filter( )
				for  k = 1 to dw_detail.rowcount()
					ls_liv_no_detail = dw_detail.getitemstring(k,'liv_no')
					ls_cie_no_detail = dw_detail.getitemstring(k,'cie_no')
					if ls_liv_no_detail= ls_liv_no and ls_cie_no_detail = ls_cie_no then
						ls_image = dw_detail.getitemstring(k,'imagefile')
						ids_fact_print.setitem(1,'imagefile',ls_image)
						exit
					end if					
				next
		//		ids_fact_print.print(true,true )
				PrintDataWindow(job, ids_fact_print)
				ids_fact_print.setfilter( "")
				ids_fact_print.filter()
				exit
			end if
		next
	end if
next

PrintClose(job)

if st_3.text = 'Desélectionner tout' then
	st_3.text = 'Sélectionner tout'
end if
/*
for i = 1 to dw_list.rowcount( )
	if lb_1.State(i) = 1 then
		ls_liv_no = lb_1.of_getlabel( i)
		for j = 1 to ids_fact_print.rowcount()
			ls_temp = ids_fact_print.getitemstring(j,'liv_no')
			if ls_temp = ls_liv_no then
				ids_fact_print.setfilter("liv_no='"+ls_liv_no+"'")
				ids_fact_print.Filter( )
				for  k = 1 to dw_1.rowcount()
					ls_liv_temp = dw_1.getitemstring(k,'liv_no')
					if ls_liv_temp = ls_liv_no then
						ls_image = dw_1.getitemstring(k,'imagefile')
						ids_fact_print.setitem(1,'imagefile',ls_image)
						exit
					end if					
				next
				ids_fact_print.print(true,true )
				ids_fact_print.setfilter( "")
				ids_fact_print.filter()
				exit
			end if
		next
	end if
next
*/


end subroutine

public subroutine of_print_pdf ();string ls_path
integer li_result
long i,j,k, u
string ls_liv_no
string ls_cie_no
string ls_temp
string ls_liv_no_detail
string ls_cie_no_detail
string ls_liv_no_temp
string ls_cie_no_temp
string ls_image
long ll_flag
long job
long ll_count
string ls_pdf

li_result = getfolder("Sélectionner un dossier pour les fichiers PDF",ls_path)
/*
li_result = GetFileSaveName ( "Select File", &
   						ls_path, ls_file, "xls", &
   						"All Files (*.xls*),*.xls*" , "C:\My Documents", &
   						32770)

*/
SetPointer(HourGlass!)
if li_result = 1 then
	//messagebox("",ls_path)
	for i = 1 to dw_list.rowcount()
		ll_flag = dw_list.getitemnumber(i,'flag')
		//la ligne cocher.
		if ll_flag = 1 then
			ll_count+=1
		end if
	next
	if ll_count = 0 then
		messagebox('Avertissement',"Vous devez sélectionner la ligne correspondante pour l'impression PDF")
		return
	end if
	
	for i = 1 to dw_list.rowcount( )
		hpb_1.position = 0
		ll_flag = dw_list.getitemnumber(i,'flag')
		if ll_flag = 1 then
			dw_detail.scrolltorow(i)
			dw_detail.setfocus()
			dw_list.scrolltorow(i)
			dw_list.setfocus()
			dw_list.setrowfocusindicator(hand!)
			dw_list.setitem(i,'flag',0)
			ls_liv_no = dw_list.getitemstring(i,'liv_no')
			
			if pos(ls_liv_no,'(M)')>0 then
				ls_liv_no = mid(ls_liv_no,1,len(ls_liv_no) - 3)
			end if
			
			ls_cie_no = dw_list.getitemstring(i,'cie_no')
			st_2.text = 'Imprimer PDF pour '+ ls_liv_no + ' ' + ls_cie_no
			hpb_1.position = 20
			for j = 1 to ids_fact_print.rowcount()
				ls_liv_no_temp = ids_fact_print.getitemstring(j,'liv_no')
				ls_cie_no_temp = ids_fact_print.getitemstring(j,'cie_no')
				if ls_liv_no_temp = ls_liv_no and ls_cie_no_temp = ls_cie_no then
					ids_fact_print.setfilter("liv_no='"+ls_liv_no+"' and cie_no='"+ls_cie_no+"'")
					ids_fact_print.Filter( )
					hpb_1.position = 50
					for  k = 1 to dw_detail.rowcount()
						ls_liv_no_detail = dw_detail.getitemstring(k,'liv_no')
						ls_cie_no_detail = dw_detail.getitemstring(k,'cie_no')
						if ls_liv_no_detail= ls_liv_no and ls_cie_no_detail = ls_cie_no then
							ls_image = dw_detail.getitemstring(k,'imagefile')
							for u = 1 to ids_fact_print.rowcount()
								ids_fact_print.setitem(u,'imagefile',ls_image)
							next
							hpb_1.position = 80
							exit
						end if					
					next
					//ids_fact_print.print(true,true )
					//PrintDataWindow(job, ids_fact_print)
					
					ls_pdf = ls_path + '\'+ls_liv_no+'_'+ls_cie_no+'_'+string(today(),'yyyymmddhhmmdd')+'.pdf'
					
					if ids_fact_print.saveas(ls_pdf, PDF!, false) <> 1 then
						messagebox('Avertissement','On ne peut pas enregistrer le fichier pdf.')
						exit
					end if
					hpb_1.position = 90
					ids_fact_print.setfilter( "")
					ids_fact_print.filter()
					hpb_1.position = 100
					exit
				end if
			next
		end if
	next
	dw_detail.scrolltorow(1)
	dw_detail.setfocus()
	dw_list.scrolltorow(1)
	dw_list.setfocus()
	st_2.text = 'Total : ' + string(dw_list.rowcount())
	hpb_1.position = 0
	if st_3.text = 'Desélectionner tout' then
		st_3.text = 'Sélectionner tout'
	end if
end if
SetPointer(Arrow!)








/*
for i = 1 to dw_list.rowcount( )
	if lb_1.State(i) = 1 then
		ls_liv_no = lb_1.of_getlabel( i)
		for j = 1 to ids_fact_print.rowcount()
			ls_temp = ids_fact_print.getitemstring(j,'liv_no')
			if ls_temp = ls_liv_no then
				ids_fact_print.setfilter("liv_no='"+ls_liv_no+"'")
				ids_fact_print.Filter( )
				for  k = 1 to dw_1.rowcount()
					ls_liv_temp = dw_1.getitemstring(k,'liv_no')
					if ls_liv_temp = ls_liv_no then
						ls_image = dw_1.getitemstring(k,'imagefile')
						ids_fact_print.setitem(1,'imagefile',ls_image)
						exit
					end if					
				next
				ids_fact_print.print(true,true )
				ids_fact_print.setfilter( "")
				ids_fact_print.filter()
				exit
			end if
		next
	end if
next
*/


end subroutine

on w_http_reponse.create
int iCurrent
call super::create
this.st_2=create st_2
this.uo_toolbar=create uo_toolbar
this.uo_fermer=create uo_fermer
this.st_1=create st_1
this.hpb_1=create hpb_1
this.dw_detail=create dw_detail
this.st_3=create st_3
this.rr_1=create rr_1
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.uo_toolbar
this.Control[iCurrent+3]=this.uo_fermer
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.hpb_1
this.Control[iCurrent+6]=this.dw_detail
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.rr_1
this.Control[iCurrent+9]=this.dw_list
end on

on w_http_reponse.destroy
call super::destroy
destroy(this.st_2)
destroy(this.uo_toolbar)
destroy(this.uo_fermer)
destroy(this.st_1)
destroy(this.hpb_1)
destroy(this.dw_detail)
destroy(this.st_3)
destroy(this.rr_1)
destroy(this.dw_list)
end on

event pfc_preopen;call super::pfc_preopen;is_xml_facture = gnv_app.inv_entrepotglobal.of_retournedonnee( 'xml_facture')

ids_fact_print = create datastore
ids_fact_print.dataobject = 'd_facture_print'
ids_fact_print = gnv_app.inv_entrepotglobal.of_retournedonnee('facture_print_datastore')

datastore lds_temp
lds_temp= create datastore
lds_temp.dataobject = 'd_facture_detail'
lds_temp=gnv_app.inv_entrepotglobal.of_retournedonnee('facture_detail_datastore')
dw_detail.Object.Data = lds_temp.Object.Data
destroy lds_temp

lds_temp = create datastore
lds_temp.dataobject = 'd_facture_list'
lds_temp=gnv_app.inv_entrepotglobal.of_retournedonnee('facture_list_datastore')
dw_list.Object.Data = lds_temp.Object.Data
destroy lds_temp


/*
ids_fact_print = create datastore
ids_fact_print.dataobject = 'd_facture_print_temp'
ids_fact_print.settransobject(sqlca)
ids_fact_print.retrieve()


dw_detail.dataobject = 'd_facture_detail_temp'
dw_detail.settransobject(sqlca)
dw_detail.retrieve()

dw_list.dataobject = 'd_facture_list_temp'
dw_list.settransobject(sqlca)
dw_list.retrieve()
*/



end event

event open;call super::open;//wei create 2022-05-24
string ls_liv_no
string ls_cie_no
string ls_liv_no_detail
string ls_cie_no_detail
long i,j
long ll_count
datastore lds_temp
blob lblob_qr
string ls_chemin
long ll_position
integer li_FileNum
string ls_chemin_image

long ll_pres
long ll_mod

string ls_cie_compagnie
string ls_chemin_img
ls_cie_compagnie = gnv_app.of_getcompagniedefaut( )
				
select 
	isnull(chemin_img,'N/A') into :ls_chemin_img 
from t_centrecipq 
where cie = :ls_cie_compagnie
;
				
if ls_chemin_img = 'N/A' then
	ls_chemin_img = "C:\Progra~~2\ii4net\"
end if
if right(ls_chemin_img,1)<>'\' then
	ls_chemin_img +='\'
end if
st_2.text = 'Total '+string(dw_list.rowcount())

//chercher l'image qr pour le dw_detail.
for i = 1 to dw_list.rowcount()
	ls_liv_no = dw_list.getitemstring(i,'liv_no')
	ls_cie_no = dw_list.getitemstring(i,'cie_no')
	select count(1)  into :ll_pres
	from t_imgcodeqr
	where liv_no = :ls_liv_no and cie_no = :ls_cie_no
	;
	ll_position = upperbound(is_qr_chemin) + 1
	
	if ll_pres > 0  then
		selectblob imgcodeqr  into :lblob_qr
		from t_imgcodeqr
		where liv_no = :ls_liv_no and cie_no = :ls_cie_no
		;
		//ls_chemin = 'C:\ii4net\cipq\'+ls_liv_no+'-'+ls_cie_no+'.png'
		ls_chemin = ls_chemin_image+ls_liv_no+'-'+ls_cie_no+'.png'
		//open/create un file .png
		li_FileNum = FileOpen(ls_chemin,StreamMode!, Write!, Shared!, Replace!)
		//write blob in the file .png
		FileWriteEx(li_FileNum, lblob_qr)
		fileclose(li_filenum)
		
		//add this file dans le tableau pour suprrimer.
		is_qr_chemin[ll_position]=ls_chemin
		for j = 1 to dw_detail.rowcount()
			ls_liv_no_detail = dw_detail.getitemstring(j,'liv_no')
			ls_cie_no_detail = dw_detail.getitemstring(j,'cie_no')
			if ls_liv_no = ls_liv_no_detail and ls_cie_no = ls_cie_no_detail then
				dw_detail.setItem(j, "imagefile", ls_chemin)
				exit
			end if
		next
		
		//pour is_qr
		select isnull(mod,0)  into :ll_mod
		from t_imgcodeqr
		where liv_no = :ls_liv_no and cie_no = :ls_cie_no
		;
		if ll_mod = 0 then
			select count(*) into :ll_count
			from t_imgcodeqrlog 
			where cie_no =:ls_cie_no  and liv_no = :ls_liv_no and action = 'mod' 
			;
			//ll_count > 0 --- on a deja envoye plus une fois.
			//ll_count = 0 --- on a deja envoye seulement une fois.
			if ll_count>0 then
				dw_list.setitem(i,'is_qr',2)
			else
				dw_list.setitem(i,'is_qr',1)
			end if
			//mod = 0 envoyer et non modify
			dw_list.setitem(i,'is_mod',0)
		else
			dw_list.setitem(i,'is_qr',0)
			//mod = 1 envoyer et modifie
			dw_list.setitem(i,'is_mod',1)
			dw_list.setitem(i,'liv_no',ls_liv_no + '(M)')
		end if
	else
		dw_list.setitem(i,'is_qr',0)
		//mod = 100 -- jamais envoyer et jamais modify.
		dw_list.setitem(i,'is_mod',100)
	end if

	
next

//synconaise dw_list et dw_detail.

dw_list.scrolltorow(1)
dw_list.setfocus()
dw_list.setrowfocusindicator(hand!)
ls_liv_no = dw_list.getitemstring(1,'liv_no')
ls_cie_no = dw_list.getitemstring(1,'cie_no')
for j = 1 to dw_detail.rowcount()
	ls_liv_no_detail = dw_detail.getitemstring(j,'liv_no')
	ls_cie_no_detail = dw_detail.getitemstring(j,'cie_no')
	if ls_liv_no = ls_liv_no_detail and ls_cie_no = ls_cie_no_detail then
		dw_detail.scrolltorow(j)
		dw_detail.setfocus()
		exit
	end if
next




/*
if dw_1.rowcount() > 0 then
	for i = 1 to dw_1.rowcount()
		ls_liv_no = dw_1.getitemstring(i,'liv_no')
		ls_cie_no = dw_1.getitemstring(i,'cie_no')
		selectblob imgcodeqr into :lblob_qr
		from t_statfacture
		where liv_no = :ls_liv_no and cie_no = :ls_cie_no
		;
		if not isnull(lblob_qr) then
			ip_1.loadink( lblob_qr)
			ls_chemin = 'C:\ii4net\cipq\'+ls_liv_no+'-'+ls_cie_no+'.png'
			ip_1.save(ls_chemin, 2, false)
			dw_1.setItem(i, "imagefile", ls_chemin)
		end if
	next
	dw_1.scrolltorow(1)
end if
*/
end event

event closequery;//
end event

event close;call super::close;long i
destroy ids_fact_print

if upperbound(is_qr_chemin)>0 then
	for i = 1 to upperbound(is_qr_chemin)
		filedelete(is_qr_chemin[i])
	next
end if
/*
delete from t_facture_list_detail_temp;
delete from t_facture_print_temp;
if SQLCA.SQLCode = 0 then
	commit using SQLCA;
else
	rollback using SQLCA;
end if
*/
		


end event

type st_2 from statictext within w_http_reponse
integer x = 2171
integer y = 1292
integer width = 3186
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 553648127
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_toolbar from u_cst_toolbarstrip within w_http_reponse
integer x = 27
integer y = 1464
integer width = 5179
integer taborder = 30
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event destructor;call super::destructor;call u_cst_toolbarstrip :: destroy
end event

event ue_buttonclicked;call super::ue_buttonclicked;choose case as_button
	case 'Envoyer'
		of_send()
	case 'Imprimer'
		of_print()
	case 'Imprimer PDF'
		of_print_pdf()
end choose
end event

type uo_fermer from u_cst_toolbarstrip within w_http_reponse
integer x = 5207
integer y = 1464
integer width = 293
integer taborder = 20
end type

on uo_fermer.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;long i
long ll_is_qr
boolean lb_non_envoie
long ll_response
lb_non_envoie = false
for i = 1 to dw_list.rowcount()
	ll_is_qr = dw_list.getitemnumber(i,'is_qr')
	if ll_is_qr = 0 then
		lb_non_envoie = true
		exit
	end if	
next
if lb_non_envoie then
	ll_response = messagebox('avertissement',"Certains bon de commande n'ont pas été envoyé. Êtes-vous sûr de fermer cette fenêtre sans procéder?",Question!,YesNo! )
	if ll_response = 1 then
		close(parent)
	end if
else
	close(parent)
end if
end event

type st_1 from statictext within w_http_reponse
integer x = 46
integer y = 52
integer width = 558
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 553648127
string text = "Les factures"
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_http_reponse
integer x = 2171
integer y = 1368
integer width = 3186
integer height = 84
unsignedinteger maxposition = 100
integer setstep = 10
end type

type dw_detail from u_dw within w_http_reponse
integer x = 2107
integer y = 156
integer width = 3392
integer height = 1120
integer taborder = 10
string dataobject = "d_facture_detail"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;settransobject(sqlca)

end event

event clicked;//
end event

event rowfocuschanged;//
end event

event itemchanged;//
end event

event editchanged;//
end event

type st_3 from statictext within w_http_reponse
integer x = 23
integer y = 1372
integer width = 2048
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 16711680
long backcolor = 15793151
string text = "Sélectionner tout"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;long i
if this.text = 'Sélectionner tout' then
	this.text = 'Desélectionner tout'
	for i = 1 to dw_list.rowcount( )
		dw_list.setitem(i,'flag',1)
	next
else
	this.text = 'Sélectionner tout'
	for i = 1 to dw_list.rowcount( )
		dw_list.setitem(i,'flag',0)
	next
end if



end event

type rr_1 from roundrectangle within w_http_reponse
long linecolor = 134217728
integer linethickness = 1
long fillcolor = 15793151
integer x = 23
integer y = 28
integer width = 5463
integer height = 124
integer cornerheight = 40
integer cornerwidth = 46
end type

type dw_list from u_dw within w_http_reponse
integer x = 23
integer y = 156
integer width = 2048
integer height = 1208
integer taborder = 20
string dataobject = "d_facture_list"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event clicked;//
string ls_liv_no
string ls_cie_no
string ls_liv_no_detail
string ls_cie_no_detail
long i
if row>0 then
	this.scrolltorow(row)
	this.setfocus()
	this.setrowfocusindicator(hand!)
	ls_liv_no = this.getitemstring(row,'liv_no')
	if pos(ls_liv_no,'(M)')>0 then
		ls_liv_no = mid(ls_liv_no,1,len(ls_liv_no) - 3)
	end if
	ls_cie_no = this.getitemstring(row,'cie_no')
	for i = 1 to dw_detail.rowcount()
		ls_liv_no_detail = dw_detail.getitemstring(i,'liv_no')
		ls_cie_no_detail = dw_detail.getitemstring(i,'cie_no')
		if ls_liv_no = ls_liv_no_detail and ls_cie_no = ls_cie_no_detail then
			dw_detail.scrolltorow(i)
			dw_detail.setfocus()
			exit
		end if
	next
end if
end event

event rowfocuschanged;


//
string ls_liv_no
string ls_cie_no
string ls_liv_no_detail
string ls_cie_no_detail
long i
if currentrow>0 then
	this.scrolltorow(currentrow)
	this.setfocus()
	this.setrowfocusindicator(hand!)
	ls_liv_no = this.getitemstring(currentrow,'liv_no')
	if pos(ls_liv_no,'(M)')>0 then
		ls_liv_no = mid(ls_liv_no,1,len(ls_liv_no) - 3)
	end if
	ls_cie_no = this.getitemstring(currentrow,'cie_no')
	for i = 1 to dw_detail.rowcount()
		ls_liv_no_detail = dw_detail.getitemstring(i,'liv_no')
		ls_cie_no_detail = dw_detail.getitemstring(i,'cie_no')
		if ls_liv_no = ls_liv_no_detail and ls_cie_no = ls_cie_no_detail then
			dw_detail.scrolltorow(i)
			dw_detail.setfocus()
			exit
		end if
	next
end if

end event

event editchanged;//
end event

event itemchanged;//
end event

event constructor;call super::constructor;this.settransobject(sqlca)

end event

event doubleclicked;call super::doubleclicked;string ls_cie_no
string ls_liv_no
if row > 0 then
	ls_cie_no = this.getitemstring(row,'cie_no')
	ls_liv_no = this.getitemstring(row,'liv_no')
	if pos(ls_liv_no,'(M)')>0 then
		ls_liv_no = mid(ls_liv_no,1,len(ls_liv_no) - 3)
	end if
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere bon centre", ls_cie_no)
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere bon no bon", ls_liv_no)
	w_bon_expedition	lw_fen
	SetPointer(HourGlass!)
	OpenSheet(lw_fen, gnv_app.of_getframe( ), 6, layered!)
	lw_fen.bringtotop = true
end if
//Bâtir le filtre
/*
string	ls_filtre = "", ls_centre
date		ld_date
long		ll_no_bon, ll_no_eleveur

dw_bon_expedition_critere.AcceptText()

ls_centre = dw_bon_expedition_critere.object.cie[1]
ll_no_bon = dw_bon_expedition_critere.object.no_bon[1]
ll_no_eleveur = dw_bon_expedition_critere.object.no_eleveur[1]
ld_date = dw_bon_expedition_critere.object.date_expe[1]

IF Not IsNull(ll_no_bon) AND ll_no_bon <> 0 AND ( IsNull(ls_centre) OR ls_centre = "" ) THEN
	gnv_app.inv_error.of_message("CIPQ0126")
	RETURN
END IF	

IF Not IsNull(ls_centre) AND ls_centre <> "" THEN
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere bon centre", ls_centre)
END IF

IF Not IsNull(ld_date) AND ld_date <> 1900-01-01 THEN
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere bon date", string(ld_date))
END IF

IF Not IsNull(ll_no_bon) AND ll_no_bon <> 0 THEN
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere bon no bon", string(ll_no_bon))
END IF

IF Not IsNull(ll_no_eleveur) AND ll_no_eleveur <> 0 THEN
	gnv_app.inv_entrepotglobal.of_ajoutedonnee("critere bon no eleveur", string(ll_no_eleveur))
END IF

//Ouvrir l'interface
w_bon_expedition	lw_fen
SetPointer(HourGlass!)
OpenSheet(lw_fen, gnv_app.of_getframe( ), 6, layered!)
*/
end event

