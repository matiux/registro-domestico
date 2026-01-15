Domain-driven-Refactoring
======

## Development

```shell
git clone git@github.com:matiux/registro-domestico.git && cd registro-domestico
cp docker/docker-compose.override.dist.yml docker/docker-compose.override.yml
cp docker/.env.dist docker/.env
rm -rf .git/hooks && ln -s ../scripts/git-hooks .git/hooks
aws-vault exec play
make build-php ARG=--no-cache
make upd
```

## Documentazione

La documentazione architetturale è mantenuta con Structurizr. Dopo aver avviato lo stack Docker, è accessibile via browser all'indirizzo:

```
http://localhost:8080
```

### Eseguire il setup del progetto
```shell
make project ARG=setup-dev
make project ARG=setup-test (opzionale per ora)
```

## Makefile di progetto
Questo repository include un Makefile che semplifica tutte le operazioni di sviluppo e manutenzione del progetto.
Grazie a esso non è necessario accedere manualmente al container Docker PHP per eseguire comandi: tutte le operazioni
comuni sono disponibili tramite make.

### Scopo
Il Makefile funge da interfaccia principale per interagire con il progetto.
Wrappa una serie di comandi Docker e strumenti interni, permettendo di eseguire attività di sviluppo, test e
manutenzione con un’unica sintassi coerente, ad esempio:

```shell
make composer ARG=update
make phpunit
make psalm
make project ARG=shortlist
```

### Struttura generale

Il Makefile definisce diversi gruppi di comandi:

| **Categoria**           | **Descrizione**                                                                                                     |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------- |
| **Docker**              | Comandi di gestione dei container: `build`, `up`, `down`, `logs`, ecc.                                              |
| **Composer / PHP**      | Wrapper per eseguire `composer` o comandi PHP all’interno del container PHP, senza doverci entrare manualmente.     |
| **Coding standard**     | Comandi per formattare o verificare il codice sorgente (es. *PHP CS Fixer*).                                        |
| **Test**                | Comandi per eseguire la suite di test (`phpunit`, `infection`, `coverage`).                                         |
| **Analisi statica**     | Comandi per strumenti come *Psalm* o *Deptrac*, utili per verificare la qualità e le dipendenze architetturali.     |
| **Sicurezza**           | Comandi per controllare le vulnerabilità nelle dipendenze.                                                          |
| **Utility di progetto** | Comandi generici per interagire con il tool bash `project`, che automatizza operazioni personalizzate del progetto. |

### Esecuzione

Tutti i comandi vengono eseguiti tramite Docker Compose, usando l’ambiente definito nel file docker-compose.yml.
Il Makefile si occupa di passare automaticamente il contesto corretto (container, utente, working directory).

Esempio:

```bash
make up                     # Avvia i container
make enter                  # Entra nel container PHP come utente di progetto
make composer ARG=install   # Esegue 'composer install' dentro al container
```
### Il tool project

Molti comandi del Makefile richiamano un eseguibile bash interno, situato in:

`tools/bin/project/project`

Questo script funge da autopilota del progetto:
contiene sotto-comandi dedicati per eseguire operazioni specifiche (build, test, formattazione, verifica vulnerabilità,
ecc.) in modo coerente e automatizzato.

Puoi vedere le operazioni disponibili con:

```bash
make project ARG=shortlist
```

## Console di Symfony

| **Comando**                                   | **Descrizione breve**                                                   |
| --------------------------------------------- | ----------------------------------------------------------------------- |
| `php bin/console`                             | Mostra l’elenco di tutti i comandi disponibili.                         |
| `php bin/console list`                        | Come sopra, ma organizzato per namespace.                               |
| `php bin/console debug:router`                | Elenca tutte le rotte registrate (nome, path, controller, metodo HTTP). |
| `php bin/console debug:container`             | Mostra i servizi presenti nel container (puoi filtrare con un nome).    |
| `php bin/console debug:config <bundle>`       | Mostra la configurazione effettiva di un bundle.                        |
| `php bin/console cache:clear`                 | Svuota la cache di Symfony.                                             |
| `php bin/console cache:warmup`                | Rigenera la cache senza cancellarla prima.                              |

### Comandi del progetto

| **Comando**                                  | **Descrizione breve**                                                   |
| -------------------------------------------- |-------------------------------------------------------------------------|
|        |                                                    |
