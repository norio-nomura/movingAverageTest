//
//  Collection+movingAverage.swift
//
//  Created by 野村 憲男 on 5/16/16.
//
//  Copyright (c) 2016 Norio Nomura
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//


// inspired by https://gist.github.com/hirohitokato/5bfc5836480d68074135820d73c04794

import Foundation

public protocol ArithmeticType: Comparable, IntegerLiteralConvertible {
    func +(lhs: Self, rhs: Self) -> Self
    func -(lhs: Self, rhs: Self) -> Self
    func *(lhs: Self, rhs: Self) -> Self
    func /(lhs: Self, rhs: Self) -> Self
}

extension Int: ArithmeticType {}
extension CGFloat: ArithmeticType {}
extension Double: ArithmeticType {}
extension Float: ArithmeticType {}

// Calculate moving average of the specified array.
// @see: https://ja.wikipedia.org/wiki/%E7%A7%BB%E5%8B%95%E5%B9%B3%E5%9D%87
#if swift(>=3)
    // tested on swift-DEVELOPMENT-SNAPSHOT-2016-05-09-a
    public extension Collection where Iterator.Element: ArithmeticType {
        @_specialize(Array<Int>)
        @_specialize(Array<CGFloat>)
        @_specialize(Array<Double>)
        @_specialize(Array<Float>)
        public func movingAverage() -> Iterator.Element {
            var i: Iterator.Element = 0
            let numer = reduce(i) {
                i = i + 1
                return $0 + $1 * i
            }
            let denom = i * (i + 1) / 2
            return numer / denom
        }
    }
#else
    public extension CollectionType where Generator.Element: ArithmeticType {
        public func movingAverage() -> Generator.Element {
            var i: Generator.Element = 0
            let numer = reduce(i) {
                i = i + 1
                return $0 + $1 * i
            }
            let denom = i * (i + 1) / 2
            return numer / denom
        }
    }
#endif
