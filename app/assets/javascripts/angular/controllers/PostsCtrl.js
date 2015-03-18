var postControllers = angular.module('postControllers', []);

postControllers.controller('userPostCtrl', ['$scope', '$http', '$location', '$sce', function($scope, $http, $location, $sce) {
	urlBits = $location.absUrl().split("/");
	urlBits.length > 4 ? offset = urlBits[5] : offset = 0;
	$http.get('/' + urlBits[3] + '/json/' + offset ).success(function(data) {
   		$scope.posts = data;
	})
}]);