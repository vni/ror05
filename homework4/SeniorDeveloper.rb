class SeniorDeveloper < Developer
  MAX_TASKS = 15

  def work!
    #FIXME: кто определяет случайную вероятность?
    if rand(3).zero?
      puts "Что-то лень"
    end

    #raise "Нечего делать!" if @task_list.empty?
    if !@task_list.empty?
      puts "#{@name}: выполнена задача \"#{@task_list.delete_at(rand(@task_list.size))}\". Осталось задач: #{@task_list.size}"
    end

    if !@task_list.empty?
      puts "#{@name}: выполнена задача \"#{@task_list.delete_at(rand(@task_list.size))}\". Осталось задач: #{@task_list.size}"
    end
  end
end
