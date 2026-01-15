<?php

declare(strict_types=1);

namespace Infra\Symfony\Controller;

use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Attribute\Route;

#[Route('/api', name: 'api_')]
class Controller
{
    #[Route(
        path: '/qualcosa',
        name: 'mostra_qualcosa',
        methods: ['GET'],
    )]
    public function creaQualcosa(
        Request $req,
    ): JsonResponse {
        return new JsonResponse(['foo' => 'bar']);
    }
}
