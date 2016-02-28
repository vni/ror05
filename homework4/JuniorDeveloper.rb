class JuniorDeveloper < Developer
  MAX_TASKS = 5
  def add_task(task)
    raise "Слишком сложно!" if task.length > 20
    super
  end

  def work!
    raise "Нечего делать!" if @task_list.empty? #FIXME: Should we raise an exception here?
    #FIXME: I hope that junior not only tries, but actually finishes his tasks...
    #FIXME: (I mean finished task should be removed from task_list)
    puts "#{@name}: пытаюсь делать задачу \"#{@task_list.shift}\". Осталось задач: #{@task_list.size}"
    #puts "#{@name}: пытаюсь делать задачу \"#{@task_list[0]}\". Осталось задач: #{@task_list.size}"
  end
end
