<?php declare(strict_types=1);

namespace Tests\Unit;

use PHPUnit\Framework\TestCase;

class ExampleTest extends TestCase
{
    public function testFirst(): string
    {
        $this->assertTrue(true);
        $a = 'first';
        return $a;
    }

    /**
     * @depends testFirst
     * 
     * @param $name string
     * @return void
     */
    public function testBasic1(string $name)
    {
        self::assertEquals($name, 'first');
    }

    /**
     * @depends testFirst
     * 
     * @param $name string
     * @return void
     */
    public function testBasic2(string $name)
    {
        self::assertEquals($name, 'first');
    }    
}
