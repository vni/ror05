require_relative 'Team'

# 1
# Учитывая, что у нас есть классы из предыдущего задания
# (Developer, JuniorDeveloper и SeniorDeveloper),
# нужно написать класс Team (команда разработчиков),
# который бы работал так:

team = Team.new do
  have_seniors "Олег", "Оксана"
  have_developers "Олеся", "Василий", "Игорь-Богдан"
  have_juniors "Владислав", "Аркадий", "Рамеш"

  priority :juniors, :developers, :seniors

  on_task :junior do |dev, task|
    puts "Отдали задачу #{task} разработчику #{dev.name}, следите за ним!"
  end

  on_task :senior do |dev, task|
    puts "#{dev.name} сделает #{task}, но просит больше с такими глупости не приставать"
  end
end

# add task to all juniors
team.add_task "Погладить шнурки"
team.add_task "Погладить шнурки 2"
team.add_task "Погладить шнурки 3"

# add task to developers
team.add_task "Вымыть посуду 1"
team.add_task "Вымыть посуду 2"
team.add_task "Вымыть посуду 3"

# and to seniors
team.add_task "Наварить борща 1"
team.add_task "Наварить борща 2"

# yet again to juniors
team.add_task "hack the kernel"


# 4
puts "\nteam.seniors:"
puts team.seniors

puts "\nteam.developers:"
puts team.developers

puts "\nteam.juniors:"
puts team.juniors

# 5
puts "\nteam.all:"
puts team.all

# 6
puts "\nteam.report:"
team.report

puts "\nPRIORITY:"
puts team.print_priority
pp team.print_priority

puts "\nTASK_TRIGGERS:"
team.print_task_triggers

# 7
#team.add_task "Помыть окна", complexity: senior

#team.add_task "Налить чаю", to: "Василий"
