def login_user(user)
  allow(request.env["warden"]).to receive(:authenticate!) {user }
  allow(controller).to receive(:current_user) { user }
end

#def wait_for_ajax
#  Timeout.timeout(Capybara.default_max_wait_time) do
#    loop do
#      active = page.evaluate_script('jQuery.active')
#      break if active == 0
#    end
#  end
#end