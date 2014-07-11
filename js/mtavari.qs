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
    დაბეჭდე დეკოდერი შეცდომა.message

დეკოდერი = (ტექსტი) ->
  რგ = /\\u([\d\w]{4})/gi;
  ტექსტი = ტექსტი.replace რგ, (შედეგი, ჯგუფი) ->
      დააბრუნე String.fromCharCode parseInt ჯგუფი, 16

  ტექსტი

დააკომპილირე = ->
  წყარო = $("#writeCode").val();

  ცადე
    კომპილირებული = ქართულსკრიპტი.დააკომპილირე წყარო, bare: on
    $("#readCode").text კომპილირებული
  დაიჭირე შეცდომა
    კონსოლში შეცდომა

დააკომპილირე()

$(".qartulskripti-code").each ->
  კოდი   = $(ეს).html()
  ღილაკი = $ '<button>დააკომპილირე</button>'
  $(ეს).append ღილაკი

  ღილაკი.click (e)->
    $("#writeCode").val კოდი
    $(".console").hide()
    $("#code").show()
    e.stopPropagation()
    დააკომპილირე()
