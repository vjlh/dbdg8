<?php

use Illuminate\Database\Seeder;

class TicketsSeeders extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        factory('App/Ticket'::class, 30)->create();
    }
}
