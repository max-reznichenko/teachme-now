# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

load_user_tabs = ->
  active_tab = $(".main .profile .tabs .tab.active")
  if active_tab.length > 0
    $(".right .ajax_loader").removeClass "invisible"
    $(".profile .content").html ""
    url = active_tab.data().url
    $.ajax
      url: url
      type: 'get'
      success: (response) ->
        $(".profile .content").html response
        $(".right .ajax_loader").addClass "invisible"

$ ->
  $("#not_social_link").click (event) ->
    event.preventDefault()
    $(".sign_in .form_wrapper").slideToggle()

  $(".submittable").click (event) ->
    event.preventDefault()
    $(this).closest("form").submit()

  $(".clickable").click (event) ->
    event.preventDefault()
    document.location = $(this).closest("a").attr("href")

  $(".toggle_subscription").click (event) ->
    url = $(this)
    $.ajax
      url: url.attr("href")
      type: 'post'
      data:
        _method: url.data().method
      success: (response) ->
        url.html(response)
        if url.data().method == 'delete'
          new_method = 'post'
        else
          new_method = 'delete'
        url.data('method', new_method)
    false

  $(".toggle_rating").click (event) ->
    url = $(this)
    $.ajax
      url: url.attr("href")
      type: 'post'
      data:
        _method: url.data().method
      success: (response) ->
        url.html(response)
        if url.data().method == 'put'
          new_method = 'post'
        else
          new_method = 'put'
        url.data('method', new_method)
    false

  load_user_tabs()

  $(".tabs .tab").click (event) ->
    $(".tabs .tab.active").removeClass("active")
    $(this).addClass("active")
    load_user_tabs()