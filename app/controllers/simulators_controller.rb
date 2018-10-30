class SimulatorsController < ApplicationController
  before_action :authenticate_user!, except: [:home, :description]

  def home; end

  def description; end

  def calc; end

  def under40; end

  def under43; end

  def result_under40
    max_treat = 6
    used_count = params[:used_count].to_i
    collecting_eggs = params[:collecting_eggs].to_i
    porting_eggs = params[:porting_eggs].to_i
    pay = params[:pay].to_i
    total = collecting_eggs + porting_eggs

    if used_count >= max_treat || total == 0
      render "simulators/result_nomatch"
      return
    end

    @result, @actual_cost, @remain_subsidy, @pay, @result_pay = calc_result(used_count, collecting_eggs, porting_eggs, pay, max_treat, total)

    if @pay <= 0
      redirect_to simulators_under40_path, alert: "支払った医療費が無い場合は助成対象にはなりません。またマイナスの入力は出来ません。"
      return
    end

    @date = Date.today.financial_year
    save_session(@result, @actual_cost, @remain_subsidy, @date)
    gon.data = [@result, @actual_cost]
    render "simulators/result"
  end

  def result_under43
    max_treat = 3
    used_count = params[:used_count].to_i
    collecting_eggs = params[:collecting_eggs].to_i
    porting_eggs = params[:porting_eggs].to_i
    pay = params[:pay].to_i
    total = collecting_eggs + porting_eggs

    if used_count >= max_treat || total == 0
      render "simulators/result_nomatch"
      return
    end

    @result, @actual_cost, @remain_subsidy, @pay, @result_pay = calc_result(used_count, collecting_eggs, porting_eggs, pay, max_treat, total)

    if @pay <= 0
      redirect_to simulators_under43_path, alert: "支払った医療費が無い場合は助成対象にはなりません。またマイナスの入力は出来ません。"
      return
    end

    @date = Date.today.financial_year
    save_session(@result, @actual_cost, @remain_subsidy, @date)
    gon.data = [@result, @actual_cost]
    render "simulators/result"
  end

  def result_nomatch
    render "simulators/result_nomatch"
  end

  def send_mail
    ResultMailer.send_result(current_user, session[:result],  session[:actual_cost], session[:date], session[:remain]).deliver
    render "simulators/send_mail"
  end

  private

  def calc_result(used_count, collecting_eggs, porting_eggs, pay, max_treat, total)
    result = total * 75_000
    result += 150_000 if used_count == 0 && total != 0
    actual_cost = pay - result
    remain_subsidy = max_treat - 1
    return result, actual_cost, remain_subsidy, pay
  end

  def save_session(result, actual_cost, remain_subsidy, date)
    session[:result] = result
    session[:actual_cost] = actual_cost
    session[:remain_subsidy] = remain_subsidy
    session[:date] = date
  end
end
