angular.module('saasfinal.cookies', [])
   .factory('CookieStore', function() {
      return {
         get: function(key) {
            var cookies = document.cookie.split(';')

            for (var i = 0; i < cookies.length; i++) {
               cookie = cookies[i].split('=');

               if (cookie[0].replace(/(^\s*|\s*$)/g, '') == key) {
                  return cookie[1]
               }
            };

            return undefined;
         },
         put: function(key, value, expires) {
            var cookie = key + "=" + value;

            if (expires) {
               cookie += ";expires=" + expires.toUTCString();
            }

            document.cookie = cookie;
         }
      }
   })
