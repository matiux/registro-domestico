# Gestione delle Architecture Decision Records (ADR)

## Status
Accepted

## Date
2026-01-15 13:20:00

## Data di accettazione
2026-01-15 16:36:30

## Contesto e definizione del problema

Il progetto richiede tracciabilita e continuita nelle decisioni architetturali. Senza ADR, le motivazioni si perdono, rendendo piu difficile l'allineamento del team e l'evoluzione coerente del sistema.

## Fattori decisionali

* Tracciabilita delle decisioni nel tempo.
* Semplicita di consultazione e revisione nel repository.
* Basso overhead per la redazione.

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

Opzione scelta: "ADR in Markdown nel repository", per garantire una traccia stabile, versionata e facilmente consultabile. Il progetto adotta ADR in Markdown e usa gli stati: proposed, accepted, rejected, deprecated, superseded by ADR-XXXX.

### Conseguenze positive <!-- opzionale -->

* Decisioni versionate e consultabili insieme al codice.
* Migliore continuita nelle scelte architetturali.

### Conseguenze negative <!-- opzionale -->

* Richiede disciplina nel mantenere gli ADR aggiornati.

## Pro e contro delle opzioni <!-- opzionale -->

### ADR in Markdown nel repository

Decisioni tracciate e vicine al codice.

* Pro: versionamento con il codice.
* Pro: facile revisione tramite PR.
* Contro: necessita di manutenzione continua.

### Decisioni registrate solo nelle issue

Decisioni distribuite tra thread operativi.

* Pro: vicino alle discussioni quotidiane.
* Pro: nessun nuovo formato da adottare.
* Contro: difficile recupero nel lungo periodo.

### Documentazione informale in wiki esterna

Decisioni separate dal repository.

* Pro: facile modifica da parte di tutti.
* Pro: aggregazione in un unico spazio.
* Contro: rischio di disallineamento con il codice.

## Collegamenti <!-- opzionale -->

* Nessuno.

## Informazioni aggiuntive <!-- opzionale -->

* Attivita: N/A.
