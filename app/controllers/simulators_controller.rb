class SimulatorsController < ApplicationController
  before_action :authenticate_user!, only: [:index]


  def index
  end

  def under40
  end

  def result_under40
    used_count = params[:used_count].to_i
    collecting_eggs = params[:collecting_eggs].to_i
    porting_eggs = params[:porting_eggs].to_i
    pay = params[:pay].to_i
    @pay = pay
    total = collecting_eggs + porting_eggs
    upper_limit = 6
    unit_price = 75_000
    special_price = 150_000
    subsidy = total * unit_price
    limit = upper_limit - used_count
    @remain = limit - 1
    @actual_cost = pay - subsidy

    if @remain < 0
      @remain = 0
    end

    if used_count >= upper_limit
      render "simulators/result_nomatch"
    elsif used_count < upper_limit && used_count == 0 && total != 0
      @result = subsidy + special_price
      @actual_cost = pay - subsidy - special_price
      session[:result] = @result
      session[:actual_cost] = @actual_cost
      session[:remain] = @remain
      render "simulators/result"
    else
      @result = subsidy
      session[:result] = @result
      session[:actual_cost] = @actual_cost
      session[:remain] = @remain
      render "simulators/result"
    end
  end

  def under43
  end

  def result_under43
    used_count = params[:used_count].to_i
    collecting_eggs = params[:collecting_eggs].to_i
    porting_eggs = params[:porting_eggs].to_i
    pay = params[:pay].to_i
    @pay = pay
    total = collecting_eggs + porting_eggs
    upper_limit = 3
    unit_price = 75_000
    special_price = 150_000
    subsidy = total * unit_price
    limit = upper_limit - used_count
    @remain = limit - 1
    @actual_cost = pay - subsidy
    @articles = {"April 2018" => 1, "May 2018" => 5}

    if @remain < 0
      @remain = 0
    end

    if used_count >= upper_limit
      render "simulators/result_nomatch"
    elsif used_count < upper_limit && used_count == 0 && total != 0
      @result = subsidy + special_price
      @actual_cost = pay - subsidy - special_price
      session[:result] = @result
      session[:actual_cost] = @actual_cost
      session[:remain] = @remain
      render "simulators/result"
    else
      @result = subsidy
      session[:result] = @result
      session[:actual_cost] = @actual_cost
      session[:remain] = @remain
      render "simulators/result"
    end
  end

  def send_mail
    ResultMailer.send_result(current_user,session[:result],session[:actual_cost],session[:remain]).deliver
    render "simulators/send_mail"
  end

end
