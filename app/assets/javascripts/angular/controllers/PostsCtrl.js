var postControllers = angular.module('postControllers', []);

postControllers.controller('userPostCtrl', ['$scope', '$http', '$location', '$sce', function($scope, $http, $location, $sce) {
	urlBits = $location.absUrl().split("/");
	urlBits.length > 4 ? offset = urlBits[5] : offset = 0;
	$http.get('/' + urlBits[3] + '/json/' + offset ).success(function(data) {
   		$scope.posts = data;
	});
	$scope.trustUrl = function(url) {
    return $sce.trustAsResourceUrl(url);
	}
}]);

postControllers.controller('homeFeedCtrl', ['$scope', '$http', '$location', '$sce', function($scope, $http, $location, $sce) {
	$http.get('/home/json').success(function(data) {
   		$scope.posts = data;
	});
	$scope.trustUrl = function(url) {
    return $sce.trustAsResourceUrl(url);
	}
}]);

postControllers.controller('commCtrl' , ['$scope', '$http', '$location', '$sce', function($scope, $http, $location, $sce) {
	urlBits = $location.absUrl().split("/");
	$http.get('/communities/' + urlBits[4] + '/posts-json').success(function(data){
		$scope.posts = data;
	});
	$http.get('/communities/' + urlBits[4] + '/forum-json').success(function(data){
		$scope.forum = data;
	});
	$scope.trustUrl = function(url) {
    return $sce.trustAsResourceUrl(url);
	}
}])
