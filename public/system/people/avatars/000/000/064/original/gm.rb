#This is the program to calculate geometric mean of a sequence.

#The sequence will be passed as an array as argument to the function
class Geometric
	#this is the method to return the geometric mean of the sequence
	def mean_calculate(x)
		tmp = 0
		y = Array.new       #This array will be used to store logarithms of the numbers of the sequence
		#this loop is used to find logs of numbers in sequence and sum them up in a variable called tmp
		for i in 0..x.length-1
			y[i] = Math.log(x[i])
			tmp = tmp+y[i]
		end
		#end of i for loop
		#this is to find average of the sum of logs taken.
		avg_log = tmp/x.length
		#This is to convert logs back to original form
		gm = Math.exp(avg_log)
		#Finally display the result !!
		puts "Geometric mean is : #{gm}"
	end
	#end of mean_calculate method
end
#end of class

# x = Array.[](1, 32.95, 32.95, 0.1, 0.1)
x = Array.[](0, 32.95, 0.3, 0.1, 0)

Geometric.new.mean_calculate(x)




# TASK
# 1. To get around zero and negative values in GM calculation: Substitute 0 with 1 and
# 2. Negative values with positive values (multiply with -1)
