//
//  MatrixFlow.swift
//  MatrixFlow
//
//  Created by Jade Choghari on 07/08/2023.
//

import Foundation
import CoreML
import Accelerate

public final class MatrixFlow {
    
    let name = "MatrixFlow"
    
    // Convert a 4d mlmultiarray to a 4d matrix
    public func convertMultiArrayToArray4d(_ multiArray: MLMultiArray) -> [[[[Decimal]]]] {
        let shape = multiArray.shape.map { $0.intValue }
        var currentIndex = [NSNumber](repeating: 0, count: shape.count)
        var array = [[[[Decimal]]]](repeating: [[[Decimal]]](repeating: [[Decimal]](repeating: [Decimal](repeating: 0, count: shape[3]), count: shape[2]), count: shape[1]), count: shape[0])
        
        for i in 0..<multiArray.count {
            let value = Decimal(multiArray[currentIndex].doubleValue) // Convert the value to Decimal
            let indices = currentIndex.compactMap { $0.intValue }
            
            array[indices[0]][indices[1]][indices[2]][indices[3]] = value
            
            // Update the current index to iterate through all elements
            for i in (0..<currentIndex.count).reversed() {
                let currentIndexValue = currentIndex[i].intValue
                
                if currentIndexValue < shape[i] - 1 {
                    currentIndex[i] = NSNumber(value: currentIndexValue + 1)
                    break
                } else {
                    currentIndex[i] = 0
                }
            }
        }
        
        return array
    }
    
    //Multiply matrices
    
    
    public func multiplyMatrices(_ matrixA: [[Decimal]], _ matrixB: [[Decimal]]) -> [[Decimal]]? {
        let rowsA = matrixA.count
        let columnsA = matrixA[0].count
        let rowsB = matrixB.count
        let columnsB = matrixB[0].count
        
        // Check if matrices can be multiplied
        guard columnsA == rowsB else {
            return nil
        }
        
        // Convert matrices to flat arrays of Double
        var flatMatrixA = matrixA.flatMap { $0.map { Double($0 as NSNumber) } }
        var flatMatrixB = matrixB.flatMap { $0.map { Double($0 as NSNumber) } }
        
        // Create result matrix
        var result = [Double](repeating: 0, count: rowsA * columnsB)
        
        // Perform matrix multiplication using Accelerate framework
        vDSP_mmulD(flatMatrixA, 1, flatMatrixB, 1, &result, 1, vDSP_Length(rowsA), vDSP_Length(columnsB), vDSP_Length(columnsA))
        
        // Convert the result back to a 2D array of Decimal
        var resultMatrix = [[Decimal]]()
        
        for i in 0..<rowsA {
            let startIndex = i * columnsB
            let endIndex = startIndex + columnsB
            let row = Array(result[startIndex..<endIndex]).map { Decimal($0) }
            resultMatrix.append(row)
            let percentage = Double(i + 1) / Double(rowsA) * 100
            let remainingPercentage = 100 - percentage
            //                    print("Remaining time: \(remainingPercentage)%")
        }
        
        return resultMatrix
    }
    
    // to 160 x 160
    public func reshapeToMatrix(array: [Decimal], rows: Int, cols: Int) -> [[Decimal]] {
        var matrix: [[Decimal]] = []
        
        for i in 0..<rows {
            let startIndex = i * cols
            let endIndex = startIndex + cols
            let row = Array(array[startIndex..<endIndex])
            matrix.append(row)
        }
        
        return matrix
    }
    
    
    public func sigmoidMatrix(_ matrix: [[Decimal]]) -> [[Decimal]] {
        
        func sigmoid(_ x: Decimal) -> Decimal {
            let doubleX = NSDecimalNumber(decimal:x).doubleValue
            let result = 1.0 / (1.0 + exp(-doubleX))
            return Decimal(result)
        }
        return matrix.map { row in
            return row.map { element in
                sigmoid(element)
            }
        }
    }
    
    
    //convert MLMultiarray to a normal Swift Array
    
    public func convertMultiArrayToArray(_ multiArray: MLMultiArray) -> [[[Decimal]]] {
        let shape = multiArray.shape.map { $0.intValue }
        var currentIndex = [NSNumber](repeating: 0, count: shape.count)
        var array = [[[Decimal]]](repeating: [[Decimal]](repeating: [Decimal](repeating: 0.0, count: shape[2]), count: shape[1]), count: shape[0])
        
        for i in 0..<multiArray.count {
            let value = multiArray[currentIndex].decimalValue
            let indices = currentIndex.compactMap { $0.intValue }
            
            array[indices[0]][indices[1]][indices[2]] = value
            
            // Update the current index to iterate through all elements
            for i in (0..<currentIndex.count).reversed() {
                let currentIndexValue = currentIndex[i].intValue
                
                if currentIndexValue < shape[i] - 1 {
                    currentIndex[i] = NSNumber(value: currentIndexValue + 1)
                    break
                } else {
                    currentIndex[i] = 0
                }
            }
        }
        
        return array
    }
    
    public func transpose<T>(_ array: [[T]]) -> [[T]] {
        guard let rowCount = array.first?.count else {
            return []
        }
        
        var transposedArray: [[T]] = Array(repeating: Array(repeating: array[0][0], count: array.count), count: rowCount)
        
        for (i, row) in array.enumerated() {
            for (j, element) in row.enumerated() {
                transposedArray[j][i] = element
            }
        }
        
        return transposedArray
    }
    
    //Convert 4d matrix from (3 x 4 x 2) to (3 x (4x2))
    public func reshapeArray(inputArray: [[[Decimal]]]) -> [[Decimal]] {
        return inputArray.map { subArray in
            return subArray.flatMap { $0 }
        }
    }
    
    //slicing
    public func slice(inputArray: [[Decimal]], start: Int, end: Int) -> [[Decimal]] {
        return inputArray.map { Array($0[start..<end]) }
    }

    //combine (2, 4) and (4, 8)
    public func combineMatrix(boxes: [[Decimal]], masks: [[Decimal]]) -> [[Decimal]] {
        var combined: [[Decimal]] = []

        for (box, mask) in zip(boxes, masks) {
            let combinedRow = box + mask
            combined.append(combinedRow)
        }

        return combined
    }
    
}
