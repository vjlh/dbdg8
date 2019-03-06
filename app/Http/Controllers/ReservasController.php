<?php

namespace App\Http\Controllers;

use App\Reserva;
use App\Pasajero_Reserva;
use App\Vuelo;
use DB;
use Illuminate\Http\Request;
use App\Http\Requests\ReservasRequest;

class ReservasController extends Controller
{
    //Probado
    public function index()
    {
        $reserva = Reserva::all();
        return $reserva;
    }

    public function create()
    {
        //
    }

    public function store(ReservasRequest $request)
    {
        try{
            $id_paquete = $request->get('id_paquete');
            \App\Paquete::find($id_paquete)->id;
            $id_seguro = $request->get('id_seguro');
            \App\Seguro::find($id_seguro)->id;
            $id_promocion = $request->get('id_promocion');
            \App\Promocion::find($id_promocion)->id;
            $id_user = $request->get('id_user');
            \App\User::find($id_user)->id;
            $id_asiento = $request->get('id_asiento');
            \App\Asiento::find($id_asiento)->id;

            $reserva = Reserva::create($request->all());
            $reserva->save();
            return Reserva::all();
        }
        catch(\Exception $e){
            return $e->getMessage();
        }
    }

    public function show($id)
    {
        $reserva = Reserva::find($id);
        if($reserva != NULL)
            return $reserva;
        else
            return "La reserva con el id ingresado no existe o fue eliminada"; 
    }

    public function edit(Reserva $reserva)
    {
        //
    }

    public function update(Request $request, $id)
    {
        $reserva = Reserva::find($id);
        try{
            $id_paquete = $request->get('id_paquete');
            \App\Paquete::find($id_paquete)->id;
            $id_seguro = $request->get('id_seguro');
            \App\Seguro::find($id_seguro)->id;
            $id_promocion = $request->get('id_promocion');
            \App\Promocion::find($id_promocion)->id;

            $reserva->fill($request->all());
            $reserva->save();
            return $reserva;
        }
        catch(\Exception $e){
            return $e->getMessage();
        }
    }

    public function destroy($id)
    {
        $reserva = Reserva::find($id);
        if($reserva!=NULL)
        {
            $reserva->delete();
            Reserva::destroy($id);
            return "Se ha eliminado la reserva de la DB";
        }
        else
            return "La reserva con el id ingresado no existe o fue eliminada"; 

    }
    public function checkIn($cod_obtenido)
    {
        $reserva = Reserva::where('codigo_reserva', $cod_obtenido)->first();
        $reserva->check_in = true;
        $reserva->save();

        $ids_pasajeros = session()->get('pasajerosId_CheckIn');
        foreach($ids_pasajeros as $id){
            $pasajero_reserva = New Pasajero_Reserva;
            $pasajero_reserva->id_reserva = $reserva->id;
            $pasajero_reserva->id_pasajero = $id;
            $pasajero_reserva->save();
        }

        session()->forget('numPasajero_CheckIn');
        session()->forget('pasajerosId_CheckIn');

        return \Redirect::to('/')->with('statusCheckIn2','El Check-In ha sido realizado exitósamente');

    }
}
