// Week 4 Code Challenges

import UIKit

// CLASS 1: Given an array of ints of odd length, return a new array length 3 containing the elements from the middle of the array. The array length will be at least 3.

let array = [1, 2, 3, 4, 5, 6, 7]

func odd(array: [Int]) -> [Int] {
    return Array(array[(array.count / 2 - 1)...(array.count / 2 + 1)])
}

odd(array)

// CLASS 2: Write a function that takes in an array of numbers, and returns the lowest and highest numbers as a tuple.

let test = [1, 2, 5, 10, 20, 3]

func tupleHighLow(input: [Int]) -> (min: Int?, max: Int?) {
    let elements = input
    let output = (elements.minElement(), elements.maxElement())
    print(output)
    return output
}

tupleHighLow(test)

<<<<<<< HEAD
// CLASS 3: Given a non-negative number "num", return true if num is within 2 of a multiple of 10. Note: (a % b) is the remainder of dividing a by b, so (7 % 5) is 2.

func multiple(num: Int) -> Bool {
    return (num + 2) % 10 <= 4
}



// multiple(54)

=======
>>>>>>> 781010de0681a2a107aa14b154bc92b3f9d1b877


