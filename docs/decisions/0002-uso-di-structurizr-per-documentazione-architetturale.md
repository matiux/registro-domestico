# Uso di Structurizr per documentazione architetturale

## Status
Accepted

## Date
2026-01-15 13:00:00

## Data di accettazione
2026-01-15 16:35:30

## Contesto e definizione del problema

Il progetto necessita di una documentazione architetturale coerente, versionata e vicina al codice. Le soluzioni informali portano a disallineamenti tra diagrammi, decisioni e implementazione.

## Fattori decisionali

* Tracciabilità delle decisioni
* Vicinanza al codice
* Versionamento
* Facilità di manutenzione

## Opzioni considerate

* Nessuna altra decisione considerata.

## Preoccupazioni e obiezioni

### Preoccupazioni

Non ostacolano la decisione.

* Nessuna.

### Obiezioni

Si oppongono alla decisione.

* Nessuna.

## Risultato della decisione

Opzione scelta: "Structurizr (DSL + markdown)", perché Structurizr consente di mantenere diagrammi, documentazione e ADR allineati e versionati insieme al codice, riducendo ambiguità e drift.

Istruzioni operative: dopo aver avviato i container con `make upd`, Structurizr è accessibile da browser all’indirizzo http://localhost:8080/.
