//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import PlaygroundSupport

import TachoGraphKit

let containerWidth: CGFloat = 375.0
let containerHeight: CGFloat = 667.0
let containerFrame: CGRect = CGRect(x: 0, y: 0, width: containerWidth, height: containerHeight)
let containerView = UIView(frame: containerFrame)

let graphWidth: CGFloat = 250
let graphX: CGFloat = containerView.frame.midX - (graphWidth / 2)
let graphY: CGFloat = containerView.frame.midY - (graphWidth / 2)
let graphFrame = CGRect(x: graphX, y: graphY, width: graphWidth, height: graphWidth)

let graph = TachoGraph(frame: graphFrame)

let a = TachoSegment(start: 0, length: 20, color: UIColor.white.cgColor)
let b = TachoSegment(start: 20, length: 30, color: UIColor.green.cgColor)
let c = TachoSegment(start: 50, length: 30, color: UIColor.brown.cgColor)
let d = TachoSegment(start: 80, length: 14, color: UIColor.blue.cgColor)

class Main: UIViewController {

    var graph: TachoGraph!
    var slider: UISlider!
    var insetSlider: UISlider!
    var scaleSlider: UISlider!
    var viewScaleSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()

        graph = TachoGraph(frame: graphFrame)
        graph.backgroundColor = UIColor.red
        graph.image = #imageLiteral(resourceName: "Sample Artwork.jpg")
        graph.secondaryImage = #imageLiteral(resourceName: "Sample Artwork.jpg")

        graph.segments = [a, b, c, d]

        slider = UISlider(frame: CGRect(x: 0, y: 0, width: containerWidth, height: 32))
        slider.addTarget(self, action: #selector(Main.updateValue), for: .valueChanged)
        slider.value = Float(graph.completed)

        insetSlider = UISlider(frame: CGRect(x: 0, y: 32, width: containerWidth, height: 32))
        insetSlider.addTarget(self, action: #selector(Main.updateInset), for: .valueChanged)
        insetSlider.value = Float(graph.imageScale)

        scaleSlider = UISlider(frame: CGRect(x: 0, y: 64, width: containerWidth, height: 32))
        scaleSlider.addTarget(self, action: #selector(Main.updateScale), for: .valueChanged)
        scaleSlider.value = Float(graph.secondaryImageScale)

        viewScaleSlider = UISlider(frame: CGRect(x: 0, y: 96, width: containerWidth, height: 32))
        viewScaleSlider.addTarget(self, action: #selector(Main.updateViewScale), for: .valueChanged)
        viewScaleSlider.value = Float(1)
        viewScaleSlider.minimumValue = 1
        viewScaleSlider.maximumValue = 5


        view.addSubview(graph)
        view.addSubview(slider)
        view.addSubview(insetSlider)
        view.addSubview(scaleSlider)
        view.addSubview(viewScaleSlider)
    }

    func updateValue() {
        graph.completed = CGFloat(slider.value)
    }

    func updateInset() {
        graph.imageScale = CGFloat(insetSlider.value)
    }

    func updateScale() {
        graph.secondaryImageScale = CGFloat(scaleSlider.value)
    }

    func updateViewScale() {
        let newWidth: CGFloat = graphWidth * CGFloat(viewScaleSlider.value)

        graph.frame = CGRect(x: graphX, y: graphY, width: newWidth, height: newWidth)
    }
}

let view = Main()
view.view.bounds = containerFrame

PlaygroundPage.current.liveView = view.view
PlaygroundPage.current.needsIndefiniteExecution = true

