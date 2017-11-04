$(document).ready(function() {
  $(".submit-bet").on("click", function(){
    var data = {}
    var tagert = $(this)
    var get_input = $(this).parent().siblings(".margin_row").find("div").find(".col-xs-4")
    data.team1_goal = parseInt(get_input.find("input[name=goal1]").val())
    data.team2_goal = parseInt(get_input.find("input[name=goal2]").val())
    data.coin = parseInt(get_input.find("input[name=coin]").val())
    data.match_id = parseInt($(this).data("match-id"))
    var current_coin = parseInt($(this).data("coin"))
    if (validate(data.team1_goal, data.team2_goal, data.coin, current_coin)) {
      $.ajax({
        type: "POST",
        url: "/bets",
        data: data,
        success: function(response) {
          if (response.status) {
            get_input.find("input[name=goal1]").val(null)
            get_input.find("input[name=goal2]").val(null)
            get_input.find("input[name=coin]").val(null)
            var html = "<tr>"
            html += "<td><i class='fa fa-futbol-o' aria-hidden='true'></i>"
            html += "<span class='bet_goal_1' data-goal-1='" + data.team1_goal
            html += "'>" + data.team1_goal + "</span></td>"
            html += "<td><i class='fa fa-futbol-o' aria-hidden='true'></i>"
            html += "<span class='bet_goal_2' data-goal-2='" + data.team2_goal
            html += "'>" + data.team2_goal + "</span></td>"
            html += "<td><i class='fa fa-usd' aria-hidden='true'></i>"
            html += "<span class='bet_coin' data-coin='" + data.coin + "'>"
            html += data.coin + "</span></td>"
            html += "<td><span class='edit_bet btn-success' data-bet-id='" + response.bet.id + "'"
            html += "data-coin-user='" + (current_coin - data.coin) + "'>"
            html += "<i class='fa fa-pencil' aria-hidden='true'></i> </span>"
            html += "<span class='delete_bet btn-danger' data-bet-id='" + response.bet.id + "'>"
            html += "<i class='fa fa-trash' aria-hidden='true'></i></span></td>"
            $(".show-list-bet").append(html)
          }
          alert(response.message)
        }
      })
    }
  })

  $(".show-list-bet").on("click", ".edit_bet", function() {
    var parent = $(this).parent()
    var tds = parent.siblings('td')
    var bet_goal_1 = tds.find(".bet_goal_1")
    var bet_goal_2 = tds.find(".bet_goal_2")
    var bet_coin = tds.find(".bet_coin")
    var bet_id = $(this).data("bet-id")
    var html = "<input type='number' class='bet_goal_1' value='"+ bet_goal_1.data("goal-1")
    html += "' data-goal1='" + bet_goal_1.data("goal-1") + "'>"
    bet_goal_1.replaceWith(html)
    html = "<input type='number' class='bet_goal_2' value='"+ bet_goal_2.data("goal-2")
    html += "' data-goal2='" + bet_goal_2.data("goal-2") + "'>"
    bet_goal_2.replaceWith(html)
    html = "<input type='number' class='bet_coin' value='"+ bet_coin.data("coin")
    html += "' data-coin='" + bet_coin.data("coin") + "'>"
    bet_coin.replaceWith(html)
    var html_button = '<span class="bet-save-edit btn-success" data-bet-id="'
    html_button += bet_id + '" data-coin-user="' + $(this).data("coin-user") + '">'
    html_button += '<i class="fa fa-floppy-o" aria-hidden="true"></i></span> '
    html_button += ' <span class="bet-cancel-edit btn-danger" data-bet-id="'
    html_button += bet_id + '" data-coin-user="' + $(this).data("coin-user") + '"'
    html_button += '"><i class="fa fa-ban" aria-hidden="true"></i></span>'
    parent.html(html_button)
  })

  $(".show-list-bet").on("click", ".bet-cancel-edit", function() {
    var parent = $(this).parent()
    var tds = parent.siblings('td')
    var bet_goal_1 = tds.find(".bet_goal_1")
    var bet_goal_2 = tds.find(".bet_goal_2")
    var bet_coin = tds.find(".bet_coin")
    var bet_id = $(this).data('bet-id')
    var html = "<span class='bet_goal_1' data-goal-1='" + bet_goal_1.data("goal1")
    html += "'>" + bet_goal_1.data("goal1") + "</span>"
    bet_goal_1.replaceWith(html)
    html = "<span class='bet_goal_2' data-goal-2='" + bet_goal_2.data("goal2")
    html += "'>" + bet_goal_2.data("goal2") + "</span>"
    bet_goal_2.replaceWith(html)
    html = "<span class='bet_coin' data-coin='" + bet_coin.data("coin") + "'>" + bet_coin.data("coin") + "</span>"
    bet_coin.replaceWith(html)
    var html_button = '<span class="edit_bet btn-success" data-bet-id="' + bet_id + '"'
    html_button += 'data-coin-user="' + $(this).data('coin-user') + '">'
    html_button += '<i class="fa fa-pencil" aria-hidden="true"></i></span> '
    html_button += ' <span class="delete_bet btn-danger" data-bet-id="' + bet_id
    html_button += '"><i class="fa fa-trash" aria-hidden="true"></i></span>'
    parent.html(html_button)
  })

  $(".show-list-bet").on("click", ".bet-save-edit", function() {
    var parent = $(this).parent()
    var tds = parent.siblings('td')
    var data = {}
    data.team1_goal = parseInt(tds.find(".bet_goal_1").val())
    data.team2_goal = parseInt(tds.find(".bet_goal_2").val())
    data.coin = parseInt(tds.find(".bet_coin").val())
    var old_coin = parseInt(tds.find(".bet_coin").data("coin"))
    var bet_id = parseInt($(this).data("bet-id"))
    var coin_user = $(this).data('coin-user')
    if (validate(data.team1_goal, data.team2_goal, data.coin, coin_user + old_coin)) {
      $.ajax({
        type: "PATCH",
        url: "/bets/" + bet_id,
        data: data,
        success: function (response){
          if (response.status) {
            var html = "<span class='bet_goal_1' data-goal-1='" + data.team1_goal + "'>" + data.team1_goal + "</span>"
            tds.find(".bet_goal_1").replaceWith(html)
            html = "<span class='bet_goal_2' data-goal-2='" + data.team2_goal + "'>" + data.team2_goal + "</span>"
            tds.find(".bet_goal_2").replaceWith(html)
            html = "<span class='bet_coin' data-coin='" + data.coin + "'>" + data.coin + "</span>"
            tds.find(".bet_coin").replaceWith(html)
            var html_button = '<span class="edit_bet btn-success" data-bet-id="' + bet_id + '"'
            html_button += 'data-coin-user="' + coin_user + '">'
            html_button += '<i class="fa fa-pencil" aria-hidden="true"></i></span> '
            html_button += ' <span class="delete_bet btn-danger" data-bet-id="' + bet_id
            html_button += '"><i class="fa fa-trash" aria-hidden="true"></i></span>'
            parent.html(html_button)
          }
          alert(response.message)
        }
      })
    }
  })

  $(".show-list-bet").on("click", ".delete_bet", function() {
    var bet_id = $(this).data("bet-id")
    var parent = $(this).parents("tr")
    $.ajax({
      type: "DELETE",
      url: "/bets/" + bet_id,
      success: function(response) {
        if (response.status) {
          parent.remove()
        }

        alert(response.message)
      }
    })
  })
})

function validate(team1_goal, team2_goal, coin, current_coin) {
  if (Number.isInteger(team1_goal) && Number.isInteger(team2_goal) && Number.isInteger(coin)) {
    if (team1_goal >= 0 && team2_goal >= 0 && coin >= 1) {
      if (current_coin >= coin) {
        return true
      } else {
        alert(I18n.t("leagues.match.coin"))
        return false
      }
    } else {
      alert(I18n.t("leagues.match.validate_value"))
      return false
    }
  } else {
    alert(I18n.t("leagues.match.integer"))
    return false
  }
}
