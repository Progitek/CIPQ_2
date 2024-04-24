$PBExportHeader$pro_u_lb.sru
$PBExportComments$(PRO) Extension Listbox class
forward
global type pro_u_lb from pfc_u_lb
end type
end forward

global type pro_u_lb from pfc_u_lb
end type
global pro_u_lb pro_u_lb

type variables
Protected:
n_lbi inv_items[]
integer ii_currentItem
integer ii_selectedItems[]
string is_sorted = ""

end variables

forward prototypes
protected function integer swap (ref n_lbi anv_item1, ref n_lbi anv_item2)
protected subroutine of_quicksortdc (unsignedinteger ai_g, unsignedinteger ai_d)
protected subroutine of_quicksortdd (unsignedinteger ai_g, unsignedinteger ai_d)
protected subroutine of_quicksortlc (unsignedinteger ai_g, unsignedinteger ai_d)
protected subroutine of_quicksortld (unsignedinteger ai_g, unsignedinteger ai_d)
protected function integer of_binsearchlc (ref n_lbi anv_item, integer ai_g, integer ai_d)
protected function integer of_binsearchdc (ref n_lbi anv_item, integer ai_g, integer ai_d)
protected function integer of_binsearchdd (ref n_lbi anv_item, integer ai_g, integer ai_d)
protected function integer of_binsearchld (ref n_lbi anv_item, integer ai_g, integer ai_d)
protected function integer of_insert (n_lbi anv_item, integer ai_index)
protected function integer of_additem (n_lbi anv_item)
public function integer of_additem (string as_item, any aa_data)
public function integer of_additem (string as_item)
public function integer of_deleteitem (integer ai_index)
public function integer of_deleteitem (any aa_data, boolean ab_label)
public function integer of_finditem (any aa_item, integer ai_index, boolean ab_label, boolean ab_exact)
public function integer of_finditem (any aa_item, integer ai_index, boolean ab_label)
public function string of_getlabel (integer ai_index)
public function any of_getdata (integer ai_index)
public function any of_getselecteddata ()
public function any of_getselectedlabel ()
public function string of_getsorted ()
public function integer of_insertitem (string as_item, any aa_data, integer ai_index)
public function integer of_insertitem (string as_item, integer ai_index)
public function integer of_reset ()
public function integer of_selecteditem ()
public function integer of_selectitem (integer ai_index)
public function integer of_selectitem (any aa_item, integer ai_index, boolean ab_label, boolean ab_exact)
public function integer of_selectitem (any aa_item, integer ai_index, boolean ab_label)
public function integer of_setsorted (string as_critere)
public function integer of_isselected (integer ai_index)
protected function integer of_binsrchsel (integer ai_index, integer ai_g, integer ai_d)
public function integer of_setstate (integer ai_index, boolean ab_state)
end prototypes

protected function integer swap (ref n_lbi anv_item1, ref n_lbi anv_item2);// Fonction qui interchange 2 n_lbi
//
// Retourne un entier
// 1 - Succès
// -1 - Échec

n_lbi lnv_tmp

lnv_tmp = anv_item1
anv_item1 = anv_item2
anv_item2 = lnv_tmp

return 1

end function

protected subroutine of_quicksortdc (unsignedinteger ai_g, unsignedinteger ai_d);any la_pivot
uint i, j, k

if ai_g = ai_d - 1 then
	if inv_items[ai_g].of_getdata() > inv_items[ai_d].of_getdata() then
		// Échanger les valeurs des vercteurs 1 et 2
		swap(inv_items[ai_g], inv_items[ai_d])
	end if
elseif ai_g < ai_d then
	// Sélection du pivot
	k = int((ai_g + ai_d) / 2)
	i = ai_g
	j = ai_d
	
	if inv_items[i].of_getdata() < inv_items[j].of_getdata() then
		if inv_items[k].of_getdata() < inv_items[i].of_getdata() then
			la_pivot = inv_items[i].of_getdata()
		elseif inv_items[k].of_getdata() < inv_items[j].of_getdata() then
			la_pivot = inv_items[k].of_getdata()

			// Échanger les valeurs des vercteurs 1 et 2
			swap(inv_items[ai_g], inv_items[k])
		else
			la_pivot = inv_items[j].of_getdata()

			// Échanger les valeurs des vercteurs 1 et 2
			swap(inv_items[ai_g], inv_items[j])
		end if
	else
		if inv_items[k].of_getdata() < inv_items[j].of_getdata() then
			la_pivot = inv_items[j].of_getdata()

			// Échanger les valeurs des vercteurs 1 et 2
			swap(inv_items[ai_g], inv_items[j])
		elseif inv_items[k].of_getdata() < inv_items[i].of_getdata() then
			la_pivot = inv_items[k].of_getdata()

			// Échanger les valeurs des vercteurs 1 et 2
			swap(inv_items[ai_g], inv_items[k])
		else
			la_pivot = inv_items[i].of_getdata()
		end if
	end if
	
	do while i < j
		do while inv_items[i].of_getdata() <= la_pivot
			i ++
		loop

		do while inv_items[j].of_getdata() >= la_pivot
			j --
		loop
		
		if i < j then
			// Échanger les valeurs des vercteurs 1 et 2
			swap(inv_items[i], inv_items[j])
		end if
	loop

	// Échanger les valeurs des vercteurs 1 et 2
	swap(inv_items[ai_g], inv_items[j])
	
	of_quicksortdc(ai_g, j - 1)
	of_quicksortdc(j + 1, ai_d)
end if

end subroutine

protected subroutine of_quicksortdd (unsignedinteger ai_g, unsignedinteger ai_d);any la_pivot
uint i, j, k

if ai_g = ai_d - 1 then
	if inv_items[ai_g].of_getdata() < inv_items[ai_d].of_getdata() then
		// Échanger les valeurs des vercteurs 1 et 2
		swap(inv_items[ai_g], inv_items[ai_d])
	end if
elseif ai_g < ai_d then
	// Sélection du pivot
	k = int((ai_g + ai_d) / 2)
	i = ai_g
	j = ai_d
	
	if inv_items[i].of_getdata() > inv_items[j].of_getdata() then
		if inv_items[k].of_getdata() > inv_items[i].of_getdata() then
			la_pivot = inv_items[i].of_getdata()
		elseif inv_items[k].of_getdata() > inv_items[j].of_getdata() then
			la_pivot = inv_items[k].of_getdata()

			// Échanger les valeurs des vercteurs 1 et 2
			swap(inv_items[ai_g], inv_items[k])
		else
			la_pivot = inv_items[j].of_getdata()

			// Échanger les valeurs des vercteurs 1 et 2
			swap(inv_items[ai_g], inv_items[j])
		end if
	else
		if inv_items[k].of_getdata() > inv_items[j].of_getdata() then
			la_pivot = inv_items[j].of_getdata()

			// Échanger les valeurs des vercteurs 1 et 2
			swap(inv_items[ai_g], inv_items[j])
		elseif inv_items[k].of_getdata() > inv_items[i].of_getdata() then
			la_pivot = inv_items[k].of_getdata()

			// Échanger les valeurs des vercteurs 1 et 2
			swap(inv_items[ai_g], inv_items[k])
		else
			la_pivot = inv_items[i].of_getdata()
		end if
	end if
	
	do while i < j
		do while inv_items[i].of_getdata() >= la_pivot
			i ++
		loop

		do while inv_items[j].of_getdata() <= la_pivot
			j --
		loop
		
		if i < j then
			// Échanger les valeurs des vercteurs 1 et 2
			swap(inv_items[i], inv_items[j])
		end if
	loop

	// Échanger les valeurs des vercteurs 1 et 2
	swap(inv_items[ai_g], inv_items[j])
	
	of_quicksortdd(ai_g, j - 1)
	of_quicksortdd(j + 1, ai_d)
end if

end subroutine

protected subroutine of_quicksortlc (unsignedinteger ai_g, unsignedinteger ai_d);string ls_pivot
uint i, j, k

if ai_g = ai_d - 1 then
	if inv_items[ai_g].of_getlabel() > inv_items[ai_d].of_getlabel() then
		// Échanger les valeurs des vercteurs 1 et 2
		swap(inv_items[ai_g], inv_items[ai_d])
	end if
elseif ai_g < ai_d then
	// Sélection du pivot
	k = int((ai_g + ai_d) / 2)
	i = ai_g
	j = ai_d
	
	if inv_items[i].of_getlabel() < inv_items[j].of_getlabel() then
		if inv_items[k].of_getlabel() < inv_items[i].of_getlabel() then
			ls_pivot = inv_items[i].of_getlabel()
		elseif inv_items[k].of_getlabel() < inv_items[j].of_getlabel() then
			ls_pivot = inv_items[k].of_getlabel()

			// Échanger les valeurs des vercteurs 1 et 2
			swap(inv_items[ai_g], inv_items[k])
		else
			ls_pivot = inv_items[j].of_getlabel()

			// Échanger les valeurs des vercteurs 1 et 2
			swap(inv_items[ai_g], inv_items[j])
		end if
	else
		if inv_items[k].of_getlabel() < inv_items[j].of_getlabel() then
			ls_pivot = inv_items[j].of_getlabel()

			// Échanger les valeurs des vercteurs 1 et 2
			swap(inv_items[ai_g], inv_items[j])
		elseif inv_items[k].of_getlabel() < inv_items[i].of_getlabel() then
			ls_pivot = inv_items[k].of_getlabel()

			// Échanger les valeurs des vercteurs 1 et 2
			swap(inv_items[ai_g], inv_items[k])
		else
			ls_pivot = inv_items[i].of_getlabel()
		end if
	end if
	
	do while i < j
		do while inv_items[i].of_getlabel() <= ls_pivot
			i ++
		loop

		do while inv_items[j].of_getlabel() >= ls_pivot
			j --
		loop
		
		if i < j then
			// Échanger les valeurs des vercteurs 1 et 2
			swap(inv_items[i], inv_items[j])
		end if
	loop

	// Échanger les valeurs des vercteurs 1 et 2
	swap(inv_items[ai_g], inv_items[j])
	
	of_quicksortlc(ai_g, j - 1)
	of_quicksortlc(j + 1, ai_d)
end if

end subroutine

protected subroutine of_quicksortld (unsignedinteger ai_g, unsignedinteger ai_d);string ls_pivot
uint i, j, k

if ai_g = ai_d - 1 then
	if inv_items[ai_g].of_getlabel() < inv_items[ai_d].of_getlabel() then
		// Échanger les valeurs des vercteurs 1 et 2
		swap(inv_items[ai_g], inv_items[ai_d])
	end if
elseif ai_g < ai_d then
	// Sélection du pivot
	k = int((ai_g + ai_d) / 2)
	i = ai_g
	j = ai_d
	
	if inv_items[i].of_getlabel() > inv_items[j].of_getlabel() then
		if inv_items[k].of_getlabel() > inv_items[i].of_getlabel() then
			ls_pivot = inv_items[i].of_getlabel()
		elseif inv_items[k].of_getlabel() > inv_items[j].of_getlabel() then
			ls_pivot = inv_items[k].of_getlabel()

			// Échanger les valeurs des vercteurs 1 et 2
			swap(inv_items[ai_g], inv_items[k])
		else
			ls_pivot = inv_items[j].of_getlabel()

			// Échanger les valeurs des vercteurs 1 et 2
			swap(inv_items[ai_g], inv_items[j])
		end if
	else
		if inv_items[k].of_getlabel() > inv_items[j].of_getlabel() then
			ls_pivot = inv_items[j].of_getlabel()

			// Échanger les valeurs des vercteurs 1 et 2
			swap(inv_items[ai_g], inv_items[j])
		elseif inv_items[k].of_getlabel() > inv_items[i].of_getlabel() then
			ls_pivot = inv_items[k].of_getlabel()

			// Échanger les valeurs des vercteurs 1 et 2
			swap(inv_items[ai_g], inv_items[k])
		else
			ls_pivot = inv_items[i].of_getlabel()
		end if
	end if
	
	do while i < j
		do while inv_items[i].of_getlabel() >= ls_pivot
			i ++
		loop

		do while inv_items[j].of_getlabel() <= ls_pivot
			j --
		loop
		
		if i < j then
			// Échanger les valeurs des vercteurs 1 et 2
			swap(inv_items[i], inv_items[j])
		end if
	loop

	// Échanger les valeurs des vercteurs 1 et 2
	swap(inv_items[ai_g], inv_items[j])
	
	of_quicksortld(ai_g, j - 1)
	of_quicksortld(j + 1, ai_d)
end if

end subroutine

protected function integer of_binsearchlc (ref n_lbi anv_item, integer ai_g, integer ai_d);// Fonction protégée qui effectue une recherche binaire dans
// le vecteur d'items et retourne la position de l'item devant
// être placé après anv_item

integer li_posmed

if ai_g > ai_d then
	return ai_g
elseif ai_g = ai_d then
	if anv_item.of_getlabel() < inv_items[ai_g].of_getlabel() then return ai_g else return ai_g + 1
else
	li_posmed = int((ai_g + ai_d) / 2)
	
	choose case true
		case anv_item.of_getlabel() < inv_items[li_posmed].of_getlabel()
			return of_binsearchlc(anv_item, ai_g, li_posmed - 1)
		case anv_item.of_getlabel() > inv_items[li_posmed].of_getlabel()
			return of_binsearchlc(anv_item, li_posmed + 1, ai_d)
		case anv_item.of_getlabel() = inv_items[li_posmed].of_getlabel()
			do
				li_posmed ++
			loop while anv_item.of_getlabel() = inv_items[li_posmed].of_getlabel() and li_posmed < upperbound(inv_items)
			
			if anv_item.of_getlabel() = inv_items[li_posmed].of_getlabel() then li_posmed ++
			return li_posmed
	end choose
end if

end function

protected function integer of_binsearchdc (ref n_lbi anv_item, integer ai_g, integer ai_d);// Fonction protégée qui effectue une recherche binaire dans
// le vecteur d'items et retourne la position de l'item devant
// être placé après anv_item

integer li_posmed

if ai_g > ai_d then
	return ai_g
elseif ai_g = ai_d then
	if anv_item.of_getdata() < inv_items[ai_g].of_getdata() then return ai_g else return ai_g + 1
else
	li_posmed = int((ai_g + ai_d) / 2)
	
	choose case true
		case anv_item.of_getdata() < inv_items[li_posmed].of_getdata()
			return of_binsearchdc(anv_item, ai_g, li_posmed - 1)
		case anv_item.of_getdata() > inv_items[li_posmed].of_getdata()
			return of_binsearchdc(anv_item, li_posmed + 1, ai_d)
		case anv_item.of_getdata() = inv_items[li_posmed].of_getdata()
			do
				li_posmed ++
			loop while anv_item.of_getdata() = inv_items[li_posmed].of_getdata() and li_posmed < upperbound(inv_items)
			
			if anv_item.of_getdata() = inv_items[li_posmed].of_getdata() then li_posmed ++
			return li_posmed
	end choose
end if

end function

protected function integer of_binsearchdd (ref n_lbi anv_item, integer ai_g, integer ai_d);// Fonction protégée qui effectue une recherche binaire dans
// le vecteur d'items et retourne la position de l'item devant
// être placé après anv_item

integer li_posmed

if ai_g > ai_d then
	return ai_g
elseif ai_g = ai_d then
	if anv_item.of_getdata() > inv_items[ai_g].of_getdata() then return ai_g else return ai_g + 1
else
	li_posmed = int((ai_g + ai_d) / 2)
	
	choose case true
		case anv_item.of_getdata() > inv_items[li_posmed].of_getdata()
			return of_binsearchdd(anv_item, ai_g, li_posmed - 1)
		case anv_item.of_getdata() < inv_items[li_posmed].of_getdata()
			return of_binsearchdd(anv_item, li_posmed + 1, ai_d)
		case anv_item.of_getdata() = inv_items[li_posmed].of_getdata()
			do
				li_posmed ++
			loop while anv_item.of_getdata() = inv_items[li_posmed].of_getdata() and li_posmed < upperbound(inv_items)
			
			if anv_item.of_getdata() = inv_items[li_posmed].of_getdata() then li_posmed ++
			return li_posmed
	end choose
end if

end function

protected function integer of_binsearchld (ref n_lbi anv_item, integer ai_g, integer ai_d);// Fonction protégée qui effectue une recherche binaire dans
// le vecteur d'items et retourne la position de l'item devant
// être placé après anv_item

integer li_posmed

if ai_g > ai_d then
	return ai_g
elseif ai_g = ai_d then
	if anv_item.of_getlabel() > inv_items[ai_g].of_getlabel() then return ai_g else return ai_g + 1
else
	li_posmed = int((ai_g + ai_d) / 2)
	
	choose case true
		case anv_item.of_getlabel() > inv_items[li_posmed].of_getlabel()
			return of_binsearchld(anv_item, ai_g, li_posmed - 1)
		case anv_item.of_getlabel() < inv_items[li_posmed].of_getlabel()
			return of_binsearchld(anv_item, li_posmed + 1, ai_d)
		case anv_item.of_getlabel() = inv_items[li_posmed].of_getlabel()
			do
				li_posmed ++
			loop while anv_item.of_getlabel() = inv_items[li_posmed].of_getlabel() and li_posmed < upperbound(inv_items)
			
			if anv_item.of_getlabel() = inv_items[li_posmed].of_getlabel() then li_posmed ++
			return li_posmed
	end choose
end if

end function

protected function integer of_insert (n_lbi anv_item, integer ai_index);// Fonction protégée qui ne fait aucune validation de tri et qui
// insère l'élément as_item à la position ai_index
// Retourne un entier
// positif - position
// -1 - échec

integer i, li_index = 0
n_lbi lnv_items[]
any la_items[], la_data[]

if isNull(ai_index) then return -1
if ai_index < 0 or ai_index > upperbound(inv_items) + 1 then return -1

// Copier la première partie du vecteur
for i = 1 to ai_index - 1
	li_index ++
	lnv_items[li_index] = inv_items[i]
next

// Insérer l'item à la position voulue
li_index ++
lnv_items[li_index] = anv_item

// Copier la 2e partie du vecteur
for i = ai_index to upperbound(inv_items)
	li_index ++
	lnv_items[li_index] = inv_items[i]
next

inv_items = lnv_items

return insertItem(anv_item.of_getlabel(), ai_index)

end function

protected function integer of_additem (n_lbi anv_item);// Ajouter un item et ses données
// Retourne un entier
// positif - position de l'item ajouté
integer li_pos

setNull(li_pos)
if isNull(anv_item) then return li_pos

choose case is_sorted
	case ''
		li_pos = 0
	case 'L', 'LA'
		li_pos = of_binsearchlc(anv_item, 1, upperbound(inv_items))
	case 'LD'
		li_pos = of_binsearchld(anv_item, 1, upperbound(inv_items))
	case 'D', 'DA'
		li_pos = of_binsearchdc(anv_item, 1, upperbound(inv_items))
	case 'DD'
		li_pos = of_binsearchdd(anv_item, 1, upperbound(inv_items))
end choose

if li_pos < 0 then return li_pos

if li_pos = 0 or li_pos > upperbound(inv_items) then
	li_pos = upperbound(inv_items) + 1
	
	inv_items[li_pos] = anv_item
	
	if AddItem(anv_item.of_getlabel()) = li_pos then
		return li_pos
	else
		return -1
	end if
else
	if of_insert(anv_item, li_pos) = li_pos then
		return li_pos
	else
		return -1
	end if
end if

end function

public function integer of_additem (string as_item, any aa_data);// Ajouter un item et ses données
integer li_null
n_lbi lnv_item

setNull(li_null)
if isNull(as_item) then return li_null

lnv_item.of_setlabel(as_item)
lnv_item.of_setdata(aa_data)

return of_additem(lnv_item)

end function

public function integer of_additem (string as_item);// Ajouter un item et sans données
any la_null
setNull(la_null)

return of_additem(as_item, la_null)

end function

public function integer of_deleteitem (integer ai_index);// supprime l'item à la position ai_index avec ses données
// puis décale les autres

integer i, li_index = 0, li_selItems[]
n_lbi lnv_items[]

for i = 1 to upperbound(inv_items)
	if i <> ai_index then
		li_index ++
		lnv_items[li_index] = inv_items[i]
	end if
next

inv_items = lnv_items

li_index = of_isSelected(ai_index)
if li_index > 0 then
	for i = 1 to upperbound(ii_selectedItems)
		if i < li_index then
			li_selItems[i] = ii_selectedItems[i]
		elseif i > li_index then
			li_selItems[i - 1] = ii_selectedItems[i]
		end if
	next
end if

deleteItem(ai_index)

return 1

end function

public function integer of_deleteitem (any aa_data, boolean ab_label);// supprime le premier item ayant l'étiquette aa_data
// puis décale les autres

integer i, li_index = 0

if ab_label then
	for i = 1 to upperbound(inv_items)
		if inv_items[i].of_getlabel() = string(aa_data) then li_index = i
	next
else
	for i = 1 to upperbound(inv_items)
		if inv_items[i].of_getdata() = aa_data then li_index = i
	next
end if

if li_index > 0 then return of_deleteitem(li_index) else return -1

end function

public function integer of_finditem (any aa_item, integer ai_index, boolean ab_label, boolean ab_exact);// Trouve le premier item dont l'étiquette est ou commence par aa_item
// ou dont les données sont aa_item après l'indice ai_index.
integer i

if ab_label then
	if classname(aa_item) <> 'string' then return -1
	
	if ab_exact then
		for i = ai_index + 1 to upperbound(inv_items)
			if inv_items[i].of_getlabel() = string(aa_item) then return i
		next
	else
		for i = ai_index + 1 to upperbound(inv_items)
			if left(inv_items[i].of_getlabel(), len(string(aa_item))) = string(aa_item) then return i
		next
	end if
else
	for i = ai_index + 1 to upperbound(inv_items)
		if inv_items[i].of_getdata() = aa_item then return i
	next
end if

return -1

end function

public function integer of_finditem (any aa_item, integer ai_index, boolean ab_label);// Trouve le premier item dont l'étiquette commence par aa_item
// ou dont les données sont aa_item après l'indice ai_index.
return of_findItem(aa_item, ai_index, ab_label, false)

end function

public function string of_getlabel (integer ai_index);// Retourne l'étiquette de l'item à la position ai_index s'il existe
// Retourne '' sinon
// Retourne Null si ai_index est null

string ls_label

setNull(ls_label)
if isNull(ai_index) then return ls_label

if ai_index < 1 or ai_index > upperbound(inv_items) then return ''

return inv_items[ai_index].of_getlabel()

end function

public function any of_getdata (integer ai_index);// Retourne les données de l'item à la position ai_index s'il existe
// Retourne Null sinon ou si ai_index est null

any la_data

setNull(la_data)
if isNull(ai_index) then return la_data

if ai_index < 1 or ai_index > upperbound(inv_items) then return la_data

return inv_items[ai_index].of_getdata()

end function

public function any of_getselecteddata ();// Retourne les données de l'item courrant s'il existe
// Retourne Null sinon ou si aucun item n'est sélectionné

any la_data

setNull(la_data)
if isNull(ii_currentItem) then return la_data

if ii_currentItem < 1 or ii_currentItem > upperbound(inv_items) then return la_data

return inv_items[ii_currentItem].of_getdata()

end function

public function any of_getselectedlabel ();// Retourne l'étiquette de l'item courrant s'il existe
// Retourne '' sinon ou si aucun item n'est sélectionné

if isNull(ii_currentItem) then return ''

if ii_currentItem < 1 or ii_currentItem > upperbound(inv_items) then return ''

return inv_items[ii_currentItem].of_getlabel()

end function

public function string of_getsorted ();// Retourne la veleur de la propriété sorted
// L - Label, ascendant
// D - Data, ascendant
// LA - Label, ascendant
// DA - Data, ascendant
// LD - Label, descendant
// DD - Data, descendant

return is_sorted

end function

public function integer of_insertitem (string as_item, any aa_data, integer ai_index);// Insère l'item as_item à la position ai_index
// si la liste n'est pas triée.
// Si elle l'est, insère à la bonne position

integer li_null
n_lbi lnv_item

setNull(li_null)
if isNull(as_item) then return li_null
if isNull(ai_index) then return li_null

lnv_item.of_setlabel(as_item)
lnv_item.of_setdata(aa_data)

if is_sorted = "" then return of_insert(lnv_item, ai_index) else return of_additem(lnv_item)

end function

public function integer of_insertitem (string as_item, integer ai_index);// Insère l'item as_item à la position ai_index

any la_null

return of_insertItem(as_item, la_null, ai_index)

end function

public function integer of_reset ();// Vide la liste de tous ses éléments

n_lbi lnv_items[]
integer li_vide[]

inv_items = lnv_items
ii_currentItem = 0
ii_selectedItems = li_vide

return reset()

end function

public function integer of_selecteditem ();// Retourne l'indice de l'item sélectionné
return ii_currentItem

end function

public function integer of_selectitem (integer ai_index);// Sélectionne l'item à l'indice ai_index.
if multiSelect then return 0

ai_index = selectItem(ai_index)

if ai_index > 0 then	ii_currentItem = ai_index

return ai_index

end function

public function integer of_selectitem (any aa_item, integer ai_index, boolean ab_label, boolean ab_exact);// Trouve et sélectionne le premier item dont l'étiquette est ou commence par aa_item
// ou dont les données sont aa_item après l'indice ai_index.
integer i, li_index = -1

if ab_label then
	if classname(aa_item) <> 'string' then return -1
	
	if ab_exact then
		for i = ai_index + 1 to upperbound(inv_items)
			if inv_items[i].of_getlabel() = string(aa_item) then
				li_index = i
				exit
			end if
		next
	else
		for i = ai_index + 1 to upperbound(inv_items)
			if left(inv_items[i].of_getlabel(), len(string(aa_item))) = string(aa_item) then
				li_index = i
				exit
			end if
		next
	end if
else
	for i = ai_index + 1 to upperbound(inv_items)
		if inv_items[i].of_getdata() = aa_item then
			li_index = i
			exit
		end if
	next
end if

li_index = selectItem(li_index)

if li_index > 0 then	ii_currentItem = li_index

return li_index

end function

public function integer of_selectitem (any aa_item, integer ai_index, boolean ab_label);// Trouve et sélectionne le premier item dont l'étiquette commence par aa_item
// ou dont les données sont aa_item après l'indice ai_index.
return of_selectItem(aa_item, ai_index, ab_label, false)

end function

public function integer of_setsorted (string as_critere);// Trie le vecteur d'items (et celui de données)
// L - Label, ascendant
// D - Data, ascendant
// LA - Label, ascendant
// DA - Data, ascendant
// LD - Label, descendant
// DD - Data, descendant
//
// Retourne un entier :
// 1 - success
// -1 - échec, peut être un argument invalide
//
// Note : attention, si les données sont un vecteur, une structure ou un objet
// et qu'on essaie de trier par les donées, cette fonction ne le détectera pas,
// mais générera une erreur à l'exécution

integer i

if isNull(as_critere) then return -1

choose case upper(trim(as_critere))
	case 'L', 'LA'
		of_quicksortlc(1, upperbound(inv_items))
	case 'LD'
		of_quicksortld(1, upperbound(inv_items))
	case 'D', 'DA'
		of_quicksortdc(1, upperbound(inv_items))
	case 'DD'
		of_quicksortdd(1, upperbound(inv_items))
	case '' // Retirer le tri, rien à faire
		is_sorted = ''
		return 1
	case else
		return -1
end choose

is_sorted = upper(trim(as_critere))

sorted = false
reset()
for i = 1 to upperbound(inv_items)
	addItem(inv_items[i].of_getlabel())
next

return 1

end function

public function integer of_isselected (integer ai_index);// Indique, dans une liste qui admet plusieurs sélections, si l'item
// dont l'indice est passé en paramètre est sélectionné.
// Retourne 0 si l'item n'est pas sélectionné et l'indice dans le vecteur
// de sélection (représentant le nombre d'item sélectionné avant celui-ci plus 1)

if isNull(ai_index) then
	integer li_null
	setNull(li_null)
	return li_null
end if

return of_binsrchsel(ai_index, 1, upperBound(ii_selectedItems))

end function

protected function integer of_binsrchsel (integer ai_index, integer ai_g, integer ai_d);// Fonction protégée qui effectue une recherche binaire dans
// le vecteur d'items sélectionnés et retourne la position de 
// l'indice de l'item sélectionné dans ce vecteur

integer li_posmed

if ai_g > ai_d then
	return 0
elseif ai_g = ai_d then
	if ii_selectedItems[ai_g] = ai_index then return ai_g else return 0
else
	li_posmed = int((ai_g + ai_d) / 2)
	
	choose case true
		case ai_index < ii_selectedItems[li_posmed]
			return of_binsrchsel(ai_index, ai_g, li_posmed - 1)
		case ai_index > ii_selectedItems[li_posmed]
			return of_binsrchsel(ai_index, li_posmed + 1, ai_d)
		case ai_index = ii_selectedItems[li_posmed]
			return li_posmed
	end choose
end if

end function

public function integer of_setstate (integer ai_index, boolean ab_state);// Sélectionne ou désélectionne l'item à l'indice ai_index.
integer li_result, i, li_cpt = 0

li_result = setState(ai_index, ab_state)

if li_result > 0 then
	for i = 1 to totalItems()
		if state(i) = 1 then
			li_cpt ++
			ii_selectedItems[li_cpt] = i
		end if
	next
end if

return li_result

end function

event constructor;call super::constructor;integer i

sorted = false

for i = 1 to upperbound(item)
	of_addItem(item[i])
next

end event

event selectionchanged;call super::selectionchanged;integer i, li_cpt = 0, li_vide[]

ii_currentItem = index

ii_selectedItems = li_vide

if multiSelect then
	for i = 1 to totalItems()
		if state(i) = 1 then
			li_cpt ++
			ii_selectedItems[li_cpt] = i
		end if
	next
else
	ii_selectedItems[1] = i
end if
end event

on pro_u_lb.create
call super::create
end on

on pro_u_lb.destroy
call super::destroy
end on

