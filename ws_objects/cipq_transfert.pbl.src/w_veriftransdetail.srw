$PBExportHeader$w_veriftransdetail.srw
forward
global type w_veriftransdetail from w_sheet_frame
end type
type uo_toolbar from u_cst_toolbarstrip within w_veriftransdetail
end type
type dw_veriftrans from u_dw within w_veriftransdetail
end type
type st_prelevement from statictext within w_veriftransdetail
end type
type st_doseprod from statictext within w_veriftransdetail
end type
type st_doseexp from statictext within w_veriftransdetail
end type
type st_bonliv from statictext within w_veriftransdetail
end type
type st_detbonliv from statictext within w_veriftransdetail
end type
type st_coteprem from statictext within w_veriftransdetail
end type
type st_111 from statictext within w_veriftransdetail
end type
type dw_recherche from u_dw within w_veriftransdetail
end type
type st_112 from statictext within w_veriftransdetail
end type
type st_113 from statictext within w_veriftransdetail
end type
type st_116 from statictext within w_veriftransdetail
end type
type st_115 from statictext within w_veriftransdetail
end type
type st_118 from statictext within w_veriftransdetail
end type
type st_119 from statictext within w_veriftransdetail
end type
type st_114 from statictext within w_veriftransdetail
end type
type st_117 from statictext within w_veriftransdetail
end type
end forward

global type w_veriftransdetail from w_sheet_frame
integer width = 4837
boolean ib_isupdateable = false
uo_toolbar uo_toolbar
dw_veriftrans dw_veriftrans
st_prelevement st_prelevement
st_doseprod st_doseprod
st_doseexp st_doseexp
st_bonliv st_bonliv
st_detbonliv st_detbonliv
st_coteprem st_coteprem
st_111 st_111
dw_recherche dw_recherche
st_112 st_112
st_113 st_113
st_116 st_116
st_115 st_115
st_118 st_118
st_119 st_119
st_114 st_114
st_117 st_117
end type
global w_veriftransdetail w_veriftransdetail

type variables
long il_type, il_centre
date ldt_date
end variables

forward prototypes
public subroutine of_rechercher ()
public function any of_diffarray (any aa_tab1[], any aa_tab2[])
end prototypes

public subroutine of_rechercher ();//long ll_row, ll_cnt, i, ll_cnt114a, ll_cnt115a, ll_cnt117a, ll_cnt118a, ll_cnt119a
//long ll_cnt114b, ll_cnt115b, ll_cnt117b, ll_cnt118b, ll_cnt119b
//dec{2}  ld_cnt114a, ld_cnt115a, ld_cnt117a, ld_cnt118a, ld_cnt119a
//dec{2}  ld_cnt114b, ld_cnt115b, ld_cnt117b, ld_cnt118b, ld_cnt119b
long i, j, k, ll_newrow
string ls_norecolte[], ls_norecolte2[], ls_temp[]

transaction CIPQADMIN
transaction CIPQLAB
transaction CIPQROX
transaction CIPQSTC
transaction CIPQSTP
string ls_sql
//date ldt_debut, ldt_fin, ldt_temp
//dec{2} ld_cnt
CIPQADMIN = CREATE transaction
CIPQADMIN.DBMS       = 'ODBC'
CIPQADMIN.AutoCommit = True
CIPQADMIN.LOCK		  = "0"
CIPQADMIN.DbParm  = "ConnectString='DSN=cipq_admin;UID=dba;PWD=sql',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT'"
connect using CIPQADMIN;

dw_recherche.reset()

if CIPQADMIN.sqlcode <> 0 then
	
	MessageBox ("Erreur de communication", "La communication avec l'administration est impossible veuillez corriger la situation",Information!, Ok!)		

else
	
	// Authentifier la connection pour la version 11

	ls_sql = "SET TEMPORARY OPTION CONNECTION_AUTHENTICATION='Company=Progitek;Application=Progitek;Signature=000fa55157edb8e14d818eb4fe3db41447146f1571g7cf6b1c162e7a4e4925570fc8104c82ac6d466c6'"
	execute immediate :ls_sql using CIPQADMIN;
	if CIPQADMIN.sqlcode <> 0 then
		MessageBox ("Validation d'authentification", CIPQADMIN.sqlerrtext)
	end if
	
end if

CIPQLAB = CREATE transaction
CIPQLAB.DBMS       = 'ODBC'
CIPQLAB.AutoCommit = True
CIPQLAB.LOCK		  = "0"
CIPQLAB.DbParm  = "ConnectString='DSN=cipq_stlambert;UID=dba;PWD=sql',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT'"
connect using CIPQLAB;

if CIPQLAB.sqlcode <> 0 then
	
	MessageBox ("Erreur de communication", "La communication avec St-Lambert est impossible veuillez corriger la situation",Information!, Ok!)

else
		
	// Authentifier la connection pour la version 11

	ls_sql = "SET TEMPORARY OPTION CONNECTION_AUTHENTICATION='Company=Progitek;Application=Progitek;Signature=000fa55157edb8e14d818eb4fe3db41447146f1571g7cf6b1c162e7a4e4925570fc8104c82ac6d466c6'"
	execute immediate :ls_sql using CIPQLAB;
	if CIPQLAB.sqlcode <> 0 then
		MessageBox ("Validation d'authentification", CIPQLAB.sqlerrtext)
	end if
	
end if

CIPQROX = CREATE transaction
CIPQROX.DBMS       = 'ODBC'
CIPQROX.AutoCommit = True
CIPQROX.LOCK		  = "0"
CIPQROX.DbParm  = "ConnectString='DSN=cipq_roxton;UID=dba;PWD=sql',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT'"
connect using CIPQROX;

if CIPQROX.sqlcode <> 0 then
		
	MessageBox ("Erreur de communication", "La communication avec Roxton est impossible veuillez corriger la situation",Information!, Ok!)		
	
else
		
		// Authentifier la connection pour la version 11

	ls_sql = "SET TEMPORARY OPTION CONNECTION_AUTHENTICATION='Company=Progitek;Application=Progitek;Signature=000fa55157edb8e14d818eb4fe3db41447146f1571g7cf6b1c162e7a4e4925570fc8104c82ac6d466c6'"
	execute immediate :ls_sql using CIPQROX;
	if CIPQROX.sqlcode <> 0 then
		MessageBox ("Validation d'authentification", CIPQROX.sqlerrtext)
	end if
	
end if

CIPQSTC = CREATE transaction
CIPQSTC.DBMS       = 'ODBC'
CIPQSTC.AutoCommit = True
CIPQSTC.LOCK		  = "0"
CIPQSTC.DbParm  = "ConnectString='DSN=cipq_stcuthbert;UID=dba;PWD=sql',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT'"
connect using CIPQSTC;

if CIPQSTC.sqlcode <> 0 then
		
	MessageBox ("Erreur de communication", "La communication avec St-Cuthbert est impossible veuillez corriger la situation",Information!, Ok!)
	
else
	
	// Authentifier la connection pour la version 11

	ls_sql = "SET TEMPORARY OPTION CONNECTION_AUTHENTICATION='Company=Progitek;Application=Progitek;Signature=000fa55157edb8e14d818eb4fe3db41447146f1571g7cf6b1c162e7a4e4925570fc8104c82ac6d466c6'"
	execute immediate :ls_sql using CIPQSTC;
	if CIPQSTC.sqlcode <> 0 then
		MessageBox ("Validation d'authentification", CIPQSTC.sqlerrtext)
	end if
	
end if

CIPQSTP = CREATE transaction
CIPQSTP.DBMS       = 'ODBC'
CIPQSTP.AutoCommit = True
CIPQSTP.LOCK		  = "0"
CIPQSTP.DbParm  = "ConnectString='DSN=cipq_stpatrice;UID=dba;PWD=sql',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT'"
connect using CIPQSTP;

if CIPQSTP.sqlcode <> 0 then
	
	MessageBox ("Erreur de communication", "La communication avec St-Patrice est impossible veuillez corriger la situation",Information!, Ok!)
	
else
		
	// Authentifier la connection pour la version 11

	ls_sql = "SET TEMPORARY OPTION CONNECTION_AUTHENTICATION='Company=Progitek;Application=Progitek;Signature=000fa55157edb8e14d818eb4fe3db41447146f1571g7cf6b1c162e7a4e4925570fc8104c82ac6d466c6'"
	execute immediate :ls_sql using CIPQSTP;
	if CIPQSTP.sqlcode <> 0 then
		MessageBox ("Validation d'authentification", CIPQSTP.sqlerrtext)
	end if
	
end if

CHOOSE CASE il_type
	CASE 1
		CHOOSE CASE il_centre
			CASE 1
				ls_sql = "select norecolte from t_recolte where cie_no = '111' and date_recolte =  '" + string(ldt_date,"yyyy-mm-dd") + "'"					
			CASE 2
				ls_sql = "select norecolte from t_recolte where cie_no = '112' and date_recolte =  '" + string(ldt_date,"yyyy-mm-dd") + "'"
			CASE 3
				ls_sql = "select norecolte from t_recolte where cie_no = '113' and date_recolte =  '" + string(ldt_date,"yyyy-mm-dd") + "'"
			CASE 4
				ls_sql = "select norecolte from t_recolte where cie_no = '116' and date_recolte =  '" + string(ldt_date,"yyyy-mm-dd") + "'"
			CASE 5
				ls_sql = "select norecolte from t_recolte where cie_no = '115' and date_recolte =  '" + string(ldt_date,"yyyy-mm-dd") + "'"
			CASE 6
				ls_sql = "select norecolte from t_recolte where cie_no = '118' and date_recolte =  '" + string(ldt_date,"yyyy-mm-dd") + "'"
			CASE 7
				ls_sql = "select norecolte from t_recolte where cie_no = '119' and date_recolte =  '" + string(ldt_date,"yyyy-mm-dd") + "'"
			CASE 8
				ls_sql = "select norecolte from t_recolte where cie_no = '114' and date_recolte =  '" + string(ldt_date,"yyyy-mm-dd") + "'"
			CASE 9
				ls_sql = "select norecolte from t_recolte where cie_no = '117' and date_recolte =  '" + string(ldt_date,"yyyy-mm-dd") + "'"
		END CHOOSE		
	CASE 2
		CHOOSE CASE il_centre
			CASE 1
				ls_sql = "select norecolte || ' - ' || isnull(ampo_total,0) from t_recolte where cie_no = '111' and date_recolte =  '" + string(ldt_date,"yyyy-mm-dd") + "'"
			CASE 2
				ls_sql = "select norecolte || ' - ' || isnull(ampo_total,0) from t_recolte where cie_no = '112' and date_recolte =  '" + string(ldt_date,"yyyy-mm-dd") + "'"
			CASE 3
				ls_sql = "select norecolte || ' - ' || isnull(ampo_total,0) from t_recolte where cie_no = '113' and date_recolte =  '" + string(ldt_date,"yyyy-mm-dd") + "'"
			CASE 4
				ls_sql = "select norecolte || ' - ' || isnull(ampo_total,0) from t_recolte where cie_no = '116' and date_recolte =  '" + string(ldt_date,"yyyy-mm-dd") + "'"
			CASE 5
				ls_sql = "select norecolte || ' - ' || isnull(ampo_total,0) from t_recolte where cie_no = '115' and date_recolte =  '" + string(ldt_date,"yyyy-mm-dd") + "'"
			CASE 6
				ls_sql = "select norecolte || ' - ' || isnull(ampo_total,0) from t_recolte where cie_no = '118' and date_recolte =  '" + string(ldt_date,"yyyy-mm-dd") + "'"
			CASE 7
				ls_sql = "select norecolte || ' - ' || isnull(ampo_total,0) from t_recolte where cie_no = '119' and date_recolte =  '" + string(ldt_date,"yyyy-mm-dd") + "'"
			CASE 8
				ls_sql = "select norecolte || ' - ' || isnull(ampo_total,0) from t_recolte where cie_no = '114' and date_recolte =  '" + string(ldt_date,"yyyy-mm-dd") + "'"
			CASE 9
				ls_sql = "select norecolte || ' - ' || isnull(ampo_total,0) from t_recolte where cie_no = '117' and date_recolte =  '" + string(ldt_date,"yyyy-mm-dd") + "'"
		END CHOOSE
	CASE 3
		CHOOSE CASE il_centre
			CASE 1
				ls_sql = "select t_statfacture.liv_no || ' - ' || isnull(t_statfacturedetail.QTE_EXP,0) &
							from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no &
															 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no &
							where   date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' AND &
									  t_statfacture.cie_no = '111' AND  &
									  t_produit.special = 1"
			CASE 2
				ls_sql = "select t_statfacture.liv_no || ' - ' || isnull(t_statfacturedetail.QTE_EXP,0) &
							from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no &
															 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no &
							where   date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' AND &
									  t_statfacture.cie_no = '112' AND  &
									  t_produit.special = 1"
			CASE 3
				ls_sql = "select t_statfacture.liv_no || ' - ' || isnull(t_statfacturedetail.QTE_EXP,0) &
							from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no &
															 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no &
							where   date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' AND &
									  t_statfacture.cie_no = '113' AND  &
									  t_produit.special = 1"
			CASE 4
				ls_sql = "select t_statfacture.liv_no || ' - ' || isnull(t_statfacturedetail.QTE_EXP,0) &
							from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no &
															 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no &
							where   date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' AND &
									  t_statfacture.cie_no = '116' AND  &
									  t_produit.special = 1"
			CASE 5
				ls_sql = "select t_statfacture.liv_no || ' - ' || isnull(t_statfacturedetail.QTE_EXP,0) &
							from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no &
															 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no &
							where   date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' AND &
									  t_statfacture.cie_no = '115' AND  &
									  t_produit.special = 1"
			CASE 6
				ls_sql = "select t_statfacture.liv_no || ' - ' || isnull(t_statfacturedetail.QTE_EXP,0) &
							from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no &
															 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no &
							where   date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' AND &
									  t_statfacture.cie_no = '118' AND  &
									  t_produit.special = 1"
			CASE 7
				ls_sql = "select t_statfacture.liv_no || ' - ' || isnull(t_statfacturedetail.QTE_EXP,0) &
							from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no &
															 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no &
							where   date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' AND &
									  t_statfacture.cie_no = '119' AND  &
									  t_produit.special = 1"
			CASE 8
				ls_sql = "select t_statfacture.liv_no || ' - ' || isnull(t_statfacturedetail.QTE_EXP,0) &
							from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no &
															 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no &
							where   date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' AND &
									  t_statfacture.cie_no = '114' AND  &
									  t_produit.special = 1"
			CASE 9
				ls_sql = "select t_statfacture.liv_no || ' - ' || isnull(t_statfacturedetail.QTE_EXP,0) &
							from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no &
															 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no &
							where   date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' AND &
									  t_statfacture.cie_no = '117' AND  &
									  t_produit.special = 1"
		END CHOOSE
	CASE 4
		CHOOSE CASE il_centre
			CASE 1
				ls_sql = "select  t_statfacture.liv_no from t_statfacture where date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' and t_statfacture.cie_no = '111'"
			CASE 2
				ls_sql = "select  t_statfacture.liv_no from t_statfacture where date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' and t_statfacture.cie_no = '112'"
			CASE 3
				ls_sql = "select  t_statfacture.liv_no from t_statfacture where date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' and t_statfacture.cie_no = '113'"
			CASE 4
				ls_sql = "select  t_statfacture.liv_no from t_statfacture where date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' and t_statfacture.cie_no = '116'"
			CASE 5
				ls_sql = "select  t_statfacture.liv_no from t_statfacture where date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' and t_statfacture.cie_no = '115'"
			CASE 6
				ls_sql = "select  t_statfacture.liv_no from t_statfacture where date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' and t_statfacture.cie_no = '118'"
			CASE 7
				ls_sql = "select  t_statfacture.liv_no from t_statfacture where date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' and t_statfacture.cie_no = '119'"
			CASE 8
				ls_sql = "select  t_statfacture.liv_no from t_statfacture where date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' and t_statfacture.cie_no = '114'"
			CASE 9
				ls_sql = "select  t_statfacture.liv_no from t_statfacture where date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' and t_statfacture.cie_no = '117'"
		END CHOOSE
	CASE 5
		CHOOSE CASE il_centre
			CASE 1
				ls_sql = "select  t_statfacturedetail.liv_no || ' -  ' || t_statfacturedetail.ligne_no &
				from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no &
				where date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' and t_statfacture.cie_no = '111' "
			CASE 2
				ls_sql = "select  t_statfacturedetail.liv_no || ' -  ' || t_statfacturedetail.ligne_no &
				from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no &
				where date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' and t_statfacture.cie_no = '112' "
			CASE 3
				ls_sql = "select  t_statfacturedetail.liv_no || ' - '  || t_statfacturedetail.ligne_no &
				from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no &
				where date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' and t_statfacture.cie_no = '113' "
			CASE 4
				ls_sql = "select  t_statfacturedetail.liv_no || ' - ' || t_statfacturedetail.ligne_no &
				from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no &
				where date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' and t_statfacture.cie_no = '116' "
			CASE 5
				ls_sql = "select  t_statfacturedetail.liv_no || ' - '  || t_statfacturedetail.ligne_no &
				from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no &
				where date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' and t_statfacture.cie_no = '115' "
			CASE 6
				ls_sql = "select  t_statfacturedetail.liv_no || ' - '  || t_statfacturedetail.ligne_no &
				from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no &
				where date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' and t_statfacture.cie_no = '118' "
			CASE 7
				ls_sql = "select  t_statfacturedetail.liv_no || ' - '  || t_statfacturedetail.ligne_no &
				from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no &
				where date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' and t_statfacture.cie_no = '119' "
			CASE 8
				ls_sql = "select  t_statfacturedetail.liv_no || ' - ' || t_statfacturedetail.ligne_no &
				from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no &
				where date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' and t_statfacture.cie_no = '114' "
			CASE 9
				ls_sql = "select  t_statfacturedetail.liv_no || ' - '  || t_statfacturedetail.ligne_no &
				from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no &
				where date(liv_date) =  '" + string(ldt_date,"yyyy-mm-dd") + "' and t_statfacture.cie_no = '117' "
		END CHOOSE
	CASE 6
		CHOOSE CASE il_centre
			CASE 1
				ls_sql = "select  famille || ' - ' || nolot from t_recolte_cote_peremption where date(date_recolte) =  '" + string(ldt_date,"yyyy-mm-dd") + "'  and cie_no = '111' "
			CASE 2
				ls_sql = "select famille || ' - ' || nolot from t_recolte_cote_peremption where date(date_recolte) =  '" + string(ldt_date,"yyyy-mm-dd") + "'  and cie_no = '112' "
			CASE 3
				ls_sql = "select famille || ' - ' || nolot from t_recolte_cote_peremption where date(date_recolte) =  '" + string(ldt_date,"yyyy-mm-dd") + "'  and cie_no = '113' "
			CASE 4
				ls_sql = "select famille || ' - ' || nolot from t_recolte_cote_peremption where date(date_recolte) =  '" + string(ldt_date,"yyyy-mm-dd") + "'  and cie_no = '116' "
			CASE 5
				ls_sql = "select famille || ' - ' || nolot from t_recolte_cote_peremption where date(date_recolte) =  '" + string(ldt_date,"yyyy-mm-dd") + "'  and cie_no = '115' "
			CASE 6
				ls_sql = "select famille || ' - ' || nolot from t_recolte_cote_peremption where date(date_recolte) =  '" + string(ldt_date,"yyyy-mm-dd") + "'  and cie_no = '118' "
			CASE 7
				ls_sql = "select famille || ' - ' || nolot from t_recolte_cote_peremption where date(date_recolte) =  '" + string(ldt_date,"yyyy-mm-dd") + "'  and cie_no = '119' "
			CASE 8
				ls_sql = "select famille || ' - ' || nolot from t_recolte_cote_peremption where date(date_recolte) =  '" + string(ldt_date,"yyyy-mm-dd") + "'  and cie_no = '114' "
			CASE 9 
				ls_sql = "select famille || ' - ' || nolot from t_recolte_cote_peremption where date(date_recolte) =  '" + string(ldt_date,"yyyy-mm-dd") + "'  and cie_no = '117' "
		END CHOOSE
END CHOOSE

i = 1
								
DECLARE listrecolte DYNAMIC CURSOR FOR SQLSA;
PREPARE sqlsa FROM :ls_sql using CIPQADMIN;

OPEN listrecolte;

FETCH listrecolte INTO :ls_norecolte[i];

DO WHILE CIPQADMIN.SQLCode = 0
	
	i++
	FETCH listrecolte INTO :ls_norecolte[i];
	
LOOP

CLOSE listrecolte;

DECLARE listrecolte2 DYNAMIC CURSOR FOR SQLSA;
CHOOSE CASE il_centre
	CASE 2
		PREPARE sqlsa FROM :ls_sql using CIPQROX;
	CASE 3
		PREPARE sqlsa FROM :ls_sql using CIPQSTC;
	CASE 4
		PREPARE sqlsa FROM :ls_sql using CIPQSTP;
	CASE ELSE
		PREPARE sqlsa FROM :ls_sql using CIPQLAB;
END CHOOSE
					
j = 1
						
OPEN listrecolte2;

FETCH listrecolte2 INTO :ls_norecolte2[j];

CHOOSE CASE il_centre
	CASE 2
		
		DO WHILE CIPQROX.SQLCode = 0
			
			j++
			FETCH listrecolte2 INTO :ls_norecolte2[j];
	
		LOOP
			
	CASE 3
		
		DO WHILE CIPQSTC.SQLCode = 0
			
			j++
			FETCH listrecolte2 INTO :ls_norecolte2[j];
	
		LOOP
		
	CASE 4
		
		DO WHILE CIPQSTP.SQLCode = 0
			
			j++
			FETCH listrecolte2 INTO :ls_norecolte2[j];
	
		LOOP
		
	CASE ELSE
		
		DO WHILE CIPQLAB.SQLCode = 0
			
			j++
			FETCH listrecolte2 INTO :ls_norecolte2[j];
	
		LOOP
		
END CHOOSE

CLOSE listrecolte2;
					
ls_temp = of_diffarray(ls_norecolte, ls_norecolte2)
					
for k = 1 to upperbound(ls_temp)
	
	ll_newrow = dw_recherche.insertRow(0)
	dw_recherche.setitem(ll_newrow,'infodifferente',ls_temp[k])
	
next

//em_debut.getdata(ldt_debut)
//em_fin.getdata(ldt_fin)
//
//dw_veriftrans.object.t_datedebut.text = string(ldt_debut)
//dw_veriftrans.object.t_datefin.text = string(ldt_fin)

//dw_veriftrans.setRedraw(false)
//ll_row = dw_veriftrans.insertRow(0)
//	dw_veriftrans.setItem(ll_row,'table','Nbr .prélev.')
//	dw_veriftrans.setItem(ll_row,'dattrans',ldt_temp)
//	
//	select count(1)  into :ll_cnt
//	from t_recolte where cie_no = '112' and date_recolte = :ldt_temp using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c112_110', ll_cnt)
//	
//	select count(1)   into :ll_cnt
//	from t_recolte where cie_no = '112' and date_recolte = :ldt_temp using CIPQROX;
//	dw_veriftrans.setItem(ll_row,'c112_112', ll_cnt)
//	
//	select count(1)  into :ll_cnt
//	from t_recolte where cie_no = '113' and date_recolte = :ldt_temp using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c113_110', ll_cnt)
//	
//	select count(1)  into :ll_cnt
//	from t_recolte where cie_no = '113' and date_recolte = :ldt_temp using CIPQSTC;
//	dw_veriftrans.setItem(ll_row,'c113_113', ll_cnt)
//	
//	select count(1) into :ll_cnt
//	from t_recolte where cie_no = '116' and date_recolte = :ldt_temp using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c116_110', ll_cnt)
//	
//	select count(1) into :ll_cnt
//	from t_recolte where cie_no = '116' and date_recolte = :ldt_temp using CIPQSTP;
//	dw_veriftrans.setItem(ll_row,'c116_116', ll_cnt)
//	
//	select count(1)  into :ll_cnt114a
//	from t_recolte where cie_no = '114' and date_recolte = :ldt_temp using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c114_110', ll_cnt114a)
//	
//	select count(1)  into :ll_cnt114b 
//	from t_recolte where cie_no = '114' and date_recolte = :ldt_temp using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c114_114', ll_cnt114b)
//	
//	select count(1)  into :ll_cnt115a 
//	from t_recolte where cie_no = '115' and date_recolte = :ldt_temp using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c115_110', ll_cnt115a)
//	
//	select count(1)  into :ll_cnt115b
//	from t_recolte where cie_no = '115' and date_recolte = :ldt_temp using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c115_115', ll_cnt115b)
//	
//	select count(1) into :ll_cnt117a
//	from t_recolte where cie_no = '117' and date_recolte = :ldt_temp using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c117_110', ll_cnt117a)
//	
//	select count(1)  into :ll_cnt117b 
//	from t_recolte where cie_no = '117' and date_recolte = :ldt_temp using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c117_117', ll_cnt117b)
//	
//	select count(1)  into :ll_cnt118a
//	from t_recolte where cie_no = '118' and date_recolte = :ldt_temp using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c118_110', ll_cnt118a)
//	
//	select count(1)  into :ll_cnt118b
//	from t_recolte where cie_no = '118' and date_recolte = :ldt_temp using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c118_118', ll_cnt118b)
//	
//	select count(1)  into :ll_cnt119a
//	from t_recolte where cie_no = '119' and date_recolte = :ldt_temp using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c119_110', ll_cnt119a)
//
//	select count(1)  into :ll_cnt119b
//	from t_recolte where cie_no = '119' and date_recolte = :ldt_temp using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c119_119', ll_cnt119b)
//	
//	select count(1) into :ll_cnt 
//	from t_recolte where cie_no = '111' and date_recolte = :ldt_temp using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c111_110', ll_cnt114a + ll_cnt115a + ll_cnt117a  + ll_cnt118a + ll_cnt119a)   	
//
//	select count(1)  into :ll_cnt
//	from t_recolte where cie_no = '111' and date_recolte = :ldt_temp using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c111_111', ll_cnt114b + ll_cnt115b + ll_cnt117b + ll_cnt118b + ll_cnt119b)
//	
//	ll_row = dw_veriftrans.insertRow(0)
//	dw_veriftrans.setItem(ll_row,'table','Nbr .doses PROD')
//	dw_veriftrans.setItem(ll_row,'dattrans',ldt_temp)
//	
//	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt
//	from t_recolte where cie_no = '112' and date_recolte = :ldt_temp using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c112_110', ld_cnt)
//	
//	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt
//	from t_recolte where cie_no = '112' and date_recolte = :ldt_temp using CIPQROX;
//	dw_veriftrans.setItem(ll_row,'c112_112', ld_cnt)
//	
//	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt
//	from t_recolte where cie_no = '113' and date_recolte = :ldt_temp using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c113_110', ld_cnt)
//	
//	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt
//	from t_recolte where cie_no = '113' and date_recolte = :ldt_temp using CIPQSTC;
//	dw_veriftrans.setItem(ll_row,'c113_113', ld_cnt)
//	
//	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt
//	from t_recolte where cie_no = '116' and date_recolte = :ldt_temp using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c116_110', ld_cnt)
//	
//	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt
//	from t_recolte where cie_no = '116' and date_recolte = :ldt_temp using CIPQSTP;
//	dw_veriftrans.setItem(ll_row,'c116_116', ld_cnt)
//	
//	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt114a
//	from t_recolte where cie_no = '114' and date_recolte = :ldt_temp using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c114_110', ld_cnt114a)
//	
//	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt114b
//	from t_recolte where cie_no = '114' and date_recolte = :ldt_temp using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c114_114', ld_cnt114b)
//	
//	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt115a
//	from t_recolte where cie_no = '115' and date_recolte = :ldt_temp using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c115_110', ld_cnt115a)
//	
//	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt115b
//	from t_recolte where cie_no = '115' and date_recolte = :ldt_temp using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c115_115', ld_cnt115b)
//	
//	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt117a
//	from t_recolte where cie_no = '117' and date_recolte = :ldt_temp using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c117_110', ld_cnt117a)
//	
//	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt117b
//	from t_recolte where cie_no = '117' and date_recolte = :ldt_temp using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c117_117', ld_cnt117b)
//	
//	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt118a
//	from t_recolte where cie_no = '118' and date_recolte = :ldt_temp using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c118_110', ld_cnt118a)
//	
//	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt118b
//	from t_recolte where cie_no = '118' and date_recolte = :ldt_temp using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c118_118', ld_cnt118b)
//	
//	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt119a
//	from t_recolte where cie_no = '119' and date_recolte = :ldt_temp using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c119_110', ld_cnt119a)
//	
//	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt119b
//	from t_recolte where cie_no = '119' and date_recolte = :ldt_temp using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c119_119', ld_cnt119b)
//	
//	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt 
//	from t_recolte where cie_no = '111' and date_recolte = :ldt_temp using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c111_110', ld_cnt114a + ld_cnt115a  + ld_cnt117a + ld_cnt118a + ld_cnt119a)
//	
//	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt
//	from t_recolte where cie_no = '111' and date_recolte = :ldt_temp using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c111_111', ld_cnt114b + ld_cnt115b  + ld_cnt117b + ld_cnt118b+ ld_cnt119b)
//	
//	ll_row = dw_veriftrans.insertRow(0)
//	dw_veriftrans.setItem(ll_row,'table','Nbr .doses EXP')
//	dw_veriftrans.setItem(ll_row,'dattrans',ldt_temp)
//	
//	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
//									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
//	where   date(liv_date) = :ldt_temp AND 
//			  t_statfacture.cie_no = '111' AND 
//			  t_produit.special = 1 using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c111_110', ld_cnt)	
//	
//	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
//									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
//	where   date(liv_date) = :ldt_temp AND 
//			  t_statfacture.cie_no = '111' AND 
//			  t_produit.special = 1 using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c111_111', ld_cnt)
//	
//	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
//									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
//	where   date(liv_date) = :ldt_temp AND 
//			  t_statfacture.cie_no = '112' AND 
//			  t_produit.special = 1 using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c112_110', ld_cnt)
//	
//	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
//									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
//	where   date(liv_date) = :ldt_temp AND 
//			  t_statfacture.cie_no = '112' AND 
//			  t_produit.special = 1 using CIPQROX;
//	dw_veriftrans.setItem(ll_row,'c112_112', ld_cnt)
//	
//	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
//									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
//	where   date(liv_date) = :ldt_temp AND 
//			  t_statfacture.cie_no = '113' AND 
//			  t_produit.special = 1 using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c113_110', ld_cnt)
//	
//	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
//									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
//	where   date(liv_date) = :ldt_temp AND 
//			  t_statfacture.cie_no = '113' AND 
//			  t_produit.special = 1 using CIPQSTC;
//	dw_veriftrans.setItem(ll_row,'c113_113', ld_cnt)
//	
//	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
//									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
//	where   date(liv_date) = :ldt_temp AND 
//			  t_statfacture.cie_no = '116' AND 
//			  t_produit.special = 1 using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c116_110', ld_cnt)
//	
//	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
//									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
//	where   date(liv_date) = :ldt_temp AND 
//			  t_statfacture.cie_no = '116' AND 
//			  t_produit.special = 1 using CIPQSTP;
//	dw_veriftrans.setItem(ll_row,'c116_116', ld_cnt)
//	
//	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
//									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
//	where   date(liv_date) = :ldt_temp AND 
//			  t_statfacture.cie_no = '114' AND 
//			  t_produit.special = 1 using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c114_110', ld_cnt)
//	
//	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
//									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
//	where   date(liv_date) = :ldt_temp AND 
//			  t_statfacture.cie_no = '114' AND 
//			  t_produit.special = 1 using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c114_114', ld_cnt)
//	
//	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
//									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
//	where   date(liv_date) = :ldt_temp AND 
//			  t_statfacture.cie_no = '115' AND 
//			  t_produit.special = 1 using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c115_110', ld_cnt)
//	
//	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
//									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
//	where   date(liv_date) = :ldt_temp AND 
//			  t_statfacture.cie_no = '115' AND 
//			  t_produit.special = 1 using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c115_115', ld_cnt)
//	
//	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
//									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
//	where   date(liv_date) = :ldt_temp AND 
//			  t_statfacture.cie_no = '117' AND 
//			  t_produit.special = 1 using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c117_110', ld_cnt)
//	
//	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
//									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
//	where   date(liv_date) = :ldt_temp AND 
//			  t_statfacture.cie_no = '117' AND 
//			  t_produit.special = 1 using CIPQSTP;
//	dw_veriftrans.setItem(ll_row,'c117_117', ld_cnt)
//	
//	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
//									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
//	where   date(liv_date) = :ldt_temp AND 
//			  t_statfacture.cie_no = '118' AND 
//			  t_produit.special = 1 using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c118_110', ld_cnt)
//	
//	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
//									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
//	where   date(liv_date) = :ldt_temp AND 
//			  t_statfacture.cie_no = '118' AND 
//			  t_produit.special = 1 using CIPQSTP;
//	dw_veriftrans.setItem(ll_row,'c118_118', ld_cnt)
//	
//	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
//									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
//	where   date(liv_date) = :ldt_temp AND 
//			  t_statfacture.cie_no = '119' AND 
//			  t_produit.special = 1 using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c119_110', ld_cnt)
//	
//	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
//									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
//	where   date(liv_date) = :ldt_temp AND 
//			  t_statfacture.cie_no = '119' AND 
//			  t_produit.special = 1 using CIPQSTP;
//	dw_veriftrans.setItem(ll_row,'c119_119', ld_cnt)
//	
//	ll_row = dw_veriftrans.insertRow(0)
//	dw_veriftrans.setItem(ll_row,'table','Bon. liv.')
//	dw_veriftrans.setItem(ll_row,'dattrans',ldt_temp)
//	
//	select  count(1)  into :ll_cnt
//	from t_statfacture
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '111' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c111_110', ll_cnt)	
//	
//	select  count(1) into :ll_cnt
//	from t_statfacture
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '111' using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c111_111', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacture
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '112'  using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c112_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacture
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '112' using CIPQROX;
//	dw_veriftrans.setItem(ll_row,'c112_112', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacture
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '113'  using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c113_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacture
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '113'  using CIPQSTC;
//	dw_veriftrans.setItem(ll_row,'c113_113', ll_cnt)
//		
//	select  count(1) into :ll_cnt
//	from t_statfacture
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '116' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c116_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacture
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '116'  using CIPQSTP;
//	dw_veriftrans.setItem(ll_row,'c116_116', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacture
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '114' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c114_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacture
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '114' using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c114_114', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacture
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '115'  using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c115_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacture
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '115' using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c115_115', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacture
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '117'  using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c117_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacture
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '117' using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c117_117', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacture
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '118' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c118_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacture
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '118'  using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c118_118', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacture
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '119' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c119_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacture
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '119' using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c119_119', ll_cnt)	
//	
//	ll_row = dw_veriftrans.insertRow(0)
//	dw_veriftrans.setItem(ll_row,'table','Det .bon. liv.')
//	dw_veriftrans.setItem(ll_row,'dattrans',ldt_temp)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '111' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c111_110', ll_cnt)	
//	
//	select  count(1) into :ll_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '111' using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c111_111', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '112' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c112_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '112' using CIPQROX;
//	dw_veriftrans.setItem(ll_row,'c112_112', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '113' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c113_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '113' using CIPQSTC;
//	dw_veriftrans.setItem(ll_row,'c113_113', ll_cnt)
//		
//	select  count(1) into :ll_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '116' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c116_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '116' using CIPQSTP;
//	dw_veriftrans.setItem(ll_row,'c116_116', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '114' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c114_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '114' using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c114_114', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '115' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c115_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '115' using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c115_115', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '117' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c117_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '117' using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c117_117', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '118' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c118_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '118' using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c118_118', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '119' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c119_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
//	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '119' using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c119_119', ll_cnt)	
//	
//	ll_row = dw_veriftrans.insertRow(0)
//	dw_veriftrans.setItem(ll_row,'table','Cote premption.')
//	dw_veriftrans.setItem(ll_row,'dattrans',ldt_temp)
//	
//	select  count(1) into :ll_cnt
//	from t_recolte_cote_peremption
//	where date(date_recolte) = :ldt_temp and cie_no = '111' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c111_110', ll_cnt)	
//	
//	select  count(1) into :ll_cnt
//	from t_recolte_cote_peremption
//	where date(date_recolte) = :ldt_temp and cie_no = '111' using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c111_111', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_recolte_cote_peremption
//	where date(date_recolte) = :ldt_temp and cie_no = '112' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c112_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_recolte_cote_peremption
//	where date(date_recolte) = :ldt_temp and cie_no = '112' using CIPQROX;
//	dw_veriftrans.setItem(ll_row,'c112_112', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_recolte_cote_peremption
//	where date(date_recolte) = :ldt_temp and cie_no = '113' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c113_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_recolte_cote_peremption
//	where date(date_recolte) = :ldt_temp and cie_no = '113' using CIPQSTC;
//	dw_veriftrans.setItem(ll_row,'c113_113', ll_cnt)
//		
//	select  count(1) into :ll_cnt
//	from t_recolte_cote_peremption
//	where date(date_recolte) = :ldt_temp and cie_no = '116' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c116_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_recolte_cote_peremption
//	where date(date_recolte) = :ldt_temp and cie_no = '116' using CIPQSTP;
//	dw_veriftrans.setItem(ll_row,'c116_116', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_recolte_cote_peremption
//	where date(date_recolte) = :ldt_temp and cie_no = '114' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c114_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_recolte_cote_peremption
//	where date(date_recolte) = :ldt_temp and cie_no = '114' using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c114_114', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_recolte_cote_peremption
//	where date(date_recolte) = :ldt_temp and cie_no = '115' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c115_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_recolte_cote_peremption
//	where date(date_recolte) = :ldt_temp and cie_no = '115' using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c115_115', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_recolte_cote_peremption
//	where date(date_recolte) = :ldt_temp and cie_no = '117' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c117_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_recolte_cote_peremption
//	where date(date_recolte) = :ldt_temp and cie_no = '117' using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c117_117', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_recolte_cote_peremption
//	where date(date_recolte) = :ldt_temp and cie_no = '118' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c118_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_recolte_cote_peremption
//	where date(date_recolte) = :ldt_temp and cie_no = '118' using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c118_118', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_recolte_cote_peremption
//	where date(date_recolte) = :ldt_temp and cie_no = '119' using CIPQADMIN;
//	dw_veriftrans.setItem(ll_row,'c119_110', ll_cnt)
//	
//	select  count(1) into :ll_cnt
//	from t_recolte_cote_peremption
//	where date(date_recolte) = :ldt_temp and cie_no = '119' using CIPQLAB;
//	dw_veriftrans.setItem(ll_row,'c119_119', ll_cnt)	
//	
//	ldt_temp = relativedate(ldt_debut,i)
//	
//next
//
//// Verrat 
//
//ll_row = dw_veriftrans.insertRow(0)
//dw_veriftrans.setItem(ll_row,'table','Verrat')
//dw_veriftrans.setItem(ll_row,'dattrans','1901-01-01')
//
//select count(1) into :ll_cnt from t_verrat where cie_no = '111' and elimin is null using CIPQADMIN;
//dw_veriftrans.setItem(ll_row,'c111_110', ll_cnt)
//
//select count(1) into :ll_cnt from t_verrat where cie_no = '111'  and elimin is null using CIPQLAB;
//dw_veriftrans.setItem(ll_row,'c111_111', ll_cnt)
//
//select count(1) into :ll_cnt from t_verrat where cie_no = '112' and elimin is null using CIPQADMIN;
//dw_veriftrans.setItem(ll_row,'c112_110', ll_cnt)
//
//select count(1) into :ll_cnt from t_verrat where cie_no = '112' and elimin is null using CIPQROX;
//dw_veriftrans.setItem(ll_row,'c112_112', ll_cnt)
//
//select count(1) into :ll_cnt from t_verrat where cie_no = '113' and elimin is null using CIPQADMIN;
//dw_veriftrans.setItem(ll_row,'c113_110', ll_cnt)
//
//select count(1) into :ll_cnt from t_verrat where cie_no = '113' and elimin is null using CIPQSTC;
//dw_veriftrans.setItem(ll_row,'c113_113', ll_cnt)
//
//select count(1) into :ll_cnt from t_verrat where cie_no = '116' and elimin is null using CIPQADMIN;
//dw_veriftrans.setItem(ll_row,'c116_110', ll_cnt)
//
//select count(1) into :ll_cnt from t_verrat where cie_no = '116' and elimin is null using CIPQSTP;
//dw_veriftrans.setItem(ll_row,'c116_116', ll_cnt)
//
//select count(1) into :ll_cnt from t_verrat where cie_no = '114' and elimin is null using CIPQADMIN;
//dw_veriftrans.setItem(ll_row,'c114_110', ll_cnt)
//
//select count(1) into :ll_cnt from t_verrat where cie_no = '114' and elimin is null using CIPQLAB;
//dw_veriftrans.setItem(ll_row,'c114_114', ll_cnt)
//
//select count(1) into :ll_cnt from t_verrat where cie_no = '115' and elimin is null using CIPQADMIN;
//dw_veriftrans.setItem(ll_row,'c115_110', ll_cnt)
//
//select count(1) into :ll_cnt from t_verrat where cie_no = '115' and elimin is null using CIPQLAB;
//dw_veriftrans.setItem(ll_row,'c115_115', ll_cnt)
//
//select count(1) into :ll_cnt from t_verrat where cie_no = '117' and elimin is null using CIPQADMIN;
//dw_veriftrans.setItem(ll_row,'c117_110', ll_cnt)
//
//select count(1) into :ll_cnt from t_verrat where cie_no = '117' and elimin is null using CIPQLAB;
//dw_veriftrans.setItem(ll_row,'c117_117', ll_cnt)
//
//select count(1) into :ll_cnt from t_verrat where cie_no = '118' and elimin is null using CIPQADMIN;
//dw_veriftrans.setItem(ll_row,'c118_110', ll_cnt)
//
//select count(1) into :ll_cnt from t_verrat where cie_no = '118' and elimin is null using CIPQLAB;
//dw_veriftrans.setItem(ll_row,'c118_118', ll_cnt)
//
//select count(1) into :ll_cnt from t_verrat where cie_no = '119' and elimin is null using CIPQADMIN;
//dw_veriftrans.setItem(ll_row,'c119_110', ll_cnt)
//
//select count(1) into :ll_cnt from t_verrat where cie_no = '119' and elimin is null using CIPQLAB;
//dw_veriftrans.setItem(ll_row,'c119_119', ll_cnt)
//
//ll_row = dw_veriftrans.insertRow(0)
//dw_veriftrans.setItem(ll_row,'table','Eleveur')
//dw_veriftrans.setItem(ll_row,'dattrans','1901-01-01')
//
//select count(1)  into :ll_cnt from t_eleveur where isnull(chkactivite,0) = 1 using CIPQADMIN;
//dw_veriftrans.setItem(ll_row,'c111_110', ll_cnt)
//dw_veriftrans.setItem(ll_row,'c112_110', ll_cnt)
//dw_veriftrans.setItem(ll_row,'c113_110', ll_cnt)
//dw_veriftrans.setItem(ll_row,'c116_110', ll_cnt)
//
//select count(1)  into :ll_cnt from t_eleveur where isnull(chkactivite,0) = 1 using CIPQLAB;
//dw_veriftrans.setItem(ll_row,'c111_111', ll_cnt)
//
//select count(1)  into :ll_cnt from t_eleveur where isnull(chkactivite,0) = 1 using CIPQROX;
//dw_veriftrans.setItem(ll_row,'c112_112', ll_cnt)
//
//select count(1)  into :ll_cnt from t_eleveur where isnull(chkactivite,0) = 1 using CIPQSTC;
//dw_veriftrans.setItem(ll_row,'c113_113', ll_cnt)
//
//select count(1)  into :ll_cnt from t_eleveur where isnull(chkactivite,0) = 1 using CIPQSTP;
//dw_veriftrans.setItem(ll_row,'c116_116', ll_cnt)
//
//ll_row = dw_veriftrans.insertRow(0)
//dw_veriftrans.setItem(ll_row,'table','Produit')
//dw_veriftrans.setItem(ll_row,'dattrans','1901-01-01')
//
//select count(1) into :ll_cnt from t_produit where actif = 1 using CIPQADMIN;
//dw_veriftrans.setItem(ll_row,'c111_110', ll_cnt)
//dw_veriftrans.setItem(ll_row,'c112_110', ll_cnt)
//dw_veriftrans.setItem(ll_row,'c113_110', ll_cnt)
//dw_veriftrans.setItem(ll_row,'c116_110', ll_cnt)
//
//select count(1) into :ll_cnt from t_produit where actif = 1 using CIPQLAB;
//dw_veriftrans.setItem(ll_row,'c111_111', ll_cnt)
//
//select count(1) into :ll_cnt from t_produit where actif = 1 using CIPQROX;
//dw_veriftrans.setItem(ll_row,'c112_112', ll_cnt)
//
//select count(1) into :ll_cnt from t_produit where actif = 1 using CIPQSTC;
//dw_veriftrans.setItem(ll_row,'c113_113', ll_cnt)
//
//select count(1) into :ll_cnt from t_produit where actif = 1 using CIPQSTP;
//dw_veriftrans.setItem(ll_row,'c116_116', ll_cnt)
//
//dw_veriftrans.groupcalc()
//dw_veriftrans.setRedraw(true)
//
//disconnect using CIPQADMIN;
//disconnect using CIPQLAB;
//disconnect using CIPQROX;
//disconnect using CIPQSTC;
//disconnect using CIPQSTP;
//
//
end subroutine

public function any of_diffarray (any aa_tab1[], any aa_tab2[]);long  i, j, k
boolean lb_present
any aa_ret[]

k = 1	
for i = 1 to upperbound(aa_tab1)

	lb_present = false
	for j = 1 to upperbound(aa_tab2)
		
		if aa_tab1[i] = aa_tab2[j] then
			lb_present = true
			exit
		end if
		
	next

	if lb_present = false then
		
		aa_ret[k] = aa_tab1[i]
		k++
		
	end if

next

for i = 1 to upperbound(aa_tab2)

	lb_present = false
	for j = 1 to upperbound(aa_tab1)
		
		if aa_tab2[i] = aa_tab1[j] then
			lb_present = true
			exit
		end if
		
	next

	if lb_present = false then
		
		aa_ret[k] = aa_tab2[i]
		k++
		
	end if

next

return aa_ret

end function

event pfc_postopen;call super::pfc_postopen;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Rechercher", "Search!")
uo_toolbar.of_AddItem("Imprimer", "Preview!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

//em_debut.text = string(today())
//em_fin.text = string(today())
end event

on w_veriftransdetail.create
int iCurrent
call super::create
this.uo_toolbar=create uo_toolbar
this.dw_veriftrans=create dw_veriftrans
this.st_prelevement=create st_prelevement
this.st_doseprod=create st_doseprod
this.st_doseexp=create st_doseexp
this.st_bonliv=create st_bonliv
this.st_detbonliv=create st_detbonliv
this.st_coteprem=create st_coteprem
this.st_111=create st_111
this.dw_recherche=create dw_recherche
this.st_112=create st_112
this.st_113=create st_113
this.st_116=create st_116
this.st_115=create st_115
this.st_118=create st_118
this.st_119=create st_119
this.st_114=create st_114
this.st_117=create st_117
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar
this.Control[iCurrent+2]=this.dw_veriftrans
this.Control[iCurrent+3]=this.st_prelevement
this.Control[iCurrent+4]=this.st_doseprod
this.Control[iCurrent+5]=this.st_doseexp
this.Control[iCurrent+6]=this.st_bonliv
this.Control[iCurrent+7]=this.st_detbonliv
this.Control[iCurrent+8]=this.st_coteprem
this.Control[iCurrent+9]=this.st_111
this.Control[iCurrent+10]=this.dw_recherche
this.Control[iCurrent+11]=this.st_112
this.Control[iCurrent+12]=this.st_113
this.Control[iCurrent+13]=this.st_116
this.Control[iCurrent+14]=this.st_115
this.Control[iCurrent+15]=this.st_118
this.Control[iCurrent+16]=this.st_119
this.Control[iCurrent+17]=this.st_114
this.Control[iCurrent+18]=this.st_117
end on

on w_veriftransdetail.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_toolbar)
destroy(this.dw_veriftrans)
destroy(this.st_prelevement)
destroy(this.st_doseprod)
destroy(this.st_doseexp)
destroy(this.st_bonliv)
destroy(this.st_detbonliv)
destroy(this.st_coteprem)
destroy(this.st_111)
destroy(this.dw_recherche)
destroy(this.st_112)
destroy(this.st_113)
destroy(this.st_116)
destroy(this.st_115)
destroy(this.st_118)
destroy(this.st_119)
destroy(this.st_114)
destroy(this.st_117)
end on

event open;call super::open;string ls_date

ls_date = message.stringparm

ldt_date = date(long(left(ls_date,4)), long(mid(ls_date,6,2)), long(right(ls_date,2)))


end event

type st_title from w_sheet_frame`st_title within w_veriftransdetail
end type

type p_8 from w_sheet_frame`p_8 within w_veriftransdetail
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_veriftransdetail
integer x = 37
integer y = 32
integer width = 4736
end type

type uo_toolbar from u_cst_toolbarstrip within w_veriftransdetail
integer x = 23
integer y = 2264
integer width = 4759
integer taborder = 10
boolean bringtotop = true
end type

on uo_toolbar.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_buttonclicked;call super::ue_buttonclicked;CHOOSE CASE as_button
	CASE "Rechercher"
		of_rechercher()
	CASE "Imprimer"
		dw_veriftrans.print(false,true)
	CASE "Fermer"
		close(parent)
END CHOOSE
end event

type dw_veriftrans from u_dw within w_veriftransdetail
integer x = 4585
integer y = 36
integer width = 151
integer height = 104
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_veriftrans"
end type

type st_prelevement from statictext within w_veriftransdetail
integer x = 55
integer y = 168
integer width = 782
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421504
string text = "Prélevement"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;st_prelevement.backcolor = rgb(0,0,255)
st_doseprod.backcolor = rgb(128,128,128)
st_doseexp.backcolor = rgb(128,128,128)
st_bonliv.backcolor = rgb(128,128,128)
st_detbonliv.backcolor = rgb(128,128,128)
st_coteprem.backcolor = rgb(128,128,128)
il_type = 1
of_rechercher()
end event

type st_doseprod from statictext within w_veriftransdetail
integer x = 841
integer y = 168
integer width = 782
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421504
string text = "Nbr. dpses PROD"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;st_prelevement.backcolor = rgb(128,128,128)
st_doseprod.backcolor = rgb(0,0,255)
st_doseexp.backcolor = rgb(128,128,128)
st_bonliv.backcolor = rgb(128,128,128)
st_detbonliv.backcolor = rgb(128,128,128)
st_coteprem.backcolor = rgb(128,128,128)
il_type = 2
of_rechercher()
end event

type st_doseexp from statictext within w_veriftransdetail
integer x = 1627
integer y = 168
integer width = 782
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421504
string text = "Nbr. dpses EXP"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;st_prelevement.backcolor = rgb(128,128,128)
st_doseprod.backcolor = rgb(128,128,128)
st_doseexp.backcolor = rgb(0,0,255)
st_bonliv.backcolor = rgb(128,128,128)
st_detbonliv.backcolor = rgb(128,128,128)
st_coteprem.backcolor = rgb(128,128,128)
il_type = 3
of_rechercher()
end event

type st_bonliv from statictext within w_veriftransdetail
integer x = 2414
integer y = 168
integer width = 782
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421504
string text = "Bon de liv."
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;st_prelevement.backcolor = rgb(128,128,128)
st_doseprod.backcolor = rgb(128,128,128)
st_doseexp.backcolor = rgb(128,128,128)
st_bonliv.backcolor = rgb(0,0,255)
st_detbonliv.backcolor = rgb(128,128,128)
st_coteprem.backcolor = rgb(128,128,128)
il_type = 4
of_rechercher()
end event

type st_detbonliv from statictext within w_veriftransdetail
integer x = 3200
integer y = 168
integer width = 782
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421504
string text = "Det. bon de liv."
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;st_prelevement.backcolor = rgb(128,128,128)
st_doseprod.backcolor = rgb(128,128,128)
st_doseexp.backcolor = rgb(128,128,128)
st_bonliv.backcolor = rgb(128,128,128)
st_detbonliv.backcolor = rgb(0,0,255)
st_coteprem.backcolor = rgb(128,128,128)
il_type = 5
of_rechercher()
end event

type st_coteprem from statictext within w_veriftransdetail
integer x = 3986
integer y = 168
integer width = 782
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421504
string text = "Cote premption"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;st_prelevement.backcolor = rgb(128,128,128)
st_doseprod.backcolor = rgb(128,128,128)
st_doseexp.backcolor = rgb(128,128,128)
st_bonliv.backcolor = rgb(128,128,128)
st_detbonliv.backcolor = rgb(128,128,128)
st_coteprem.backcolor = rgb(0,0,255)
il_type = 6
of_rechercher()
end event

type st_111 from statictext within w_veriftransdetail
integer x = 55
integer y = 268
integer width = 512
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421504
string text = "ADM - 111"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;st_111.backcolor = rgb(0,0,255)
st_112.backcolor = rgb(128,128,128)
st_113.backcolor = rgb(128,128,128)
st_116.backcolor = rgb(128,128,128)
st_115.backcolor = rgb(128,128,128)
st_118.backcolor = rgb(128,128,128)
st_119.backcolor = rgb(128,128,128)
st_114.backcolor = rgb(128,128,128)
st_117.backcolor = rgb(128,128,128)
Il_centre = 1
of_rechercher( )
end event

type dw_recherche from u_dw within w_veriftransdetail
integer x = 59
integer y = 376
integer width = 4704
integer height = 1860
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_veriftransinfo"
end type

type st_112 from statictext within w_veriftransdetail
integer x = 571
integer y = 268
integer width = 512
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421504
string text = "ADM - 112"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;st_111.backcolor = rgb(128,128,128)
st_112.backcolor = rgb(0,0,255)
st_113.backcolor = rgb(128,128,128)
st_116.backcolor = rgb(128,128,128)
st_115.backcolor = rgb(128,128,128)
st_118.backcolor = rgb(128,128,128)
st_119.backcolor = rgb(128,128,128)
st_114.backcolor = rgb(128,128,128)
st_117.backcolor = rgb(128,128,128)
Il_centre = 2
of_rechercher( )
end event

type st_113 from statictext within w_veriftransdetail
integer x = 1088
integer y = 268
integer width = 512
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421504
string text = "ADM - 113"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;st_111.backcolor = rgb(128,128,128)
st_112.backcolor = rgb(128,128,128)
st_113.backcolor = rgb(0,0,255)
st_116.backcolor = rgb(128,128,128)
st_115.backcolor = rgb(128,128,128)
st_118.backcolor = rgb(128,128,128)
st_119.backcolor = rgb(128,128,128)
st_114.backcolor = rgb(128,128,128)
st_117.backcolor = rgb(128,128,128)
Il_centre = 3
of_rechercher( )
end event

type st_116 from statictext within w_veriftransdetail
integer x = 1605
integer y = 268
integer width = 512
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421504
string text = "ADM - 116"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;st_111.backcolor = rgb(128,128,128)
st_112.backcolor = rgb(128,128,128)
st_113.backcolor = rgb(128,128,128)
st_116.backcolor = rgb(0,0,255)
st_115.backcolor = rgb(128,128,128)
st_118.backcolor = rgb(128,128,128)
st_119.backcolor = rgb(128,128,128)
st_114.backcolor = rgb(128,128,128)
st_117.backcolor = rgb(128,128,128)
Il_centre = 4
of_rechercher( )
end event

type st_115 from statictext within w_veriftransdetail
integer x = 2121
integer y = 268
integer width = 512
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421504
string text = "ADM - 115"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;st_111.backcolor = rgb(128,128,128)
st_112.backcolor = rgb(128,128,128)
st_113.backcolor = rgb(128,128,128)
st_116.backcolor = rgb(128,128,128)
st_115.backcolor = rgb(0,0,255)
st_118.backcolor = rgb(128,128,128)
st_119.backcolor = rgb(128,128,128)
st_114.backcolor = rgb(128,128,128)
st_117.backcolor = rgb(128,128,128)
Il_centre = 5
of_rechercher( )
end event

type st_118 from statictext within w_veriftransdetail
integer x = 2642
integer y = 268
integer width = 512
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421504
string text = "ADM - 118"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;st_111.backcolor = rgb(128,128,128)
st_112.backcolor = rgb(128,128,128)
st_113.backcolor = rgb(128,128,128)
st_116.backcolor = rgb(128,128,128)
st_115.backcolor = rgb(128,128,128)
st_118.backcolor = rgb(0,0,255)
st_119.backcolor = rgb(128,128,128)
st_114.backcolor = rgb(128,128,128)
st_117.backcolor = rgb(128,128,128)
Il_centre = 6
of_rechercher( )
end event

type st_119 from statictext within w_veriftransdetail
integer x = 3159
integer y = 268
integer width = 512
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421504
string text = "ADM - 119"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;st_111.backcolor = rgb(128,128,128)
st_112.backcolor = rgb(128,128,128)
st_113.backcolor = rgb(128,128,128)
st_116.backcolor = rgb(128,128,128)
st_115.backcolor = rgb(128,128,128)
st_118.backcolor = rgb(128,128,128)
st_119.backcolor = rgb(0,0,255)
st_114.backcolor = rgb(128,128,128)
st_117.backcolor = rgb(128,128,128)
Il_centre = 7
of_rechercher( )
end event

type st_114 from statictext within w_veriftransdetail
integer x = 3680
integer y = 268
integer width = 512
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421504
string text = "ADM - 114"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;st_111.backcolor = rgb(128,128,128)
st_112.backcolor = rgb(128,128,128)
st_113.backcolor = rgb(128,128,128)
st_116.backcolor = rgb(128,128,128)
st_115.backcolor = rgb(128,128,128)
st_118.backcolor = rgb(128,128,128)
st_119.backcolor = rgb(128,128,128)
st_114.backcolor = rgb(0,0,255)
st_117.backcolor = rgb(128,128,128)
Il_centre = 8
of_rechercher( )
end event

type st_117 from statictext within w_veriftransdetail
integer x = 4206
integer y = 268
integer width = 512
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421504
string text = "ADM - 117"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;st_111.backcolor = rgb(128,128,128)
st_112.backcolor = rgb(128,128,128)
st_113.backcolor = rgb(128,128,128)
st_116.backcolor = rgb(128,128,128)
st_115.backcolor = rgb(128,128,128)
st_118.backcolor = rgb(128,128,128)
st_119.backcolor = rgb(128,128,128)
st_114.backcolor = rgb(128,128,128)
st_117.backcolor = rgb(0,0,255)
Il_centre = 9
of_rechercher( )
end event

