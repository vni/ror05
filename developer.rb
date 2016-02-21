class Developer
	@@MAX_TASKS = 10

	def initialize(name)
		@name = name
		@task_list = []
	end

	def add_task(task)
		puts "Developer.add_task called"
		raise "Слишком много работы! (@task_list.size: #{@task_list.size}, @@MAX_TASKS: #{@@MAX_TASKS}" unless @task_list.size < @@MAX_TASKS
		@task_list << task
		puts "#{@name}: Добавлена задача \"#{task}\". Всего в списке задач: #{@task_list.size}"
	end

	def tasks
		@task_list.each_with_index.map{ |elm, i| (i+1).to_s + ". " + elm + "\n" }
	end

	def work!
		raise "Нечего делать!" if @task_list.empty?
		puts "#{@name}: выполнена задача \"#{@task_list.shift}\". Осталось задач: #{@task_list.size}"
	end

	def status
		case @task_list.size
		when 0 then "свободен"
		when 1..9 then "работаю"
		when @@MAX_TASKS then "занят"
		# FIXME:
		else raise "The sing that should not be!"
		end
	end

	def can_add_task?
		@task_list.size < @@MAX_TASKS
	end

	def can_work?
		!@task_list.empty?
	end
end

dev = Developer.new("Вася")

# Extend our Вася Developer instance. Just for test purposes.
def dev.test
	def ppp msg #my pretty print
		puts "\n*** " + msg
	end

	def task_list_size
		@task_list.size
	end

	def erase_task_list
		@task_list = []
	end

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
		ppp "Пытаемся загрузить разработчика работой сверх @@MAX_TASKS. Ожидаем выброс исключения."
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
		erase_task_list
		11.times.each do |i|
			puts "#{i}> #{status} task_list_size: #{task_list_size}"
			add_task "Сделай #{i}"
		end
	rescue Exception => msg
		ppp "Получили исключение после попытки лишний раз нагрузить разработчика лишней работой. Всё ок."
	end

	begin
		erase_task_list
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

dev.test

class JuniorDeveloper < Developer
	@@MAX_TASKS = 5
	def add_task(task)
		puts "JuniorDeveloper.add_task called"
		raise "Слишком сложно!" if task.length > 20
		super task
	end

	def work!
		raise "Нечего делать!" if @task_list.empty? #FIXME: Should we raise an exception here?
		#FIXME: should the number of tasks be less? Or JuniorDeveloper always do only one task?
		#puts "#{@name}: пытаюсь делать задачу \"#{@task_list.shift}\". Осталось задач: #{@task_list.size}"
		puts "#{@name}: пытаюсь делать задачу \"#{@task_list[0]}\". Осталось задач: #{@task_list.size}"
	end
end

# Extend JuniourDeveloper class for test purposes
class JuniorDeveloper
	#FIXME: make ppp only one in Developer class.
	def ppp msg #my pretty print
		puts "\n*** " + msg
	end

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

jun = JuniorDeveloper.new("Федя")
jun.test

class SeniorDeveloper < Developer
	@@MAX_TASKS = 15

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

# Extend SeniorDeveloper class just for test purposes
class SeniorDeveloper
	#FIXME: make ppp only one in Developer class.
	def ppp msg #my pretty print
		puts "\n*** " + msg
	end

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

sen = SeniorDeveloper.new("John 5")
sen.test


# AN OLD CODE. UNNEEDED. JUST FOR REFERENCE.
=begin
# Explicitly extend Developer class with helper methods which are not relevant to the homework3
class Developer
	def task_list_size
		@task_list.size
	end

	def erase_task_list
		@task_list = []
	end

	def self.test
		def self.ppp msg #my pretty print
			puts "\n*** " + msg
		end

		ppp "Создаем Developer:"
		dev = Developer.new "Вася"
		p dev

		ppp "Добавляем новую задачу:"
		dev.add_task "Полить кактус"

		ppp "Нумерованный список задач в порядке их добавления:"
		puts dev.tasks

		ppp "Пытаемся выполнить первую задачу:"
		dev.work!

		ppp "Список задач (должен быть пустым):"
		puts dev.tasks

		begin
			ppp "Пытаемся выполнить первую задачу. Ожидаем исключение, так как задач для выполнения нету."
			dev.work!
		rescue Exception => msg
			ppp "Мы получили исключение после dev.work! с пустым списком задач: \"#{msg}\"! Отлично!."
		end

		begin
			ppp "Пытаемся загрузить разработчика работой сверх @@MAX_TASKS. Ожидаем выброс исключения."
			11.times.each do  |i|
				case i % 3
					when 0 then dev.add_task "Сделай то #{i}"
					when 1 then dev.add_task "Сделай сё #{i}"
					when 2 then dev.add_task "Поди туда, незнаю куда #{i}"
				end
			end
		rescue Exception => msg
			ppp "Мы получили исключение после попытки накидать лишних задач разработчику: \"#{msg}\"! Отлично!."
		end

		ppp "Проверка метода status:"
		dev.erase_task_list
		10.times.each do |i|
			puts "#{i}> #{dev.status} dev.@task_list.size: #{dev.task_list_size}"
			dev.add_task "Сделай #{i}"
		end
	end
end
=end
