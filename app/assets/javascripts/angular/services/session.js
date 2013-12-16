angular.module('saasfinal.session', ['saasfinal.cookies'])
   .factory('Session', function(CookieStore) {
      var session = {
         loggedIn: CookieStore.get('userId'),
         logIn: function() {
            loginPopup = window.open('/session/create', 'loginPopup', 'width=480,height=640,left=' +
               ((window.screen.availWidth/2)-240));
            if (window.focus) {
               loginPopup.focus();
            }
         },
         logOut: function() {
            window.location = "/session/destroy";
         }
      };

      return session;
   })
