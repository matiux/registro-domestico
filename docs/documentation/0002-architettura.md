## Architettura generale

- **Approccio CQRS-first**
    - separazione netta tra:
        - **scrittura** (comandi, regole, validazioni)
        - **lettura** (query, viste, report)
- **Event Bus** per la comunicazione tra moduli
- **Event Sourcing opzionale**
    - valutato caso per caso
    - non imposto globalmente

---
### Stile architetturale

- Monolite modulare
- CQRS-first
- Event Bus interno

## Diagrammi

### Contesto del sistema

![](embed:SystemContext)

### Struttura del sistema

![](embed:Architettura)

## Decisioni

- [ADR-0003: CQRS come Architecture Style](../decisions/0003-cqrs-come-architecture-style.md)
- [ADR-0002: Uso di Structurizr per documentazione architetturale](../decisions/0002-uso-di-structurizr-per-documentazione-architetturale.md)
