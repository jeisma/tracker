module ApplicationHelper
  def logo
    image_tag('logo.png', :alt => 'Time Off Tracker', :class => "round")
  end
end
