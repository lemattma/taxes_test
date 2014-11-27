require_relative "lib/app.rb"
app = App.new
input = ''

while i = STDIN.gets
  input += i
end

puts "\nInput:"
puts input

puts "\nOutput:"
puts app.process input
