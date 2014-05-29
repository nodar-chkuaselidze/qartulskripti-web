კონსოლში = console.log
window.დაბეჭდე = ->
  არგუმენტები = Array.prototype.slice.apply arguments

  console.log.apply null, არგუმენტები
  $("#console").append არგუმენტები.join ' '
  $("#console").append '\n'

$(document).click ->
  $("#code").hide()
  $(".console").hide()

$("#run").click (e) ->
  $("#code").show()
  $(".console").hide()
  e.stopPropagation()

$("#code").click (e) ->
  e.stopPropagation()

$("#writeCode").keyup ->
  დააკომპილირე()

$(".console > button").click ->
  $(".console").hide()

$("#code > button").click ->
  $(".console").show()
  $("#console").text ''

  ცადე
    eval($("#readCode").text());
  დაიჭირე შეცდომა
    დაბეჭდე შეცდომა


დააკომპილირე = ->
  წყარო = $("#writeCode").val();

  ცადე
    კომპილირებული = ქართულსკრიპტი.დააკომპილირე წყარო, bare: on
    $("#readCode").text კომპილირებული
  დაიჭირე {ადგილი, მესიჯი}
    დაბეჭდე ადგილი, მესიჯი


დააკომპილირე()
