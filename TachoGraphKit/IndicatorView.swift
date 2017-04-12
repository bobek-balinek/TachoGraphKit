//
//  IndicatorView.swift
//  TachoGraphKit
//
//  Created by Przemyslaw Bobak on 11/04/2017.
//  Copyright © 2017 Spirograph Limited. All rights reserved.
//

import UIKit

class IndicatorView: UIView {

    var fillColor: UIColor = UIColor.white
    internal var triangleLayer: CAShapeLayer = CAShapeLayer()

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    fileprivate func commonInit() {
        backgroundColor = UIColor.clear
    }

    fileprivate func calculateFrame(_ rect: CGRect) -> CGRect {
        let midFrame: CGFloat = rect.midX
        let topFrame: CGFloat = 15.0
        let height: CGFloat = 7.0
        let width: CGFloat = 10.0
        let posX: CGFloat = (midFrame - width / 2)

        return CGRect(x: posX, y: topFrame, width: width, height: height)
    }

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!

        context.saveGState()

        let frame: CGRect = calculateFrame(rect)
        let width: CGFloat = frame.width
        let height: CGFloat = frame.height
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 5.0, y: 0))
        path.addLine(to: CGPoint(x: width, y: height))
        path.close()

        fillColor.setFill()

        context.translateBy(x: frame.midX - (width / 2), y: frame.minY - (height / 2))
        context.addPath(path.cgPath)
        context.drawPath(using: .fill)
        context.restoreGState()
    }
}
