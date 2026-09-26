## Attributi e metodi di oggetti e talismani
class_name ObjectClass
extends DiceClass

# ----------------------------- A T T R I B U T I -----------------------------
## STATISTICHE BONUS
var forza      : int = 0
var precisione : int = 0

## DADI
# formato: [ {"tipo": ATTACCO, "numero": 2, "bonus": 5}, ... ]
var danni : Array = []
var cure  : Array = []

## STATO
var nome       : String = ""
var attivo     : bool   = false
var aggiornato : bool   = true

## NODI PERSONAGGI
var m_AM      : SpinBox
var m_AF      : SpinBox
var terminale : TextEdit

# -------------------------------- M E T O D I --------------------------------
## Costruttore della classe                                             [br][br]
## Salva in locale i nodi condivisi col personaggio
func _init(nodo_m_AM : SpinBox, nodo_m_AF : SpinBox, nodo_terminale : TextEdit) -> void:
	m_AM      = nodo_m_AM
	m_AF      = nodo_m_AF
	terminale = nodo_terminale

## Aggiunge le statistiche fornite dall'oggetto
func aggiorna_statistiche() -> void:
	if aggiornato:
		return
	
	if attivo:
		m_AM.value += forza/3.0
		m_AF.value += precisione/3.0
	else:
		m_AM.value -= forza/3.0
		m_AF.value -= precisione/3.0
	
	aggiornato = true

## Tira i danni aggiuntivi
func tira_danni() -> int:
	if danni.is_empty():
		return -1
	
	var danni_bonus : int = 0
	var risultato   : Dictionary
	
	terminale.text += "\nBONUS " + nome + ":\n"
	
	for dadi in danni:
		risultato = tira(dadi["numero"], dadi["tipo"])
		terminale.text += risultato["testo"]
		danni_bonus += risultato["valore"] + dadi["bonus"]
	
	return danni_bonus

## Tira le cure
func tira_cure() -> int:
	if cure.is_empty():
		return -1
	
	var cura      : int = 0
	var risultato : Dictionary
	
	terminale.text = "CURA " + nome + ":\n\n"
	
	for dadi in cure:
		risultato = tira(dadi["numero"], dadi["tipo"])
		terminale.text += risultato["testo"]
		cura += risultato["valore"] + dadi["bonus"]
	
	terminale.text += "\nVita ripristinata: " + str(cura)
	
	return cura

## Usa l'oggetto                                                        [br][br]
## Tira danni o cure in base ai dadi assegnati all'oggetto
func usa() -> void:
	tira_danni()
	tira_cure()
