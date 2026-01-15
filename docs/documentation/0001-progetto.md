**📒 Sistema di tracciamento spese e inventario personale**

*(monolite modulare, CQRS-first)*

---
## Obiettivo

**RegistroDomestico** è un progetto di studio e sperimentazione architetturale, con potenzialità concrete nell'uso quotidiano,
che ha come obiettivo la gestione di:

- **Entrate e uscite di denaro**
- **Conti multipli e trasferimenti**
- **Oggetti acquistati e inventariati**

Il progetto è sviluppato come **monolite modulare**, seguendo i principi illustrati nel libro **“CQRS by examples”**.

---
## Sottodomini (Bounded Context)

### 📘 Registro Contabile (Ledger)

Responsabile del tracciamento del **denaro**.

Gestisce:
- Conti (es. banca, contanti, carta)
- Movimenti contabili
- Entrate, uscite, trasferimenti
- Categorie e report

#### Comandi principali
- `RegistraEntrata`
- `RegistraUscita`
- `TrasferisciDenaro`
- `RiclassificaMovimento`
- `AnnullaMovimento`

#### Query principali
- Saldo per conto
- Elenco movimenti
- Report mensili
- Breakdown per categoria

---
### 📦 Inventario

Responsabile della gestione degli **oggetti acquistati**.

Gestisce:
- Articoli
- Quantità e unità
- Giacenze
- Consumi
- Soglie minime

#### Comandi principali
- `CreaArticolo` (Da valutare)
- `CreaBozzaAcquisto`
- `CreaAcquisto`
- `AggiungiArticoloAdAcquisto`
- `CompletaAcquisto`
- `ConsumaArticolo`
- `RettificaGiacenza`

#### Query principali
- Elenco articoli
- Giacenze sotto soglia
- Storico acquisti
- Consumi

---
## Integrazione Registro Contabile ↔ Inventario

### Spese inventariabili

Una **uscita** può essere:
- una spesa “fine a se stessa” (bollette, carburante, ecc.)
- una **spesa inventariabile**, cioè una spesa che rappresenta l’acquisto di uno o più articoli da inserire in inventario

---
### Flusso

1. L’utente registra un’uscita nel **Registro Contabile**
2. Se l’uscita è marcata come **inventario richiesto**:
    - il Registro Contabile pubblica l’evento di integrazione:
        - **`SpesaConRichiestaInventarioRegistrata`**
3. L’**Inventario** riceve l’evento e:
    - crea una **Bozza di acquisto in entrata**
    - collegata alla spesa
4. L’utente inserisce uno o più articoli nella bozza
5. Quando l’acquisto viene completato:
    - l’Inventario pubblica l’evento:
        - **`AcquistoRegistrato`**
6. Il Registro Contabile riceve l’evento e:
    - marca la spesa come **inventario collegato**

---
## Stato del progetto

- progetto **in fase di modellazione**
- focus iniziale su:
    - Registro Contabile
    - integrazione con Inventario
- evoluzione guidata da:
    - casi d’uso reali
    - principi CQRS
    - chiarezza del dominio
