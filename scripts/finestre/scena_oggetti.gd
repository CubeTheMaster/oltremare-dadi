extends DiceClass

# ------------------------------- S E G N A L I -------------------------------
## Invia la lista aggiornata degli oggetti attivi alla scena del personaggio
signal oggetti_attivati(oggetti: Dictionary)

# ----------------------------- V A R I A B I L I -----------------------------
## PERSONAGGIO
var oggetti_personaggio : Dictionary
var m_AM                : SpinBox
var m_AF                : SpinBox
var terminale           : TextEdit

## OGGETTI
# Oggetti OFFENSIVI
var polvere_rossa      : ObjectClass
var ultimo_sigaro      : ObjectClass

# Oggetti CURATIVI
var confettura         : ObjectClass
var bottiglia_mercurio : ObjectClass

# Talismani
var cerchio_forza      : ObjectClass
var cerchio_definitivo : ObjectClass

# Lista oggetti
var oggetti : Dictionary

# ------------------------------ F U N Z I O N I ------------------------------
## - UTILITÀ -
# Inizializzazione
## Ready (eseguito all'istante)
## Assegna a ogni oggetto i suoi valori
## Leggi lo stato (attivo/disattivato) degli oggetti dalla scheda del giocatore
func _ready() -> void:
	# Crea oggetti
	polvere_rossa      = ObjectClass.new(m_AM, m_AF, terminale)
	ultimo_sigaro      = ObjectClass.new(m_AM, m_AF, terminale)
	confettura         = ObjectClass.new(m_AM, m_AF, terminale)
	bottiglia_mercurio = ObjectClass.new(m_AM, m_AF, terminale)
	cerchio_forza      = ObjectClass.new(m_AM, m_AF, terminale)
	cerchio_definitivo = ObjectClass.new(m_AM, m_AF, terminale)
	
	# Polvere Rossa
	polvere_rossa.nome  = "Polvere Rossa"
	polvere_rossa.danni = [{"tipo": ATTACCO_PIU1, "numero": 2, "bonus": 0}]
	
	# Ultimo Sigaro
	ultimo_sigaro.nome  = "Ultimo Sigaro"
	ultimo_sigaro.danni = [{"tipo": ATTACCO_PIU1, "numero": 3, "bonus": 0}]
	
	# Confettura
	confettura.nome = "Confettura"
	confettura.cure = [{"tipo": ARCANO, "numero": 2, "bonus": 5}]
	
	# Bottiglia di Mercurio
	bottiglia_mercurio.nome = "Bottiglia di Mercurio"
	bottiglia_mercurio.cure = [{"tipo": ARCANO, "numero": 2, "bonus": 7}]
	
	# Cerchio [Forza]
	cerchio_forza.nome  = "Cerchio [Forza]"
	cerchio_forza.forza = 6
	
	# Cerchio [Definitivo]
	cerchio_definitivo.nome       = "Cerchio [Definitivo]"
	cerchio_definitivo.forza      = 3
	cerchio_definitivo.precisione = 3
	
	# la lista contiene solo gli oggetti a uso continuo
	oggetti = {
		polvere_rossa.nome      : polvere_rossa,
		ultimo_sigaro.nome      : ultimo_sigaro,
		cerchio_forza.nome      : cerchio_forza,
		cerchio_definitivo.nome : cerchio_definitivo,
	}
	
	# leggi lo stato degli oggetti e assegnalo agli switch
	for oggetti_attivi in oggetti_personaggio:
		oggetti[oggetti_attivi].attivo = oggetti_personaggio[oggetti_attivi].attivo
	
	%"Switch Polvere Rossa".button_pressed        = polvere_rossa.attivo
	%"Switch Ultimo Sigaro".button_pressed        = ultimo_sigaro.attivo
	%"Switch Cerchio [Forza]".button_pressed      = cerchio_forza.attivo
	%"Switch Cerchio [Definitivo]".button_pressed = cerchio_definitivo.attivo

# Invio dati
## Invia i dati inseriti e chiudi la finestra
func salva_ed_esci() -> void:
	oggetti[polvere_rossa.nome].attivo = %"Switch Polvere Rossa".button_pressed
	oggetti[ultimo_sigaro.nome].attivo = %"Switch Ultimo Sigaro".button_pressed
	
	if oggetti[cerchio_forza.nome].attivo != %"Switch Cerchio [Forza]".button_pressed:
		oggetti[cerchio_forza.nome].attivo     = %"Switch Cerchio [Forza]".button_pressed
		oggetti[cerchio_forza.nome].aggiornato = false
	if oggetti[cerchio_definitivo.nome].attivo != %"Switch Cerchio [Definitivo]".button_pressed:
		oggetti[cerchio_definitivo.nome].attivo = %"Switch Cerchio [Definitivo]".button_pressed
		oggetti[cerchio_definitivo.nome].aggiornato = false
	
	oggetti_attivati.emit(oggetti)
	queue_free()

## - INTERFACCIA -
# Oggetti a uso istantaneo
## Usa un barattolo di confettura
func _on_usa_confettura_pressed() -> void:
	confettura.usa()
	salva_ed_esci()

## Usa una bottiglia di mercurio
func _on_usa_bottiglia_di_mercurio_pressed() -> void:
	bottiglia_mercurio.usa()
	salva_ed_esci()

# Chiudi finestra
## Salva ed esci
func _on_x_pressed() -> void:
	salva_ed_esci()

## Salva ed esci
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("indietro") or event.is_action_pressed("invio"):
		get_viewport().set_input_as_handled()
		salva_ed_esci()

# Scena
## Torna alla selezione personaggi se premi la freccia indietro
func _on_indietro_pressed() -> void:
	var percorso_scena_giocatore : String = "res://scenes/schermate/giocatore.tscn"
	get_tree().change_scene_to_file(percorso_scena_giocatore)
