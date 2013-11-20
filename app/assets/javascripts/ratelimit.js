/**
 * Hold calls to fn `delay` until milliseconds after the last call (i.e. to save server resources while user is typing).
 *
 * @param fn Limit the rate of this function
 * @param delay Delay (in ms) after last call before calling fn (defaults to 300ms)
 * @returns Wrapped function which obeys delay
 */
function ratelimit(fn, delay) {
   delay = delay || 300;

   var delayTimer = null;

   return function() {
      var args = arguments;
      queuedCall = function(){
         delayTimer = null;
         fn.apply(this, args)
      };

      if (delayTimer) {
         window.clearTimeout(delayTimer);
      }

      delayTimer = window.setTimeout(queuedCall, delay);
   };
}
