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

/**
 * Cache the return value of fn.
 *
 * @param expires (Optional) Time in ms before cached data is discarded.
 * @param validate (Optional) validate(oldArgs, newArgs) should return true if the cached value is valid.
 * @returns Wrapped version of fn
 */
function cache(fn, expires, validate) {
   validate = validate || function() { return true; };
   expires = expires || 100000000000;

   var oldArgs, cachedValue, timeout;

   function clearCache() {
      timeout = cachedValue = undefined;
   }

   return function() {
      if (cachedValue !== undefined) {
         if (validate(oldArgs, arguments)) {
            return cachedValue;
         } else {
            window.clearTimeout(timeout)
            cachedValue = undefined;
         }
      }

      if (!timeout) {
         timeout = window.setTimeout(clearCache, expires);
      }

      oldArgs = arguments;
      cachedValue = fn.apply(this, arguments);

      return cachedValue;
   };
}
