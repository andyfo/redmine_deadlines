class DeadlinesController < ApplicationController
  unloadable

  helper :calendars

  before_filter :find_users, :except => [:destroy]

  def index
    if params[:year] and params[:year].to_i > 1900
      @year = params[:year].to_i
      if params[:month] and params[:month].to_i > 0 and params[:month].to_i < 13
        @month = params[:month].to_i
      end
    end

    @year ||= Date.today.year
    @month ||= Date.today.month

    @calendar = Redmine::Helpers::Calendar.new(Date.civil(@year, @month, 1), current_language, :month)

    events = []
    events += Deadline.where(["due_date BETWEEN ? AND ?", @calendar.startdt, @calendar.enddt])
    @calendar.events = events

    @statistics = Deadline.statistics_for(@users)
  end

  def new
    @deadline = Deadline.new
  end

  def create
    @deadline = Deadline.new(params[:deadline])

    respond_to do |format|
      if @deadline.save
        format.html { redirect_to deadlines_url }
      else
        format.html { render :action => :new }
      end
    end
  end

  def edit
    @deadline = Deadline.find(params[:id])
  end

  def update
    @deadline = Deadline.find(params[:id])

    respond_to do |format|
      if @deadline.update_attributes(params[:deadline])
        format.html { redirect_to deadlines_url }
      else
        format.html { render :action => :edit }
      end
    end
  end

  def destroy
    @deadline = Deadline.find(params[:id])
    @deadline.destroy

    respond_to do |format|
      format.html { redirect_to deadlines_url }
    end
  end

  private

  def find_users
    @users = Person.logged.status(1).where(:type => 'User').order("lastname").all
  end
end
