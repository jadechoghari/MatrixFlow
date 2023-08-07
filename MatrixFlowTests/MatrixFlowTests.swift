//
//  MatrixFlowTests.swift
//  MatrixFlowTests
//
//  Created by Jade Choghari on 06/08/2023.
//

import XCTest
import CoreML
@testable import MatrixFlow

final class MatrixFlowTests: XCTestCase {
    
    var matrixFlow: MatrixFlow!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        matrixFlow = MatrixFlow()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConvertMultiArrayToArray4d() {
        let shape: [NSNumber] = [1, 3, 4, 2]
        let result: [[[[Decimal]]]] = [[[[0, 1], [1, 2], [2, 3], [3, 4]], [[1, 2], [2, 3], [3, 4], [4, 5]], [[2, 3], [3, 4], [4, 5], [5, 6]]]]
        // Create an MLMultiArray with the specified shape
        guard let multiArray = try? MLMultiArray(shape: shape, dataType: .float32) else {
            fatalError("Failed to create MLMultiArray")
        }

        // Initialize the MLMultiArray with some values
        for i in 0..<shape[0].intValue {
            for j in 0..<shape[1].intValue {
                for k in 0..<shape[2].intValue {
                    for l in 0..<shape[3].intValue {
                        let indices = [i, j, k, l] as [NSNumber]
                        multiArray[indices] = NSNumber(value: i + j + k + l)
                    }
                }
            }
        }
        XCTAssertEqual(matrixFlow.convertMultiArrayToArray4d(multiArray), result)
    }
    
    func testMultiplyMatrices() {
        let matrixAA: [[Decimal]] = [[1, 2, 3], [4, 5, 6]]
        let matrixBB: [[Decimal]] = [[7, 8], [9, 10], [11, 12]]
        let result: [[Decimal]] = [[58, 64], [139, 154]]
        XCTAssertEqual(matrixFlow.multiplyMatrices(matrixAA, matrixBB), result)
    }
    
    func tetstReshapeToMatrix() {
        //code here
        let flattenedArray: [Decimal] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25]
        let result: [[Decimal]] = [[1, 2, 3, 4, 5], [6, 7, 8, 9, 10], [11, 12, 13, 14, 15], [16, 17, 18, 19, 20], [21, 22, 23, 24, 25]]
        
        XCTAssertEqual(matrixFlow.reshapeToMatrix(array: flattenedArray, rows: 5, cols: 5), result)
    }
    
    func testSigmoidMatrix() {
        //code here
        let matrix: [[Decimal]] = [
            [1.8, 2.0, 3.0],
            [4.9, 5.0, 6.0],
            [7.0, 8.0, 9.0]
        ]
        
        let result: [[Decimal]] = [[0.8581489350995122176, 0.880797077977882624, 0.9525741268224335872], [0.9926084586557181952, 0.9933071490757152768, 0.9975273768433655808], [0.9990889488055998464, 0.9996646498695335936, 0.9998766054240137216]]

        
        XCTAssertEqual(matrixFlow.sigmoidMatrix(matrix), result)
    }

    func testConvertMultiArrayToArray() {
        //code here
        let shape: [NSNumber] = [1, 3, 4]
        guard let multiArray = try? MLMultiArray(shape: shape, dataType: .float32) else {
            fatalError("Failed to create MLMultiArray")
        }

        // Initialize the MLMultiArray with some values
        for i in 0..<shape[0].intValue {
            for j in 0..<shape[1].intValue {
                for k in 0..<shape[2].intValue {
                    let indices = [i, j, k] as [NSNumber]
                    multiArray[indices] = NSNumber(value: i + j + k)
                }
            }
        }
        
        let result: [[[Decimal]]] = [[[0, 1, 2, 3], [1, 2, 3, 4], [2, 3, 4, 5]]]
        
        XCTAssertEqual(matrixFlow.convertMultiArrayToArray(multiArray), result)
        
    }
    
    func testTranspose() {
        //code here
        let reducedArray: [[Decimal]] = [[0, 1, 2, 3], [1, 2, 3, 4], [2, 3, 4, 5]]
        let result: [[Decimal]] = [[0, 1, 2], [1, 2, 3], [2, 3, 4], [3, 4, 5]]
        
        XCTAssertEqual(matrixFlow.transpose(reducedArray), result)
        
    }
    func testReshapeArray() {
        //code here
        let array: [[[Decimal]]] = [[[1.1, 1.2], [1.3, 1.4], [1.5, 1.6], [1.7, 1.8]], [[2.1, 2.2], [2.3, 2.4], [2.5, 2.6], [2.7, 2.8]], [[3.1, 3.2], [3.3, 3.4], [3.5, 3.6], [3.7, 3.8]]]
        let result: [[Decimal]] = [[1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8], [2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8], [3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8]]
        
        XCTAssertEqual(matrixFlow.reshapeArray(inputArray: array), result)
        
    }
    func testSlice() {
        //code here
        let input: [[Decimal]] = [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 50], [11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 15], [21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 16]]
        let result: [[Decimal]] = [[1, 2, 3, 4, 5], [11, 12, 13, 14, 15], [21, 22, 23, 24, 25]]
        
        XCTAssertEqual(matrixFlow.slice(inputArray: input, start: 0, end: 5), result)
        
    }
    func testCombineMatrix() {
        //code here similar to np.hstack
        let boxes: [[Decimal]] = [[1, 2, 3, 4, 5], [11, 12, 13, 14, 15], [21, 22, 23, 24, 25]]
        let masks: [[Decimal]] = [[6, 7, 8, 9, 10, 50], [16, 17, 18, 19, 20, 15], [26, 27, 28, 29, 30, 16]]
        let results: [[Decimal]] = [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 50], [11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 15], [21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 16]]
        
        XCTAssertEqual(matrixFlow.combineMatrix(boxes: boxes, masks: masks), results)
        
    }
    
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
