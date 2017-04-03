//: Playground - noun: a place where people can play

import UIKit


//MARK: - FIZZBUZZ
let numbers = [1, 2, 3, 4, 5, 15]

for number in numbers {
    
    if number % 3 == 0 && number % 5 == 0 {
        print("\(number) - fizzBuzz")
    } else if number % 3 == 0 {
        print("\(number)-fizz")
    } else if number % 5 == 0 {
        print("\(number)-buzz")
    } else {
        print(number)
    }
}



let numbers2 = [1, 2, 3, 4, 6, 8, 11, 13, 16, 19, 21, 32]

numbers2.count

//MARK: - Linear search


func linearSearchFor(searchValue: Int, array: [Int]) -> Bool {
    for number in array {
        if number == searchValue {
            return true
        }
    }
    
    return false
}

linearSearchFor(searchValue: 20, array: numbers2)


//MARK: - Binary tree search

func binarySearchFor(searchValue: Int, array: [Int]) -> Bool {
    var leftIndex = 0
    var rightIndex = array.count - 1
    
    while leftIndex <= rightIndex {
        let middleIndex = (leftIndex + rightIndex) / 2
        let middleValue = array[middleIndex]
        print("middleIndex-\(middleValue)")
        
        if  middleValue == searchValue {
            return true
        }
        
        if searchValue < middleValue {
            rightIndex = middleIndex - 1
        }
        
        if searchValue > middleValue {
            leftIndex = middleIndex + 1
        }
    }
    
    
    return false
}


binarySearchFor(searchValue: 2, array: numbers2)

//loop style factorial 

func factorialFor(number: UInt) -> UInt {
    if number == 0 {
        return 0
    }
    
    var finalValue: UInt = 1
    for i in 1...number {
        finalValue *= i
    }
    
    return finalValue
}

//recursive factorial

func recursiveFactorialFor(number: UInt) -> UInt {
    if number == 0 {
        return 1
    }
    
    return number * recursiveFactorialFor(number: number - 1)
}

recursiveFactorialFor(number: 4)















