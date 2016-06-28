// Week 4 Code Challenges

// Given an array of ints of odd length, return a new array length 3 containing the elements from the middle of the array. The array length will be at least 3.

import UIKit

let array = [1, 2, 3, 4, 5, 6, 7]

func odd(array: [Int]) -> [Int] {
    return Array(array[(array.count / 2 - 1)...(array.count / 2 + 1)])
}

odd(array)





