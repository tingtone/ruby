ActionMailer::Base.smtp_settings = {
  :address              => "smtp.exmail.qq.com",
  :port                 => 25,
  :domain               => "exmail.qq.com",
  :user_name            => "nonreply@kittypad.com",
  :password             => "kittypad",
  #:authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
#Mail.register_interceptors(DevelopmentMailInterceptor) if Rails.env.development?

