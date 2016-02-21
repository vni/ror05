#FIXME: break long lines into smaller one
#FIXME: make tabstop only 2 spaces (NOT tabs!)
class Developer
	@@MAX_TASKS = 10

	def initialize(name)
		@name = name
		@task_list = []
	end

	def add_task(task)
		raise "Слишком много работы!" unless @task_list.size < @@MAX_TASKS
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
		#FIXME: try to use can_add_task? and can_work? here
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

class JuniorDeveloper < Developer
	@@MAX_TASKS = 5
	def add_task(task)
		raise "Слишком сложно!" if task.length > 20
		super task
	end

	def work!
		raise "Нечего делать!" if @task_list.empty? #FIXME: Should we raise an exception here?
		#FIXME: I hope that junior not only tries, but actually finishes his tasks...
		puts "#{@name}: пытаюсь делать задачу \"#{@task_list.shift}\". Осталось задач: #{@task_list.size}"
		#puts "#{@name}: пытаюсь делать задачу \"#{@task_list[0]}\". Осталось задач: #{@task_list.size}"
	end
end

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
