﻿$PBExportHeader$w_r_frequence_relle_recolte.srw
forward
global type w_r_frequence_relle_recolte from w_rapport
end type
end forward

global type w_r_frequence_relle_recolte from w_rapport
string title = "Rapport - Fréquence réelle de récolte des verrats selon leur famille"
end type
global w_r_frequence_relle_recolte w_r_frequence_relle_recolte

on w_r_frequence_relle_recolte.create
call super::create
end on

on w_r_frequence_relle_recolte.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;long	ll_nb
string ls_sql
date	ld_de, ld_au

ld_de = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date de"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date de", "")
ld_au = date(gnv_app.inv_entrepotglobal.of_retournedonnee("lien date au"))
gnv_app.inv_entrepotglobal.of_ajoutedonnee("lien date au", "")

SetPointer(Hourglass!)

select count(1) into :ll_nb from #Tmp_Recolte_Famille_Frequence_Reelle;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Tmp_Recolte_Famille_Frequence_Reelle (famille varchar(15) not null,~r~n" + &
													"cie_no varchar(3) not null,~r~n" + &
													"quantite_01 integer null,~r~n" + &
													"quantite_02 integer null,~r~n" + &
													"quantite_03 integer null,~r~n" + &
													"quantite_04 integer null,~r~n" + &
													"quantite_05 integer null,~r~n" + &
													"quantite_06 integer null,~r~n" + &
													"nb_dose_01 integer null,~r~n" + &
													"nb_dose_02 integer null,~r~n" + &
													"nb_dose_03 integer null,~r~n" + &
													"nb_dose_04 integer null,~r~n" + &
													"nb_dose_05 integer null,~r~n" + &
													"nb_dose_06 integer null,~r~n" + &
													"nbdosemoyenne float null,~r~n" + &
													"primary key (famille, cie_no))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Tmp_Recolte_Famille_Frequence_Reelle;
	commit using sqlca;
end if

select count(1) into :ll_nb from #Tmp_recolte;
if SQLCA.SQLCode = -1 then
	ls_sql = "create table #Tmp_recolte (norecolte integer not null,~r~n" + &
													"cie_no varchar(3) not null,~r~n" + &
													"codeverrat varchar(12) not null,~r~n" + &
													"date_recolte datetime null,~r~n" + &
													"volume double null,~r~n" + &
													"absorbance double null,~r~n" + &
													"ampo_total double null,~r~n" + &
													"ampo_faite double null,~r~n" + &
													"type_sem varchar(1) null,~r~n" + &
													"pourc_dechets double null,~r~n" + &
													"prepose integer null,~r~n" + &
													"jeudi varchar(1) null,~r~n" + &
													"concentration double null,~r~n" + &
													"nbr_sperm integer null,~r~n" + &
													"transdate datetime null,~r~n" + &
													"heure_recolte datetime null,~r~n" + &
													"classe varchar(20) null,~r~n" + &
													"motilite_p integer null,~r~n" + &
													"collectis bit null,~r~n" + &
													"exclusif bit null,~r~n" + &
													"gedis bit null,~r~n" + &
													"validation bit null,~r~n" + &
													"heure_analyse datetime null,~r~n" + &
													"ancien_codeverrat varchar(12) null,~r~n" + &
													"heure_edition datetime null,~r~n" + &
													"messagerecolte varchar(150) null,~r~n" + &
													"compteurpunch integer null,~r~n" + &
													"preplaboid integer null,~r~n" + &
													"emplacement varchar(6) null,~r~n" + &
													"type_exclu smallint null,~r~n" + &
													"ivos bit null,~r~n" + &
													"primary key (norecolte, cie_no))"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ai_rec on #Tmp_recolte (norecolte asc,~r~n" + &
																 "cie_no asc,~r~n" + &
																 "codeverrat asc,~r~n" + &
																 "date_recolte asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create clustered index ai_rec_v on #Tmp_recolte (codeverrat asc,~r~n" + &
																				 "date_recolte desc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ix_heure on #Tmp_recolte (norecolte asc,~r~n" + &
																	"cie_no asc,~r~n" + &
																	"date_recolte desc,~r~n" + &
																	"heure_recolte desc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_12_4 on #Tmp_recolte (codeverrat asc,~r~n" + &
																	"exclusif asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_fdsfds_2 on #Tmp_recolte (date_recolte desc,~r~n" + &
																		 "norecolte desc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_poil_4 on #Tmp_recolte (date_recolte asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_poil1_1 on #Tmp_recolte (cie_no asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
	
	ls_sql = "create index ixc_poil1_2 on #Tmp_recolte (codeverrat asc,~r~n" + &
																		"cie_no asc)"
	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
else
	delete from #Tmp_recolte;
	commit using sqlca;
end if

INSERT INTO #Tmp_Recolte 
SELECT 	t_RECOLTE.* 
FROM 		t_RECOLTE 
INNER JOIN t_Verrat_Classe 
ON t_RECOLTE.Classe = t_Verrat_Classe.ClasseVerrat 
WHERE date(t_RECOLTE.DATE_recolte) >= :ld_de And date(t_RECOLTE.DATE_recolte) <= :ld_au ;
COMMIT USING SQLCA;

SetPointer(HourGlass!)

//Ancien Req_tblRecolte_Famille_Frequence_Reelle_Ajout
INSERT INTO #Tmp_Recolte_Famille_Frequence_Reelle 
( Famille, CIE_NO, Quantite_01, Quantite_02, Quantite_03, Quantite_04, Quantite_05, Quantite_06, Nb_Dose_01, Nb_Dose_02, Nb_Dose_03, Nb_Dose_04, Nb_Dose_05, Nb_Dose_06 )

SELECT DISTINCT
t_Verrat_Classe.Famille, 
#Tmp_Recolte.CIE_NO,

isnull((select count(1) from #Tmp_Recolte Temp_t_Recolteqteverrat1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = Temp_t_Recolteqteverrat1.Classe)
where  dow(Temp_t_Recolteqteverrat1.date_recolte) = 1 AND 
Temp_t_Recolteqteverrat1.cie_no = #Tmp_Recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  Temp_t_Recolteqteverrat1.cie_no, t_1.Famille),0) as countverrat1,

isnull((select count(1) from #Tmp_Recolte Temp_t_Recolteqteverrat1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = Temp_t_Recolteqteverrat1.Classe)
where  dow(Temp_t_Recolteqteverrat1.date_recolte) = 2 AND 
Temp_t_Recolteqteverrat1.cie_no = #Tmp_Recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  Temp_t_Recolteqteverrat1.cie_no, t_1.Famille),0) as countverrat2,

isnull((select count(1) from #Tmp_Recolte Temp_t_Recolteqteverrat1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = Temp_t_Recolteqteverrat1.Classe)
where  dow(Temp_t_Recolteqteverrat1.date_recolte) = 3 AND 
Temp_t_Recolteqteverrat1.cie_no = #Tmp_Recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  Temp_t_Recolteqteverrat1.cie_no, t_1.Famille),0) as countverrat3,

isnull((select count(1) from #Tmp_Recolte Temp_t_Recolteqteverrat1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = Temp_t_Recolteqteverrat1.Classe)
where  dow(Temp_t_Recolteqteverrat1.date_recolte) = 4 AND 
Temp_t_Recolteqteverrat1.cie_no = #Tmp_Recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  Temp_t_Recolteqteverrat1.cie_no, t_1.Famille),0) as countverrat4,

isnull((select count(1) from #Tmp_Recolte Temp_t_Recolteqteverrat1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = Temp_t_Recolteqteverrat1.Classe)
where  dow(Temp_t_Recolteqteverrat1.date_recolte) = 5 AND 
Temp_t_Recolteqteverrat1.cie_no = #Tmp_Recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  Temp_t_Recolteqteverrat1.cie_no, t_1.Famille),0) as countverrat5,

isnull((select count(1) from #Tmp_Recolte Temp_t_Recolteqteverrat1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = Temp_t_Recolteqteverrat1.Classe)
where  dow(Temp_t_Recolteqteverrat1.date_recolte) = 6 AND 
Temp_t_Recolteqteverrat1.cie_no = #Tmp_Recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  Temp_t_Recolteqteverrat1.cie_no, t_1.Famille),0) as countverrat6,

isnull((select sum(doses1.AMPO_TOTAL) from #Tmp_Recolte doses1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = doses1.Classe)
where  dow(doses1.date_recolte) = 1 AND 
doses1.cie_no = #Tmp_Recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  doses1.cie_no, t_1.Famille),0) as somdoses1,

isnull((select sum(doses1.AMPO_TOTAL) from #Tmp_Recolte doses1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = doses1.Classe)
where  dow(doses1.date_recolte) = 2 AND 
doses1.cie_no = #Tmp_Recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  doses1.cie_no, t_1.Famille),0) as somdoses2,

isnull((select sum(doses1.AMPO_TOTAL) from #Tmp_Recolte doses1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = doses1.Classe)
where  dow(doses1.date_recolte) = 3 AND 
doses1.cie_no = #Tmp_Recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  doses1.cie_no, t_1.Famille),0) as somdoses3,

isnull((select sum(doses1.AMPO_TOTAL) from #Tmp_Recolte doses1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = doses1.Classe)
where  dow(doses1.date_recolte) = 4 AND 
doses1.cie_no = #Tmp_Recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  doses1.cie_no, t_1.Famille),0) as somdoses4,

isnull((select sum(doses1.AMPO_TOTAL) from #Tmp_Recolte doses1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = doses1.Classe)
where  dow(doses1.date_recolte) = 5 AND 
doses1.cie_no = #Tmp_Recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  doses1.cie_no, t_1.Famille),0) as somdoses5,

isnull((select sum(doses1.AMPO_TOTAL) from #Tmp_Recolte doses1 
INNER JOIN t_Verrat_Classe t_1 ON (t_1.ClasseVerrat = doses1.Classe)
where  dow(doses1.date_recolte) = 6 AND 
doses1.cie_no = #Tmp_Recolte.cie_no AND t_1.Famille = t_Verrat_Classe.Famille
GROUP BY  doses1.cie_no, t_1.Famille),0) as somdoses6

FROM t_Verrat_Classe INNER JOIN #Tmp_Recolte ON (t_Verrat_Classe.ClasseVerrat = #Tmp_Recolte.Classe);

COMMIT USING SQLCA;

ls_sql = "drop table #Tmp_Recolte"
EXECUTE IMMEDIATE :ls_sql USING SQLCA;

SetPointer(HourGlass!)

//Ancien Req_tblRecolte_Famille_Frequence_Reelle_NbDoseMoy_MAJ
UPDATE 
#Tmp_Recolte_Famille_Frequence_Reelle 
SET #Tmp_Recolte_Famille_Frequence_Reelle.NbDoseMoyenne = 
ROUND((cast((isnull(Nb_Dose_01,0)+isnull(Nb_Dose_02,0)+isnull(Nb_Dose_03,0)+isnull(Nb_Dose_04,0)+isnull(Nb_Dose_05,0)+isnull(Nb_Dose_06,0)) as float))/
cast((isnull(Quantite_01,0)+isnull(Quantite_02,0)+isnull(Quantite_03,0)+isnull(Quantite_04,0)+isnull(Quantite_05,0)+isnull(Quantite_06,0)) as float) ,2) ;
COMMIT USING SQLCA;
SetPointer(HourGlass!)

ll_nb = dw_preview.retrieve(ld_de, ld_au)
end event

type dw_preview from w_rapport`dw_preview within w_r_frequence_relle_recolte
string dataobject = "d_r_frequence_relle_recolte"
end type
