$PBExportHeader$w_veriftrans.srw
forward
global type w_veriftrans from w_sheet_frame
end type
type uo_toolbar from u_cst_toolbarstrip within w_veriftrans
end type
type dw_veriftrans from u_dw within w_veriftrans
end type
type st_1 from statictext within w_veriftrans
end type
type em_fin from editmask within w_veriftrans
end type
type st_2 from statictext within w_veriftrans
end type
type em_debut from editmask within w_veriftrans
end type
type rr_1 from roundrectangle within w_veriftrans
end type
end forward

global type w_veriftrans from w_sheet_frame
integer width = 4837
boolean ib_isupdateable = false
uo_toolbar uo_toolbar
dw_veriftrans dw_veriftrans
st_1 st_1
em_fin em_fin
st_2 st_2
em_debut em_debut
rr_1 rr_1
end type
global w_veriftrans w_veriftrans

forward prototypes
public subroutine of_rechercher ()
end prototypes

public subroutine of_rechercher ();long ll_row, ll_cnt, i, ll_cnt114a, ll_cnt115a, ll_cnt117a, ll_cnt118a, ll_cnt119a
long ll_cnt114b, ll_cnt115b, ll_cnt117b, ll_cnt118b, ll_cnt119b
dec{2}  ld_cnt114a, ld_cnt115a, ld_cnt117a, ld_cnt118a, ld_cnt119a
dec{2}  ld_cnt114b, ld_cnt115b, ld_cnt117b, ld_cnt118b, ld_cnt119b
transaction CIPQADMIN
transaction CIPQLAB
transaction CIPQROX
transaction CIPQSTC
transaction CIPQSTP
string ls_sql
date ldt_debut, ldt_fin, ldt_temp
dec{2} ld_cnt
CIPQADMIN = CREATE transaction
CIPQADMIN.DBMS       = 'ODBC'
CIPQADMIN.AutoCommit = True
CIPQADMIN.LOCK		  = "0"
CIPQADMIN.DbParm  = "ConnectString='DSN=cipq_admin;UID=dba;PWD=sql',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT'"
connect using CIPQADMIN;

dw_veriftrans.reset()

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

em_debut.getdata(ldt_debut)
em_fin.getdata(ldt_fin)

dw_veriftrans.object.t_datedebut.text = string(ldt_debut)
dw_veriftrans.object.t_datefin.text = string(ldt_fin)

dw_veriftrans.setRedraw(false)

ldt_temp  = ldt_debut
for i =  1 to daysafter(ldt_debut, ldt_fin) + 1
	
	ll_row = dw_veriftrans.insertRow(0)
	dw_veriftrans.setItem(ll_row,'table','Nbr .prélev.')
	dw_veriftrans.setItem(ll_row,'dattrans',ldt_temp)
	
	select count(1)  into :ll_cnt
	from t_recolte where cie_no = '112' and date_recolte = :ldt_temp using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c112_110', ll_cnt)
	
	select count(1)   into :ll_cnt
	from t_recolte where cie_no = '112' and date_recolte = :ldt_temp using CIPQROX;
	dw_veriftrans.setItem(ll_row,'c112_112', ll_cnt)
	
	select count(1)  into :ll_cnt
	from t_recolte where cie_no = '113' and date_recolte = :ldt_temp using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c113_110', ll_cnt)
	
	select count(1)  into :ll_cnt
	from t_recolte where cie_no = '113' and date_recolte = :ldt_temp using CIPQSTC;
	dw_veriftrans.setItem(ll_row,'c113_113', ll_cnt)
	
	select count(1) into :ll_cnt
	from t_recolte where cie_no = '116' and date_recolte = :ldt_temp using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c116_110', ll_cnt)
	
	select count(1) into :ll_cnt
	from t_recolte where cie_no = '116' and date_recolte = :ldt_temp using CIPQSTP;
	dw_veriftrans.setItem(ll_row,'c116_116', ll_cnt)
	
	select count(1)  into :ll_cnt114a
	from t_recolte where cie_no = '114' and date_recolte = :ldt_temp using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c114_110', ll_cnt114a)
	
	select count(1)  into :ll_cnt114b 
	from t_recolte where cie_no = '114' and date_recolte = :ldt_temp using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c114_114', ll_cnt114b)
	
	select count(1)  into :ll_cnt115a 
	from t_recolte where cie_no = '115' and date_recolte = :ldt_temp using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c115_110', ll_cnt115a)
	
	select count(1)  into :ll_cnt115b
	from t_recolte where cie_no = '115' and date_recolte = :ldt_temp using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c115_115', ll_cnt115b)
	
	select count(1) into :ll_cnt117a
	from t_recolte where cie_no = '117' and date_recolte = :ldt_temp using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c117_110', ll_cnt117a)
	
	select count(1)  into :ll_cnt117b 
	from t_recolte where cie_no = '117' and date_recolte = :ldt_temp using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c117_117', ll_cnt117b)
	
	select count(1)  into :ll_cnt118a
	from t_recolte where cie_no = '118' and date_recolte = :ldt_temp using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c118_110', ll_cnt118a)
	
	select count(1)  into :ll_cnt118b
	from t_recolte where cie_no = '118' and date_recolte = :ldt_temp using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c118_118', ll_cnt118b)
	
	select count(1)  into :ll_cnt119a
	from t_recolte where cie_no = '119' and date_recolte = :ldt_temp using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c119_110', ll_cnt119a)

	select count(1)  into :ll_cnt119b
	from t_recolte where cie_no = '119' and date_recolte = :ldt_temp using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c119_119', ll_cnt119b)
	
	select count(1) into :ll_cnt 
	from t_recolte where cie_no = '111' and date_recolte = :ldt_temp using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c111_110', ll_cnt114a + ll_cnt115a + ll_cnt117a  + ll_cnt118a + ll_cnt119a)   	

	select count(1)  into :ll_cnt
	from t_recolte where cie_no = '111' and date_recolte = :ldt_temp using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c111_111', ll_cnt114b + ll_cnt115b + ll_cnt117b + ll_cnt118b + ll_cnt119b)
	
	ll_row = dw_veriftrans.insertRow(0)
	dw_veriftrans.setItem(ll_row,'table','Nbr .doses PROD')
	dw_veriftrans.setItem(ll_row,'dattrans',ldt_temp)
	
	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt
	from t_recolte where cie_no = '112' and date_recolte = :ldt_temp using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c112_110', ld_cnt)
	
	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt
	from t_recolte where cie_no = '112' and date_recolte = :ldt_temp using CIPQROX;
	dw_veriftrans.setItem(ll_row,'c112_112', ld_cnt)
	
	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt
	from t_recolte where cie_no = '113' and date_recolte = :ldt_temp using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c113_110', ld_cnt)
	
	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt
	from t_recolte where cie_no = '113' and date_recolte = :ldt_temp using CIPQSTC;
	dw_veriftrans.setItem(ll_row,'c113_113', ld_cnt)
	
	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt
	from t_recolte where cie_no = '116' and date_recolte = :ldt_temp using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c116_110', ld_cnt)
	
	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt
	from t_recolte where cie_no = '116' and date_recolte = :ldt_temp using CIPQSTP;
	dw_veriftrans.setItem(ll_row,'c116_116', ld_cnt)
	
	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt114a
	from t_recolte where cie_no = '114' and date_recolte = :ldt_temp using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c114_110', ld_cnt114a)
	
	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt114b
	from t_recolte where cie_no = '114' and date_recolte = :ldt_temp using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c114_114', ld_cnt114b)
	
	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt115a
	from t_recolte where cie_no = '115' and date_recolte = :ldt_temp using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c115_110', ld_cnt115a)
	
	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt115b
	from t_recolte where cie_no = '115' and date_recolte = :ldt_temp using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c115_115', ld_cnt115b)
	
	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt117a
	from t_recolte where cie_no = '117' and date_recolte = :ldt_temp using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c117_110', ld_cnt117a)
	
	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt117b
	from t_recolte where cie_no = '117' and date_recolte = :ldt_temp using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c117_117', ld_cnt117b)
	
	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt118a
	from t_recolte where cie_no = '118' and date_recolte = :ldt_temp using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c118_110', ld_cnt118a)
	
	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt118b
	from t_recolte where cie_no = '118' and date_recolte = :ldt_temp using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c118_118', ld_cnt118b)
	
	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt119a
	from t_recolte where cie_no = '119' and date_recolte = :ldt_temp using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c119_110', ld_cnt119a)
	
	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt119b
	from t_recolte where cie_no = '119' and date_recolte = :ldt_temp using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c119_119', ld_cnt119b)
	
	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt 
	from t_recolte where cie_no = '111' and date_recolte = :ldt_temp using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c111_110', ld_cnt114a + ld_cnt115a  + ld_cnt117a + ld_cnt118a + ld_cnt119a)
	
	select isnull(sum(isnull(ampo_total,0)),0) into :ld_cnt
	from t_recolte where cie_no = '111' and date_recolte = :ldt_temp using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c111_111', ld_cnt114b + ld_cnt115b  + ld_cnt117b + ld_cnt118b+ ld_cnt119b)
	
	ll_row = dw_veriftrans.insertRow(0)
	dw_veriftrans.setItem(ll_row,'table','Nbr .doses EXP')
	dw_veriftrans.setItem(ll_row,'dattrans',ldt_temp)
	
	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
	where   date(liv_date) = :ldt_temp AND 
			  t_statfacture.cie_no = '111' AND 
			  t_produit.special = 1 using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c111_110', ld_cnt)	
	
	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
	where   date(liv_date) = :ldt_temp AND 
			  t_statfacture.cie_no = '111' AND 
			  t_produit.special = 1 using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c111_111', ld_cnt)
	
	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
	where   date(liv_date) = :ldt_temp AND 
			  t_statfacture.cie_no = '112' AND 
			  t_produit.special = 1 using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c112_110', ld_cnt)
	
	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
	where   date(liv_date) = :ldt_temp AND 
			  t_statfacture.cie_no = '112' AND 
			  t_produit.special = 1 using CIPQROX;
	dw_veriftrans.setItem(ll_row,'c112_112', ld_cnt)
	
	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
	where   date(liv_date) = :ldt_temp AND 
			  t_statfacture.cie_no = '113' AND 
			  t_produit.special = 1 using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c113_110', ld_cnt)
	
	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
	where   date(liv_date) = :ldt_temp AND 
			  t_statfacture.cie_no = '113' AND 
			  t_produit.special = 1 using CIPQSTC;
	dw_veriftrans.setItem(ll_row,'c113_113', ld_cnt)
	
	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
	where   date(liv_date) = :ldt_temp AND 
			  t_statfacture.cie_no = '116' AND 
			  t_produit.special = 1 using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c116_110', ld_cnt)
	
	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
	where   date(liv_date) = :ldt_temp AND 
			  t_statfacture.cie_no = '116' AND 
			  t_produit.special = 1 using CIPQSTP;
	dw_veriftrans.setItem(ll_row,'c116_116', ld_cnt)
	
	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
	where   date(liv_date) = :ldt_temp AND 
			  t_statfacture.cie_no = '114' AND 
			  t_produit.special = 1 using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c114_110', ld_cnt)
	
	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
	where   date(liv_date) = :ldt_temp AND 
			  t_statfacture.cie_no = '114' AND 
			  t_produit.special = 1 using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c114_114', ld_cnt)
	
	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
	where   date(liv_date) = :ldt_temp AND 
			  t_statfacture.cie_no = '115' AND 
			  t_produit.special = 1 using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c115_110', ld_cnt)
	
	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
	where   date(liv_date) = :ldt_temp AND 
			  t_statfacture.cie_no = '115' AND 
			  t_produit.special = 1 using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c115_115', ld_cnt)
	
	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
	where   date(liv_date) = :ldt_temp AND 
			  t_statfacture.cie_no = '117' AND 
			  t_produit.special = 1 using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c117_110', ld_cnt)
	
	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
	where   date(liv_date) = :ldt_temp AND 
			  t_statfacture.cie_no = '117' AND 
			  t_produit.special = 1 using CIPQSTP;
	dw_veriftrans.setItem(ll_row,'c117_117', ld_cnt)
	
	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
	where   date(liv_date) = :ldt_temp AND 
			  t_statfacture.cie_no = '118' AND 
			  t_produit.special = 1 using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c118_110', ld_cnt)
	
	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
	where   date(liv_date) = :ldt_temp AND 
			  t_statfacture.cie_no = '118' AND 
			  t_produit.special = 1 using CIPQSTP;
	dw_veriftrans.setItem(ll_row,'c118_118', ld_cnt)
	
	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
	where   date(liv_date) = :ldt_temp AND 
			  t_statfacture.cie_no = '119' AND 
			  t_produit.special = 1 using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c119_110', ld_cnt)
	
	select isnull(sum(isnull(t_statfacturedetail.QTE_EXP,0)),0) into :ld_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.liv_no = t_statfacture.liv_no and t_statfacture.cie_no = t_statfacturedetail.cie_no
									 INNER JOIN t_produit ON t_produit.noproduit = t_statfacturedetail.prod_no
	where   date(liv_date) = :ldt_temp AND 
			  t_statfacture.cie_no = '119' AND 
			  t_produit.special = 1 using CIPQSTP;
	dw_veriftrans.setItem(ll_row,'c119_119', ld_cnt)
	
	ll_row = dw_veriftrans.insertRow(0)
	dw_veriftrans.setItem(ll_row,'table','Bon. liv.')
	dw_veriftrans.setItem(ll_row,'dattrans',ldt_temp)
	
	select  count(1)  into :ll_cnt
	from t_statfacture
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '111' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c111_110', ll_cnt)	
	
	select  count(1) into :ll_cnt
	from t_statfacture
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '111' using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c111_111', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacture
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '112'  using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c112_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacture
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '112' using CIPQROX;
	dw_veriftrans.setItem(ll_row,'c112_112', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacture
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '113'  using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c113_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacture
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '113'  using CIPQSTC;
	dw_veriftrans.setItem(ll_row,'c113_113', ll_cnt)
		
	select  count(1) into :ll_cnt
	from t_statfacture
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '116' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c116_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacture
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '116'  using CIPQSTP;
	dw_veriftrans.setItem(ll_row,'c116_116', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacture
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '114' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c114_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacture
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '114' using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c114_114', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacture
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '115'  using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c115_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacture
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '115' using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c115_115', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacture
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '117'  using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c117_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacture
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '117' using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c117_117', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacture
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '118' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c118_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacture
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '118'  using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c118_118', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacture
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '119' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c119_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacture
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '119' using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c119_119', ll_cnt)	
	
	ll_row = dw_veriftrans.insertRow(0)
	dw_veriftrans.setItem(ll_row,'table','Det .bon. liv.')
	dw_veriftrans.setItem(ll_row,'dattrans',ldt_temp)
	
	select  count(1) into :ll_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '111' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c111_110', ll_cnt)	
	
	select  count(1) into :ll_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '111' using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c111_111', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '112' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c112_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '112' using CIPQROX;
	dw_veriftrans.setItem(ll_row,'c112_112', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '113' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c113_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '113' using CIPQSTC;
	dw_veriftrans.setItem(ll_row,'c113_113', ll_cnt)
		
	select  count(1) into :ll_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '116' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c116_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '116' using CIPQSTP;
	dw_veriftrans.setItem(ll_row,'c116_116', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '114' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c114_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '114' using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c114_114', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '115' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c115_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '115' using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c115_115', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '117' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c117_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '117' using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c117_117', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '118' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c118_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '118' using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c118_118', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '119' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c119_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_statfacturedetail INNER JOIN t_statfacture ON t_statfacturedetail.cie_no = t_statfacture.cie_no AND t_statfacturedetail.liv_no = t_statfacture.liv_no
	where date(liv_date) = :ldt_temp and t_statfacture.cie_no = '119' using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c119_119', ll_cnt)	
	
	ll_row = dw_veriftrans.insertRow(0)
	dw_veriftrans.setItem(ll_row,'table','Cote premption.')
	dw_veriftrans.setItem(ll_row,'dattrans',ldt_temp)
	
	select  count(1) into :ll_cnt
	from t_recolte_cote_peremption
	where date(date_recolte) = :ldt_temp and cie_no = '111' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c111_110', ll_cnt)	
	
	select  count(1) into :ll_cnt
	from t_recolte_cote_peremption
	where date(date_recolte) = :ldt_temp and cie_no = '111' using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c111_111', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_recolte_cote_peremption
	where date(date_recolte) = :ldt_temp and cie_no = '112' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c112_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_recolte_cote_peremption
	where date(date_recolte) = :ldt_temp and cie_no = '112' using CIPQROX;
	dw_veriftrans.setItem(ll_row,'c112_112', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_recolte_cote_peremption
	where date(date_recolte) = :ldt_temp and cie_no = '113' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c113_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_recolte_cote_peremption
	where date(date_recolte) = :ldt_temp and cie_no = '113' using CIPQSTC;
	dw_veriftrans.setItem(ll_row,'c113_113', ll_cnt)
		
	select  count(1) into :ll_cnt
	from t_recolte_cote_peremption
	where date(date_recolte) = :ldt_temp and cie_no = '116' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c116_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_recolte_cote_peremption
	where date(date_recolte) = :ldt_temp and cie_no = '116' using CIPQSTP;
	dw_veriftrans.setItem(ll_row,'c116_116', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_recolte_cote_peremption
	where date(date_recolte) = :ldt_temp and cie_no = '114' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c114_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_recolte_cote_peremption
	where date(date_recolte) = :ldt_temp and cie_no = '114' using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c114_114', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_recolte_cote_peremption
	where date(date_recolte) = :ldt_temp and cie_no = '115' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c115_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_recolte_cote_peremption
	where date(date_recolte) = :ldt_temp and cie_no = '115' using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c115_115', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_recolte_cote_peremption
	where date(date_recolte) = :ldt_temp and cie_no = '117' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c117_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_recolte_cote_peremption
	where date(date_recolte) = :ldt_temp and cie_no = '117' using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c117_117', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_recolte_cote_peremption
	where date(date_recolte) = :ldt_temp and cie_no = '118' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c118_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_recolte_cote_peremption
	where date(date_recolte) = :ldt_temp and cie_no = '118' using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c118_118', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_recolte_cote_peremption
	where date(date_recolte) = :ldt_temp and cie_no = '119' using CIPQADMIN;
	dw_veriftrans.setItem(ll_row,'c119_110', ll_cnt)
	
	select  count(1) into :ll_cnt
	from t_recolte_cote_peremption
	where date(date_recolte) = :ldt_temp and cie_no = '119' using CIPQLAB;
	dw_veriftrans.setItem(ll_row,'c119_119', ll_cnt)	
	
	ldt_temp = relativedate(ldt_debut,i)
	
next

// Verrat 

ll_row = dw_veriftrans.insertRow(0)
dw_veriftrans.setItem(ll_row,'table','Verrat')
dw_veriftrans.setItem(ll_row,'dattrans','1901-01-01')

select count(1) into :ll_cnt from t_verrat where cie_no = '111' and elimin is null using CIPQADMIN;
dw_veriftrans.setItem(ll_row,'c111_110', ll_cnt)

select count(1) into :ll_cnt from t_verrat where cie_no = '111'  and elimin is null using CIPQLAB;
dw_veriftrans.setItem(ll_row,'c111_111', ll_cnt)

select count(1) into :ll_cnt from t_verrat where cie_no = '112' and elimin is null using CIPQADMIN;
dw_veriftrans.setItem(ll_row,'c112_110', ll_cnt)

select count(1) into :ll_cnt from t_verrat where cie_no = '112' and elimin is null using CIPQROX;
dw_veriftrans.setItem(ll_row,'c112_112', ll_cnt)

select count(1) into :ll_cnt from t_verrat where cie_no = '113' and elimin is null using CIPQADMIN;
dw_veriftrans.setItem(ll_row,'c113_110', ll_cnt)

select count(1) into :ll_cnt from t_verrat where cie_no = '113' and elimin is null using CIPQSTC;
dw_veriftrans.setItem(ll_row,'c113_113', ll_cnt)

select count(1) into :ll_cnt from t_verrat where cie_no = '116' and elimin is null using CIPQADMIN;
dw_veriftrans.setItem(ll_row,'c116_110', ll_cnt)

select count(1) into :ll_cnt from t_verrat where cie_no = '116' and elimin is null using CIPQSTP;
dw_veriftrans.setItem(ll_row,'c116_116', ll_cnt)

select count(1) into :ll_cnt from t_verrat where cie_no = '114' and elimin is null using CIPQADMIN;
dw_veriftrans.setItem(ll_row,'c114_110', ll_cnt)

select count(1) into :ll_cnt from t_verrat where cie_no = '114' and elimin is null using CIPQLAB;
dw_veriftrans.setItem(ll_row,'c114_114', ll_cnt)

select count(1) into :ll_cnt from t_verrat where cie_no = '115' and elimin is null using CIPQADMIN;
dw_veriftrans.setItem(ll_row,'c115_110', ll_cnt)

select count(1) into :ll_cnt from t_verrat where cie_no = '115' and elimin is null using CIPQLAB;
dw_veriftrans.setItem(ll_row,'c115_115', ll_cnt)

select count(1) into :ll_cnt from t_verrat where cie_no = '117' and elimin is null using CIPQADMIN;
dw_veriftrans.setItem(ll_row,'c117_110', ll_cnt)

select count(1) into :ll_cnt from t_verrat where cie_no = '117' and elimin is null using CIPQLAB;
dw_veriftrans.setItem(ll_row,'c117_117', ll_cnt)

select count(1) into :ll_cnt from t_verrat where cie_no = '118' and elimin is null using CIPQADMIN;
dw_veriftrans.setItem(ll_row,'c118_110', ll_cnt)

select count(1) into :ll_cnt from t_verrat where cie_no = '118' and elimin is null using CIPQLAB;
dw_veriftrans.setItem(ll_row,'c118_118', ll_cnt)

select count(1) into :ll_cnt from t_verrat where cie_no = '119' and elimin is null using CIPQADMIN;
dw_veriftrans.setItem(ll_row,'c119_110', ll_cnt)

select count(1) into :ll_cnt from t_verrat where cie_no = '119' and elimin is null using CIPQLAB;
dw_veriftrans.setItem(ll_row,'c119_119', ll_cnt)

ll_row = dw_veriftrans.insertRow(0)
dw_veriftrans.setItem(ll_row,'table','Eleveur')
dw_veriftrans.setItem(ll_row,'dattrans','1901-01-01')

select count(1)  into :ll_cnt from t_eleveur where isnull(chkactivite,0) = 1 using CIPQADMIN;
dw_veriftrans.setItem(ll_row,'c111_110', ll_cnt)
dw_veriftrans.setItem(ll_row,'c112_110', ll_cnt)
dw_veriftrans.setItem(ll_row,'c113_110', ll_cnt)
dw_veriftrans.setItem(ll_row,'c116_110', ll_cnt)

select count(1)  into :ll_cnt from t_eleveur where isnull(chkactivite,0) = 1 using CIPQLAB;
dw_veriftrans.setItem(ll_row,'c111_111', ll_cnt)

select count(1)  into :ll_cnt from t_eleveur where isnull(chkactivite,0) = 1 using CIPQROX;
dw_veriftrans.setItem(ll_row,'c112_112', ll_cnt)

select count(1)  into :ll_cnt from t_eleveur where isnull(chkactivite,0) = 1 using CIPQSTC;
dw_veriftrans.setItem(ll_row,'c113_113', ll_cnt)

select count(1)  into :ll_cnt from t_eleveur where isnull(chkactivite,0) = 1 using CIPQSTP;
dw_veriftrans.setItem(ll_row,'c116_116', ll_cnt)

ll_row = dw_veriftrans.insertRow(0)
dw_veriftrans.setItem(ll_row,'table','Produit')
dw_veriftrans.setItem(ll_row,'dattrans','1901-01-01')

select count(1) into :ll_cnt from t_produit where actif = 1 using CIPQADMIN;
dw_veriftrans.setItem(ll_row,'c111_110', ll_cnt)
dw_veriftrans.setItem(ll_row,'c112_110', ll_cnt)
dw_veriftrans.setItem(ll_row,'c113_110', ll_cnt)
dw_veriftrans.setItem(ll_row,'c116_110', ll_cnt)

select count(1) into :ll_cnt from t_produit where actif = 1 using CIPQLAB;
dw_veriftrans.setItem(ll_row,'c111_111', ll_cnt)

select count(1) into :ll_cnt from t_produit where actif = 1 using CIPQROX;
dw_veriftrans.setItem(ll_row,'c112_112', ll_cnt)

select count(1) into :ll_cnt from t_produit where actif = 1 using CIPQSTC;
dw_veriftrans.setItem(ll_row,'c113_113', ll_cnt)

select count(1) into :ll_cnt from t_produit where actif = 1 using CIPQSTP;
dw_veriftrans.setItem(ll_row,'c116_116', ll_cnt)

dw_veriftrans.groupcalc()
dw_veriftrans.setRedraw(true)

disconnect using CIPQADMIN;
disconnect using CIPQLAB;
disconnect using CIPQROX;
disconnect using CIPQSTC;
disconnect using CIPQSTP;


end subroutine

event pfc_postopen;call super::pfc_postopen;uo_toolbar.of_settheme("classic")
uo_toolbar.of_DisplayBorder(true)
uo_toolbar.of_AddItem("Rechercher", "Search!")
uo_toolbar.of_AddItem("Imprimer", "Preview!")
uo_toolbar.of_AddItem("Fermer", "Exit!")
uo_toolbar.of_displaytext(true)

em_debut.text = string(today())
em_fin.text = string(today())
end event

on w_veriftrans.create
int iCurrent
call super::create
this.uo_toolbar=create uo_toolbar
this.dw_veriftrans=create dw_veriftrans
this.st_1=create st_1
this.em_fin=create em_fin
this.st_2=create st_2
this.em_debut=create em_debut
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toolbar
this.Control[iCurrent+2]=this.dw_veriftrans
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.em_fin
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.em_debut
this.Control[iCurrent+7]=this.rr_1
end on

on w_veriftrans.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_toolbar)
destroy(this.dw_veriftrans)
destroy(this.st_1)
destroy(this.em_fin)
destroy(this.st_2)
destroy(this.em_debut)
destroy(this.rr_1)
end on

type st_title from w_sheet_frame`st_title within w_veriftrans
end type

type p_8 from w_sheet_frame`p_8 within w_veriftrans
end type

type rr_infopat from w_sheet_frame`rr_infopat within w_veriftrans
integer y = 32
integer width = 4736
end type

type uo_toolbar from u_cst_toolbarstrip within w_veriftrans
integer x = 23
integer y = 2264
integer width = 3424
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

type dw_veriftrans from u_dw within w_veriftrans
integer x = 46
integer y = 216
integer width = 4722
integer height = 1992
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_veriftrans"
end type

event doubleclicked;call super::doubleclicked;date ldt_date

ldt_date = this.getITemDate(row,'dattrans')

opensheetwithparm(w_veriftransdetail,string(ldt_date,'yyyy-mm-dd'), gnv_app.of_getFrame(),6,layered!)
end event

type st_1 from statictext within w_veriftrans
integer x = 3502
integer y = 2292
integer width = 123
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Du"
boolean focusrectangle = false
end type

type em_fin from editmask within w_veriftrans
integer x = 4315
integer y = 2268
integer width = 421
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type st_2 from statictext within w_veriftrans
integer x = 4146
integer y = 2292
integer width = 123
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "au"
boolean focusrectangle = false
end type

type em_debut from editmask within w_veriftrans
integer x = 3657
integer y = 2272
integer width = 421
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type rr_1 from roundrectangle within w_veriftrans
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 15793151
integer x = 32
integer y = 188
integer width = 4763
integer height = 2048
integer cornerheight = 40
integer cornerwidth = 46
end type

