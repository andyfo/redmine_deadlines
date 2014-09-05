class Deadline < ActiveRecord::Base
  unloadable

  has_and_belongs_to_many :users

  STATES = %w(expected ok missed early)

  validates_presence_of :title
  validates_presence_of :due_date
  validates_inclusion_of :state, :in => STATES
  validates :users, :length => { :minimum => 1 }

  scope :for_user, lambda { |user| joins(:users).where(["users.id = ?", user.id]) }
  scope :without_expected, where(["state != ?", "expected"])

  def self.statistics_for(people)
    stats = []

    people.each do |person|
      deadlines = for_user(person).without_expected.all
      stat = {
        "id" => person.id,
        "name" => person.name,
        "missed" => 0,
        "ok" => 0,
        "early" => 0
      }
      
      deadlines.each do |deadline|
        stat[deadline.state] += 1
      end

      stats << stat
    end

    stats.sort_by { |i| i["missed"] }.reverse
  end

  def assigned_to?(user)
    users.include?(user)
  end

  def start_date
    nil
  end
end
