<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class VuelosRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'hora_vuelo' => 'required|date_format:"H:i:s"', 
            'duracion_vuelo' => 'required|date_format:"H:i"', 
            'fecha_vuelo' => 'required|date', 
            'origen_vuelo' => 'required|string', 
            'destino_vuelo' => 'required|string', 
            'id_avion' => 'required|numeric', 
            'id_aeropuerto' => 'required|numeric',
            'cantidad_disponible' => 'required|numeric',
        ];
    }
}
