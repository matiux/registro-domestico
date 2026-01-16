# Utilizzo di factory

## Data
2026-01-16 22:49:01

## Status
Accepted

## Data di accettazione
2026-01-16 22:49:01

## Contesto e definizione del problema

La creazione dei Command parte dal delivery mechanism (web controller, CLI, message queue) e deve trasformare
input infrastrutturali in oggetti applicativi. Nella maggior parte dei casi costruire i Command nel controller
basta, ma serve una linea guida che eviti di mescolare dettagli infrastrutturali nei Command e centralizzi la
logica di creazione. Inoltre, quando i Command hanno molti parametri opzionali, la costruzione diretta diventa
verbosa e soggetta a errori.

Esempi dal testo: un Command puo essere creato con un factory method direttamente nel Command:

```php
$command = SignUpCommand::fromHttpRequest($request);
```

Oppure con factory dedicate per canale:

```php
SignUpCommandFactory::fromHttpRequest($request);
SignUpCommandFactory::fromCliInput($input);
SignUpCommandFactory::fromMessagePayload($message);
```

```php
(new SignUpCommandHttpRequestFactory($request))->build();
(new SignUpCommandCliInputFactory($input))->build();
```

Per comandi con molti opzionali, un builder rende la creazione piu leggibile:

```php
$command = SignUpCommandBuilderMock::builder($authorId, 'johndoe', 'test@email.com')
    ->build();
```

## Fattori decisionali

* Centralizzare la logica di creazione dei Command per ridurre duplicazioni tra canali (API, web form, CLI, message queue).
* Evitare l'accoppiamento tra Application e Infrastructure mantenendo i Command puliti.
* Fornire un percorso semplice da usare quando il numero di parametri opzionali cresce, come il builder nell'esempio.
* Mantenere la trasformazione dal delivery mechanism coerente e testabile.
* Consentire estensioni future dei canali senza toccare il core applicativo.

## Opzioni considerate

* Usare factory dedicate per costruire i Command, con metodi statici o classi factory specifiche per canale.

## Preoccupazioni e obiezioni

### Preoccupazioni

Non ostacolano la decisione.

* Nessuna.

### Obiezioni

Si oppongono alla decisione.

* Nessuna.

## Risultato della decisione

Opzione scelta: "Usare factory dedicate per costruire i Command, con metodi statici o classi factory specifiche per canale", perche centralizza la trasformazione dal delivery mechanism e evita di mescolare dettagli infrastrutturali nei Command. Il testo mostra che questo vale sia per factory method sul Command, sia per factory dedicate per canale:

```php
$command = SignUpCommand::fromHttpRequest($request);
```

```php
SignUpCommandFactory::fromMessagePayload($message);
(new SignUpCommandHttpRequestFactory($request))->build();
```

Quando i parametri opzionali sono numerosi, l'uso di un builder mantiene la costruzione chiara e consistente:

```php
$command = SignUpCommandBuilderMock::builder(Uuid::uuid4()->toString(), 'johndoe', 'test@email.com')
    ->name('John Doe')
    ->website('https://johndoe.com')
    ->biography('An example author')
    ->birthDate('31/01/1983')
    ->location('California')
    ->build();
```

Esempio completo di builder dal testo:

```php
final class SignUpCommandBuilder
{
    private function __construct(
        private string $authorId,
        private string $userName,
        private string $email,
        private ?string $name = null,
        private ?string $location = null,
        private ?string $website = null,
    ) {
    }

    public static function create(
        string $authorId,
        string $userName,
        string $email
    ): self {
        return new self($authorId, $userName, $email);
    }

    public function username(string $userName): self
    {
        $this->userName = $userName;

        return $this;
    }

    public function email(string $email): self
    {
        $this->email = $email;

        return $this;
    }

    public function name(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function location(string $location): self
    {
        $this->location = $location;

        return $this;
    }

    public function website(string $website): self
    {
        $this->website = $website;

        return $this;
    }

    public function build(): SignUpCommand
    {
        return new SignUpCommand(
            $this->authorId,
            $this->userName,
            $this->email,
            $this->name,
            $this->location,
            $this->website
        );
    }
}
```
