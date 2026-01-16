# Aggregato OperazioneContabile

## Data
2026-01-16 15:01:27

## Status
Accepted

## Data di accettazione
2026-01-16 15:05:22

## Contesto e definizione del problema

OperazioneContabile rappresenta un atto intenzionale e atomico che produce un solo effetto contabile. L'aggregate fa parte del bounded context Registro Contabile (Ledger). Deve coprire entrate, uscite e trasferimenti, mantenendo invarianti di bilanciamento e evitando registrazioni duplicate. Serve un modello coerente con il linguaggio contabile italiano, con CQRS (un comando -> una operazione) e con future estensioni come annullo, rettifica e collegamento inventario.

## Fattori decisionali

* Coerenza con il linguaggio contabile italiano.
* Allineamento con CQRS (un comando -> una operazione).
* Capacita di gestire invarianti di dominio (effetto unico, bilanciamento trasferimenti, stato inventario).
* Facilita di estensione per annullo, rettifica e integrazione inventario.
* Supporto all'emissione di eventi di dominio e integrazione.

## Opzioni considerate

* Nessuna altra decisione considerata.

## Risultato della decisione

Opzione scelta: "Aggregate Root OperazioneContabile con specializzazioni Entrata, Uscita e Trasferimento", perche centralizza gli invarianti critici, mantiene coerenza con il linguaggio di dominio e facilita l'estensione futura mantenendo l'allineamento a CQRS.
