'use strict';
angular.module("IntegratedFramework.Signin", ['ngRoute'])
    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/Signin', {
            templateUrl: 'Signin.html',
            controller: 'SigninController'
        })
    }])
    .controller("SigninController", function ($scope, $http, myHttpService, serviceList) {
        layer.load(0);
    })
;
