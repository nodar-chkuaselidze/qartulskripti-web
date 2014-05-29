დაბეჭდე = console.log

$(document).click ->
  $("#code").hide()

$("#run").click (e) ->
  $("#code").show();
  e.stopPropagation();

$("#code").click (e) ->
  e.stopPropagation();

$("#writeCode").keyup ->
  დააკომპილირე()


დააკომპილირე = ->
  წყარო = $("#writeCode").val();

  ცადე
    კომპილირებული = ქართულსკრიპტი.დააკომპილირე წყარო, bare: on
    $("#readCode").text კომპილირებული
  დაიჭირე {ადგილი, მესიჯი}
    დაბეჭდე ადგილი, მესიჯი


დააკომპილირე()

