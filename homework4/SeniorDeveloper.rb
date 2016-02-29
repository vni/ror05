class SeniorDeveloper < Developer
  MAX_TASKS = 15

  def work!
    if rand(3).zero?
      puts "Что-то лень"
      return
    end

    [2, @task_list.count].min.times do |_|
      puts "#{@name}: выполнена задача \"#{@task_list.at(rand(@task_list.size))}\". Осталось задач: #{@task_list.size}"
    end
  end

  def priority_type
    :seniors
  end

  def on_task_type
    :senior
  end

  def title
    "senior"
  end
end
