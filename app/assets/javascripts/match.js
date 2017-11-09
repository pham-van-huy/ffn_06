$(document).ready(function() {
  $('#match_team1_id').on('change', function() {
    var team1_id = $(this).val()
    $('#match_team2_id option').css('display', '')
    $('#match_team2_id option[value="' + team1_id + '"]').css('display', 'none')
  })
  $('#match_team2_id').on('change', function() {
    var team2_id = $(this).val()
    $('#match_team1_id option').css('display', '')
    $('#match_team1_id option[value="' + team2_id + '"]').css('display', 'none')
  })

  $('#time-of-match .time').timepicker({
      'showDuration': true,
      'timeFormat': I18n.t('datejs.time'),
      'interval': 15
    });

  $('#time-of-match .date').datepicker({
    'format': I18n.t('datejs.date'),
    'autoclose': true
  });

  // initialize datepair
  var basicExampleEl = document.getElementById("time-of-match");
  if (basicExampleEl) {
    var datepair = new Datepair(basicExampleEl, {
      'defaultTimeDelta': 6300000,
      'setMinTime': 5
    });
  }
})
