HA$PBExportHeader$n_cst_transfert_inter_centre.sru
forward
global type n_cst_transfert_inter_centre from n_base
end type
end forward

global type n_cst_transfert_inter_centre from n_base autoinstantiate
end type

forward prototypes
public subroutine of_transfert (date ad_cur)
public function string of_dosavetoprinter (string as_cie, string as_nocommande, string as_cietransfertto)
public subroutine of_transfert_recolte_commande ()
public subroutine of_importfichier ()
public subroutine of_enlevervieuxfichiers ()
end prototypes

public subroutine of_transfert (date ad_cur);//of_transfert

string	ls_retour, ls_prefnom, ls_cie, ls_nocommande, ls_ciecentre, ls_repexport, ls_NameInit, ls_ecrire = '', &
			ls_string, ls_app = "'", ls_sql
n_ds		lds_centres_transferables, lds_commandes_a_transferer, lds_Tmplt_Commande, lds_Tmplt_CommandeDetail			
long		ll_cpt_centre, ll_cpt_commande, ll_cpt_Tmplt_Commande, ll_cpt_Tmplt_CommandeDetail, ll_pos, ll_rtn, &
			ll_row_transferable, ll_rowcount_a, ll_taille_fich, ll_rowcount_temp, ll_eleveur
dec		ldec_QteInit, ldec_QteCommande, ldec_QteExpedie, ldec_QteTransfert, ldec_QteTransfertTot
integer	li_FileNum
datetime	ldt_heure

IF gnv_app.inv_error.of_message("CIPQ0078") = 1 THEN
	
	//V$$HEX1$$e900$$ENDHEX$$rifier si le transfert est suspendu
	ls_retour = gnv_app.of_getvaleurini( "FTP", "Transfert_Commande")
	IF upper(ls_retour) <> "TRUE" THEN
		gnv_app.inv_error.of_message("CIPQ0138")
		RETURN
	END IF
	
	//V$$HEX1$$e900$$ENDHEX$$rifier le r$$HEX1$$e900$$ENDHEX$$pertoire d'exportation
	ls_repexport = gnv_app.of_getvaleurini( "FTP", "EXPORTPATH")
	IF LEN(ls_repexport) > 0 THEN
		IF NOT FileExists(ls_repexport) THEN
			gnv_app.inv_error.of_message("CIPQ0139")
			RETURN
		END IF
	ELSE
		gnv_app.inv_error.of_message("CIPQ0140")
		RETURN
	END IF
	
	IF RIGHT(ls_repexport, 1) <> "\" THEN
		ls_repexport += "\"
	END IF
	
	// V$$HEX1$$e900$$ENDHEX$$rifier si une commande qu'on s'appr$$HEX1$$ea00$$ENDHEX$$te $$HEX2$$e0002000$$ENDHEX$$transf$$HEX1$$e900$$ENDHEX$$rer est trait$$HEX1$$e900$$ENDHEX$$e
	setNull(ll_eleveur)
	
	  select first t_Commande.No_Eleveur
		 into :ll_eleveur
		 from t_Commande inner join t_CommandeDetail
		 					  on t_CommandeDetail.NoCommande = t_Commande.NoCommande and t_CommandeDetail.CieNo = t_Commande.CieNo
							  inner join t_CentreCIPQ on t_CentreCIPQ.PrefNom = t_CommandeDetail.Trans
		where date(t_Commande.DateCommande) = :ad_cur
		  and t_Commande.Traiter = 1
		  and isnull(t_CommandeDetail.QteTransfert, 0) <> 0
		  and t_CommandeDetail.TranName Is Null
	order by t_Commande.No_Eleveur;
	
	if not isNull(ll_eleveur) then
		gnv_app.inv_error.of_message("CIPQ0161", {string(ll_eleveur)})
		return
	end if
	
	//Cr$$HEX1$$e900$$ENDHEX$$er les tables temporaires
	select count(1) into :ll_rowcount_temp from #TMP_Trans_Commande;
	if SQLCA.SQLCode = -1 then
		ls_sql = "create table #TMP_Trans_Commande (CieNo varchar(3) not null,~r~n" + &
																 "NoCommande varchar(6) not null,~r~n" + &
																 "No_Eleveur integer null,~r~n" + &
																 "NoBonExpe varchar(7) null,~r~n" + &
																 "BonCommandeClient varchar(6) null,~r~n" + &
																 "DateCommande datetime null,~r~n" + &
																 "NoVendeur integer null,~r~n" + &
																 "CodeTransport varchar(12) null,~r~n" + &
																 "LivrAMPM varchar(2) null,~r~n" + &
																 "Traiter bit null,~r~n" + &
																 "Imprimer bit null,~r~n" + &
																 "Facture bit null,~r~n" + &
																 "DateFacturation datetime null,~r~n" + &
																 "NoFacture varchar(10) null,~r~n" + &
																 "TauxTaxeFederale double null,~r~n" + &
																 "TauxTaxeProvinciale double null,~r~n" + &
																 "Repeat bit null,~r~n" + &
																 "Reste integer null,~r~n" + &
																 "~"Message~" varchar(75) null,~r~n" + &
																 "Repartition integer null,~r~n" + &
																 "Locked varchar(1) null default 'C',~r~n" + &
																 "DUPLICATION varchar(50) null,~r~n" + &
																 "TransferePar varchar(3) null,~r~n" + &
																 "NoRepeat varchar(6) null,~r~n" + &
																 "lockedby varchar(255) null,~r~n" + &
																 "primary key (CieNo, NoCommande))"
		EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	end if
	
	select count(1) into :ll_rowcount_temp from #TMP_Trans_CommandeDetail;
	if SQLCA.SQLCode = -1 then
		ls_sql = "create table #TMP_Trans_CommandeDetail (CieNo varchar(3) not null,~r~n" + &
																		 "NoCommande varchar(6) not null,~r~n" + &
																		 "NoLigne integer not null,~r~n" + &
																		 "NoProduit varchar(16) null,~r~n" + &
																		 "CodeVerrat varchar(12) null,~r~n" + &
																		 "QteCommande float null,~r~n" + &
																		 "QteExpedie float null,~r~n" + &
																		 "Melange varchar(50) null,~r~n" + &
																		 "Description varchar(50) null,~r~n" + &
																		 "TransfCommande varchar(5) null,~r~n" + &
																		 "NoLigneHeader integer null,~r~n" + &
																		 "Choix integer null,~r~n" + &
																		 "TranName varchar(25) null,~r~n" + &
																		 "Trans varchar(1) null,~r~n" + &
																		 "Fixe bit null,~r~n" + &
																		 "Repartition integer null,~r~n" + &
																		 "QteInit integer null,~r~n" + &
																		 "QteTransfert integer null,~r~n" + &
																		 "NoItem integer null,~r~n" + &
																		 "Compteur integer null,~r~n" + &
																		 "NoRepeat varchar(6) null,~r~n" + &
																		 "primary key (CieNo, NoCommande, NoLigne))"
		EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	end if
	
	//Pr$$HEX1$$e900$$ENDHEX$$parer les datastores
	lds_Tmplt_Commande = CREATE n_ds
	lds_Tmplt_Commande.dataobject = "ds_Tmplt_Commande"
	lds_Tmplt_Commande.of_setTransobject(SQLCA)
	
	lds_Tmplt_CommandeDetail = CREATE n_ds
	lds_Tmplt_CommandeDetail.dataobject = "ds_Tmplt_CommandeDetail"
	lds_Tmplt_CommandeDetail.of_setTransobject(SQLCA)
	
	lds_commandes_a_transferer = CREATE n_ds
	lds_commandes_a_transferer.dataobject = "ds_commandes_a_transferer"
	lds_commandes_a_transferer.of_setTransobject(SQLCA)
	
	//D$$HEX1$$e900$$ENDHEX$$terminer les centres transf$$HEX1$$e900$$ENDHEX$$rables
	lds_centres_transferables = CREATE n_ds
	lds_centres_transferables.dataobject = "ds_centres_transferables"
	lds_centres_transferables.of_setTransobject(SQLCA)
	ll_row_transferable = lds_centres_transferables.Retrieve()
	
	
	FOR ll_cpt_centre = 1 TO ll_row_transferable
		
		ls_ecrire = ""
		
		ls_prefnom = lds_centres_transferables.Object.prefnom[ll_cpt_centre]
		ls_ciecentre = lds_centres_transferables.Object.cie[ll_cpt_centre]
		
		//Vider '#TMP_Trans_Commande' et '#TMP_Trans_CommandeDetail'
		DELETE FROM #TMP_Trans_Commande ;
		COMMIT USING SQLCA;
		DELETE FROM #TMP_Trans_CommandeDetail ;
		COMMIT USING SQLCA;
		
		//V$$HEX1$$e900$$ENDHEX$$rifier si $$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ments $$HEX2$$e0002000$$ENDHEX$$transf$$HEX1$$e900$$ENDHEX$$rer pour ce centre, pour cette date
		ll_rowcount_a = lds_commandes_a_transferer.Retrieve(ad_cur, ls_prefnom)
		
		FOR ll_cpt_commande = 1 TO ll_rowcount_a
			
			//Pr$$HEX1$$e900$$ENDHEX$$parer les tables qui serviront pour g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer les commandes SQL
			
			ls_cie = lds_commandes_a_transferer.object.t_commande_cieno[ll_cpt_commande]
			ls_nocommande = lds_commandes_a_transferer.object.t_commande_nocommande[ll_cpt_commande]
			
			//On inscrit la commande
			INSERT INTO #TMP_Trans_Commande
			SELECT t_Commande.cieno,
					 t_Commande.nocommande,
					 t_Commande.no_eleveur,
					 t_Commande.nobonexpe,
					 t_Commande.boncommandeclient,
					 t_Commande.datecommande,
					 t_Commande.novendeur,
					 t_Commande.codetransport,
					 t_Commande.livrampm,
					 t_Commande.traiter,
					 t_Commande.imprimer,
					 t_Commande.facture,
					 t_Commande.datefacturation,
					 t_Commande.nofacture,
					 t_Commande.tauxtaxefederale,
					 t_Commande.tauxtaxeprovinciale,
					 t_Commande.repeat,
					 t_Commande.reste,
					 replace(replace(replace(t_Commande.message_commande, ',', ''), :ls_app, ''),';',''),
					 t_Commande.repartition,
					 t_Commande.locked,
					 t_Commande.duplication,
					 t_Commande.transferepar,
					 t_Commande.norepeat,
					 t_Commande.lockedby
			FROM	 t_Commande
         WHERE t_Commande.CieNo = :ls_cie AND t_Commande.NoCommande = :ls_nocommande;
			IF SQLCA.SQLCode <> 0 then
				gnv_app.inv_error.of_message("CIPQ0152",{"Insertion dans #TMP_Trans_Commande", SQLCA.SQLeRRText})
			ELSE
				COMMIT USING SQLCA;
				IF SQLCA.SQLCode <> 0 then
					gnv_app.inv_error.of_message("CIPQ0152",{"Insertion dans #TMP_Trans_Commande", SQLCA.SQLeRRText})
				END IF
			END IF
			
			INSERT 	INTO #TMP_Trans_CommandeDetail 
			SELECT 	t_CommandeDetail.cieno,
						t_CommandeDetail.nocommande,
						t_CommandeDetail.noligne,
						t_CommandeDetail.noproduit,
						t_CommandeDetail.codeverrat,
						t_CommandeDetail.qtecommande,
						t_CommandeDetail.qteexpedie,
						replace(replace(t_CommandeDetail.melange, ',', ''), :ls_app, ''),
						replace(replace(t_CommandeDetail.description, ',', ''), :ls_app, ''),
						t_CommandeDetail.transfcommande,
						t_CommandeDetail.noligneheader,
						t_CommandeDetail.choix,
						t_CommandeDetail.tranname,
						t_CommandeDetail.trans,
						t_CommandeDetail.fixe,
						t_CommandeDetail.repartition,
						t_CommandeDetail.qteinit,
						t_CommandeDetail.qtetransfert,
						t_CommandeDetail.noitem,
						t_CommandeDetail.compteur,
						t_CommandeDetail.norepeat
			FROM		t_CommandeDetail
			WHERE 	t_CommandeDetail.CieNo = :ls_cie AND t_CommandeDetail.NoCommande = :ls_nocommande
			AND 		(t_CommandeDetail.TranName Is Null) AND t_CommandeDetail.Trans  = :ls_prefnom;
			IF SQLCA.SQLCode <> 0 then
				gnv_app.inv_error.of_message("CIPQ0152",{"Insertion dans #TMP_Trans_CommandeDetail", SQLCA.SQLeRRText})
			ELSE
				COMMIT USING SQLCA;
				IF SQLCA.SQLCode <> 0 then
					gnv_app.inv_error.of_message("CIPQ0152",{"Insertion dans #TMP_Trans_CommandeDetail", SQLCA.SQLeRRText})
				END IF
			END IF	
			
			//les inscriptions $$HEX2$$e0002000$$ENDHEX$$imprimer batch
			ls_ecrire = ls_ecrire + THIS.of_dosavetoprinter(ls_cie, ls_nocommande, ls_ciecentre) 
			
			//On v$$HEX1$$e900$$ENDHEX$$rifie les qt$$HEX1$$e900$$ENDHEX$$s command$$HEX1$$e900$$ENDHEX$$es, exp$$HEX1$$e900$$ENDHEX$$di$$HEX1$$e900$$ENDHEX$$es et transf$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es
			SELECT 
			SUM(QteInit),
			SUM(QteCommande),
			SUM(QteExpedie),
			SUM(QteTransfert)
			INTO :ldec_QteInit, :ldec_QteCommande, :ldec_QteExpedie, :ldec_QteTransfertTot
			FROM t_commandedetail
			WHERE CIENO = :ls_cie AND NoCommande = :ls_nocommande ;
			IF SQLCA.SQLCode < 0 then
				gnv_app.inv_error.of_message("CIPQ0152",{"SELECT de Sum1 - of_transfert - inter-centre", SQLCA.SQLeRRText})
			END IF			
			
			SELECT SUM(QteTransfert)
			INTO :ldec_QteTransfert
			FROM t_commandedetail
			WHERE CIENO = :ls_cie AND NoCommande = :ls_nocommande AND Trans = :ls_prefnom ;
			IF SQLCA.SQLCode < 0 then
				gnv_app.inv_error.of_message("CIPQ0152",{"SELECT de Sum2 - of_transfert - inter-centre", SQLCA.SQLeRRText})
			END IF			

			//MAJ de Transf$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$Par
			UPDATE #TMP_Trans_Commande 
			SET 	#TMP_Trans_Commande.TransferePar = CieNo, #TMP_Trans_Commande.CieNo = :ls_ciecentre
			WHERE #TMP_Trans_Commande.CieNo = :ls_cie AND #TMP_Trans_Commande.NoCommande = :ls_nocommande;
			IF SQLCA.SQLCode <> 0 then
				gnv_app.inv_error.of_message("CIPQ0152",{"Update de #TMP_Trans_Commande", SQLCA.SQLeRRText})
			ELSE
				COMMIT USING SQLCA;
				IF SQLCA.SQLCode <> 0 then
					gnv_app.inv_error.of_message("CIPQ0152",{"Update de #TMP_Trans_Commande", SQLCA.SQLeRRText})
				END IF
			END IF	
			
			UPDATE #TMP_Trans_CommandeDetail 
			SET 	#TMP_Trans_CommandeDetail.CieNo = :ls_ciecentre
			WHERE #TMP_Trans_CommandeDetail.CieNo = :ls_cie AND #TMP_Trans_CommandeDetail.NoCommande = :ls_nocommande;
			IF SQLCA.SQLCode <> 0 then
				gnv_app.inv_error.of_message("CIPQ0152",{"Update de #TMP_Trans_CommandeDetail 1", SQLCA.SQLeRRText})
			ELSE
				COMMIT USING SQLCA;
				IF SQLCA.SQLCode <> 0 then
					gnv_app.inv_error.of_message("CIPQ0152",{"Update de #TMP_Trans_CommandeDetail 1", SQLCA.SQLeRRText})
				END IF
			END IF	
			
			//MAJ des qt$$HEX2$$e9002000$$ENDHEX$$initiale, command$$HEX2$$e9002000$$ENDHEX$$et transf$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$
			UPDATE 	#TMP_Trans_CommandeDetail 
			SET 		#TMP_Trans_CommandeDetail.QteInit = If QteExpedie >0 then 0 else QteInit endif, 
						#TMP_Trans_CommandeDetail.QteCommande = QteTransfert, 
						#TMP_Trans_CommandeDetail.QteExpedie = 0, 
						#TMP_Trans_CommandeDetail.QteTransfert = 0, 
						#TMP_Trans_CommandeDetail.TransfCommande = Null, 
						#TMP_Trans_CommandeDetail.Trans = Null 
			WHERE 	#TMP_Trans_CommandeDetail.CieNo = :ls_ciecentre
						AND #TMP_Trans_CommandeDetail.NoCommande = :ls_nocommande ;
			IF SQLCA.SQLCode <> 0 then
				gnv_app.inv_error.of_message("CIPQ0152",{"Update de #TMP_Trans_CommandeDetail 2", SQLCA.SQLeRRText})
			ELSE
				COMMIT USING SQLCA;
				IF SQLCA.SQLCode <> 0 then
					gnv_app.inv_error.of_message("CIPQ0152",{"Update de #TMP_Trans_CommandeDetail 2", SQLCA.SQLeRRText})
				END IF
			END IF	
			
			//Si toute la commande est transf$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e: (le total des Qt$$HEX1$$e900$$ENDHEX$$Init= au total des qt$$HEX1$$e900$$ENDHEX$$s transf$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$) 
			// et (le total des qt$$HEX1$$e900$$ENDHEX$$s en commande=0) on va la consid$$HEX1$$e900$$ENDHEX$$rer comme trait$$HEX1$$e900$$ENDHEX$$e et comme imprim$$HEX1$$e900$$ENDHEX$$e
			// et ne sera jamais factur$$HEX1$$e900$$ENDHEX$$e
			If ldec_QteInit = ldec_QteTransfertTot Then
				UPDATE t_Commande SET t_Commande.Traiter = 1, t_Commande.Imprimer = 1 
				WHERE t_Commande.CieNo = :ls_cie AND t_Commande.NoCommande = :ls_nocommande ;
				IF SQLCA.SQLCode <> 0 then
					gnv_app.inv_error.of_message("CIPQ0152",{"Commande toute transf$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e", SQLCA.SQLeRRText})
				ELSE
					COMMIT USING SQLCA;
					IF SQLCA.SQLCode <> 0 then
						gnv_app.inv_error.of_message("CIPQ0152",{"Commande toute transf$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e", SQLCA.SQLeRRText})
					END IF
				END IF	
			End If
			
		END FOR

		//Les donn$$HEX1$$e900$$ENDHEX$$es sont pr$$HEX1$$e900$$ENDHEX$$par$$HEX1$$e900$$ENDHEX$$es, on pr$$HEX1$$e900$$ENDHEX$$pare l'export
		
		
		//Ajouter les commandes
		lds_Tmplt_Commande.Retrieve()
		//Le saveas $$HEX1$$e900$$ENDHEX$$crase le fichier et ajoute une entete avec le create
		lds_Tmplt_Commande.SaveAs("Z:\cipq\tempo.txt", SQLInsert!, FALSE)
		ls_string = ""
		DO WHILE YIELD()
		LOOP
		IF FileExists("Z:\cipq\tempo.txt") THEN
			li_FileNum = FileOpen("Z:\cipq\tempo.txt", TextMode!)
			IF li_FileNum = -1 THEN
				gnv_app.inv_error.of_message("CIPQ0151",{"Ouverture de fichier", "Z:\cipq\tempo.txt", "of_transfert 1 (inter-centre)"})
			END IF			
			FileReadEX(li_FileNum, ls_string)
			FileClose(li_FileNum)
			
			//Ajuster le contenu du export
			ls_string = gnv_app.inv_string.of_globalreplace( ls_string, "tempo", "t_commande")
			ls_string = gnv_app.inv_string.of_globalreplace( ls_string, "~r~n", "")
			ls_string = gnv_app.inv_string.of_globalreplace( ls_string, ";", ";~r~n")
			
			ll_pos = POS(ls_string, "INSERT")
			IF ll_pos > 0 THEN
				ls_string = MID(ls_string, ll_pos)
			ELSE
				ls_string = ""
			END IF
			
			DO WHILE YIELD()
			LOOP
			
		ELSE
			gnv_app.inv_error.of_message("CIPQ0153", {"Z:\cipq\tempo.txt", "of_transfert B" })
		END IF
		ls_ecrire = ls_ecrire + "~r~n" + ls_string + " "
				
		//Ajouter les commandes d$$HEX1$$e900$$ENDHEX$$tail
		ll_rowcount_temp = lds_Tmplt_CommandeDetail.Retrieve()
		
		//Validation parce qu'il n'y a pas de ligne
		IF ll_rowcount_temp = 0 AND ll_rowcount_a > 0 THEN
			Messagebox("Attention", "Il y a des commandes $$HEX2$$e0002000$$ENDHEX$$transf$$HEX1$$e900$$ENDHEX$$rer mais il n'y a pas de d$$HEX1$$e900$$ENDHEX$$tail. Cette situation est irr$$HEX1$$e900$$ENDHEX$$guli$$HEX1$$e800$$ENDHEX$$re et il se peut que ces commandes ne se soient pas transf$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es correctement.")
		END IF
		
		//Le saveas $$HEX1$$e900$$ENDHEX$$crase le fichier et ajoute une entete avec le create
		lds_Tmplt_CommandeDetail.SaveAs("Z:\cipq\tempo.txt", SQLInsert!, FALSE)
		ls_string = ""
		DO WHILE YIELD()
		LOOP
		
		IF FileExists("Z:\cipq\tempo.txt") THEN
			li_FileNum = FileOpen("Z:\cipq\tempo.txt", TextMode!)
			IF li_FileNum = -1 THEN
				gnv_app.inv_error.of_message("CIPQ0151",{"Ouverture de fichier", "Z:\cipq\tempo.txt", "of_transfert (inter-centre)"})
			END IF
			
			FileReadEX(li_FileNum, ls_string)
			FileClose(li_FileNum)
			
			//Ajuster le contenu du export
			ls_string = gnv_app.inv_string.of_globalreplace( ls_string, "tempo", "t_commandedetail")
			ls_string = gnv_app.inv_string.of_globalreplace( ls_string, "~r~n", "")
			ls_string = gnv_app.inv_string.of_globalreplace( ls_string, "~;", ";~r~n")
			
			ll_pos = POS(ls_string, "INSERT")
			IF ll_pos > 0 THEN
				ls_string = MID(ls_string, ll_pos)
			ELSE
				ls_string = ""
			END IF
			
			DO WHILE YIELD()
			LOOP
			
		ELSE
			gnv_app.inv_error.of_message("CIPQ0153", {"Z:\cipq\tempo.txt", "of_transfert C" })
		END IF
		ls_ecrire = ls_ecrire + "~r~n" + ls_string + " "
		
		//Cr$$HEX1$$e900$$ENDHEX$$er le fichier
		ls_NameInit = ls_ciecentre + "C" + string(month(today()),'00') + string(day(today()),'00') + & 
			string(year(today()),'0000') + string(hour(now()),'00') + string(minute(now()),'00') + & 
			string(second(now()),'00') + ".txt" 

		IF trim(ls_ecrire) <> "" AND TRIM(gnv_app.inv_string.of_globalreplace( ls_ecrire, "~r~n", "")) <> "" THEN
			ll_taille_fich = len(ls_ecrire) + 16
			ls_ecrire = gnv_app.inv_string.of_padleft(string(ll_taille_fich) + '~r~n', 16) + ls_ecrire
			
			ll_rtn = gnv_app.inv_filesrv.of_filewrite( ls_repexport + "TMP_" + ls_NameInit, ls_ecrire )
			IF ll_rtn < 0 THEN
				gnv_app.inv_error.of_message("CIPQ0151",{"$$HEX1$$c900$$ENDHEX$$criture du fichier de transfert", ls_repexport + "TMP_" +ls_NameInit, "of_transfert (inter-centre)"})
			ELSE
				//Renommer le fichier
				ll_rtn = gnv_app.inv_filesrv.of_filerename( ls_repexport + "TMP_" + ls_NameInit, ls_repexport + ls_NameInit)
				IF ll_rtn < 0 THEN
					gnv_app.inv_error.of_message("CIPQ0151",{"$$HEX1$$c900$$ENDHEX$$criture du fichier de transfert - rename", ls_repexport + ls_NameInit, "of_transfert (inter-centre)"})
				END IF
			END IF
		END IF
		
		DO WHILE YIELD()
		LOOP
		
		//Mise $$HEX2$$e0002000$$ENDHEX$$jour des $$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ments transf$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$s pour ce centre
		UPDATE #TMP_Trans_CommandeDetail SET #TMP_Trans_CommandeDetail.TranName = :ls_NameInit ;
		IF SQLCA.SQLCode <> 0 then
			gnv_app.inv_error.of_message("CIPQ0152",{"Mise $$HEX2$$e0002000$$ENDHEX$$jour des $$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ments transf$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$s pour ce centre", SQLCA.SQLeRRText})
		ELSE
			COMMIT USING SQLCA;
			IF SQLCA.SQLCode <> 0 then
				gnv_app.inv_error.of_message("CIPQ0152",{"Mise $$HEX2$$e0002000$$ENDHEX$$jour des $$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ments transf$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$s pour ce centre", SQLCA.SQLeRRText})
			END IF
		END IF
		
		UPDATE t_CommandeDetail 
		INNER JOIN #TMP_Trans_CommandeDetail 
		ON (t_CommandeDetail.NoLigne = #TMP_Trans_CommandeDetail.NoLigne) 
		AND (t_CommandeDetail.NoCommande = #TMP_Trans_CommandeDetail.NoCommande)
			SET t_CommandeDetail.TranName = #TMP_Trans_CommandeDetail.TranName;
		IF SQLCA.SQLCode <> 0 then
			gnv_app.inv_error.of_message("CIPQ0152",{"2 - Mise $$HEX2$$e0002000$$ENDHEX$$jour des $$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ments transf$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$s pour ce centre", SQLCA.SQLeRRText})
		ELSE
			COMMIT USING SQLCA;
			IF SQLCA.SQLCode <> 0 then
				gnv_app.inv_error.of_message("CIPQ0152",{"2 - Mise $$HEX2$$e0002000$$ENDHEX$$jour des $$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ments transf$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$s pour ce centre", SQLCA.SQLeRRText})
			END IF
		END IF
		
		ldt_heure = datetime(today(),now())
		
		INSERT INTO t_TransfertCommande ( CieNo, NoCommande, No_Eleveur, DateCommande, NoLigne, NoProduit, CodeVerrat, QteTransfert, NoLigneHeader, Choix, NoItem, NomFichier, HeureTransfert ) 
		SELECT 
					#TMP_Trans_CommandeDetail.CieNo, 
					#TMP_Trans_CommandeDetail.NoCommande, 
					#TMP_Trans_Commande.No_Eleveur, 
					#TMP_Trans_Commande.DateCommande, 
					#TMP_Trans_CommandeDetail.NoLigne, 
					#TMP_Trans_CommandeDetail.NoProduit, 
					#TMP_Trans_CommandeDetail.CodeVerrat, 
					#TMP_Trans_CommandeDetail.QteCommande, 
					#TMP_Trans_CommandeDetail.NoLigneHeader, 
					#TMP_Trans_CommandeDetail.Choix, 
					#TMP_Trans_CommandeDetail.NoItem, 
					#TMP_Trans_CommandeDetail.TranName, 
					:ldt_heure
		FROM #TMP_Trans_Commande 
		INNER JOIN #TMP_Trans_CommandeDetail 
		ON (#TMP_Trans_Commande.NoCommande = #TMP_Trans_CommandeDetail.NoCommande) 
		AND (#TMP_Trans_Commande.CieNo = #TMP_Trans_CommandeDetail.CieNo);		
		IF SQLCA.SQLCode <> 0 then
			gnv_app.inv_error.of_message("CIPQ0152",{"Insert dans t_TransfertCommande (of_transfert)", SQLCA.SQLeRRText})
		ELSE
			COMMIT USING SQLCA;
			IF SQLCA.SQLCode <> 0 then
				gnv_app.inv_error.of_message("CIPQ0152",{"Insert dans t_TransfertCommande (of_transfert)", SQLCA.SQLeRRText})
			END IF
		END IF
		
		DO WHILE YIELD()
		LOOP
		
	END FOR
	IF IsValid(lds_centres_transferables) THEN Destroy(lds_centres_transferables)
	IF IsValid(lds_commandes_a_transferer) THEN Destroy(lds_commandes_a_transferer)
	IF IsValid(lds_Tmplt_Commande) THEN Destroy(lds_Tmplt_Commande)
	IF IsValid(lds_Tmplt_CommandeDetail) THEN Destroy(lds_Tmplt_CommandeDetail)
		
END IF

IF FileExists("Z:\cipq\tempo.txt") THEN
	FileDelete("Z:\cipq\tempo.txt")
END IF

RETURN
end subroutine

public function string of_dosavetoprinter (string as_cie, string as_nocommande, string as_cietransfertto);//of_DoSaveToPrinter

string	ls_retour = "", ls_description = "", ls_produit, ls_verrat, ls_desc_to
long		ll_cpt_commandedetail, ll_no_eleveur, ll_qte_transfert
n_ds		lds_Tmplt_Commande, lds_Tmplt_CommandeDetail
date		ld_datecommande

//Pr$$HEX1$$e900$$ENDHEX$$parer les datastores
lds_Tmplt_Commande = CREATE n_ds
lds_Tmplt_Commande.dataobject = "ds_Tmplt_Commande_specifique"
lds_Tmplt_Commande.of_setTransobject(SQLCA)

lds_Tmplt_CommandeDetail = CREATE n_ds
lds_Tmplt_CommandeDetail.dataobject = "ds_Tmplt_CommandeDetail_specifique"
lds_Tmplt_CommandeDetail.of_setTransobject(SQLCA)

lds_Tmplt_Commande.Retrieve(as_cie, as_nocommande)
IF lds_Tmplt_Commande.RowCount() > 0 THEN
	//Impression sur centre futur
	ls_retour = ls_retour + "INSERT INTO Tmp_ImpressionCommande ( DescriptionCommande) VALUES (" +&
		"'Commandes transf$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es par : " + as_cie + "'); ~r~n"
	
	//Impression sur centre en cours
	ls_desc_to = 'Commandes transf$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es $$HEX1$$e000$$ENDHEX$$: ' + as_cietransfertto 	
	INSERT INTO Tmp_ImpressionCommande ( DescriptionCommande) 
	VALUES (:ls_desc_to);
	
	IF SQLCA.SQLCode <> 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"Insertion dans le backup papier", SQLCA.SQLeRRText})
	ELSE
		COMMIT USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			gnv_app.inv_error.of_message("CIPQ0152",{"Insertion dans le backup papier", SQLCA.SQLeRRText})
		END IF
	END IF
	
	lds_Tmplt_CommandeDetail.Retrieve(as_cie, as_nocommande)
	
	ld_datecommande = date(lds_Tmplt_Commande.object.datecommande[1])
	ll_no_eleveur = lds_Tmplt_Commande.object.no_eleveur[1]
	FOR ll_cpt_commandedetail = 1 TO lds_Tmplt_CommandeDetail.RowCount()
		
		ll_qte_transfert = lds_Tmplt_CommandeDetail.object.qtetransfert[ll_cpt_commandedetail]
		ls_produit = lds_Tmplt_CommandeDetail.object.noproduit[ll_cpt_commandedetail]
		ls_verrat = lds_Tmplt_CommandeDetail.object.codeverrat[ll_cpt_commandedetail]
		
		ls_description = string(ld_datecommande) + "; " + string(now(), "hh:mm:ss") + "; " + string(ll_no_eleveur) + &
			"; NoComm-: " +as_cie + ":" + as_nocommande + ";NoComm: Nouveau_numero; Trans: " + string(ll_qte_transfert)
			
		IF Not IsNull(ls_produit) THEN
			ls_description = ls_description + " " + ls_produit
		END IF

		IF Not IsNull(ls_verrat) THEN
			ls_description = ls_description + " Verrat: " + ls_verrat
		END IF
		
		//Impression sur centre futur
		ls_retour = ls_retour + "INSERT INTO Tmp_ImpressionCommande ( DescriptionCommande) VALUES (" + &
				"'" + ls_description + "'); ~r~n"
		
		//Impression sur centre en cours
		INSERT INTO Tmp_ImpressionCommande ( DescriptionCommande) 
		VALUES (:ls_description);
		IF SQLCA.SQLCode <> 0 then
			gnv_app.inv_error.of_message("CIPQ0152",{"Insertion dans le backup papier - d$$HEX1$$e900$$ENDHEX$$tail", SQLCA.SQLeRRText})
		ELSE
			COMMIT USING SQLCA;
			IF SQLCA.SQLCode <> 0 then
				gnv_app.inv_error.of_message("CIPQ0152",{"Insertion dans le backup papier - d$$HEX1$$e900$$ENDHEX$$tail", SQLCA.SQLeRRText})
			END IF
		END IF
		
	END FOR
	
END IF


If IsValid(lds_Tmplt_Commande) THEN Destroy(lds_Tmplt_Commande)
IF IsValid(lds_Tmplt_CommandeDetail) THEN Destroy(lds_Tmplt_CommandeDetail)

RETURN ls_retour
end function

public subroutine of_transfert_recolte_commande ();//of_transfert_recolte_commande
string 	ls_retour, ls_repexport, ls_nomfichier, ls_string, ls_ecrire
n_ds		lds_t_recolte_112, lds_t_recolte_commande_112
long		ll_cpt, ll_nbligne, ll_pos, ll_rtn
int		li_FileNum
datetime	ldt_cur

//V$$HEX1$$e900$$ENDHEX$$rifier si le transfert est suspendu
ls_retour = gnv_app.of_getvaleurini( "FTP", "Transfert_Commande")
IF upper(ls_retour) <> "TRUE" THEN
	gnv_app.inv_error.of_message("CIPQ0138")
	RETURN
END IF

//V$$HEX1$$e900$$ENDHEX$$rifier le r$$HEX1$$e900$$ENDHEX$$pertoire d'exportation
ls_repexport = gnv_app.of_getvaleurini( "FTP", "EXPORTPATH")
IF LEN(ls_repexport) > 0 THEN
	IF NOT FileExists(ls_repexport) THEN
		gnv_app.inv_error.of_message("CIPQ0139")
		RETURN
	END IF
ELSE
	gnv_app.inv_error.of_message("CIPQ0140")
	RETURN
END IF

IF RIGHT(ls_repexport, 1) <> "\" THEN
	ls_repexport += "\"
END IF

//On cr$$HEX1$$e900$$ENDHEX$$er le fichier pour 111 dans le r$$HEX1$$e900$$ENDHEX$$pertoire de transfert
ls_nomfichier = "111R" + string(month(today()),'00') + string(day(today()),'00') + & 
	string(year(today()),'0000') + string(hour(now()),'00') + string(minute(now()),'00') + & 
	string(second(now()),'00') + ".txt" 
	
//On y transfert les donn$$HEX1$$e900$$ENDHEX$$es
	//Pr$$HEX1$$e900$$ENDHEX$$parer les datastores
lds_t_recolte_112 = CREATE n_ds
lds_t_recolte_112.dataobject = "ds_t_recolte_112"
lds_t_recolte_112.of_setTransobject(SQLCA)
ll_nbligne = lds_t_recolte_112.retrieve()
IF ll_nbligne > 0 THEN
	lds_t_recolte_112.SaveAs("Z:\cipq\tempo.txt", SQLInsert!, FALSE)
	ls_string = ""
	IF FileExists("Z:\cipq\tempo.txt") THEN
		li_FileNum = FileOpen("Z:\cipq\tempo.txt", TextMode!)
		IF li_FileNum = -1 THEN
			gnv_app.inv_error.of_message("CIPQ0151",{"Ouverture de fichier", "Z:\cipq\tempo.txt", "1 of_transfert recolte (inter-centre)"})
		END IF		
		FileReadEX(li_FileNum, ls_string)
		FileClose(li_FileNum)
		
		//Ajuster le contenu du export
		ls_string = gnv_app.inv_string.of_globalreplace( ls_string, "tempo", "t_recolte_112")
		ls_string = gnv_app.inv_string.of_globalreplace( ls_string, "~r~n", "")
		ls_string = gnv_app.inv_string.of_globalreplace( ls_string, "~;", ";~r~n")
		
		ll_pos = POS(ls_string, "INSERT")
		IF ll_pos > 0 THEN
			ls_string = MID(ls_string, ll_pos)
		ELSE
			ls_string = ""
		END IF
		
		DO WHILE YIELD()
		LOOP
	ELSE
		gnv_app.inv_error.of_message("CIPQ0153", {"Z:\cipq\tempo.txt", "of_transfert_recolte_commande 1" })
	END IF
	ls_ecrire = ls_ecrire + "~r~n" + ls_string + " "
	
END IF

lds_t_recolte_commande_112 = CREATE n_ds
lds_t_recolte_commande_112.dataobject = "ds_t_recolte_commande_112"
lds_t_recolte_commande_112.of_setTransobject(SQLCA)
ll_nbligne = lds_t_recolte_commande_112.retrieve()
IF ll_nbligne > 0 THEN
	lds_t_recolte_commande_112.SaveAs("Z:\cipq\tempo.txt", SQLInsert!, FALSE)
	ls_string = ""
	IF FileExists("Z:\cipq\tempo.txt") THEN
		li_FileNum = FileOpen("Z:\cipq\tempo.txt", TextMode!)
		IF li_FileNum = -1 THEN
			gnv_app.inv_error.of_message("CIPQ0151",{"Ouverture de fichier", "Z:\cipq\tempo.txt", "2 of_transfert recolte_commande (inter-centre)"})
		END IF		
		FileReadEX(li_FileNum, ls_string)
		FileClose(li_FileNum)
		
		//Ajuster le contenu du export
		ls_string = gnv_app.inv_string.of_globalreplace( ls_string, "tempo", "t_recolte_commande_112")
		ls_string = gnv_app.inv_string.of_globalreplace( ls_string, "~r~n", "")
		ls_string = gnv_app.inv_string.of_globalreplace( ls_string, "~;", ";~r~n")
		
		ll_pos = POS(ls_string, "INSERT")
		IF ll_pos > 0 THEN
			ls_string = MID(ls_string, ll_pos)
		ELSE
			ls_string = ""
		END IF
		
		DO WHILE YIELD()
		LOOP
	ELSE
		gnv_app.inv_error.of_message("CIPQ0153", {"Z:\cipq\tempo.txt", "of_transfert_recolte_commande 2" })
	END IF
	ls_ecrire = ls_ecrire + "~r~n" + ls_string + " "

END IF

IF trim(ls_ecrire) <> "" AND TRIM(gnv_app.inv_string.of_globalreplace( ls_ecrire, "~r~n", "")) <> "" THEN
	ls_ecrire = ls_ecrire + "~r~n" + &
		"UPDATE t_CentreCIPQ SET LastDate_rptRecolteCommande = Now(*) WHERE t_CentreCIPQ.CIE = '111' ;"
	
	ll_rtn = gnv_app.inv_filesrv.of_filewrite( ls_repexport + "TMP_" + ls_nomfichier, ls_ecrire )
	IF ll_rtn < 0 THEN
		gnv_app.inv_error.of_message("CIPQ0151",{"$$HEX1$$c900$$ENDHEX$$criture du fichier de transfert", ls_repexport + "TMP_" + ls_nomfichier, "of_transfert_recolte_commande (inter-centre)"})
	ELSE
		//Renommer le fichier
		ll_rtn = gnv_app.inv_filesrv.of_filerename( ls_repexport + "TMP_" + ls_nomfichier, ls_repexport + ls_nomfichier)
		IF ll_rtn < 0 THEN
			gnv_app.inv_error.of_message("CIPQ0151",{"$$HEX1$$c900$$ENDHEX$$criture du fichier de transfert - rename", ls_repexport + "TMP_" + ls_nomfichier, "of_transfert_recolte_commande (inter-centre)"})
		END IF
		
	END IF

	DO WHILE YIELD()
	LOOP
	
	
	ldt_cur = datetime(Today(), now())
	
	//Validation pour la r$$HEX1$$e900$$ENDHEX$$ceptions du fichier des r$$HEX1$$e900$$ENDHEX$$coltes
	INSERT INTO t_TransfertCommande ( CieNo, DateCommande, NomFichier, HeureTransfert )
	VALUES ('111', :ldt_cur, :ls_nomfichier, :ldt_cur);
	IF SQLCA.SQLCode <> 0 then
		gnv_app.inv_error.of_message("CIPQ0152",{"Validation pour la r$$HEX1$$e900$$ENDHEX$$ceptions du fichier des r$$HEX1$$e900$$ENDHEX$$coltes", SQLCA.SQLeRRText})
	ELSE
		COMMIT USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			gnv_app.inv_error.of_message("CIPQ0152",{"Validation pour la r$$HEX1$$e900$$ENDHEX$$ceptions du fichier des r$$HEX1$$e900$$ENDHEX$$coltes", SQLCA.SQLeRRText})
		END IF
	END IF
	
ELSE
	gnv_app.inv_error.of_message("CIPQ0159")

END IF

DO WHILE YIELD()
LOOP


IF IsValid(lds_t_recolte_commande_112) THEN Destroy(lds_t_recolte_commande_112)
IF IsValid(lds_t_recolte_112) THEN Destroy(lds_t_recolte_112)

RETURN
end subroutine

public subroutine of_importfichier ();//of_importfichier

string 	ls_repexport, ls_repimport, ls_repimportold, ls_contenu, ls_ligne[], ls_array_value[], &
			ls_value, ls_newnocommande, ls_newcentre, ls_null[], ls_oldnocommande, ls_oldcentre, &
			ls_ConfirmationFile, ls_ecrire, ls_ancien_no_boucle[], ls_nouveau_no_boucle[], ls_null_array[], &
			ls_ReplImpDir, ls_nom_fichier, ls_fichier, ls_ext
long		ll_cpt, ll_nbligne, ll_cpt_ligne, ll_nbligne_valeur, ll_rtn, ll_cpt_array_cherche
integer	li_FileNum, li_debutboucle
datetime	ldt_reception
boolean	lb_traiter_fichier

SetPointer(HourGlass!)

//V$$HEX1$$e900$$ENDHEX$$rifier le r$$HEX1$$e900$$ENDHEX$$pertoire d'exportation
ls_repexport = gnv_app.of_getvaleurini( "FTP", "EXPORTPATH")
IF LEN(ls_repexport) > 0 THEN
	IF NOT FileExists(ls_repexport) THEN
		gnv_app.inv_error.of_message("CIPQ0139")
		RETURN
	END IF
ELSE
	gnv_app.inv_error.of_message("CIPQ0140")
	RETURN
END IF
IF RIGHT(ls_repexport, 1) <> "\" THEN 	ls_repexport += "\"

//V$$HEX1$$e900$$ENDHEX$$rifier le r$$HEX1$$e900$$ENDHEX$$pertoire d'importation
ls_repimport = gnv_app.of_getvaleurini( "FTP", "IMPORTPATH")
IF LEN(ls_repimport) > 0 THEN
	IF NOT FileExists(ls_repimport) THEN
		gnv_app.inv_error.of_message("CIPQ0142")
		RETURN
	END IF
ELSE
	gnv_app.inv_error.of_message("CIPQ0141")
	RETURN
END IF
IF RIGHT(ls_repimport, 1) <> "\" THEN ls_repimport += "\"

//V$$HEX1$$e900$$ENDHEX$$rifier le r$$HEX1$$e900$$ENDHEX$$pertoire de sauvegarde des fichiers import$$HEX1$$e900$$ENDHEX$$s
ls_repimportold = gnv_app.of_getvaleurini( "FTP", "IMPORTPATHOLD")
IF LEN(ls_repimportold) > 0 THEN
	IF NOT FileExists(ls_repimportold) THEN
		gnv_app.inv_error.of_message("CIPQ0143")
		RETURN
	END IF
ELSE
	gnv_app.inv_error.of_message("CIPQ0144")
	RETURN
END IF
IF RIGHT(ls_repimportold, 1) <> "\" THEN ls_repimportold += "\"

ls_ReplImpDir = gnv_app.of_getvaleurini( "IMPORT", "ImportDir")
If Right(ls_ReplImpDir, 1) <> "\" Then ls_ReplImpDir = ls_ReplImpDir + "\"

//Importer les fichiers
n_cst_dirattrib lnv_dirlistattrib[]
gnv_app.inv_filesrv.of_dirlist( ls_repimport + "*.txt", 0, lnv_dirlistattrib)

FOR ll_cpt = 1 TO UpperBound(lnv_dirlistattrib)
	
	SetPointer(HourGlass!)
	
	lb_traiter_fichier = true
	
	ls_ancien_no_boucle[] = ls_null_array[]
	ls_nouveau_no_boucle[] = ls_null_array[]
			
	IF LEFT(Upper(lnv_dirlistattrib[ll_cpt].is_filename),3) <> "TMP" and LEFT(Upper(lnv_dirlistattrib[ll_cpt].is_filename),3) <> 'ZIP' THEN
		
		li_FileNum = FileOpen(ls_repimport + lnv_dirlistattrib[ll_cpt].is_filename, TextMode!)
		IF li_FileNum = -1 THEN
			gnv_app.inv_error.of_message("CIPQ0151",{"Ouverture de fichier", ls_repimport + lnv_dirlistattrib[ll_cpt].is_filename, "Importation de fichier (inter-centre)"})
		END IF
		FileReadEX(li_FileNum, ls_contenu)
		FileClose(li_FileNum)
		
		ls_contenu = TRIM(ls_contenu)
		
		CHOOSE CASE UPPER(MID(lnv_dirlistattrib[ll_cpt].is_filename, 4,1))
			CASE "C" //Fichier de commande
				//Pr$$HEX1$$e900$$ENDHEX$$parer le fichier
				ls_ligne = ls_null
				ll_nbligne = gnv_app.inv_string.of_parsetoarray( ls_contenu, "~r~n", ls_ligne)
				
				// V$$HEX1$$e900$$ENDHEX$$rifier si on a l'enti$$HEX1$$e800$$ENDHEX$$ret$$HEX2$$e9002000$$ENDHEX$$du fichier
				ls_ligne[1] = trim(ls_ligne[1])
				if isNumber(ls_ligne[1]) then
					if gnv_app.inv_filesrv.of_getFileSize(ls_repimport + lnv_dirlistattrib[ll_cpt].is_filename) <> double(ls_ligne[1]) then
						gnv_app.inv_error.of_message("CIPQ0018",{"L'int$$HEX1$$e900$$ENDHEX$$grit$$HEX2$$e9002000$$ENDHEX$$du fichier de commande ~"" + ls_repimport + lnv_dirlistattrib[ll_cpt].is_filename + "~" est corrompue.~r~n" + &
																			  "Le fichier a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$plac$$HEX2$$e9002000$$ENDHEX$$dans le dossier d'archivage sans $$HEX1$$ea00$$ENDHEX$$tre trait$$HEX1$$e900$$ENDHEX$$."})
						// Pour poursuivre le traitement avec le prochain fichier
						lb_traiter_fichier = false
					else
						li_debutboucle = 2
					end if
				else
					gnv_app.inv_error.of_message("CIPQ0020",{"L'int$$HEX1$$e900$$ENDHEX$$grit$$HEX2$$e9002000$$ENDHEX$$du fichier de commande ~"" + ls_repimport + lnv_dirlistattrib[ll_cpt].is_filename + "~" n'a pas pu $$HEX1$$ea00$$ENDHEX$$tre v$$HEX1$$e900$$ENDHEX$$rifi$$HEX1$$e900$$ENDHEX$$e."})
					li_debutboucle = 1
				end if
				
				if lb_traiter_fichier then
					FOR ll_cpt_ligne = li_debutboucle TO ll_nbligne
						IF ls_ligne[ll_cpt_ligne] <> "" AND NOT ISNULL(ls_ligne[ll_cpt_ligne]) THEN
							
							//Code pour mettre le nouveau num$$HEX1$$e900$$ENDHEX$$ro de commande
							IF POS(upper(ls_ligne[ll_cpt_ligne]), "INSERT INTO T_COMMANDE") > 0 THEN
								//Faire un array des valeurs
								ls_array_value = ls_null
								ll_nbligne_valeur = gnv_app.inv_string.of_parsetoarray( ls_ligne[ll_cpt_ligne], ",", ls_array_value)
								
								IF ll_nbligne_valeur > 1 THEN
									//Trouver le nouveau num$$HEX1$$e900$$ENDHEX$$ro de commande
									ls_newcentre = trim(gnv_app.inv_string.of_globalreplace( ls_array_value[1], "'", ""))
									ls_newcentre = right(ls_newcentre,3)
									
									//R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer l'ancien no de commande 
									ls_oldnocommande = trim(gnv_app.inv_string.of_globalreplace( ls_array_value[2], "'", ""))
									//Enlever le premier caract$$HEX1$$e800$$ENDHEX$$re zarbi
									ls_oldnocommande = MID(ls_oldnocommande, 2)
	
									//Si c'est le detail prendre le num$$HEX1$$e900$$ENDHEX$$ro du p$$HEX1$$e800$$ENDHEX$$re
									IF POS(upper(ls_ligne[ll_cpt_ligne]), "INSERT INTO T_COMMANDEDETAIL") > 0 THEN
										// 2008-10-24 chang$$HEX2$$e9002000$$ENDHEX$$- ls_newnocommande = ls_dernier_numero_commande
										FOR ll_cpt_array_cherche = 1 TO UpperBound(ls_ancien_no_boucle)
											IF ls_ancien_no_boucle[ll_cpt_array_cherche] = ls_oldnocommande THEN
												ls_newnocommande = ls_nouveau_no_boucle[ll_cpt_array_cherche]
												EXIT
											END IF
										END FOR
										
										// On vide le champ melange (la 8e valeur)
										ls_array_value[8] = "''"
									ELSE
										//C'est le p$$HEX1$$e800$$ENDHEX$$re r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer le prochain num$$HEX1$$e900$$ENDHEX$$ro
										ls_newnocommande = string(gnv_app.of_recupererprochainno( ls_newcentre))
										ls_ancien_no_boucle[upperbound(ls_ancien_no_boucle) + 1] = ls_oldnocommande
										ls_nouveau_no_boucle[upperbound(ls_nouveau_no_boucle) + 1] = ls_newnocommande
										
										//vider le locked et le lockedby
										ls_array_value[21] = "'C'"
										ls_array_value[25] = "null)"
									END IF
									
									//Changer la 2i$$HEX1$$e800$$ENDHEX$$me valeur  (le no de commande)
									ls_array_value[2]  = "'" + ls_newnocommande + "'"
									//Refaire le insert
									gnv_app.inv_string.of_arraytostring( ls_array_value, ",", ls_ligne[ll_cpt_ligne])
									
									//Pr$$HEX1$$e900$$ENDHEX$$parer fichier de r$$HEX1$$e900$$ENDHEX$$ponse automatique
									IF ll_nbligne_valeur = 25 THEN //INSERT INTO t_commande
										//Savoir d'o$$HEX3$$f9002000e700$$ENDHEX$$a a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$transf$$HEX1$$e900$$ENDHEX$$rer
										ls_oldcentre = trim(gnv_app.inv_string.of_globalreplace( ls_array_value[23], "'", ""))
										ls_oldcentre = Right(ls_oldcentre,3)
										
										//D$$HEX1$$e900$$ENDHEX$$terminer le nom du fichier
										ls_ConfirmationFile = ls_oldcentre + "K" + string(today(),'mmddyyyy') + &
											string(now(),'hhmmss') + ".txt"
											
										// Ralentir d'une seconde pour ne pas que le prochain fichier ait le m$$HEX1$$ea00$$ENDHEX$$me nom
										Sleep(1)
										
										ldt_reception = datetime(today(),now())
										ls_ecrire = "UPDATE t_TransfertCommande SET Reception = '" + String(ldt_reception, "yyyy-mm-dd hh:mm:ss") + &
											"', NewNoCommande = '" + ls_newnocommande + "' WHERE CIENO = '" + &
											ls_newcentre + "' AND NoCommande = '" + ls_oldnocommande + "' ;"
											
										//D$$HEX1$$e900$$ENDHEX$$terminer ce qui ira dans le fichier
										IF trim(ls_ecrire) <> "" THEN
											ll_rtn = gnv_app.inv_filesrv.of_filewrite( ls_repexport + "TMP_" + ls_ConfirmationFile, ls_ecrire )
											IF ll_rtn < 0 THEN
												gnv_app.inv_error.of_message("CIPQ0151",{"$$HEX1$$c900$$ENDHEX$$criture du fichier de confirmation de transfert de commande", ls_repexport + "TMP_" + ls_ConfirmationFile, "Importation de fichier (inter-centre)"})
											ELSE
												//Renommer le fichier
												ll_rtn = gnv_app.inv_filesrv.of_filerename( ls_repexport + "TMP_" + ls_ConfirmationFile, ls_repexport + ls_ConfirmationFile)
												IF ll_rtn < 0 THEN
													gnv_app.inv_error.of_message("CIPQ0151",{"$$HEX1$$c900$$ENDHEX$$criture du fichier de confirmation de transfert de commande - rename", ls_repexport + ls_ConfirmationFile, "Importation de fichier (inter-centre)"})
												END IF
											END IF
										END IF
										
										DO WHILE YIELD()
										LOOP
										
									END IF
								END IF
								
							END IF
							
							//Rouler le SQL
							IF TRIM(ls_ligne[ll_cpt_ligne]) <> "" THEN
								EXECUTE IMMEDIATE :ls_ligne[ll_cpt_ligne] USING SQLCA;
								IF SQLCA.SQLCode <> 0 then
									gnv_app.inv_error.of_message("CIPQ0152",{"(C) SQL import$$HEX1$$e900$$ENDHEX$$s du fichier: " + lnv_dirlistattrib[ll_cpt].is_filename, SQLCA.SQLeRRText})
								ELSE
									COMMIT USING SQLCA;
									IF SQLCA.SQLCode <> 0 then
										gnv_app.inv_error.of_message("CIPQ0152",{"(C) SQL import$$HEX1$$e900$$ENDHEX$$s du fichier: " + lnv_dirlistattrib[ll_cpt].is_filename, SQLCA.SQLeRRText})
									END IF
								END IF
							END IF
						END IF
					END FOR
				end if
				
			CASE "K", "O"
				//K=confirmation de la r$$HEX1$$e900$$ENDHEX$$ception d'un fichier de commande
				//O=confirmation de la r$$HEX1$$e900$$ENDHEX$$ception d'un fichier de r$$HEX1$$e900$$ENDHEX$$colte/commande
				
				//Simplement rouler le contenu du fichier
				EXECUTE IMMEDIATE :ls_contenu USING SQLCA;
				IF SQLCA.SQLCode <> 0 then
					gnv_app.inv_error.of_message("CIPQ0152",{"(K,O) SQL import$$HEX1$$e900$$ENDHEX$$s du fichier: " + lnv_dirlistattrib[ll_cpt].is_filename, SQLCA.SQLeRRText})
				ELSE
					COMMIT USING SQLCA;
					IF SQLCA.SQLCode <> 0 then
						gnv_app.inv_error.of_message("CIPQ0152",{"(K,O) SQL import$$HEX1$$e900$$ENDHEX$$s du fichier: " + lnv_dirlistattrib[ll_cpt].is_filename, SQLCA.SQLeRRText})
					END IF
				END IF
				
			CASE "T"
				//T=Table de pilotage
				//D$$HEX1$$e900$$ENDHEX$$placer le fichier
				
				// 2009-11-25 S$$HEX1$$e900$$ENDHEX$$bastien Tremblay - passer par des fichier "Tmp"
				
				IF FileExists(ls_ReplImpDir) THEN
					//D$$HEX1$$e900$$ENDHEX$$placer dans old
					ll_rtn = FileCopy(ls_repimport + lnv_dirlistattrib[ll_cpt].is_filename, ls_repimportold + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename)
					IF ll_rtn < 1 THEN
						gnv_app.inv_error.of_message("CIPQ0151",{ls_repimport + lnv_dirlistattrib[ll_cpt].is_filename, ls_repimportold + lnv_dirlistattrib[ll_cpt].is_filename, "Importation de fichier (inter-centre) - D$$HEX1$$e900$$ENDHEX$$placer le fichier dans importold (pilotage)"})
					END IF				
					
					do while yield()
					loop
					
					// Renommer le fichier temporaire pour enlever le pr$$HEX1$$e900$$ENDHEX$$fixe "Tmp" (la copie est termin$$HEX1$$e900$$ENDHEX$$e)
					//V$$HEX1$$e900$$ENDHEX$$rifier si le fichier existe deja
					IF FileExists(ls_repimportold + lnv_dirlistattrib[ll_cpt].is_filename) THEN
						ll_rtn = gnv_app.inv_filesrv.of_filerename(ls_repimportold + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, ls_repimportold + string(hour(now())) + "_" + string(minute(now())) + "_" + lnv_dirlistattrib[ll_cpt].is_filename)
						IF ll_rtn < 1 THEN
							gnv_app.inv_error.of_message("CIPQ0151",{ls_repimportold + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, ls_repimportold + string(hour(now())) + "_" + string(minute(now())) + "_" + lnv_dirlistattrib[ll_cpt].is_filename, "T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$chargement de fichier (inter-centre) - Renommer le fichier dans importold (pilotage)"})
						END IF
					ELSE
						ll_rtn = gnv_app.inv_filesrv.of_filerename(ls_repimportold + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, ls_repimportold + lnv_dirlistattrib[ll_cpt].is_filename)
						IF ll_rtn < 1 THEN
							gnv_app.inv_error.of_message("CIPQ0151",{ls_repimportold + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, ls_repimportold + lnv_dirlistattrib[ll_cpt].is_filename, "T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$chargement de fichier (inter-centre) - Renommer le fichier dans importold (pilotage)"})
						END IF
					END IF
					
					// D$$HEX1$$e900$$ENDHEX$$placer le fichier dans le r$$HEX1$$e900$$ENDHEX$$pertoire de traitement
					
					ll_rtn = FileMove(ls_repimport + lnv_dirlistattrib[ll_cpt].is_filename, ls_ReplImpDir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename)
					IF ll_rtn < 0 THEN
						gnv_app.inv_error.of_message("CIPQ0151",{ls_repimport + lnv_dirlistattrib[ll_cpt].is_filename, ls_ReplImpDir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, "T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$chargement de fichier (inter-centre) - D$$HEX1$$e900$$ENDHEX$$placer le fichier dans recoie (pilotage)"})
					END IF
				
					do while yield()
					loop
					
					// On renomme le fichier pour enlever le pr$$HEX1$$e900$$ENDHEX$$fixe "Tmp" (la copie est termin$$HEX1$$e900$$ENDHEX$$e)
					// V$$HEX1$$e900$$ENDHEX$$rifier si le fichier existe d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$
					if FileExists(ls_ReplImpDir + lnv_dirlistattrib[ll_cpt].is_filename) then
						ll_rtn = lastPos(lnv_dirlistattrib[ll_cpt].is_filename, '.')
						if ll_rtn > 0 then
							ls_fichier = left(lnv_dirlistattrib[ll_cpt].is_filename, ll_rtn - 1)
							ls_ext = mid(lnv_dirlistattrib[ll_cpt].is_filename, ll_rtn)
						else
							ls_fichier = lnv_dirlistattrib[ll_cpt].is_filename
							ls_ext = ""
						end if
						ll_rtn = 0
						
						do
							ll_rtn ++
							ls_nom_fichier = ls_fichier + '-' + string(ll_rtn) + ls_ext
						loop while FileExists(ls_ReplImpDir + ls_nom_fichier)
					else
						ls_nom_fichier = lnv_dirlistattrib[ll_cpt].is_filename
					end if
					
					ll_rtn = gnv_app.inv_filesrv.of_filerename(ls_ReplImpDir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, ls_ReplImpDir + ls_nom_fichier)
					IF ll_rtn < 0 THEN
						gnv_app.inv_error.of_message("CIPQ0151",{ls_ReplImpDir + 'Tmp' + lnv_dirlistattrib[ll_cpt].is_filename, ls_ReplImpDir + ls_nom_fichier, "T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$chargement de fichier (inter-centre) - Renommer le fichier dans recoie (pilotage)"})
					END IF
				ELSE
					gnv_app.inv_error.of_message("CIPQ0150")
				END IF
				
			Case "R" //Fichier de R$$HEX1$$e900$$ENDHEX$$colte_Commande
				
				delete from t_Recolte_112;
				commit using SQLCA;
				delete from t_Recolte_Commande_112;
				commit using SQLCA;
				
				//Rouler le contenu du fichier
				EXECUTE IMMEDIATE :ls_contenu USING SQLCA;
				IF SQLCA.SQLCode <> 0 then
					gnv_app.inv_error.of_message("CIPQ0152",{"(R) SQL import$$HEX1$$e900$$ENDHEX$$s du fichier: " + lnv_dirlistattrib[ll_cpt].is_filename, SQLCA.SQLeRRText})
				ELSE
					COMMIT USING SQLCA;
					IF SQLCA.SQLCode <> 0 then
						gnv_app.inv_error.of_message("CIPQ0152",{"(R) SQL import$$HEX1$$e900$$ENDHEX$$s du fichier: " + lnv_dirlistattrib[ll_cpt].is_filename, SQLCA.SQLeRRText})
					END IF
				END IF
				
				//Pr$$HEX1$$e900$$ENDHEX$$parer la confirmation "O"
				
				//D$$HEX1$$e900$$ENDHEX$$terminer le nom du fichier
				ls_ConfirmationFile = "112O" + string(today(),'mmddyyyy') + string(now(),'hhmmss') + ".txt"
					
				// Ralentir d'une seconde pour ne pas que le prochain fichier ait le m$$HEX1$$ea00$$ENDHEX$$me nom
				Sleep(1)
				
				ldt_reception = datetime(today(),now())
				ls_ecrire = "UPDATE t_TransfertCommande SET Reception = '" + String(ldt_reception, "yyyy-mm-dd hh:mm:ss") + &
					"' WHERE CIENO = '111' AND Upper(NomFichier) = '" + UPPER(lnv_dirlistattrib[ll_cpt].is_filename) + "' ;"
					
				//D$$HEX1$$e900$$ENDHEX$$terminer ce qui ira dans le fichier
				IF trim(ls_ecrire) <> "" THEN
					ll_rtn = gnv_app.inv_filesrv.of_filewrite( ls_repexport + "TMP_" + ls_ConfirmationFile, ls_ecrire )
					IF ll_rtn < 0 THEN
						gnv_app.inv_error.of_message("CIPQ0151",{"$$HEX1$$c900$$ENDHEX$$criture du fichier de confirmation des r$$HEX1$$e900$$ENDHEX$$coltes-commandes", ls_repexport + "TMP_" + ls_ConfirmationFile, "Importation de fichier (inter-centre)"})
					ELSE
						//Renommer le fichier
						ll_rtn = gnv_app.inv_filesrv.of_filerename( ls_repexport + "TMP_" + ls_ConfirmationFile, ls_repexport + ls_ConfirmationFile)
						IF ll_rtn < 0 THEN
							gnv_app.inv_error.of_message("CIPQ0151",{"$$HEX1$$c900$$ENDHEX$$criture du fichier de confirmation des r$$HEX1$$e900$$ENDHEX$$coltes-commandes - rename", ls_repexport + ls_ConfirmationFile, "Importation de fichier (inter-centre)"})
						END IF
					END IF
				END IF
				
		END CHOOSE
	
		do while yield()
		loop
		
		//D$$HEX1$$e900$$ENDHEX$$placer le fichier dans importold
		//En commentaires quand on fait des tests
		If UPPER(MID(lnv_dirlistattrib[ll_cpt].is_filename, 4,1)) <> "T" THEN
			if FileExists(ls_repimportold + lnv_dirlistattrib[ll_cpt].is_filename) THEN
				if FileDelete(ls_repimportold + lnv_dirlistattrib[ll_cpt].is_filename) then
					ll_rtn = FileMove(ls_repimport + lnv_dirlistattrib[ll_cpt].is_filename, ls_repimportold + lnv_dirlistattrib[ll_cpt].is_filename)
					IF ll_rtn < 1 THEN
						gnv_app.inv_error.of_message("CIPQ0151",{ls_repimport + lnv_dirlistattrib[ll_cpt].is_filename, ls_repimportold + lnv_dirlistattrib[ll_cpt].is_filename, "Importation de fichier (inter-centre) - D$$HEX1$$e900$$ENDHEX$$placer le fichier dans importold ($$HEX2$$e0002000$$ENDHEX$$la toute fin)"})
					END IF
				else
					gnv_app.inv_error.of_message("CIPQ0151",{ls_repimport + lnv_dirlistattrib[ll_cpt].is_filename, ls_repimportold + lnv_dirlistattrib[ll_cpt].is_filename, "Importation de fichier (inter-centre) - Essayer de fermer CIPQ Transfert et r$$HEX1$$e900$$ENDHEX$$ouvrir Si l'erreur persiste, d$$HEX1$$e900$$ENDHEX$$placer le fichier dans importold ($$HEX2$$e0002000$$ENDHEX$$la toute fin)"})
				end if
			else
				ll_rtn = FileMove(ls_repimport + lnv_dirlistattrib[ll_cpt].is_filename, ls_repimportold + lnv_dirlistattrib[ll_cpt].is_filename)
				IF ll_rtn < 1 THEN
					gnv_app.inv_error.of_message("CIPQ0151",{ls_repimport + lnv_dirlistattrib[ll_cpt].is_filename, ls_repimportold + lnv_dirlistattrib[ll_cpt].is_filename, "Importation de fichier (inter-centre) - D$$HEX1$$e900$$ENDHEX$$placer le fichier dans importold ($$HEX2$$e0002000$$ENDHEX$$la toute fin)"})
				END IF
			end if
		END IF
	END IF

END FOR

RETURN
end subroutine

public subroutine of_enlevervieuxfichiers ();//of_EnleverVieuxFichiers

//Supprime tous les fichiers dont le FileDateTime est < $$HEX2$$e0002000$$ENDHEX$$15 jours de la date du jour
string 	ls_repimportold, ls_repexportold
boolean	lb_rtn
long		ll_totalitems, ll_cpt

SetPointer(HourGlass!)

//V$$HEX1$$e900$$ENDHEX$$rifier le r$$HEX1$$e900$$ENDHEX$$pertoire de sauvegarde des fichiers import$$HEX1$$e900$$ENDHEX$$s
ls_repimportold = gnv_app.of_getvaleurini( "FTP", "IMPORTPATHOLD")
IF LEN(ls_repimportold) > 0 THEN
	IF NOT FileExists(ls_repimportold) THEN
		gnv_app.inv_error.of_message("CIPQ0143")
		RETURN
	END IF
ELSE
	gnv_app.inv_error.of_message("CIPQ0144")
	RETURN
END IF
IF RIGHT(ls_repimportold, 1) <> "\" THEN ls_repimportold += "\"

//V$$HEX1$$e900$$ENDHEX$$rifier le r$$HEX1$$e900$$ENDHEX$$pertoire d'exportation
ls_repexportold = gnv_app.of_getvaleurini( "FTP", "EXPORTPATHOLD")
IF LEN(ls_repexportold) > 0 THEN
	IF NOT FileExists(ls_repexportold) THEN
		gnv_app.inv_error.of_message("CIPQ0145")
		RETURN
	END IF
ELSE
	gnv_app.inv_error.of_message("CIPQ0146")
	RETURN
END IF
IF RIGHT(ls_repexportold, 1) <> "\" THEN 	ls_repexportold += "\"

n_cst_dirattrib lnv_dirlistattrib[], lnv_vide[]
//Nettoyer IMPORTPATHOLD
gnv_app.inv_filesrv.of_dirlist( ls_repimportold + "*.*", 0, lnv_dirlistattrib)
FOR ll_cpt = 1 TO UpperBound(lnv_dirlistattrib)
	IF POS(UPPER(lnv_dirlistattrib[ll_cpt].is_filename),"TMP") > 0 THEN
		IF lnv_dirlistattrib[ll_cpt].id_creationdate < RelativeDate(today(), -15) THEN
			lb_rtn = FileDelete(ls_repimportold + lnv_dirlistattrib[ll_cpt].is_filename)
			IF lb_rtn = FALSE THEN
				gnv_app.inv_error.of_message("CIPQ0151",{"Destruction", lnv_dirlistattrib[ll_cpt].is_filename, "Nettoyer IMPORTPATHOLD"})
			END IF
		END IF
	ELSEIF lnv_dirlistattrib[ll_cpt].id_creationdate < RelativeDate(today(), -300) THEN
		lb_rtn = FileDelete(ls_repimportold + lnv_dirlistattrib[ll_cpt].is_filename)
		IF lb_rtn = FALSE THEN
			gnv_app.inv_error.of_message("CIPQ0151",{"Destruction", lnv_dirlistattrib[ll_cpt].is_filename, "Nettoyer IMPORTPATHOLD"})
		END IF
	END IF
END FOR

lnv_dirlistattrib = lnv_vide

//Nettoyer EXPORTPATHOLD
gnv_app.inv_filesrv.of_dirlist( ls_repexportold + "*.*", 0, lnv_dirlistattrib)
FOR ll_cpt = 1 TO UpperBound(lnv_dirlistattrib)
	IF POS(UPPER(lnv_dirlistattrib[ll_cpt].is_filename),"TMP") > 0 THEN
		IF lnv_dirlistattrib[ll_cpt].id_creationdate < RelativeDate(today(), -15) THEN
			lb_rtn = FileDelete(ls_repexportold + lnv_dirlistattrib[ll_cpt].is_filename)
			IF lb_rtn = FALSE THEN
				gnv_app.inv_error.of_message("CIPQ0151",{"Destruction", lnv_dirlistattrib[ll_cpt].is_filename, "Nettoyer EXPORTPATHOLD"})
			END IF
		END IF
	ELSEIF lnv_dirlistattrib[ll_cpt].id_creationdate < RelativeDate(today(), -300) THEN
		lb_rtn = FileDelete(ls_repexportold + lnv_dirlistattrib[ll_cpt].is_filename)
		IF lb_rtn = FALSE THEN
			gnv_app.inv_error.of_message("CIPQ0151",{"Destruction", lnv_dirlistattrib[ll_cpt].is_filename, "Nettoyer EXPORTPATHOLD"})
		END IF
	END IF
END FOR


RETURN
end subroutine

on n_cst_transfert_inter_centre.create
call super::create
end on

on n_cst_transfert_inter_centre.destroy
call super::destroy
end on

