<?php

namespace App\Http\Controllers;

use App\M_User;
use App\M_Favorite;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'username' => 'required',
            'password' => 'required',
            'nama' => 'required',
            'alamat' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'error' => $validator->errors()->getMessages()
            ]);
        }
        $data = M_User::insertGetId([
            'username' => $request->input('username'),
            'password' => Hash::make($request->input('password')),
            'nama' => $request->input('nama'),
            'alamat' => $request->input('alamat'),
            'no_hp' => $request->input('no_hp'),
        ]);
        if ($data) {
            $getData = M_User::where('username',$request->input('username'))->first();
            return response()->json([
                'code' => 200,
                'message' => 'Regitrasi Berhasil',
                'data'=>$getData

            ]);
        }
        return response()->json([
            'code' => 400,
            'message' => 'Regitrasi Gagal',

        ]);
    }
    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'username' => 'required',
            'password' => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json([
                'error' => $validator->errors()->getMessages()
            ]);
        }
        $data = M_User::where('username', $request->input('username'))->first();
        if ($data) {
            if (Hash::check($request->input('password'),$data->password)) {
                return response()->json([
                    'code' => 200,
                    'message' => 'Login Berhasil',
                    'data' => $data
                ]);
            } else {
                return response()->json([
                    'code' => 400,
                    'message' => 'Password atau Username salah',
                ]);
            }
        }

        return response()->json([
            'code' => 400,
            'message' => 'Username tidak terdaftar',
        ]);
    }
    public function getUserById($id)
    {
        $data = M_User::where('id_user', $id)->first();
        if($data){
            return response()->json([
                'code'=> 200,
                'message'=> 'Data Berhasil Diambil',
                'data'=> $data
            ]);
        }
        return response()->json([
            'code'=> 400,
            'message'=> 'Data Tidak Terdaftar',
        ]);
    }   
    public function deleteUser(Request $request)
    {
        $data = M_User::where('id_user', $request->input('id_user'))->delete();
        if($data){
            return response()->json([
                'code'=> 200,
                'message'=> 'Data Berhasil di delete',
            ]);
        }
        
        return response()->json([
            'code'=> 400,
            'message'=> 'Data Tidak Tersedia',
        ]);
    }
}
