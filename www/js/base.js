document.getElementsByTagName("html")[0].style.setProperty("font-size", (document.body.clientWidth / 360 * 12) + "px");
var HOST='http://192.168.199.197:8080/Wuliu-Api/webapi/';
// var HOST='http://192.168.199.100:8080/Wuliu-Api/webapi/';
if (window.devicePixelRatio == 0.75) {
    console.log("devicePixelRatio is 0.75");
}
if (window.devicePixelRatio == 1.0) {
    console.log("devicePixelRatio is 1.0");
}
if (window.devicePixelRatio == 1.5) {
    //alert("devicePixelRatio is 1.5");
    viewport = $("meta[name=viewport]").get(0);
    viewport.setAttribute('content', 'target-densitydpi=185dpi,width=device-width, initial-scale=1.0,user-scalable=no');
}
if (window.devicePixelRatio >= 2.0) {
    //alert("devicePixelRatio is 2.0");
    viewport = $("meta[name=viewport]").get(0);
    viewport.setAttribute('content', 'target-densitydpi=medium-dpi,width=device-width, initial-scale=1.0,user-scalable=no');
}
