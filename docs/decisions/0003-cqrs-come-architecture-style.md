# CQRS come Architecture Style

## Data
2026-01-15 18:46:20

## Status
Accepted

## Data di accettazione
2026-01-15 18:46:20

## Contesto e definizione del problema

La crescita del dominio richiede ridurre l'accoppiamento tra letture e scritture, senza perdere chiarezza nel modello. Le letture hanno esigenze di prestazioni e di modellazione diverse dalle scritture. Serve una struttura che renda espliciti questi flussi e supporti evoluzione e scalabilità.

## Fattori decisionali

* Separazione di responsabilità tra letture e scritture
* Prestazioni e scalabilità delle query di lettura
* Chiarezza del modello e riduzione della complessità accidentale

## Opzioni considerate

* Monolite CRUD con modello unico
* CQRS con modelli e percorsi separati
* Microservizi per separare lettura e scrittura

## Risultato della decisione

Opzione scelta: "CQRS con modelli e percorsi separati", perchè allinea il modello di scrittura alle regole di dominio e consente ottimizzare le query di lettura senza compromettere la coerenza del core.
