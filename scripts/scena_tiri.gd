extends Control

# Dizionari
const ATTACCO =          {1 : 1,  2 : 1,  3 : 1,  4 : 2,  5 : 2,  6 : 3}
const ATTACCO_PIU1 =     {1 : 1,  2 : 2,  3 : 2,  4 : 2,  5 : 3,  6 : 4}
const ARCANO =           {1 : 1,  2 : 2,  3 : 3,  4 : 5,  5 : 6,  6 : 8}
const ATTACCO_ADF =      {1 : 2,  2 : 2,  3 : 3,  4 : 3,  5 : 4,  6 : 4}
const ATTACCO_ADF_PIU1 = {1 : 3,  2 : 3,  3 : 4,  4 : 4,  5 : 5,  6 : 6}
const ORRIDO =           {1 : "Attacco", 2 : "Attacco", 3 : "Attacco +1", 4 : "Attacco ADF", 5 : "Attacco ADF +1", 6 : "Arcano"}
const DIFESA =           {1 : 0,  2 : 1,  3 : 1,  4 : 1,  5 : 1,  6 : 2}
const DIFESA_PIU1 =      {1 : 1,  2 : 1,  3 : 2,  4 : 2,  5 : 2,  6 : 3}
const SCHIVATA =         {1 : 0,  2 : 0,  3 : 0,  4 : 1,  5 : 1,  6 : INF}

# Prendi il valore in "Numero" per ogni tipo di dado, se è maggiore di 0 tira i dadi e somma i risultati
func _ready() -> void:
	# Attacco
	var numero_dadi_attacco = int($"../Griglia Verticale/Griglia Orizzontale 1/Dadi Atacco/Contatore/Numero".text)
	if numero_dadi_attacco > 0 :
		var dadi_attacco_tirati = []
		var attacco_totale = 0
		for i in numero_dadi_attacco :
			dadi_attacco_tirati.append(randi_range(1,6))
			attacco_totale += ATTACCO[dadi_attacco_tirati[i]]
		$Contenitore/Testo.text += "ATTACCO:\nDadi: " + str(dadi_attacco_tirati) + "\nTotale: " + str(attacco_totale) + "\n\n"
	
	# Attacco +1
	var numero_dadi_attacco_piu1 = int($"../Griglia Verticale/Griglia Orizzontale 1/Dadi Atacco +1/Contatore/Numero".text)
	if numero_dadi_attacco_piu1 > 0 :
		var dadi_attacco_piu1_tirati = []
		var attacco_piu1_totale = 0
		for i in numero_dadi_attacco_piu1 :
			dadi_attacco_piu1_tirati.append(randi_range(1,6))
			attacco_piu1_totale += ATTACCO_PIU1[dadi_attacco_piu1_tirati[i]]
		$Contenitore/Testo.text += "ATTACCO +1:\nDadi: " + str(dadi_attacco_piu1_tirati) + "\nTotale: " + str(attacco_piu1_totale) + "\n\n"
		
	# Arcano
	var numero_dadi_arcano = int($"../Griglia Verticale/Griglia Orizzontale 1/Dadi Arcano/Contatore/Numero".text)
	if numero_dadi_arcano > 0 :
		var dadi_arcano_tirati = []
		var arcano_totale = 0
		for i in numero_dadi_arcano :
			dadi_arcano_tirati.append(randi_range(1,6))
			arcano_totale += ARCANO[dadi_arcano_tirati[i]]
		$Contenitore/Testo.text += "ARCANO:\nDadi: " + str(dadi_arcano_tirati) + "\nTotale: " + str(arcano_totale) + "\n\n"
	
	# Attacco ADF
	var numero_dadi_attacco_ADF = int($"../Griglia Verticale/Griglia Orizzontale 2/Dadi Attacco ADF/Contatore/Numero".text)
	if numero_dadi_attacco_ADF > 0 :
		var dadi_attacco_ADF_tirati = []
		var attacco_ADF_totale = 0
		for i in numero_dadi_attacco_ADF :
			dadi_attacco_ADF_tirati.append(randi_range(1,6))
			attacco_ADF_totale += ATTACCO_ADF[dadi_attacco_ADF_tirati[i]]
		$Contenitore/Testo.text += "ATTACCO ARMA DA FUOCO:\nDadi: " + str(dadi_attacco_ADF_tirati) + "\nTotale: " + str(attacco_ADF_totale) + "\n\n"
	
	# Attacco ADF +1
	var numero_dadi_attacco_ADF_piu1 = int($"../Griglia Verticale/Griglia Orizzontale 2/Dadi Attacco ADF +1/Contatore/Numero".text)
	if numero_dadi_attacco_ADF_piu1 > 0 :
		var dadi_attacco_ADF_piu1_tirati = []
		var attacco_ADF_piu1_totale = 0
		for i in numero_dadi_attacco_ADF_piu1 :
			dadi_attacco_ADF_piu1_tirati.append(randi_range(1,6))
			attacco_ADF_piu1_totale += ATTACCO_ADF_PIU1[dadi_attacco_ADF_piu1_tirati[i]]
		$Contenitore/Testo.text += "ATTACCO ARMA DA FUOCO +1:\nDadi: " + str(dadi_attacco_ADF_piu1_tirati) + "\nTotale: " + str(attacco_ADF_piu1_totale) + "\n\n"
	
	# Orrido
	var numero_dadi_orridi = int($"../Griglia Verticale/Griglia Orizzontale 2/Dadi Orridi/Contatore/Numero".text)
	if numero_dadi_orridi > 0 :
		var dadi_orridi_tirati = []
		var tipo_orrido = ""
		for i in numero_dadi_orridi :
			dadi_orridi_tirati.append(randi_range(1,6))
			tipo_orrido += ORRIDO[dadi_orridi_tirati[i]] + ", "
		$Contenitore/Testo.text += "ORRIDO:\nDadi: " + str(dadi_orridi_tirati) + "\nTipo: " + tipo_orrido.substr(0,len(tipo_orrido)-2) + "\n\n"
	
	# Difesa
	var numero_dadi_difesa = int($"../Griglia Verticale/Griglia Orizzontale 3/Dadi Difesa/Contatore/Numero".text)
	if numero_dadi_difesa > 0 :
		var dadi_difesa_tirati = []
		var difesa_totale = 0
		for i in numero_dadi_difesa :
			dadi_difesa_tirati.append(randi_range(1,6))
			difesa_totale += DIFESA[dadi_difesa_tirati[i]]
		$Contenitore/Testo.text += "DIFESA:\nDadi: " + str(dadi_difesa_tirati) + "\nTotale: " + str(difesa_totale) + "\n\n"
	
	# Difesa +1
	var numero_dadi_difesa_piu1 = int($"../Griglia Verticale/Griglia Orizzontale 3/Dadi Difesa +1/Contatore/Numero".text)
	if numero_dadi_difesa_piu1 > 0 :
		var dadi_difesa_piu1_tirati = []
		var difesa_piu1_totale = 0
		for i in numero_dadi_difesa_piu1 :
			dadi_difesa_piu1_tirati.append(randi_range(1,6))
			difesa_piu1_totale += DIFESA_PIU1[dadi_difesa_piu1_tirati[i]]
		$Contenitore/Testo.text += "DIFESA +1:\nDadi: " + str(dadi_difesa_piu1_tirati) + "\nTotale: " + str(difesa_piu1_totale) + "\n\n"
	
	# Schivata
	var numero_dadi_schivata = int($"../Griglia Verticale/Griglia Orizzontale 3/Dadi Schivata/Contatore/Numero".text)
	if numero_dadi_schivata > 0 :
		var dadi_schivata_tirati = []
		var schivata_totale = 0
		for i in numero_dadi_schivata :
			dadi_schivata_tirati.append(randi_range(1,6))
			schivata_totale += SCHIVATA[dadi_schivata_tirati[i]]
		$Contenitore/Testo.text += "SCHIVATA:\nDadi: " + str(dadi_schivata_tirati)
		if schivata_totale < INF :
			$Contenitore/Testo.text += "\nTotale: " + str(schivata_totale) + "\n\n"
		else :
			$Contenitore/Testo.text += "\nSCHIVA!\n\n"
	
	# Segnala se nessun dado è stato tirato, altrimenti togli gli ultimi \n inutili
	if $Contenitore/Testo.text == "" :
		$Contenitore/Testo.text = "bel tiro bro\nora prova a metterci un dado"
	else :
		$Contenitore/Testo.text = $Contenitore/Testo.text.substr(0,len($Contenitore/Testo.text)-2)

# Se premi il tasto X chiudi
func _on_x_pressed() -> void:
	queue_free()

func _on_indietro_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
