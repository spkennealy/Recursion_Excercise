require 'byebug'

# ------------------------ Warmup ------------------------

# Write a recursive method, range, that takes a start and an end and returns 
# an array of all numbers in that range, exclusive. For example, range(1, 5) 
# should return [1, 2, 3, 4]. If end < start, you can return an empty array.

def range(start, last)
    return [] if start > last
    return [start] if start == last - 1
    [start] + range(start+1, last)
end 

# p range(1, 5) # ==> [1, 2, 3, 4]
# p range(2, 10) # ==> [2, 3, 4, 5, 6, 7, 8, 9]
# p range(4, 2) # ==> []

# Write both a recursive and iterative version of sum of an array.

def sum_recursive(array)
    array.inject(&:+)
end 

# p sum_recursive([3, 4, 7]) # ==> 14
# p sum_recursive([1, 2, 3]) # ==> 6
# p sum_recursive([10, 205, 33]) # ==> 248

def sum_iterative(array)
    return 0 if array.length < 1
    array[0] + sum_iterative(array[1..-1])
end 

# p sum_iterative([3, 4, 7]) # ==> 14
# p sum_iterative([1, 2, 3]) # ==> 6
# p sum_iterative([10, 205, 33]) # ==> 248


# ------------------------ Exponentiation ------------------------

# Write two versions of exponent that use two different recursions:

# recursion 1
# exp(b, 0) = 1
# exp(b, n) = b * exp(b, n - 1)

def exponentiation_1(base, power)
    return 1 if power <= 0
    base * exponentiation_1(base, power - 1)
end 

# p exponentiation_1(1, 0) # ==> 1
# p exponentiation_1(2, 1) # ==> 2
# p exponentiation_1(3, 3) # ==> 27
# p exponentiation_1(5, 7) # ==> 78125

# recursion 2
# exp(b, 0) = 1
# exp(b, 1) = b
# exp(b, n) = exp(b, n / 2) ** 2             [for even n]
# exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]

def exponentiation_2(base, power)
    return 1 if power <= 0
    if power.even?
        half_power = exponentiation_2(base, power / 2)
        half_power * half_power
    else
        minus_one_power = exponentiation_2(base, (power - 1) / 2)
        base * (minus_one_power * minus_one_power)
    end 
end 

# p exponentiation_2(1, 0) # ==> 1
# p exponentiation_2(2, 1) # ==> 2
# p exponentiation_2(3, 3) # ==> 27
# p exponentiation_2(5, 7) # ==> 78125


# ------------------------ Deep dup ------------------------

# Using recursion and the is_a? method, write an Array#deep_dup method 
# that will perform a "deep" duplication of the interior arrays.

# It's okay to iterate over array elements using the normal each for this one.
# You should be able to handle "mixed" arrays. For instance: [1, [2], [3, [4]]].

class Array
    def deep_dup
        copy = []
        self.each do |object|
            if object.is_a?(Array)
                copy << object.deep_dup
            else
                copy << object
            end 
        end 
        copy
    end 
end 

# TEST CASES
# array = [1, [2], [3, [4]]]
# dup_1 = array.deep_dup
# dup_1[1] << 1
# p dup_1[1] # ==> [2, 1]
# p array[1] # ==> [2]

# # ---- 
# robot_parts = [
#   ["nuts", "bolts", "washers"],
#   ["capacitors", "resistors", "inductors"]
# ]

# robot_parts_copy = robot_parts.deep_dup
# robot_parts_copy[1] << "LEDs"
# p robot_parts_copy[1] # ==> ["capacitors", "resistors", "inductors", "LEDs"]
# p robot_parts[1] # ==> ["capacitors", "resistors", "inductors"]


# ------------------------ Fibonacci ------------------------

# Write a recursive and an iterative Fibonacci method. The method should take 
# in an integer n and return the first n Fibonacci numbers in an array.

# You shouldn't have to pass any arrays between methods; you should be able 
# to do this just passing a single argument for the number of Fibonacci 
# numbers requested.

def recursive_fibonacci(n)
    return [0] if n == 1
    return [0, 1] if n == 2
    fibonicci_result = recursive_fibonacci(n - 1)
    fibonicci_result << fibonicci_result[-1] + fibonicci_result[-2]
end 

# p recursive_fibonacci(3) # ==> [0, 1, 1]
# p recursive_fibonacci(4) # ==> [0, 1, 1, 2]
# p recursive_fibonacci(5) # ==> [0, 1, 1, 2, 3]
# p recursive_fibonacci(6) # ==> [0, 1, 1, 2, 3, 5]

def iterative_fibonacci(n)
    fibonicci_result = [0, 1]

    i = 1
    while fibonicci_result.length < n
        fibonicci_result << fibonicci_result[i-1] + fibonicci_result[i]
        i += 1
    end 

    fibonicci_result
end 

# p iterative_fibonacci(3) # ==> [0, 1, 1]
# p iterative_fibonacci(4) # ==> [0, 1, 1, 2]
# p iterative_fibonacci(5) # ==> [0, 1, 1, 2, 3]
# p iterative_fibonacci(6) # ==> [0, 1, 1, 2, 3, 5]

# ------------------------ Binary Search ------------------------

# The binary search algorithm begins by comparing the target value to the 
# value of the middle element of the sorted array. If the target value is 
# equal to the middle element's value, then the position is returned and the 
# search is finished. If the target value is less than the middle element's 
# value, then the search continues on the lower half of the array; or if the 
# target value is greater than the middle element's value, then the search 
# continues on the upper half of the array. This process continues, 
# eliminating half of the elements, and comparing the target value to the 
# value of the middle element of the remaining elements - until the target 
# value is either found (and its associated element position is returned), 
# or until the entire array has been searched (and "not found" is returned).

# Write a recursive binary search: bsearch(array, target). Note that binary 
# search only works on sorted arrays. Make sure to return the location of the 
# found object (or nil if not found!). Hint: you will probably want to use 
# subarrays.

def bsearch(array, target)
    mid = array.length / 2
    mid_value = array[mid]
    lower_half = array[0...mid]
    upper_half = array[mid+1...array.length]

    if array.length < 1
        puts "not found"
        return nil  
    elsif mid_value == target
        return array.index(mid_value)
    elsif target < mid_value 
        bsearch(lower_half, target)
    elsif target > mid_value
        upper = bsearch(upper_half, target)
        upper.nil? ? upper : upper + mid + 1
    end 
end 

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil


# ------------------------ Merge Sort ------------------------

# Implement a method merge_sort that sorts an Array:

# The base cases are for arrays of length zero or one. Do not use a 
# length-two array as a base case. This is unnecessary.
# You'll want to write a merge helper method to merge the sorted halves.

def merge_sort(array)
    return array if array.length <= 1
    
    mid = array.length / 2
    left = array[0...mid]
    right = array[mid...array.length]
    
    merge(merge_sort(left), merge_sort(right))
end 

def merge(left, right)
    sorted = []
    until left.length == 0 || right.length == 0
        if left[0] < right[0]
            sorted << left.shift
        else
            sorted << right.shift
        end
    end
    sorted + left + right
end 

# p merge_sort([0, 4, 9, 8, 3, 5, 6])
# p merge_sort([3, 7, 5, 1, 4, 9, 8])
# p merge_sort([6, 1, 4, 9, 8])
# p merge_sort([3, 7, 5, 1, 4, 9, 8, 2, 0])


# ------------------------ Array Subsets ------------------------

# Write a method subsets that will return all subsets of an array.

def subsets(array)
    return [[]] if array.length == 0
    return [[], array] if array.length == 1
    
    array_without_end = subsets(array[0...-1]) 
    array_end = subsets(array[0...-1]).map {|arr| arr << array[-1]}
    array_without_end + array_end
end 

# p subsets([]) # => [[]]
# p subsets([1]) # => [[], [1]]
# p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
# p subsets([1, 2, 3]) # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]


# ------------------------ Permutations ------------------------

# Write a recursive method permutations(array) that calculates all the 
# permutations of the given array. For an array of length n there are n! 
# different permutations. So for an array with three elements we will 
# have 3 * 2 * 1 = 6 different permutations.

def permutations(array)
    return [array] if array.length <= 1
    # debugger
    first = [array[0]]
    perms = permutations(array[1..-1])
    result = []
    for perm in perms
        result << first + perm 
        for i in (1...perm.length)
            result << (perm[0...i] + first + perm[i..-1])
        end
        result << perm + first 
    end 
    result
end 

# p permutations([1, 2, 3]) # => [[1, 2, 3], [1, 3, 2],
#                           #     [2, 1, 3], [2, 3, 1],
#                           #     [3, 1, 2], [3, 2, 1]]

# p [1, 2, 3].permutation.to_a  # => [[1, 2, 3], [1, 3, 2],
#                               #     [2, 1, 3], [2, 3, 1],
#                               #     [3, 1, 2], [3, 2, 1]]


# ------------------------ Make Change ------------------------

# First, write a 'greedy' version called greedy_make_change:

# Take as many of the biggest coin as possible and add them to your result.
# Add to the result by recursively calling your method on the remaining 
# amount, leaving out the biggest coin, until the remainder is zero.

def greedy_make_change(amount, coins=[25, 10, 5, 1])
    return [] if amount <= 0
    sorted_coins = coins.sort!.reverse.select {|coin| coin < amount}

    change = []
    coin_amount = amount / sorted_coins[0]
    coin_amount.times {change << sorted_coins[0]}
    new_amount = amount % (coin_amount * sorted_coins[0])
    sorted_coins.shift
    change << greedy_make_change(new_amount, sorted_coins)
    change.flatten
end 

p greedy_make_change(39)
p greedy_make_change(14, [10, 7, 1])

# To make_better_change, we only take one coin at a time and never rule out 
# denominations that we've already used. This allows each coin to be available 
# each time we get a new remainder. By iterating over the denominations and 
# continuing to search for the best change, we assure that we test for 
# 'non-greedy' uses of each denomination.

# Discuss the following game plan and then work together to implement your new method:

# Iterate over each coin.
# Grab only one of that one coin and recursively call make_better_change on 
# the remainder using coins less than or equal to the current coin.
# Add the the single coin to the change returned by the recursive call. 
# This will be a possible solution, but maybe not the best one.
# Keep track of the best solution and return it at the end.

def make_better_change(amount, coins=[25, 10, 5, 1])

end 