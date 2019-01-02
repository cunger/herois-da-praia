function isViewFor(controller, action) {
  return !!$('body' +
    '[data-controller="' + controller + '"]' +
    '[data-action="' + action + '"]'
  ).length;
}

$(document).on('turbolinks:load', function (event) {
  if (isViewFor('welcome', 'home')) {
    indicateUnsubmittedLogs();
    return;
  }

  if (isViewFor('welcome', 'delete')) {
    deleteAllDataButton();
    return;
  }

  if (isViewFor('activities', 'index')) {
    fillList();
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
    finishButton();
    return;
  }

  if (isViewFor('beachcleans', 'thanks')) {
    markBeachcleanAsSubmitted();
    return;
  }
});
