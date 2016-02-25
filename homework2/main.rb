ARGV0 = "main.rb"

# ARGV validation
if ARGV.length != 4 then
	puts "Usage: #{ARGV0} x_point y_point x y"
	exit 1
end
x_point, y_point, x, y = ARGV

if x_point == x and y_point == y then
	puts "Точка найдена!"
elsif x_point == x then
	puts "х координата верна, y нет"
elsif y_point == y then
	puts "y координата верна, x нет"
else
	puts "Близко, но нет"
end
