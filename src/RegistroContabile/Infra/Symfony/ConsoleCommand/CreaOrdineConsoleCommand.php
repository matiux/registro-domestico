<?php

declare(strict_types=1);

namespace Infra\Symfony\ConsoleCommand;

use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

#[AsCommand(
    name: 'registro-domestico:ordini:crea',
    description: 'Crea un nuovo ordine',
    hidden: false,
)]
class CreaOrdineConsoleCommand extends Command
{
    private OutputInterface $output;
    private InputInterface $input;

    #[\Override]
    protected function initialize(InputInterface $input, OutputInterface $output): void
    {
        parent::initialize($input, $output);

        $this->output = $output;
        $this->input = $input;
    }

    #[\Override]
    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $this->output->writeln('Ordine creato con successo!');

        return Command::SUCCESS;
    }
}
