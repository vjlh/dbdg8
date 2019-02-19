<?php

namespace App\Http\Controllers;
use DB;
use App\Quotation;
use App\Transporte;
use App\Transporte_Reserva;
use Illuminate\Http\Request;
use App\Http\Requests\TransportesRequest;
use Carbon\Carbon;


class TransportesController extends Controller
{

    public function index()
    {
        /*$transporte = Transporte::all()
        ->where('modelo_transporte','=',request("modelo_transporte"))
        ->where('num_asientos_transporte','=',request("num_asientos_transporte"))
        ->where('num_puertas_transporte','=',request("num_puertas_transporte"))
        ->where('aire_acondicioando_transporte','=',request("aire_acondicionado_transporte"));

        return view('seleccionar_auto', compact('seleccionar_auto'));*/
        //creams 2 objetos tipo carbon con las fechas 

        $fecha_inicio = Carbon::parse(request('fecha_inicio'));
        $fecha_fin = Carbon::parse(request('fecha_fin'));

        $diasDiferencia = $fecha_fin->diffInDays($fecha_inicio);

        $ciudad = request('ciudad_inicio');
        $num_asientos= request('num_asientos_transporte');

        
        $transportes_reservados1 =  DB::table('transportes_reservas')->where('fecha_fin','<',$fecha_inicio)->select('id_transporte')->get();                        
        $transportes_reservados2 =  DB::table('transportes_reservas')->where('fecha_inicio','>',$fecha_fin)->select('id_transporte')->get();                        
        
        $ids = [];
        $ids_NoDisponibles =[];

        foreach($transportes_reservados1 as $tr1){
            array_push($ids,$tr1->id_transporte);
        }
        foreach($transportes_reservados2 as $tr2){
            array_push($ids,$tr2->id_transporte);
        }

        $transportes_reservados3 = DB::table('transportes_reservas')->whereNotIn('id_transporte',$ids)->select('id_transporte')->get();
        foreach($transportes_reservados3 as $tr3){
            array_push($ids_NoDisponibles,$tr3->id_transporte);
        }

        $transportes = Transporte::all()->whereNotIn('id',$ids_NoDisponibles)
                                        ->where('num_asientos_transporte','=',$num_asientos);

        
        /*->where('ubicacion','=',$ciudad_hospedaje) */
        session()->put('diasTransporte', $diasDiferencia);
        session()->put('fechaInicioTransporte', $fecha_inicio);
        session()->put('fechaFinTransporte', $fecha_fin);
        session()->put('ubicacionTransporte', $ciudad);
        session()->put('asientosTransporte', $num_asientos);

        return view('autos',compact('transportes'));
    }

    public function create()
    {
        //
    }

    public function store(TransportesRequest $request)
    {
        $transporte = Transporte::create($request->all());
        $transporte->save();
        return $transporte;
    }

    public function show($id)
    {
        $transporte = Transporte::find($id);
        if($transporte!=NULL)
            return $transporte;
        else
            return "El transporte con el id ingresado no existe o fue eliminado"; 
    }

    public function edit(Transporte $transporte)
    {
        //
    }

    public function update(TransportesRequest $request, $id)
    {
        $transporte = Transporte::find($id);
        $transporte->fill($request->all());
        $transporte->save();
        return $transporte;
    }

    public function destroy($id)
    {
        $transporte = Transporte::find($id);
        if($transporte!=NULL)
        {
            $transporte->delete();
            Transporte::destroy($id);
            return "Se ha eliminado el transporte de la DB";
        }
        else
            return "El transporte con el id ingresado no existe o fue eliminado"; 

    }
}
