<?php

use PHPUnit\Framework\TestCase;

final class BasicTest extends TestCase
{
    public function testSum()
    {
        $this->assertEquals(4, 2 + 2);
    }
}
