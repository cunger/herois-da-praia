function isViewFor(controller, action) {
  return !!$('body' +
    '[data-controller="' + controller + '"]' +
    '[data-action="' + action + '"]'
  ).length;
}

$(document).on('turbolinks:load', function (event) {

  if (isViewFor('welcome', 'start')) {
    indicateUnsubmittedLogs();
    return;
  }

  if (isViewFor('beachcleans', 'new')) {
    handlerForPlaceOptions();
    startLoggingButton();
    return;
  }

  if (isViewFor('beachcleans', 'show')) {
    initCounts();
    attachHandlersForCountingItems();
    saveButton();
    submitButton();
    deleteButton();
    return;
  }

  if (isViewFor('beachcleans', 'summary')) {
    initCounts();
    backButton();
    sendButton();
    return;
  }

  if (isViewFor('beachcleans', 'thanks')) {
    markBeachcleanAsSubmitted();
    return;
  }
});
