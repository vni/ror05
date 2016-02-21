require_relative "./developer.rb"

def ppp msg #my pretty print
  puts "\n*** " + msg
end

# Extend Developer class for test purposes.
class Developer
  def test
    ppp "Создаем Developer:"
    #dev = Developer.new "Вася" # Already created
    p self

    ppp "Добавляем новую задачу:"
    add_task "Полить кактус"

    ppp "Нумерованный список задач в порядке их добавления:"
    puts tasks

    ppp "Пытаемся выполнить первую задачу:"
    work!

    ppp "Список задач (должен быть пустым):"
    puts tasks

    begin
      ppp "Пытаемся выполнить первую задачу. Ожидаем исключение, так как задач для выполнения нету."
      work!
    rescue Exception => msg
      ppp "Мы получили исключение после dev.work! с пустым списком задач: \"#{msg}\"! Отлично!."
    end

    begin
      ppp "Пытаемся загрузить разработчика работой сверх MAX_TASKS. Ожидаем выброс исключения."
      11.times.each do  |i|
        case i % 3
          when 0 then add_task "Сделай то #{i}"
          when 1 then add_task "Сделай сё #{i}"
          when 2 then add_task "Поди туда, незнаю куда #{i}"
        end
      end
    rescue Exception => msg
      ppp "Мы получили исключение после попытки накидать лишних задач разработчику: \"#{msg}\"! Отлично!."
    end

    begin
      ppp "Проверка метода status:"
      @task_list = [] # erase task_list
      11.times.each do |i|
        puts "#{i}> #{status} @task_list.size: #{@task_list.size}"
        add_task "Сделай #{i}"
      end
    rescue Exception => msg
      ppp "Получили исключение после попытки лишний раз нагрузить разработчика лишней работой. Всё ок."
    end

    begin
      @task_list = [] # erase task_list
      ppp "*** STARTING WITH AN EMPTY task_list"
      ppp "*** can_add_task? and can_work? test:"
      11.times.each do |i|
        puts "|#{i}| can_add_task? #{can_add_task?}. can_work? #{can_work?}"
        add_task "task #{i}"
      end
    rescue Exception => msg
      ppp "Exception received. It's ok and expected: '#{msg}'."
    end
  end
end

ppp "TEST Developer ***\n"
dev = Developer.new("Вася")
dev.test

# Extend JuniourDeveloper class for test purposes
class JuniorDeveloper
  def test
    ppp "JuniorDeveloper created:"
    p self
    begin
      ppp "Try to add more then 5 tasks..."
      6.times.each {|i| add_task "junior task #{i}"}
    rescue Exception => msg
      ppp "Catch an exception. As expected. '#{msg}'."
    end

    begin
      ppp "Test to add task w/ more than 20 symbols:"
      @task_list = [] # erase task_list
      add_task "Very long task with more then 20 chars of data"
    rescue Exception => msg
      ppp "Catch an exception. As expected. '#{msg}'."
    end

    ppp "JuniorDeveloper.work!:"
    add_task "Почистить обувь"
    work!
  end
end

ppp "TEST JuniorDeveloper ***\n"
jun = JuniorDeveloper.new("Федя")
jun.test

# Extend SeniorDeveloper class just for test purposes
class SeniorDeveloper
  def test
    ppp "SeniorDeveloper created:"
    p self
    begin
      ppp "Try to add more then 15 tasks..."
      16.times.each {|i| add_task "big senior task #{i}"}
    rescue Exception => msg
      ppp "Catch an exception. As expected. '#{msg}'."
    end

    ppp "SeniorDeveloper.work!:"
    10.times.each {|_| work!; puts}
    #work!
  end
end

ppp "TEST SeniorDeveloper ***\n"
sen = SeniorDeveloper.new("John 5")
sen.test
