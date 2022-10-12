# frozen_string_literal: true

module Hix
  module Lib
    module DefaultsSMTP
      SMTP = {
        smtp: { port: 587 }.freeze,
        aws_ses: { port: 587 }.freeze,
        mailgun_api: { port: 587 }.freeze,
        mailgun_smtp: { port: 587, address: "smtp.mailgun.org" }.freeze,
        mandrill: { port: 587, address: "smtp.mandrillapp.com" }.freeze,
        gmail: { port: 587, address: "smtp.gmail.com" }.freeze,
        sendgrid_api: { port: 587, username: "apikey" }.freeze,
        sendgrid_smtp: { port: 465, address: "smtp.sendgrid.net" }.freeze,
      }.freeze
    end
  end
end
