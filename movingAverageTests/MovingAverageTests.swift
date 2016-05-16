//
//  movingAverageTests.swift
//  movingAverageTests
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

import XCTest
import movingAverage

class MovingAverageTests: XCTestCase {

    func testCGFloat() {
        let a = (1..<1000000).map{ CGFloat($0) }

#if swift(>=3)
        self.measure {
            XCTAssertEqualWithAccuracy(666666.33333, a.movingAverage(), accuracy: 0.00001)
        }
#else
        self.measureBlock {
            XCTAssertEqualWithAccuracy(666666.33333, a.movingAverage(), accuracy: 0.00001)
        }
#endif
    }

    func testDouble() {
        let a = (1..<1000000).map(Double.init)

#if swift(>=3)
        self.measure {
            XCTAssertEqualWithAccuracy(666666.33333, a.movingAverage(), accuracy: 0.00001)
        }
#else
        self.measureBlock {
            XCTAssertEqualWithAccuracy(666666.33333, a.movingAverage(), accuracy: 0.00001)
        }
#endif
    }

    func testFloat() {
        let a = (1..<1000000).map(Float.init)

#if swift(>=3)
        self.measure {
            XCTAssertEqualWithAccuracy(666666, a.movingAverage(), accuracy: 100)
        }
#else
        self.measureBlock {
            XCTAssertEqualWithAccuracy(666666, a.movingAverage(), accuracy: 100)
        }
#endif
    }


    func testInt() {
        let a = (1..<1000000).map{ Int($0) }

#if swift(>=3)
        self.measure {
            XCTAssertEqual(666666, a.movingAverage())
        }
#else
        self.measureBlock {
            XCTAssertEqual(666666, a.movingAverage())
        }
#endif
    }
}

