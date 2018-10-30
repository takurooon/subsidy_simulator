class ResultMailer < ApplicationMailer

  def send_result(user, result, actual_cost, date, remain_subsidy)
    @result = result
    @actual_cost = actual_cost
    @remain_subsidy = remain_subsidy
    @date = date
    mail to: user.email, subject: "診断結果"
  end

end
