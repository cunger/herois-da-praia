function prettyDate(log) {
  return new Date(log.date).toDateString();
}

function prettyPlace(log) {
  if (log.place_id == '1') return 'Guinjata';
  if (log.place_id == '2') return 'Paindane';
  return log.place_name || 'Somewhere';
}

function fillList() {
  function noUnsubmittedLogs() {
    var p = document.createElement('p');
    var p_text = document.createTextNode('You have no unsubmitted logs.');
    $(p).append(p_text);
    $(p).insertAfter(ul);
  }

  var ul = $('#unsubmitted-logs');
  ul.empty();

  if (!database) {
    noUnsubmittedLogs();
  }

  database.find({
    selector: { submitted: false }
  })
  .then(function (result) {
    if (result.docs.length === 0) {
      noUnsubmittedLogs();
    }

    result.docs.forEach(function (log) {
      var li = document.createElement('li');
      $(li).addClass('activity');

      var anchor = document.createElement('a');
      var text = document.createTextNode(prettyDate(log) + ' ' + prettyPlace(log));
      var icon = document.createElement('img');
      icon.src = 'images/' + log.model + '_icon.png';
      $(icon).addClass('icon');
      $(anchor).append(icon);
      $(anchor).append(text);
      $(anchor).addClass('item');

      if (log.model === 'beachclean') {
        anchor.href = 'beachcleans/' + log._id;
      }
      if (log.model === 'whalewatch') {
        anchor.href = 'whalewatches/' + log._id;
      }

      li.appendChild(anchor);
      ul.append(li);
    })
  })
  .catch(console.log);
}

function indicateUnsubmittedLogs() {
  var span = $('#unsubmitted-logs-count');

  database.find({
    selector: { submitted: false }
  })
  .then(function (result) {
    var count = result.docs.length;
    span.html(count);
    span.removeClass();
    count === 0 ? span.addClass('counter-zero') : span.addClass('counter-non-zero');
  })
  .catch(console.log);
}
