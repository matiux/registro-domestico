workspace "RegistroDomestico" "Documentazione e diagrammi C4" {

    !docs documentation
    !adrs decisions

    // model → cosa esiste (mattoncini + relazioni)
    model {

        // parole riservate C4 (Structurizr DSL)

        // person        → una persona reale (utente umano)
        // softwareSystem→ il sistema nel suo insieme
        // container     → qualcosa che gira / si deploya (API, backend, DB, bus)
        // component     → parte interna di un container (classi, handler, servizi)

        user = person "Utente" "Persona che registra spese e gestisce l'inventario."

        servizio = softwareSystem "RegistroDomestico" "Monolite modulare CQRS-first" {
            ledger = container "Ledger" "Registro contabile (spese, ecc.)" "Backend"
            inventory = container "Inventory" "Gestione inventario (acquisti, giacenze, ecc.)" "Backend"
            eventBus = container "Event Bus" "Integrazione interna tramite eventi" "In-process"
            db = container "Database" "Persistenza" "DB"
        }

        // a -> b        → relazione: a usa / dipende da b

        user -> servizio "Usa"
        ledger -> db "Legge/scrive"
        inventory -> db "Legge/scrive"
        ledger -> eventBus "Pubblica eventi"
        inventory -> eventBus "Pubblica eventi"
        eventBus -> ledger "Consegna eventi"
        eventBus -> inventory "Consegna eventi"
    }

    // views → come lo guardi (diagrammi)
    views {

        // systemContext → vista macro (utente + sistema)
        // container     → vista dei container interni
        // component     → vista dei componenti di un container

        systemContext servizio "SystemContext" {
            include *
            autoLayout
        }

        container servizio "Architettura" {
            include *
            autoLayout
        }

        theme default
    }
}
