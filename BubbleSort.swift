import Foundation

// Author: Tamer Zreg
// Description: This program reads numbers from a file, sorts each line of numbers using the bubble sort algorithm,
//              prints the sorted numbers, and then writes the sorted numbers to a new file.

// Bubble sort function
func bubbleSort(_ array: inout [Int]) {
    let n = array.count
    for i in 0..<n {
        for j in 0..<n-i-1 {
            if array[j] > array[j+1] {
                let temp = array[j]
                array[j] = array[j+1]
                array[j+1] = temp
            }
        }
    }
}

// Function to read numbers from file and return as an array of arrays of Integers
func readNumbersFromFile(_ fileName: String) -> [[Int]]? {
    // Initialize an empty array to store the numbers
    var numbersArray: [[Int]] = []
    do {
        // Read the contents of the file
        let content = try String(contentsOfFile: fileName, encoding: .utf8)
        // Split the content by newline character to get lines
        let lines = content.components(separatedBy: "\n")
        // Iterate over each line
        for line in lines {
            // Split the line by whitespace to get individual numbers
            let numbers = line.components(separatedBy: " ").compactMap { Int($0) }
            // Append the numbers to the numbersArray
            numbersArray.append(numbers)
        }
    } catch {
        // Print error if any
        print("Error reading file: \(error)")
        return nil
    }
    return numbersArray
}

// Function to write numbers to file
func writeNumbersToFile(_ fileName: String, numbers: [[Int]]) {
    var content = ""
    // Iterate over each line of numbers
    for line in numbers {
        // Convert each number in the line to string and join them by whitespace
        let lineString = line.map { String($0) }.joined(separator: " ")
        // Append the line to content with newline character
        content.append(lineString + "\n")
    }
    do {
        // Write the content to file
        try content.write(toFile: fileName, atomically: true, encoding: .utf8)
        print("Numbers written to file successfully.")
    } catch {
        // Print error if any
        print("Error writing to file: \(error)")
    }
}

// Read numbers from file
if let numbers = readNumbersFromFile("numbers.txt") {
    // Sort each line of numbers using bubble sort
    for i in 0..<numbers.count {
        bubbleSort(&numbers[i])
    }
    
    // Print sorted numbers
    print("Sorted numbers:")
    for line in numbers {
        print(line)
    }
    
    // Write sorted numbers to file
    writeNumbersToFile("sorted_numbers.txt", numbers: numbers)
} else {
    print("Failed to read numbers from file.")
}
