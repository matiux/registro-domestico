## Uso di Codex per creare ADR e documentazione

Questa guida spiega come usare Codex per creare ADR e aggiornare la documentazione.

### Creazione di un nuovo ADR: due modalità

#### 1) Richiesta diretta al prompt

Puoi chiedere direttamente a Codex di creare l'ADR specificando titolo, status e indicazioni sui contenuti. Esempio:

```
Crea un nuovo ADR in docs/decisions usando il template in docs/decisions/_templates/adr-template.md.
Titolo: CQRS come Architecture Style
Status: Proposed
Nelle sezioni, compila con testo sufficientemente approfondito basandoti sulla chat "Libro: CQRS by Examples".
I fattori decisionali sono i seguenti: ...
Non ci sono altre opzioni considerate.
Non ci sono preoccupazioni.
Non ci sono obiezioni.
Il risultato della decisione è: ...
Mostrami il diff.
```

#### 2) Uso della skill `adr-new`

La skill `adr-new` guida la compilazione del template ufficiale degli ADR. Una volta invocata, Codex chiede tutte le informazioni necessarie (contesto, fattori decisionali, opzioni, scelta e giustificazione), genera il file in `docs/decisions/` con il numero progressivo e mostra il diff.

### Passare da Proposed ad Accepted

Per cambiare lo stato di un ADR da Proposed ad Accepted si usa la skill `adr-accept`. La skill aggiorna lo status e imposta la data di accettazione. Usala quando la decisione e stata formalmente approvata.
