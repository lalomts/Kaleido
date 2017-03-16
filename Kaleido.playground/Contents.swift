//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let view = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 400))
view.backgroundColor = #colorLiteral(red: 0.1603881121, green: 0.1677560508, blue: 0.2133775949, alpha: 1)
PlaygroundPage.current.liveView = view

let main = CALayer()
main.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
main.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor

let kaleido = KaleidoLayer(referenceLayer: main)

let row = CAReplicatorLayer()
row.frame = CGRect(x: 0, y: 0, width: 600, height: 200)
row.instanceCount =  3
row.instanceTransform = CATransform3DMakeTranslation(200, 0, 0)
row.addSublayer(kaleido)

let grid = CAReplicatorLayer()
grid.frame = view.layer.frame
grid.instanceCount = 2
grid.instanceTransform = CATransform3DMakeTranslation(0, 200, 0)
grid.addSublayer(row)

view.layer.addSublayer(grid)


