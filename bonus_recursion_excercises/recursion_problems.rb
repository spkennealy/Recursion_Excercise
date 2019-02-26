# ------------------------ Problem 1 ------------------------

# You have array of integers. Write a recursive solution to find the sum of 
# the integers.

def sum_recur(array)
    return 0 if array.length <= 0
    array[0] + sum_recur(array[1..-1])
end

# p sum_recur([2, 4, 6]) # ==> 12
# p sum_recur([6, 4, 6, 5, 9]) # ==> 30
# p sum_recur([1, 2, 3, 4, 5, 6, 7, 8, 9]) # ==> 45

# ------------------------ Problem 2 ------------------------ 

# You have array of integers. Write a recursive solution to determine 
# whether or not the array contains a specific value.

def includes?(array, target)
    return false if array.length <= 0
    return true if array[0] == target
    includes?(array[1..-1], target)
end

# p includes?([19, 20, 3, 4, 6], 3) # ==> true
# p includes?([4, 6, 1, 2, 6, 7, 3], 2) # ==> true
# p includes?([2, 4, 6], 1) # ==> false

# ------------------------ Problem 3 ------------------------

# You have an unsorted array of integers. Write a recursive solution to 
# count the number of occurrences of a specific value.

def num_occur(array, target)
    return 0 if array.length <= 0
    count = 0
    if array[0] == target
        count += 1
        count += num_occur(array[1..-1], target)
    else 
        count += num_occur(array[1..-1], target)
    end 
    count
end

# p num_occur([19, 20], 20) # ==> 1
# p num_occur([19, 20, 3, 4, 6], 3) # ==> 1
# p num_occur([3, 3, 4, 5, 3], 3) # ==> 3
# p num_occur([0, 2, 4, 5, 6, 5, 5, 5, 5], 5) # ==> 5

# ------------------------ Problem 4 ------------------------

# You have array of integers. Write a recursive solution to determine whether 
# or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
    return false if array.length <= 1
    return true if array[0] + array[1] == 12
    add_to_twelve?(array[1..-1])
end

# p add_to_twelve?([3, 9, 10]) # ==> true
# p add_to_twelve?([1, 3, 4, 5, 9]) # ==> false
# p add_to_twelve?([10, 1, 11, 4]) # ==> true
# p add_to_twelve?([3, 8, 9, 35, 20]) # ==> false

# ------------------------ Problem 5 ------------------------

# You have array of integers. Write a recursive solution to determine if 
# the array is sorted.

def sorted?(array)
    return true if array.length <= 1
    return false if array[0] > array[1]
    sorted?(array[1..-1])
end

# p sorted?([1, 4, 3, 7, 8]) # ==> false
# p sorted?([4, 5, 6, 1, 2]) # ==> false
# p sorted?([1, 3, 6, 8, 9]) # ==> true
# p sorted?([1, 2, 4, 6, 10]) # ==> true

# ------------------------ Problem 6 ------------------------

# Write a recursive function to reverse a string. Don't use any built-in 
# #reverse methods!

def reverse(string)
    reversed = ""
    return string if string.length <= 1
    reversed += string[-1] + reverse(string[0..-2])
    reversed
end

p reverse("Kennealy") # ==> "ylaenneK"
p reverse("Sean") # ==> "naeS"
p reverse("Kierstyn") # ==> "nytsreiK"
