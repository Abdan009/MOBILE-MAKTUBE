<?php

namespace App\Http\Controllers;

use App\M_Favorite;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class FavoriteController extends Controller
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
            'id_user' => 'required',
            'id_video' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'error' => $validator->errors()->getMessages()
            ]);
        }
        $data = M_Favorite::insertGetId([
            'id_user' => $request->input('id_user'),
            'id_video' => $request->input('id_video'),
        ]);
        if ($data) {
            return response()->json([
                'code' => 200,
                'message' => 'Data Berhasil Disimpan',

            ]);
        }
        return response()->json([
            'code' => 400,
            'message' => 'Data Gagal Disimpan',

        ]);
    }

    public function index()
    {
        return response()->json([
            'code' => 200,
            'message' => 'Data Berhasil Diambil',
            'data' => M_Favorite::get()
        ]);
    }
    public function deleteFavorite($idUser, $idVideo)
    {
        $data =  M_Favorite::where('id_user', $idUser)->where('id_video', $idVideo)->delete();
        if ($data) {
            return response()->json([
                'code' => 200,
                'message' => 'Data Berhasil Dihapus',
            ]);
        }
        return response()->json([
            'code' => 400,
            'message' => 'Data Tidak Tersedia',
        ]);
    }
    public function getMyFavorite($id)
    {
        try {
            $data =  M_Favorite::with(['detailUser'])->where('id_user', $id)->get();
            if ($data) {
                return response()->json([
                    'code' => 200,
                    'message' => 'Data Berhasil Didapatkan',
                    'data' =>  $data
                ]);
            }
            return response()->json([
                'code' => 400,
                'message' => 'Data Tidak Tersedia',
            ]);
        } catch (Exception $error) {
            return response()->json([
                'code' => 400,
                'message' => 'Data Gagal Disimpan',
                'error' => $error

            ]);
        }
    }
}
