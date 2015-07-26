// Given a query string "?to=email&why=because&first=John&Last=smith"
// getUrlVar("to")  will return "email"
// getUrlVar("last") will return "smith"

function getUrlVar(key){
  var result = new RegExp(key + "=([^&]*)", "i").exec(window.location.search);
  return result && unescape(result[1]) || "";
}

$(function () {
  $scope = getUrlVar("scope") || "all";
  $selector = "li#" +  $scope + "-issues";
  $( $selector ).addClass( "active" );
});
