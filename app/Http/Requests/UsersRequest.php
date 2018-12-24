<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UsersRequest extends FormRequest
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
            'name' => 'required|string', 
            'email' => 'required|email', 
            'password' => 'required|string', 
            'apellido_usuario' => 'required|string', 
            'fecha_nacimiento' => 'required|date', 
            'num_documento_usuario' => 'required|numeric',
            'pais_usuario' => 'required|string',
        ];
    }
}
