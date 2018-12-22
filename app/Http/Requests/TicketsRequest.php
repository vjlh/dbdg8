<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class TicketsRequest extends FormRequest
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
            'tipo_pago' => 'Required|in:Credito,Debito,Efectivo,Cheque', 
            'monto_pago' => 'Required|integer', 
            'fecha_pago' => 'Required|date', 
            'id_reserva' => 'Required|numeric'
        ];
    }
}