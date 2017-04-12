//
//  TachoSegment.swift
//  TachoGraphKit
//
//  Created by Przemyslaw Bobak on 10/04/2017.
//  Copyright © 2017 Spirograph Limited. All rights reserved.
//

import Foundation

public struct TachoSegment {
    let start: Float
    let length: Float
    let color: CGColor

    public init(start: Float, length: Float, color: CGColor) {
        self.start = start
        self.length = length
        self.color = color
    }

    static var empty: TachoSegment {
        let white = CGColor(
            colorSpace: CGColorSpaceCreateDeviceRGB(),
            components: [1.0, 1.0, 1.0, 1.0]
        )

        return TachoSegment(start: 0, length: 0, color: white!)
    }
}
