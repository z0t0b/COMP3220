# Dr. Li, TA: Jay Patel(jsp0053@auburn.edu)
# COMP3220 - 002 : Programming Languages
# Project_1

# Search controller class
class SearchController

	attr_accessor :searchSuggestionList

	def initialize(search_list = [])
		#<TODO: write your code here>
    @searchSuggestionList = search_list
  end

	def showList()
		#<TODO: write your code here>
    @searchSuggestionList
	end

	def updateList(movie_name)
		#<TODO: write your code here>
    if searchSuggestionList.include? movie_name
      searchSuggestionList.delete(movie_name)
      searchSuggestionList.unshift(movie_name)
    else
      searchSuggestionList.unshift(movie_name)
    end
	end

	def saveListToFile()
		##### 
		#
		# 1.save updated search suggestion list to "data.txt" file 
		#
		#####
		#<TODO: write your code here>
    File.write("data.txt", searchSuggestionList)
    return
	end

end


