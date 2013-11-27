angular.module('saasfinal.toolbar', [])
   /**
    * Elements with the class navbar-dynamic-top will have inline position until they
    * are scrolled out of view, at which point they have fixed position at the top of
    * the window.
    */
   .directive('navbarDynamicTop', function() {
      return {
         restrict: 'C',
         link: function(scope, element, attrs) {
            console.log("!!!!", element)
            var fixedClass = 'navbar-fixed-top';
            var placeholder = $('<div>');

            element.replaceWith(placeholder);
            placeholder.append(element);

            if (element.hasClass(fixedClass)) {
               console.log("Warning: navbar-dynamic-top should not be used on fixed position elements, but", element, "has class", fixedClass);
            }

            function updatePositioning() {
               // Check whether the element has been scrolled out of view
               if (placeholder.offset().top < $(window).scrollTop()) {
                  element.addClass(fixedClass)
               } else {
                  element.removeClass(fixedClass)
               }
            }

            function updatePlaceholder() {
               placeholder.height(element.height());
            }

            $(window)
               .scroll(updatePositioning)
               .resize(updatePlaceholder)

            element.on('$destroy', function() {
               $(window)
                  .off('scroll', updatePositioning)
                  .off('resize', updatePlaceholder)
            })
         }
      }
   })
