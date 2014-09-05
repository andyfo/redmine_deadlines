Redmine::Plugin.register :deadlines do
  name 'Deadlines'
  author 'Ondrej Zabojnik'
  description 'Track deadlines.'
  version '0.0.1'
  url 'https://github.com/zabojnik/redmine-deadlines'
  menu :top_menu, :deadlines, { :controller => 'deadlines', :action => 'index' }, :caption => 'Deadlines', :after => :home
end
