# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $(".comment-form, .reply-form")
  .on "ajax:beforeSend", (evt, xhr, settings) ->
    $(this).find('textarea')
    .addClass('uneditable-input')
    .attr('disabled', 'disabled');

  $(".comment-form")
  .on "ajax:success", (evt, data, status, xhr) ->
    $(this).find('textarea')
    .removeClass('uneditable-input')
    .removeAttr('disabled', 'disabled')
    .val('');
    $(xhr.responseText).hide().insertAfter($(this).next()).show('slow');

  $(document)
  .on "click", ".show-reply-button", ->
    console.log('ide to');
    $(this).siblings(".reply-form").toggle();

  # handle reply form
  .on "ajax:success", ".reply-form", (evt, data, status, xhr) ->
    $(this).find('textarea')
    .removeClass('uneditable-input')
    .removeAttr('disabled', 'disabled')
    .val('');
    elem = $(this).closest(".comment-show");
    elem.hide();
    elem.append($(xhr.responseText));
    elem.show("slow");
    $(this).hide();

  # handle delete comment
  .on "ajax:beforeSend", ".remove-comment-button", ->
    $(this).closest(".comment-show").fadeTo('fast', 0.5);
  .on "ajax:success", ".remove-comment-button", ->
    $(this).closest(".comment-show").hide('fast');
  .on "ajax:error", ".remove-comment-button", ->
    $(this).closest(".comment-show").fadeTo('fast', 1);


