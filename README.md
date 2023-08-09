# MatrixFlow
A CocoaPods library for swift-driven matrix and image operations, offering seamless integration of CoreML and Accelerate frameworks for optimized machine learning and mathematical computations.

<img src="https://developer.apple.com/assets/elements/icons/create-ml-framework/create-ml-framework-96x96_2x.png"  width="10%" height="10%">
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Swift_logo.svg/1024px-Swift_logo.svg.png"  width="20%" height="20%">

MatrixFlow is a sophisticated Swift library that harnesses the power of CoreML and the Accelerate framework. Its primary purpose is to offer user-friendly solutions for intricate challenges in matrix manipulation, image processing, machine learning processing, and beyond. 

The Accelerate framework offers exposure to SIMD instructions inherent in contemporary CPUs, which in turn, markedly enhances the performance of certain computational tasks. Regrettably, due to its somewhat arcane nature and less-than-intuitive APIs, many developers bypass the Accelerate framework. This oversight is unfortunate, considering the potential performance enhancements that many applications stand to gain from its integration. 

MatrixFlow is strategically positioned to bridge this disconnect. It simplifies the complexities tied to matrix manipulations with mlmultiarray, providing developers an intuitive interface to execute Python-esque functions such as: 

Comparison table between the functions inside MatrixFlow and their similar Python functions, particularly with the `numpy` library, which is commonly used for matrix operations in Python.

| **Swift Function**       | **Python (numpy) Equivalent** | **Math Representation** |
|--------------------------|-------------------------------|-------------------------|
| ConvertMultiArrayToArray4d | `numpy.asarray()` (with shape adjustment) | <img src="https://latex.codecogs.com/gif.latex?A%20\in%20\mathbb{R}^{w%20\times%20x%20\times%20y%20\times%20z}%20\" />  |
| MultiplyMatrices        | `numpy.dot()` | <img src="https://latex.codecogs.com/gif.latex?C%20=%20A%20\times%20B%20\text{%20where%20}%20A%20\in%20\mathbb{R}^{m%20\times%20n}%20\text{%20and%20}%20B%20\in%20\mathbb{R}^{n%20\times%20p}" />  |
| ReshapeToMatrix         | `numpy.reshape()` | <img src="https://latex.codecogs.com/gif.latex?C%20=%20B%20=%20\text{reshape}(A,%20(m,%20n%20\times%20o))%20\text{%20where%20}%20A%20\in%20\mathbb{R}^{m%20\times%20n%20\times%20o}" />  |
| SigmoidMatrix           | `def sigmoid(x):return 1 / (1 + np.exp(-x))` | <img src="https://latex.codecogs.com/gif.latex?S(x)%20=%20\frac{1}{1%20+%20e^{-x}}" /> |
| ConvertMultiArrayToArray | `numpy.asarray()` (with shape adjustment) | <img src="https://latex.codecogs.com/gif.latex?\(%20B%20=%20\text{reshape}(A,%20(m,%20n%20\times%20o))%20\)%20where%20\(%20A%20\in%20\mathbb{R}^{m%20\times%20n%20\times%20o}%20\" /> |
| Transpose               | `numpy.transpose()` | <img src="https://latex.codecogs.com/gif.latex?\(%20B%20=%20A^T%20\)%20where%20\(%20A%20\in%20\mathbb{R}^{m%20\times%20n}%20\)"/> |
| ReshapeArray            | `numpy.reshape()` | <img src="https://latex.codecogs.com/gif.latex?\(%20B%20=%20\text{reshape}(A,%20(m,%20n%20\times%20o))%20\)%20where%20\(%20A%20\in%20\mathbb{R}^{m%20\times%20n%20\times%20o}%20\)"/> |
| Slice                   | `matrix[:5]` | <img src="https://latex.codecogs.com/gif.latex?B%20=%20A_{[:k]}%20\text{%20where%20}%20k%20\text{%20is%20the%20number%20of%20rows/columns%20to%20slice}"/> |
| CombineMatrix           | `numpy.hstack()` | <img src="https://latex.codecogs.com/gif.latex?C%20=%20\text{hstack}(A,%20B)%20\text{%20for%20horizontally%20stacking%20matrices%20}%20A%20\text{%20and%20}%20B"/> |


Its vast potential makes it a valuable asset for diverse applications, from gaming to machine learning development, all within the Swift ecosystem. 

**Target Audience**: Individuals seeking streamlined solutions to manipulate multiarray matrices and process CoreML outputs.

Additionally, here's a brief guide on how to install the `MatrixFlow` library using different package managers:

---

### Installation Guide for MatrixFlow

**1. Swift Package Manager:**
   
To integrate `MatrixFlow` into your Xcode project using Swift Package Manager, add the following as a dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/jadechoghari/MatrixFlow.git", .upToNextMajor(from: "1.0.0"))
]
```

Then, simply import `MatrixFlow` wherever you need it.

**2. CocoaPods:**

Firstly, ensure you have CocoaPods installed. If not, install it using:

```
$ gem install cocoapods
```

Next, create a `Podfile` in your project directory (if you haven't) and add:

```
pod 'MatrixFlow'
```

Now, run the following command:

```
$ pod install
```

Post installation, ensure to open your project's `.xcworkspace`.

**3. Carthage:**

Ensure you have Carthage installed. If not, you can get it via Homebrew:

```
$ brew install carthage
```

Then, create a `Cartfile` in your project directory (if you haven't) and add:

```
github "jadechoghari/MatrixFlow"
```

Now, execute:

```
$ carthage update
```

After it's done, add the built `.framework` binaries to your target's "Linked Frameworks and Libraries" section in Xcode.

---

### MatrixFlow Usage Guide

---

**1. ConvertMultiArrayToArray4d:** 

This function seamlessly transforms a 4D `MLMultiArray` into a structured 4D matrix tailored for immediate application. The resulting matrix is of type `[[[[Decimal]]]]`, leveraging the Decimal type to ensure precision in the data representation.

**Usage:** 

```swift
import MatrixFlow
// Generating a 4D MLMultiArray
guard let multiArray = try? MLMultiArray(shape: shape, dataType: .float32) else { 
    fatalError("Failed to create MLMultiArray") 
}

// Populate the MLMultiArray with some values
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

let fourArray = MatrixFlow.convertMultiArrayToArray4d(multiArray)
```

**Expected Result of type :** 

```swift
[[[[0, 1], [1, 2], [2, 3], [3, 4]], [[1, 2], [2, 3], [3, 4], [4, 5]], [[2, 3], [3, 4], [4, 5], [5, 6]]]]
//of type [[[[Decimal]]]]
```

---

**2. MultiplyMatrices:** 

The function accepts two 2D matrices and performs matrix multiplication. For instance, a (2, 4) matrix multiplied with a (4, 8) matrix.

**Usage:**

```swift
import MatrixFlow
let matrixA: [[Decimal]] = [[1, 2, 3], [4, 5, 6]]
let matrixB: [[Decimal]] = [[7, 8], [9, 10], [11, 12]]

//Perform multiplication
let result = MatrixFlow.multiplyMatrices(matrixAA, matrixBB)

//expected results of type [[Decimal]]: [[58, 64], [139, 154]]
```

---

**3. ReshapeToMatrix:** 

This function accepts a 2D matrix and reshapes it, effectively halving its dimensions. For example, it can transform a (3, 25600) matrix into a (3, 160, 160) structure.

``` swift
import MatrixFlow
let flattenedArray: [Decimal] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25]
let rows = 5
let columns = 5
// specifiy the number of rows and columns you'll need accordingly
let result = MatrixFlow.reshapeToMatrix(array: flattenedArray, rows: rows, cols: columns)

//expected result of type [[Decimal]]
// [[1, 2, 3, 4, 5], [6, 7, 8, 9, 10], [11, 12, 13, 14, 15], [16, 17, 18, 19, 20], [21, 22, 23, 24, 25]]

```

---

**4. SigmoidMatrix:** 

Implements the sigmoid activation function to each cell of a matrix of type `[[Decimal]]`.

**Usage:**

```swift
import MatrixFlow
let matrix: [[Decimal]] = [
    [1.8, 2.0, 3.0], 
    [4.9, 5.0, 6.0], 
    [7.0, 8.0, 9.0]
]

let result: [[Decimal]] = MatrixFlow.sigmoidMatrix(matrix)
//expected result: [[Decimal]] = [[0.8581489350995122176, 0.880797077977882624, 0.9525741268224335872], [0.9926084586557181952, 0.9933071490757152768, 0.9975273768433655808], [0.9990889488055998464, 0.9996646498695335936, 0.9998766054240137216]]
```

**5. ConvertMultiArrayToArray:**

This function is designed to convert an `MLMultiArray` with three dimensions into a 3D matrix ready for use.

**Usage:**

```swift
import MatrixFlow
let shape: [NSNumber] = [1, 3, 4]

guard let multiArray = try? MLMultiArray(shape: shape, dataType: .float32) else {
    fatalError("Failed to create MLMultiArray")
}

// Populate the MLMultiArray
for i in 0..<shape[0].intValue {
    for j in 0..<shape[1].intValue {
        for k in 0..<shape[2].intValue {
            let indices = [i, j, k] as [NSNumber]
            multiArray[indices] = NSNumber(value: i + j + k)
        }
    }
}
let result: [[[Decimal]]] = MatrixFlow.convertMultiArrayToArray(multiArray)

// expected result: [[[Decimal]]] = [[[0, 1, 2, 3], [1, 2, 3, 4], [2, 3, 4, 5]]]
```

---

**6. Transpose:**


This function transposes a 2D matrix, essentially swapping its rows with columns.

**Usage:**
``` swift
import MatrixFlow
let array: [[Decimal]] = [[0, 1, 2, 3], [1, 2, 3, 4], [2, 3, 4, 5]]

let result = MatrixFlow.transpose(array)

//expected result: [[Decimal]] = [[0, 1, 2], [1, 2, 3], [2, 3, 4], [3, 4, 5]]
```

---

**7. ReshapeArray:**

This function reshapes a 3D matrix by merging its last two dimensions.

**Usage:**

```swift
import MatrixFlow
let array: [[[Decimal]]] = [[[1.1, 1.2], [1.3, 1.4], [1.5, 1.6], [1.7, 1.8]], [[2.1, 2.2], [2.3, 2.4], [2.5, 2.6], [2.7, 2.8]], [[3.1, 3.2], [3.3, 3.4], [3.5, 3.6], [3.7, 3.8]]]

let result = MatrixFlow.reshapeArray(inputArray: array)

//expected result: [[Decimal]] = [[1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8], [2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8], [3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8]]
```

---

**8. Slice:**

This function performs matrix slicing. Given a matrix, it retrieves the first five rows.

**Usage:**

```swift
import MatrixFlow
let input: [[Decimal]] = [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 50], [11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 15], [21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 16]]

//Specify the start and end index of the slicing
let start = 0
let end = 5

let result = MatrixFlow.slice(inputArray: input, start: 0, end: 5)

//expected result: [[Decimal]] = [[1, 2, 3, 4, 5], [11, 12, 13, 14, 15], [21, 22, 23, 24, 25]]
```

---

**9. CombineMatrix:**

This function is analogous to the numpy `hstack` operation. It horizontally stacks two matrices.

**Usage:**

```swift
import MatrixFlow
// boxes and masks are named for illustration purposes
let arrayA: [[Decimal]] = [[1, 2, 3, 4, 5], [11, 12, 13, 14, 15], [21, 22, 23, 24, 25]]
let arrayB: [[Decimal]] = [[6, 7, 8, 9, 10, 50], [16, 17, 18, 19, 20, 15], [26, 27, 28, 29, 30, 16]]

let result = MatrixFlow.combineMatrix(boxes: arrayA, masks: arrayB)

//expected results: [[Decimal]] = [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 50], [11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 15], [21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 16]]
```






