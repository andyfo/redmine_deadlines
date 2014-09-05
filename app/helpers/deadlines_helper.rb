module DeadlinesHelper

  def users_checkboxes(object, users, checked=nil)
    users.map do |user|
      c = checked.nil? ? object.assigned_to?(user) : checked
      tag = check_box_tag 'deadline[user_ids][]', user.id, c, :id => nil
      content_tag 'label', "#{tag} #{h(user)}".html_safe,
                  :id => "deadline_user_ids_#{user.id}"
    end.join.html_safe
  end

  def assignees(deadline)
    deadline.users.map(&:lastname).join("+")
  end

  def short_title(deadline)
    if deadline.title
      deadline.title.truncate(20)
    else
      ""
    end
  end

  def possible_states
    Deadline::STATES
  end

end
