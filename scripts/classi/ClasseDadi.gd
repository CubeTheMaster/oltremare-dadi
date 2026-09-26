## Definisce la funzione dei tiri e i dizionari dei dadi utilizzati da tutto il resto del codice
class_name DiceClass
extends Control

# Dadi
const ARCANO           = {1 : 1,  2 : 2,  3 : 3,  4 : 5,  5 : 6,  6 : 8,  "nome" : "Arcano"        }
const ATTACCO          = {1 : 1,  2 : 1,  3 : 1,  4 : 2,  5 : 2,  6 : 3,  "nome" : "Attacco"       }
const ATTACCO_PIU1     = {1 : 1,  2 : 2,  3 : 2,  4 : 2,  5 : 3,  6 : 4,  "nome" : "Attacco +1"    }
const ATTACCO_ADF      = {1 : 2,  2 : 2,  3 : 3,  4 : 3,  5 : 4,  6 : 4,  "nome" : "Attacco ADF"   }
const ATTACCO_ADF_PIU1 = {1 : 3,  2 : 3,  3 : 4,  4 : 4,  5 : 5,  6 : 6,  "nome" : "Attacco ADF +1"}
const DIFESA           = {1 : 0,  2 : 1,  3 : 1,  4 : 1,  5 : 1,  6 : 2,  "nome" : "Difesa"        }
const DIFESA_PIU1      = {1 : 1,  2 : 1,  3 : 2,  4 : 2,  5 : 2,  6 : 3,  "nome" : "Difesa +1"     }
const SCHIVATA         = {1 : 0,  2 : 0,  3 : 0,  4 : 1,  5 : 1,  6 : INF,"nome" : "Schivata"      }
const ORRIDO           = {
	1 : ATTACCO, 2 : ATTACCO, 3 : ATTACCO_PIU1, 4 : ATTACCO_ADF, 5 : ATTACCO_ADF_PIU1, 6 : ARCANO,
	"nome" : "Orrido"
}

## Tira dadi specificando numero e tipo
func tira(numero: int, tipo: Dictionary, newline: bool = true) -> Dictionary:
	var _tiri  = []
	var _testo = ""
	var _valore
	
	if tipo == ORRIDO:
		_valore = []
	else:
		_valore = 0
	
	for i in range(numero):
		_tiri.append(randi_range(1,6))
		if tipo == ORRIDO:
			_valore.append(tipo[_tiri[i]])
		else:
			_valore += tipo[_tiri[i]]
	
	_testo += "Dadi " + tipo["nome"] + ":  " + str(_tiri)
	if newline:
		_testo += "\n"
	
	return {"tiri": _tiri, "valore": _valore, "testo": _testo}
