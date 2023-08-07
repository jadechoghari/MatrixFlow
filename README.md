# MatrixFlow
A CocoaPods library for swift-driven matrix and image operations, offering seamless integration of CoreML and Accelerate frameworks for optimized machine learning and mathematical computations.

MatrixFlow is a sophisticated Swift library that harnesses the power of CoreML and the Accelerate framework. Its primary purpose is to offer user-friendly solutions for intricate challenges in matrix manipulation, image processing, machine learning processing, and beyond. 

The Accelerate framework offers exposure to SIMD instructions inherent in contemporary CPUs, which in turn, markedly enhances the performance of certain computational tasks. Regrettably, due to its somewhat arcane nature and less-than-intuitive APIs, many developers bypass the Accelerate framework. This oversight is unfortunate, considering the potential performance enhancements that many applications stand to gain from its integration. 

MatrixFlow is strategically positioned to bridge this disconnect. It simplifies the complexities tied to matrix manipulations with mlmultiarray, providing developers an intuitive interface to execute Python-esque functions such as: 

Comparison table between the functions inside MatrixFlow and their similar Python functions, particularly with the `numpy` library, which is commonly used for matrix operations in Python.

| **Swift Function**       | **Python (numpy) Equivalent** | **Math Representation** |
|--------------------------|-------------------------------|-------------------------|
| ConvertMultiArrayToArray4d | `numpy.asarray()` (with shape adjustment) | \( A \in \mathbb{R}^{w \times x \times y \times z} \) |
| MultiplyMatrices        | `numpy.dot()` | \( C = A \times B \) where \( A \in \mathbb{R}^{m \times n} \) and \( B \in \mathbb{R}^{n \times p} \) |
| ReshapeToMatrix         | `numpy.reshape()` | \( B = \text{reshape}(A, (m, n \times o)) \) where \( A \in \mathbb{R}^{m \times n \times o} \) |
| SigmoidMatrix           | \( \frac{1}{1 + \texttt{numpy.exp(-matrix)}} \) | \( S(x) = \frac{1}{1 + e^{-x}} \) |
| ConvertMultiArrayToArray | `numpy.asarray()` (with shape adjustment) | \( A \in \mathbb{R}^{w \times x \times y} \) |
| Transpose               | `numpy.transpose()` | \( B = A^T \) where \( A \in \mathbb{R}^{m \times n} \) |
| ReshapeArray            | `numpy.reshape()` | \( B = \text{reshape}(A, (m, n \times o)) \) where \( A \in \mathbb{R}^{m \times n \times o} \) |
| Slice                   | `matrix[:5]` | \( B = A_{[:k]} \) where \( k \) is the number of rows/columns to slice |
| CombineMatrix           | `numpy.hstack()` | \( C = \text{hstack}(A, B) \) for horizontally stacking matrices \( A \) and \( B \) |

<img src="https://latex.codecogs.com/gif.latex?O_t=\( A \in \mathbb{R}^{w \times x \times y \times z} \)" /> 

Its vast potential makes it a valuable asset for diverse applications, from gaming to machine learning development, all within the Swift ecosystem. 

**Target Audience**: Individuals seeking streamlined solutions to manipulate multiarray matrices and process CoreML outputs.

Certainly, here's a brief guide on how to install the `MatrixFlow` library using different package managers:

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
pod 'MatrixFlow', :git => 'https://github.com/jadechoghari/MatrixFlow.git'
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

let fourArray = convertMultiArrayToArray(multiArray)
```

**Expected Result:** 

```swift
let result: [[[[Decimal]]]] = [[[[0, 1], [1, 2], [2, 3], [3, 4]], [[1, 2], [2, 3], [3, 4], [4, 5]], [[2, 3], [3, 4], [4, 5], [5, 6]]]]
```

---

**2. MultiplyMatrices:** 

The function accepts two 2D matrices and performs matrix multiplication. For instance, a (2, 4) matrix multiplied with a (4, 8) matrix.

**Usage:**

```swift
let matrixAA: [[Decimal]] = [[1, 2, 3], [4, 5, 6]]
let matrixBB: [[Decimal]] = [[7, 8], [9, 10], [11, 12]]

let result: [[Decimal]] = [[58, 64], [139, 154]]
```

---

**3. ReshapeToMatrix:** 

This function accepts a 2D matrix and reshapes it, effectively halving its dimensions. For example, it can transform a (3, 25600) matrix into a (3, 160, 160) structure.

---

**4. SigmoidMatrix:** 

Implements the sigmoid activation function to each cell of a matrix of type `[[Decimal]]`.

**Usage:**

```swift
let matrix: [[Decimal]] = [
    [1.8, 2.0, 3.0], 
    [4.9, 5.0, 6.0], 
    [7.0, 8.0, 9.0]
]

let result: [[Decimal]] = [[0.8581489350995122176, 0.880797077977882624, 0.9525741268224335872], [0.9926084586557181952, 0.9933071490757152768, 0.9975273768433655808], [0.9990889488055998464, 0.9996646498695335936, 0.9998766054240137216]]
```

**5. ConvertMultiArrayToArray:**

This function is designed to convert an `MLMultiArray` with three dimensions into a 3D matrix ready for use.

**Usage:**

```swift
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

let result: [[[Decimal]]] = [[[0, 1, 2, 3], [1, 2, 3, 4], [2, 3, 4, 5]]]
```

---

**6. Transpose:**

This function transposes a 2D matrix, essentially swapping its rows with columns.

**Usage:**

```swift
let reducedArray: [[Decimal]] = [[0, 1, 2, 3], [1, 2, 3, 4], [2, 3, 4, 5]]
let result: [[Decimal]] = [[0, 1, 2], [1, 2, 3], [2, 3, 4], [3, 4, 5]]
```

---

**7. ReshapeArray:**

This function reshapes a 3D matrix by merging its last two dimensions.

**Usage:**

```swift
let array: [[[Decimal]]] = [[[1.1, 1.2], [1.3, 1.4], [1.5, 1.6], [1.7, 1.8]], [[2.1, 2.2], [2.3, 2.4], [2.5, 2.6], [2.7, 2.8]], [[3.1, 3.2], [3.3, 3.4], [3.5, 3.6], [3.7, 3.8]]]
let result: [[Decimal]] = [[1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8], [2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8], [3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8]]
```

---

**8. Slice:**

This function performs matrix slicing. Given a matrix, it retrieves the first five rows.

**Usage:**

```swift
let input: [[Decimal]] = [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 50], [11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 15], [21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 16]]
let result: [[Decimal]] = [[1, 2, 3, 4, 5], [11, 12, 13, 14, 15], [21, 22, 23, 24, 25]]
```

---

**9. CombineMatrix:**

This function is analogous to the numpy `hstack` operation. It horizontally stacks two matrices.

**Usage:**

```swift
let boxes: [[Decimal]] = [[1, 2, 3, 4, 5], [11, 12, 13, 14, 15], [21, 22, 23, 24, 25]]
let masks: [[Decimal]] = [[6, 7, 8, 9, 10, 50], [16, 17, 18, 19, 20, 15], [26, 27, 28, 29, 30, 16]]
let results: [[Decimal]] = [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 50], [11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 15], [21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 16]]
```

I'd be happy to provide you with a description of each function as a mathematical formula, but note that I can't produce actual drawn formulas within this text-based platform. However, I can describe them using LaTeX notation, which is a common way to represent mathematical expressions in a text format, and they can be rendered in various platforms that support LaTeX.

Table re each function with the appropriate mathematical formula:

| **Swift Function**       | **Mathematical Representation (LaTeX)** |
|--------------------------|-----------------------------------------|
| ConvertMultiArrayToArray4d | \( A \in \mathbb{R}^{w \times x \times y \times z} \) |
| MultiplyMatrices        | \( C = A \times B \) where \( A \in \mathbb{R}^{m \times n} \) and \( B \in \mathbb{R}^{n \times p} \) |
| ReshapeToMatrix         | \( B = \text{reshape}(A, (m, n \times o)) \) where \( A \in \mathbb{R}^{m \times n \times o} \) |
| SigmoidMatrix           | \( S(x) = \frac{1}{1 + e^{-x}} \) |
| ConvertMultiArrayToArray | \( A \in \mathbb{R}^{w \times x \times y} \) |
| Transpose               | \( B = A^T \) where \( A \in \mathbb{R}^{m \times n} \) |
| ReshapeArray            | \( B = \text{reshape}(A, (m, n \times o)) \) where \( A \in \mathbb{R}^{m \times n \times o} \) |
| Slice                   | \( B = A_{[:k]} \) where \( k \) is the number of rows/columns to slice |
| CombineMatrix           | \( C = \text{hstack}(A, B) \) for horizontally stacking matrices \( A \) and \( B \) |

To visualize these formulas, you'd typically use a LaTeX rendering platform or software such as Overleaf, LaTeXiT, or even certain online platforms like MathJax on websites.






