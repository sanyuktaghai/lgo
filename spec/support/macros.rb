require 'date'

def login_user(user)
  allow(request.env["warden"]).to receive(:authenticate!) {user }
  allow(controller).to receive(:current_user) { user }
end

def select_by_id(option, options = {})
  field = options[:from]
  page.select option, :from => field
end

def select_date(date, options = {})
  field = options[:from]
  select_by_id date.year.to_s, :from => "#{field}_1i"
  select_by_id Date::MONTHNAMES[date.month], :from => "#{field}_2i"
  select date.day.to_s, :from => "#{field}_3i"  
end

def fill_in_trix_editor(id, value)
#  find(:xpath, "//*[@id='#{id}'][last()]", visible: false).set(value)
  find(:xpath, "//*[@id='#{id}']", visible: false).set(value)
end