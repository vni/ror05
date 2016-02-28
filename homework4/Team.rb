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

  def print_priority
    @priorities
  end

  def on_task to_whom, &block
    @task_triggers[to_whom] = block
  end

  # FIXME: remove it
  def print_task_triggers
    pp @task_triggers
  end

  def add_task tsk
    # FIXME: somewhat complicated logic here. Simplify it.
    sorted = @developers.sort_by(&:task_count)
    first = sorted[0]
    slice = sorted.take_while{|elm| elm.task_count == first.task_count}

    found = nil
    @priorities.each do |prio|
      case prio
      when :juniors; found = slice.select{|elm| elm.class == JuniorDeveloper}
      when :developers; found = slice.select{|elm| elm.class == Developer}
      when :seniors; found = slice.select{|elm| elm.class == SeniorDeveloper}
      end

      break unless found.empty?
    end

    to_whom = found[0]

    to_whom.add_task tsk
    case to_whom.class.to_s
    when "JuniorDeveloper"
      if @task_triggers[:junior]
        @task_triggers[:junior].call(to_whom, tsk)
      end
    when "Developer"
      if @task_triggers[:developer]
        @task_triggers[:developer].call(to_whom, tsk)
      end
    when "SeniorDeveloper"
      if @task_triggers[:senior]
        @task_triggers[:senior].call(to_whom, tsk)
      end
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
    # FIXME: FINISH IT
  end
end
