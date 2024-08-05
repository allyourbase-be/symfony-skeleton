<?php

namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Twig\Environment;

#[Route('/', name: 'index')]
final readonly class IndexController
{
    public function __construct(private Environment $twig)
    {
    }

    public function __invoke(): Response
    {
        return new Response($this->twig->render('index.html.twig'));
    }
}
