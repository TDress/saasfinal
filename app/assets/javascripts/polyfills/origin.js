// Fix for IE, which doesn't support location.origin
if (!window.location.origin) {
   window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port: '');
}
