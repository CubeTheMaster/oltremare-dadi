# Variabili e Funzioni utilizzate da tutti i personaggi
class_name CharacterClass
extends Control

# ----------------------------- V A R I A B I L I -----------------------------
## COSTANTI
# Dadi
const ARCANO           = {1 : 1,  2 : 2,  3 : 3,  4 : 5,  5 : 6,  6 : 8,  "nome" : "Arcano"        }
const ATTACCO          = {1 : 1,  2 : 1,  3 : 1,  4 : 2,  5 : 2,  6 : 3,  "nome" : "Attacco"       }
const ATTACCO_PIU1     = {1 : 1,  2 : 2,  3 : 2,  4 : 2,  5 : 3,  6 : 4,  "nome" : "Attacco +1"    }
const ATTACCO_ADF      = {1 : 2,  2 : 2,  3 : 3,  4 : 3,  5 : 4,  6 : 4,  "nome" : "Attacco ADF"   }
const ATTACCO_ADF_PIU1 = {1 : 3,  2 : 3,  3 : 4,  4 : 4,  5 : 5,  6 : 6,  "nome" : "Attacco ADF +1"}
const DIFESA           = {1 : 0,  2 : 1,  3 : 1,  4 : 1,  5 : 1,  6 : 2,  "nome" : "Difesa"        }
const DIFESA_PIU1      = {1 : 1,  2 : 1,  3 : 2,  4 : 2,  5 : 2,  6 : 3,  "nome" : "Difesa +1"     }
const SCHIVATA         = {1 : 0,  2 : 0,  3 : 0,  4 : 1,  5 : 1,  6 : INF,"nome" : "Schivata"      }

# Difese standard
const N_LEGGERA: Dictionary = {"DIF": 1, "SCH": 1  }
const N_MEDIA:   Dictionary = {"DIF": 2, "DIF+1": 1}
const N_PESANTE: Dictionary = {"DIF": 1, "DIF+1": 4}

# Attacchi standard
const N_DISARMATO: Dictionary = {"ATT": 2, "ATT+1": 2}
const N_PRESA:     Dictionary = {"ATT": 4, "ATT+1": 3}

## OUTPUT FUNZIONE TIRI
var risultato: Dictionary
var danni: int
var riduzione #: int o float
var gittata: int
var cura: int

## MODIFICATORI
@onready var m_AM: SpinBox = assegna_modificatore(%Valore_M)
@onready var m_AF: SpinBox = assegna_modificatore(%Valore_F)

## CASELLA DI TESTO
@onready var terminale: TextEdit = %Testo

# ------------------------------ F U N Z I O N I ------------------------------
## - TIRI -
# Generico
## Tira dadi specificando numero e tipo
func tira(numero: int, tipo: Dictionary, newline: bool = true) -> Dictionary:
	var _tiri = []
	var _valore = 0
	var _testo = ""
	
	for i in range(numero):
		_tiri.append(randi_range(1,6))
		_valore += tipo[_tiri[i]]
	
	_testo += "Dadi " + tipo["nome"] + ":  " + str(_tiri)
	if newline:
		_testo += "\n"
	
	return {"tiri": _tiri, "valore": _valore, "testo": _testo}

# Difese
## Difesa classe LEGGERA (1 DIF, 1 SCH)
func difesa_leggera(newline: bool = true) -> Dictionary:
	var _tiri = {"DIF" : [], "SCH" : []}
	var _valore = 0
	var _testo = ""
	var _risultato: Dictionary
	
	# tiro dado DIF
	_risultato = tira(N_LEGGERA["DIF"], DIFESA)
	_tiri["DIF"].append(_risultato["tiri"])
	_valore += _risultato["valore"]
	_testo += _risultato["testo"]
	
	if newline:
		_testo += "\n"
	
	# tiro dado SCH
	_risultato = tira(N_LEGGERA["SCH"], SCHIVATA)
	_tiri["SCH"].append(_risultato["tiri"])
	_valore += _risultato["valore"]
	_testo += _risultato["testo"]
	
	return {"tiri": _tiri, "valore": _valore, "testo": _testo}

## Difesa classe MEDIA (2 DIF, 1 DIF+1)
func difesa_media(newline: bool = true) -> Dictionary:
	var _tiri = {"DIF" : [], "DIF+1" : []}
	var _valore = 0
	var _testo = ""
	var _risultato: Dictionary
	
	# tiro dadi DIF
	_risultato = tira(N_MEDIA["DIF"], DIFESA)
	_tiri["DIF"].append(_risultato["tiri"])
	_valore += _risultato["valore"]
	_testo += _risultato["testo"]
	
	if newline:
		_testo += "\n"
	
	# tiro dadi DIF+1
	_risultato = tira(N_MEDIA["DIF+1"], DIFESA_PIU1)
	_tiri["DIF+1"].append(_risultato["tiri"])
	_valore += _risultato["valore"]
	_testo += _risultato["testo"]
	
	return {"tiri": _tiri, "valore": _valore, "testo": _testo}

## Difesa classe PESANTE (1 DIF, 4 DIF+1)
func difesa_pesante(newline: bool = true) -> Dictionary:
	var _tiri = {"DIF" : [], "DIF+1" : []}
	var _valore = 0
	var _testo = ""
	var _risultato: Dictionary
	
	# tiro dadi DIF
	_risultato = tira(N_PESANTE["DIF"], DIFESA)
	_tiri["DIF"].append(_risultato["tiri"])
	_valore += _risultato["valore"]
	_testo += _risultato["testo"]
	
	if newline:
		_testo += "\n"
	
	# tiro dadi DIF+1
	_risultato = tira(N_PESANTE["DIF+1"], DIFESA_PIU1)
	_tiri["DIF+1"].append(_risultato["tiri"])
	_valore += _risultato["valore"]
	_testo += _risultato["testo"]
	
	return {"tiri": _tiri, "valore": _valore, "testo": _testo}

# Attacchi
## Attacco DISARMATO (2 ATT, 2 ATT+1)
func attacco_disarmato(newline: bool = true) -> Dictionary:
	var _tiri = {"ATT" : [], "ATT+1" : []}
	var _valore = 0
	var _testo = ""
	var _risultato: Dictionary
	
	# tiro dadi ATT
	_risultato = tira(N_DISARMATO["ATT"], ATTACCO)
	_tiri["ATT"].append(_risultato["tiri"])
	_valore += _risultato["valore"]
	_testo += _risultato["testo"]
	
	if newline:
		_testo += "\n"
	
	# tiro dadi ATT+1
	_risultato = tira(N_DISARMATO["ATT+1"], ATTACCO_PIU1)
	_tiri["ATT+1"].append(_risultato["tiri"])
	_valore += _risultato["valore"]
	_testo += _risultato["testo"]
	
	return {"tiri": _tiri, "valore": _valore, "testo": _testo}

## Attacco PRESA (4 ATT, 3 ATT+1)
func attacco_presa(schivata_nemico: bool = false, newline: bool = true) -> Dictionary:
	var _tiri = {"ATT" : [], "ATT+1" : [], "SCH" : []}
	var _valore = 0
	var _riduzione = 0
	var _testo = ""
	var _risultato: Dictionary
	
	# tiro dadi ATT
	_risultato = tira(N_PRESA["ATT"], ATTACCO)
	_tiri["ATT"].append(_risultato["tiri"])
	_valore += _risultato["valore"]
	_testo += _risultato["testo"]
	
	if newline:
		_testo += "\n"
	
	# tiro dadi ATT+1
	_risultato = tira(N_PRESA["ATT+1"], ATTACCO_PIU1)
	_tiri["ATT+1"].append(_risultato["tiri"])
	_valore += _risultato["valore"]
	_testo += _risultato["testo"]
	
	# tiro schivata NEMICO
	if schivata_nemico:
		_risultato = tira(1, SCHIVATA)
		_tiri["SCH"].append(_risultato["tiri"])
		_riduzione += _risultato["valore"]
		return {"tiri": _tiri, "valore": _valore, "testo": _testo, "riduzione": _riduzione}
	else:
		return {"tiri": _tiri, "valore": _valore, "testo": _testo}

# Effetti di stato
## Danno MARCHIATURA (2 ATT+1 Puri)
func marchiatura(_terminale: TextEdit, newline: bool = true) -> void:
	var _valore = 0
	var _risultato: Dictionary
	
	# spazio variabile, minimo 1
	for _i in range(1 + int(newline)):
		_terminale.text += "\n"
	
	# tiri dadi ATT+1
	_risultato = tira(2, ATTACCO_PIU1)
	_valore += _risultato["valore"]
	_terminale.text += _risultato["testo"]
	_terminale.text += "MARCHIATURA:  " + str(_valore) + " Puri"

## - UTILITÀ -
# Initializzazione
## Metti a 0 i modificatori non assegnati
func assegna_modificatore(nodo_modificatore: Node) -> SpinBox:
	var modificatore: SpinBox
	
	if is_instance_valid(nodo_modificatore):
		modificatore = nodo_modificatore
	else:
		modificatore = SpinBox.new()
		modificatore.value = 0
	
	return modificatore

## Resetta le variabili all'inizio di ogni azione
func reset() -> void:
	danni = 0
	riduzione = 0
	gittata = 0
	cura = 0
	terminale.text = ""

# Abilità
## Verifica se la schivata è riuscita
func schivata(_riduzione, _terminale: TextEdit, newline: bool = true) -> void:
	if newline :
		_terminale.text += "\n"
	
	if riduzione < INF :
		_terminale.text += "RIDUZIONE:  " + str(_riduzione)
	else :
		_terminale.text += "SCHIVA!!!"

## Verifica se la presa non è utilizzabile
func forza_insufficiente(_m_AM: SpinBox, _terminale: TextEdit) -> bool:
	if  _m_AM.value < 1:
		_terminale.text += "Forza insufficiente"
		return true
	else:
		return false

## - INTERFACCIA -
# Scena
## Torna alla selezione personaggi se premi ESC
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("indietro"):
		get_tree().change_scene_to_file("res://scenes/giocatore.tscn")

## Torna alla selezione personaggi se premi la freccia indietro
func _on_indietro_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/giocatore.tscn")
