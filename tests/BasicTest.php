<?php

declare(strict_types=1);

namespace App\Tests;

use PHPUnit\Framework\TestCase;

final class BasicTest extends TestCase
{
    public function testSum(): void
    {
        $this->assertEquals(4, 2 + 2);
    }
}