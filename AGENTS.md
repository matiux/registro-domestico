# AGENTS.md — ADR & Documentazione (Structurizr)

## Scope
Questo agente gestisce ADR e documentazione architetturale.

## Percorsi canonici
- ADR: docs/decisions/
- Template ADR: docs/decisions/_templates/adr-template.md
- Documentazione: docs/documentation/
- Structurizr: docs/workspace.dsl

## Regole ADR (OBBLIGATORIE)
- Ogni ADR è un file Markdown in `docs/decisions/`
- Naming: NNNN-kebab-case.md
- Il contenuto DEVE rispettare esattamente il template ufficiale
- Non modificare MAI il template
- Compilare sempre:
    - Titolo
    - Status
    - Date
    - Contesto e definizione del problema
    - Fattori decisionali
    - Opzioni considerate
    - Risultato della decisione

## Regole di documentazione
- Se una decisione è architetturalmente rilevante:
    - deve essere citata in `docs/documentation/`
- Non ristrutturare file esistenti senza richiesta esplicita

## Comportamento dell’agente
- Prima di scrivere: piano sintetico (max 5 step)
- Diff piccoli
- Nessun refactor non richiesto
- Chiedere conferma prima di comandi shell
