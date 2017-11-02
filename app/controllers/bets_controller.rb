class BetsController < ApplicationController
  before_action :check_data, only: [:create]
  before_action :check_update, only: [:update]
  before_action :check_destroy, only: [:destroy]
  def create
    new_bet = @match.bets.create!(user_id: current_user.id,
      team1_goal: params[:team1_goal],
      team2_goal: params[:team2_goal],
      coin: params[:coin])
    new_coin = current_user.coin - params[:coin].to_i
    current_user.update!(coin: new_coin)
    respond_to do |format|
      msg = {status: true, message: t("controller.bets.create_success"), bet: new_bet}
      format.json{render json: msg}
    end
  rescue
    respond_to do |format|
      msg = {status: false, message: t("controller.bets.create_fail")}
      format.json{render json: msg}
    end
  end

  def update
    new_coin = current_user.coin + @bet.coin - params[:coin].to_i
    @bet.update_attributes(team1_goal: params[:team1_goal], team2_goal: params[:team2_goal], coin: params[:coin])
    new_coin -= params[:coin].to_i
    current_user.update(coin: new_coin)
    respond_to do |format|
      msg = {status: true, message: t("controller.bets.update_success")}
      format.json{render json: msg}
    end
  rescue
    respond_to do |format|
      msg = {status: false, message: t("controller.bets.update_fail")}
      format.json{render json: msg}
    end
  end

  def destroy
    new_coin = current_user.coin + @bet.coin
    if @bet.destroy
      current_user.update!(coin: new_coin)
      respond_to do |format|
        msg = {status: true, message: t("controller.bets.delete_success")}
        format.json{render json: msg}
      end
    else
      respond_to do |format|
        msg = {status: false, message: t("controller.bets.delete_fail")}
        format.json{render json: msg}
      end
    end
  end

  private
  def check_data
    @match = Match.find_by_id params[:match_id]
    unless @match && valid_bet?(@match) && current_user.coin >= params[:coin].to_i
      respond_to do |format|
        msg = {status: false, message: t("controller.bets.create_fail")}
        format.json{render json: msg}
      end
    end
  end

  def check_update
    @bet = Bet.find_by_id params[:id]
    coin_user = current_user.coin + @bet.coin
    unless @bet && valid_bet?(@bet.match) && coin_user >= params[:coin].to_i && @bet.user_id == current_user.id
      respond_to do |format|
        msg = {status: false, message: t("controller.bets.canot_update")}
        format.json{render json: msg}
      end
    end
  end

  def check_destroy
    @bet = Bet.find_by_id params[:id]
    time_valid = @bet.match.start_time + Settings.valid_bet.minutes
    unless @bet && time_valid.future? && logged_in?
      respond_to do |format|
        msg = {status: false, message: t("controller.bets.canot_delete")}
        format.json{render json: msg}
      end
    end
  end
end
