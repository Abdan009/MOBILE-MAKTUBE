<?php

namespace App;

use Illuminate\Auth\Authenticatable;
use Illuminate\Contracts\Auth\Access\Authorizable as AuthorizableContract;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Database\Eloquent\Model;
use Laravel\Lumen\Auth\Authorizable;

class M_Favorite extends Model {
    protected $table = 'favorite';
    
    public function detailUser()
    {
        return $this->hasOne(M_User::class,'id_user','id_user');
    }
}
