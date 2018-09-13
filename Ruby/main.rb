# CENSORED
# COMP3220 - 002 : Programming Languages
# Project_1

require_relative 'search_controller.rb' 


# Initialize default list ...
defaultSearchList = ["toy story", 
						"spider man", 
						"star wars", 
						"harry potter", 
						"the hobbit", 
						"the hangover"]

# Let first search_controller get default list
controllerObject = SearchController.new(defaultSearchList)

##### 
#
# 1.create endless loop 
# 2.get an input from terminal(console)
# 3.update search suggestion list
# 4.loop should end when user write "exit"
# 5.save updated "searchSuggestionList" to "data.txt" file
#
#####
#<TODO: write your code here>
while 2 > 1
  puts ""
  puts "search_list: #{controllerObject.showList()}"
  puts ""
  print "New lookup:"
  newInput = gets.chomp
  

  if (newInput != "exit")
    controllerObject.updateList(newInput.downcase.gsub /[^\x20-\x7F\x0D\x0A]/, '')
    next
  else
    controllerObject.saveListToFile()
    return
  end
end
