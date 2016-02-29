require_relative 'Developer.rb'
require_relative 'JuniorDeveloper.rb'
require_relative 'SeniorDeveloper.rb'

class Team
  def initialize &block
    @developers = []
    @priorities = []
    @task_triggers = {}

    instance_eval &block
  end

  def have_seniors *args
    args.each do |a|
      @developers.push SeniorDeveloper.new a
    end
  end

  def have_developers *args
    args.each do |a|
      @developers.push Developer.new a
    end
  end

  def have_juniors *args
    args.each do |a|
      @developers.push JuniorDeveloper.new a
    end
  end

  def priority *args
    @priorities = args
  end

  def on_task to_whom, &block
    @task_triggers[to_whom] = block
  end

  def add_task tsk
    to_whom = sorted_developers()[0]
    to_whom.add_task tsk
    if @task_triggers[to_whom.on_task_type]
      @task_triggers[to_whom.on_task_type].call(to_whom, tsk)
    end
  end

  def seniors
    @developers.select do |elm|
      elm if elm.class == SeniorDeveloper
    end
  end

  def developers
    @developers.select do |elm|
      elm if elm.class == Developer
    end
  end

  def juniors
    @developers.select do |elm|
      elm if elm.class == JuniorDeveloper
    end
  end

  def all
    @developers
  end

  def report
    sorted_developers().each do |dev|
      puts dev.report
    end
  end

  private

  def sorted_developers
    @developers.sort_by do |dev|
      [dev.task_count, @priorities.index(dev.priority_type)]
    end
  end
end
