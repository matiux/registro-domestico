---
name: adr-new
description: Crea un nuovo ADR in docs/decisions usando il template ufficiale e (opzionale) aggiorna la documentazione.
---

## Input richiesto (chiedili all'utente se mancano)
- Titolo ADR (breve)
- Contesto e definizione del problema
- Fattori decisionali
- Opzioni considerate
- Opzione scelta (deve essere una delle opzioni considerate)
- Giustificazione

## Regole (obbligatorie)
- Usa il template: docs/decisions/_templates/adr-template.md
- Crea il file in: docs/decisions/NNNN-<slug>.md
- NNNN = prossimo numero disponibile (4 cifre, progressivo)
- Slug = kebab-case
- Imposta:
  - Status: Proposed
  - Data: data odierna con orario (YYYY-MM-DD HH:MM:SS)
  - Data di accettazione: -
- NON modificare il template.

## Pulizia template (OBBLIGATORIO)
- Non lasciare nel file testo segnaposto del template, ad esempio righe che contengono:
  `[ad esempio`, `[etc.]`, `[opzione`, `<!-- opzionale -->`.
- Se non ci sono contenuti reali per una sezione opzionale, rimuovi l'intera sezione (titolo incluso) invece di lasciare placeholder.

## Output
1) Nuovo file ADR creato e compilato.
2) Se l'utente lo chiede, aggiungi un riferimento in docs/documentation/0002-architettura.md in una sezione "Decisioni" (creala se manca), come lista di link.
3) Mostra il diff.
