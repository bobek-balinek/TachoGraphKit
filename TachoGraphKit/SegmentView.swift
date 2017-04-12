//
//  SegmentView.swift
//  TachoGraphKit
//
//  Created by Przemyslaw Bobak on 10/04/2017.
//  Copyright © 2017 Spirograph Limited. All rights reserved.
//

import UIKit

class SegmentView: UIView {
    var totalLength: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    var lineHeight: CGFloat = 4 {
        didSet {
            setNeedsDisplay()
        }
    }
    var rotationAngle: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    var segment: TachoSegment = .empty {
        didSet {
            setNeedsDisplay()
        }
    }

    var start: CGFloat {
        return CGFloat(segment.start)
    }
    var length: CGFloat {
        return CGFloat(segment.length)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    public convenience init(with segment: TachoSegment) {
        self.init(frame: CGRect.zero)

        self.segment = segment
    }

    fileprivate func commonInit() {
        backgroundColor = UIColor.clear
        tintColor = UIColor(cgColor: segment.color)
    }

    fileprivate func startAngle() -> CGFloat {
        let angle = (self.start / totalLength)

        return floatToAngle(number: angle)
    }

    fileprivate func endAngle() -> CGFloat {
        let start = (self.start / totalLength)
        let angle = start + (self.length / totalLength)

        return floatToAngle(number: angle)
    }

    fileprivate func floatToAngle(number: CGFloat) -> CGFloat {
        // Offset by -PI (-90 degrees anti-clockwise)
        let offset: CGFloat = CGFloat.pi / 2
        
        return (number * (CGFloat.pi * 2)) - offset
    }

    open override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!

        context.saveGState()

        let inset: CGFloat = lineHeight / 2
        let innerFrame = rect.insetBy(dx: inset, dy: inset)
        let radius = innerFrame.width / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)

        let path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: startAngle(),
            endAngle: endAngle(),
            clockwise: true
        )

        path.lineWidth = lineHeight
        tintColor.setStroke()
        UIColor.clear.setFill()

        context.translateBy(x: center.x, y: center.y)
        context.rotate(by: rotationAngle)
        context.translateBy(x: -center.x, y: -center.y)

        context.setLineWidth(lineHeight)
        context.addPath(path.cgPath)
        context.drawPath(using: .fillStroke)
        context.restoreGState()
    }
}
