Redmine::Plugin.register :redmine_deadlines do
  name 'Redmine Deadlines'
  author 'Ondrej Zabojnik'
  description 'Track deadlines.'
  version '0.0.1'
  url 'https://github.com/zabojnik/redmine_deadlines'
  menu :top_menu, :redmine_deadlines, { :controller => 'deadlines', :action => 'index' }, :caption => 'Deadlines', :after => :home
end
