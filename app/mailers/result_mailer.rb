class ResultMailer < ApplicationMailer

  def send_result(user, result, actual_cost, date, remain)
    @result = result
    @actual_cost = actual_cost
    @remain = remain
    @date = date
    mail to: user.email, subject: "診断結果"
  end

end
