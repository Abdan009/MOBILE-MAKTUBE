<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
    return $router->app->version();
});

/////////////////////// LOGIN ///////////////////////
$router->post('login', 'UserController@login');

/////////////////////// CRUD FAVORITE ///////////////////////
$router->post('store_favorite', 'FavoriteController@store');
$router->get('get_favorites', 'FavoriteController@index');
$router->delete('delete_favorite/{idUser}/{idVideo}', 'FavoriteController@deleteFavorite');
$router->get('get_my_favorite/{id}', 'FavoriteController@getMyFavorite');

/////////////////////// CRUD USER ///////////////////////
$router->post('register', 'UserController@store');
$router->get('users/{id}', 'UserController@getUserById');
$router->delete('delete_User', 'UserController@deleteUser');

/////////////////////// CRUD VISITORS ///////////////////////
$router->post('add_visitorr', 'VisitorsController@addVisitor');
$router->get('get_my_visitor/{id}', 'VisitorsController@getMyVisitors');
$router->get('get_visitor_videos/{id}', 'VisitorsController@getInVisitorsVideos');

