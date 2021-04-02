<?php

namespace App\Http\Controllers;

use App\M_Visitors;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class VisitorsController extends Controller
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

    public function addVisitor(Request $request)
    {
        $validator= Validator::make($request->all(), [
            'id_user'=> 'required',
            'id_video'=> 'required',
            'time_create'=>'required'
        ]);

        if($validator->fails()){
            return response()->json([
                'error'=> $validator->errors()->getMessages()
            ]);
        }
        $data = M_Visitors::insertGetId([
            'id_user'=> $request->input('id_user'),
            'id_video'=> $request->input('id_video'),
            'time_create'=> $request->input('time_create')
        ]);
        if($data){
            return response()->json([
                'code'=> 200,
                'message'=> 'Data Berhasil Disimpan',
                
            ]);
        }
        return response()->json([
            'code'=> 400,
            'message'=> 'Data Gagal Disimpan',
            
        ]);
    }

    public function getMyVisitors($id)
    {
        $data = M_Visitors::where('id_user', $id)->get();

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
    public function getInVisitorsVideos($id)
    {
        $data = M_Visitors::where('id_video', $id)->get();
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
}
