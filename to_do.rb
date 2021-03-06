require 'active_record'
require './lib/task'

database_configuration = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configuration["development"]
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "Welcome to the to do list"
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "Press 'a' to add a task, 'l' to list your tasks, or 'd' to mark a task as done."
    puts "Press 'e' to exit."
    choice = gets.chomp
    case choice
      when 'a'
        add
      when 'l'
        list
      when 'd'
        mark_done
      when 'e'
        puts 'GOODBYE!'
      else puts "Sorry that is not a valid option"
    end
  end
end

def add
  puts "What do you want to do"
  task_name = gets.chomp
  task = Task.new(:name => task_name, :done => false)
  if task.save
   puts "'#{task.name}' has been added to your to do list"
 else
   puts "That wasn't a valid task"
   task.errors.full_messages.each {|message| puts message}
 end
end

def mark_done
  puts "Which of these would you like to mark as done?"
  Task.all.each { |task| puts task.name }
  done_task_name = gets.chomp
  done_task = Task.where(:name => done_task_name).first
  done_task.update_attributes(:done => true)
end

def list
  puts "Here is everything you need to do:"
  task = Task.not_done
  task.each {|task| puts task.name}
end

welcome
