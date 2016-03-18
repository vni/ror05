class JuniorDeveloper < Developer
  MAX_TASKS = 5

  def add_task(task)
    raise "Слишком сложно!" if task.length > 20
    super
  end

  def work!
    raise "Нечего делать!" if @task_list.empty? #FIXME: Should we raise an exception here?
    puts "#{@name}: пытаюсь делать задачу \"#{@task_list.shift}\". Осталось задач: #{@task_list.size}"
  end

  def priority_type
    :juniors
  end

  def on_task_type
    :junior
  end

  def title
    "junior"
  end
end
