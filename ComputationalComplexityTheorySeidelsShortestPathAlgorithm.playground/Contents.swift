//  SeidelsShortestPath
//
//  Created by Григорий Сосновский on 3/20/21.
//

import XCTest

struct Matrix {
    let body: [[Int]]
    var isAllOne: Bool = true
    var isAllZero: Bool = true
}

func seidel(input: [[Int]]) -> [[Int]] {
    let n = input.count
    var check = Matrix(body: input)
    
    for  i in 0..<n {
        for j in 0..<n {
            guard i != j else { continue }
            if check.body[i][j] != 1 {
                check.isAllOne = false
            }
            
            if check.body[i][j] != 0 {
                check.isAllZero = false
            }
            
            if !check.isAllOne && !check.isAllZero {
                break
            }
        }
    }
    
    if check.isAllOne || check.isAllZero {
        return input
    }
    
    let squared = multiplyMatrix(left: input, right: input)
    var matrixA: [[Int]] = []
    
    for  i in 0..<n {
        matrixA.append([])
        for j in 0..<n {
            if i != j && (input[i][j] == 1 || squared[i][j] > 0) {
                matrixA[i].append(1)
            } else {
                matrixA[i].append(0)
            }
        }
    }
    
    let distances = seidel(input: matrixA)
    let matrixB = multiplyMatrix(left: distances, right: input)

    var degree: [Int] = []
    for  i in 0..<n {
        degree.append(0)
        for j in 0..<n {
            degree[i] += input[i][j]
        }
    }
    
    var result: [[Int]] = []
    for  i in 0..<n {
        result.append([])
        for j in 0..<n {
            if matrixB[i][j] >= distances[i][j] * degree[j] {
                result[i].append(2 * distances[i][j])
            } else {
                result[i].append(2 * distances[i][j] - 1)
            }
        }
    }
    
    return result
}

func multiplyMatrix(left: [[Int]], right: [[Int]]) -> [[Int]] {
    var result: [[Int]] = []
    let n = left.count
    
    for  i in 0..<n {
        result.append([])
        for j in 0..<n {
            var sum = 0
            
            for k in 0..<n {
                sum += left[i][k] * right[k][j]
            }
            
            result[i].append(sum)
        }
    }
    
    return result
}

// MARK: - Unit tests
class SeidelTests: XCTestCase {
    func test3by3() {
        let test = [
            [0, 1, 0],
            [1, 0, 1],
            [1, 0, 0]
        ]
        
        let expectedResult = [
            [0, 1, 2],
            [2, 0, 1],
            [2, 1, 0]
        ]
        
        XCTAssertEqual(expectedResult, seidel(input: test))
    }
    
    func test4by4() {
        let test = [
            [0, 1, 1, 1],
            [1, 0, 0, 0],
            [1, 1, 0, 1],
            [1, 0, 0, 0]
        ]
        
        let expectedResult = [
            [0, 2, 1, 2],
            [1, 0, 1, 2],
            [1, 2, 0, 2],
            [1, 2, 1, 0]
        ]
        
        XCTAssertEqual(expectedResult, seidel(input: test))
    }
    
    func test5by5() {
        let test = [
            [0, 1, 1, 1, 1],
            [0, 0, 1, 0, 1],
            [0, 1, 0, 1, 1],
            [1, 0, 0, 0, 1],
            [1, 0, 1, 1, 0],
        ]
        
        let expectedResult = [
            [0, 1, 1, 2, 2],
            [1, 0, 1, 2, 2],
            [1, 1, 0, 2, 2],
            [1, 2, 2, 0, 2],
            [1, 2, 1, 2, 0]
        ]
        
        XCTAssertEqual(expectedResult, seidel(input: test))
    }
    
    func testAllOne() {
        let test = [
            [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
        ]
        
        XCTAssertEqual(test, seidel(input: test))
    }
    
    func testAllZero() {
        let test = [
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        ]
        
        XCTAssertEqual(test, seidel(input: test))
    }
    
    func testMultiply() {
        let test = [
            [1, 0, 0, 1],
            [1, 0, 0, 1],
            [1, 0, 0, 1],
            [1, 0, 0, 1],
        ]
        
        let expectedResult = [
            [2, 0, 0, 2],
            [2, 0, 0, 2],
            [2, 0, 0, 2],
            [2, 0, 0, 2],
        ]
        
        XCTAssertEqual(expectedResult, multiplyMatrix(left: test, right: test))
    }
}

SeidelTests.defaultTestSuite.run()
