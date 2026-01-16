# Funzionamento dei command handler

## Data
2026-01-16 23:00:52

## Status
Accepted

## Data di accettazione
2026-01-16 23:00:52

## Contesto e definizione del problema

I Command trasportano i dati necessari a un'operazione, ma serve un meccanismo per eseguirla orchestrando oggetti e servizi di dominio: il Command Handler. L'orchestrazione include la trasformazione dei parametri in tipi di dominio, il recupero o la creazione degli Aggregate e l'invocazione delle operazioni richieste. Il testo evidenzia che il flusso cambia tra creazione e aggiornamento a seconda dello stile del Repository (persistence-oriented o collection-oriented) e dell'uso della Unit of Work, che opera nell'infrastruttura e non nel dominio.

Esempio di Command Handler che crea un Aggregate e pubblica eventi:

```php
final class PostCheepCommandHandler
{
    public function __construct(
        private AuthorRepository $authorRepository,
        private CheepRepository $cheepRepository,
        private EventBus $eventBus
    ) {
    }

    public function __invoke(PostCheepCommand $command): void
    {
        $authorId = AuthorId::fromString($command->authorId());
        $cheepId = CheepId::fromString($command->cheepId());
        $message = CheepMessage::write($command->message());

        $author = $this->authorRepository->ofId($authorId);
        $this->checkAuthorExists($author, $authorId);

        $cheep = Cheep::compose($cheepId, $authorId, $message);
        $this->cheepRepository->add($cheep);

        $this->eventBus->notifyAll($cheep->domainEvents());
    }

    private function checkAuthorExists(?Author $author, AuthorId $authorId): void
    {
        if (null === $author) {
            throw AuthorDoesNotExist::withAuthorIdOf($authorId);
        }
    }
}
```

Esempio di Command Handler che aggiorna un Aggregate gia esistente:

```php
final class UpdateCheepMessageCommandHandler
{
    public function __construct(
        private CheepRepository $cheepRepository
    ) {
    }

    public function __invoke(UpdateCheepMessageCommand $message): void
    {
        $cheepId = CheepId::fromString($message->cheepId());
        $cheepMessage = CheepMessage::write($message->message());

        $cheep = $this->cheepRepository->ofId($cheepId);

        if (null === $cheep) {
            throw CheepDoesNotExist::withIdOf($cheepId);
        }

        $cheep->recomposeWith($cheepMessage);
    }
}
```

## Fattori decisionali

* I Command Handler devono orchestrare il dominio trasformando input in Value Object e invocando Aggregate.
* La scelta tra repository persistence-oriented e collection-oriented incide su come persistere le modifiche.
* L'uso della Unit of Work permette di evitare chiamate esplicite di salvataggio sugli update.
* Le dipendenze devono essere su interfacce di dominio, non su dettagli infrastrutturali.
* E utile poter sostituire repository reali con implementazioni in-memory per i test.

## Opzioni considerate

* Definire i Command Handler come orchestratori che dipendono da interfacce di dominio e repository; persistenza delegata all'infrastruttura.

## Preoccupazioni e obiezioni

### Preoccupazioni

Non ostacolano la decisione.

* Nessuna.

### Obiezioni

Si oppongono alla decisione.

* Nessuna.

## Risultato della decisione

Opzione scelta: "Definire i Command Handler come orchestratori che dipendono da interfacce di dominio e repository; persistenza delegata all'infrastruttura", perche rispecchia l'orchestrazione descritta dal testo e mantiene il dominio indipendente dai dettagli infrastrutturali. Il Command Handler trasforma input in Value Object, recupera o crea l'Aggregate e invoca l'operazione richiesta. La persistenza e responsabilita dell'infrastruttura, anche tramite Unit of Work.

Cos'e la Unit of Work (UoW): meccanismo, tipicamente fornito da un ORM come Doctrine, che traccia gli oggetti caricati, osserva le modifiche e sincronizza automaticamente il database a fine operazione. Il Command Handler non la invoca; lavora con oggetti in memoria mentre l'infrastruttura rileva e persiste le modifiche.

Differenza tra creazione e aggiornamento:

* Creazione: l'Aggregate nasce in memoria e non e ancora tracciato. La chiamata a `repository->add()` lo registra nella Unit of Work, dichiarando che deve essere persistito.
* Aggiornamento: l'Aggregate e gia stato caricato dal repository, quindi e gia sotto osservazione. Non serve chiamare `save()`; la Unit of Work persiste automaticamente le modifiche quando l'operazione termina.

Esempio di repository in-memory per test:

```php
final class InMemoryCheepRepository implements CheepRepository
{
    /** @var Cheep[] */
    private array $items = [];

    public function add(Cheep $cheep): void
    {
        $this->items[$cheep->id()->toString()] = $cheep;
    }

    public function ofId(CheepId $cheepId): ?Cheep
    {
        return $this->items[$cheepId->toString()] ?? null;
    }
}
```

Esempio di test con repository in-memory:

```php
final class PostCheepCommandHandlerTest extends TestCase
{
    private InMemoryCheepRepository $cheepRepository;
    private InMemoryAuthorRepository $authorRepository;
    private InMemoryEventBus $eventBus;
    private DateTimeImmutable $today;

    protected function setUp(): void
    {
        $this->cheepRepository = new InMemoryCheepRepository();
        $this->authorRepository = new InMemoryAuthorRepository();
        $this->eventBus = new InMemoryEventBus();
        $this->today = $this->getToday();

        Clock::instance()->changeStrategy(
            new DateCollectionClockStrategy([$this->today])
        );
    }

    /** @test */
    public function throwsExceptionWhenAuthorDoesNotExist(): void
    {
        $this->expectException(AuthorDoesNotExist::class);
        $this->expectExceptionMessage('Author "b547cf31-a0d2-4d26-aa77-8901fbdc0549" does not exist');

        $authorId = 'b547cf31-a0d2-4d26-aa77-8901fbdc0549';
        $cheepId = Uuid::uuid4()->toString();

        $this->postNewCheep(
            $authorId,
            $cheepId,
            'A message'
        );
    }

    /** @test */
    public function cheepIsPersistedSuccessfully(): void
    {
        $author = AuthorTestDataBuilder::anAuthor()->build();
        $this->authorRepository->add($author);

        $cheepId = Uuid::uuid4()->toString();
        $message = 'A message';

        $this->postNewCheep(
            $author->authorId()->id(),
            $cheepId,
            $message
        );

        $cheep = $this->cheepRepository->ofId(CheepId::fromString($cheepId));
        $this->assertNotNull($cheep);
    }

    private function postNewCheep(
        string $authorId,
        string $cheepId,
        string $message
    ): void {
        $this->eventBus->reset();

        (new PostCheepCommandHandler(
            $this->authorRepository,
            $this->cheepRepository,
            $this->eventBus
        ))(
            PostCheepCommand::fromArray([
                'author_id' => $authorId,
                'cheep_id' => $cheepId,
                'message' => $message,
            ])
        );
    }
}
```
