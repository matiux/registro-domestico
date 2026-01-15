---
name: adr-accept
description: Imposta uno specifico ADR come accepted e aggiorna la Date a oggi, includendo il supporto per Structurizr.
---

## Input richiesto
- Percorso file ADR (es: docs/decisions/0002-qualcosa.md)

## Regole
1. Se esiste una riga:
    - `Status: ...`
    - aggiornarla in `Status: Accepted`
    - aggiornare (o aggiungere se assente) la riga:
        - `Data di accettazione: YYY-MM-DD HH:MM:SS` (data odierna con orario)
      
2. Se lo stato è già `Accepted`:
    - non fare modifiche

3. Non cambiare nient’altro nel file.

4. Mostrare sempre il diff.

## Note
- Non rinominare file.
- Non modificare template o altri documenti.
