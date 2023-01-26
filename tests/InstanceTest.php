<?php

declare(strict_types=1);

namespace Tests\Warsztaty;

use GuzzleHttp\Client;
use PHPUnit\Framework\TestCase;

final class InstanceTest extends TestCase
{
    public function testShootByGetRequestGives200SuccessResponse(): void
    {
        //arrange
        $client = new Client([]);

        //act
        $response = $client->get(self::getInstanceIp());

        //assert
        $this->assertEquals(200, $response->getStatusCode());
    }

    private static function getInstanceIp(): string
    {
        $name = 'WARSZTATY_INSTANCE_IP';

        if (isset($_ENV[$name]) === false) {
            throw new \RuntimeException("Env variable is missing!");
        }

        if (strlen($_ENV[$name]) === 0) {
            throw new \RuntimeException("Env variable is missing!");
        }

        return $_ENV[$name];
    }
}
