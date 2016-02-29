class Developer
  MAX_TASKS = 10

  attr_reader :name

  def initialize(name)
    @name = name
    @task_list = []
  end

  def add_task(task)
    raise "Слишком много работы!" unless @task_list.size < self.class::MAX_TASKS
    @task_list << task
    puts "%s: Добавлена задача \"%s\". Всего в списке задач: %i" %
      [@name, task, @task_list.size]
    #puts "#{@name}: Добавлена задача \"#{task}\". Всего в списке задач: #{@task_list.size}"
  end

  def task_count
    @task_list.count
  end

  def tasks
    @task_list.each_with_index.map{ |elm, i| (i+1).to_s + ". " + elm + "\n" }
  end

  def work!
    raise "Нечего делать!" if @task_list.empty?
    puts "#{@name}: выполнена задача \"#{@task_list.shift}\". Осталось задач: #{@task_list.size}"
  end

  def status
    #FIXME: try to use can_add_task? and can_work? here
    case @task_list.size
    when !can_work? then "свободен"
    when !can_add_task? then "занят"
    else "работаю"
    end
  end

  def can_add_task?
    @task_list.size < self.class::MAX_TASKS
  end

  def can_work?
    !@task_list.empty?
  end

  def priority_type
    :developers
  end

  def on_task_type
    :developer
  end

  def report
    str = "#{@name} (#{title}): "
    @task_list.each do |tsk|
      str += tsk + ", "
    end
    str.chomp!(", ")
    str
  end

  def title
    "developer"
  end
end
