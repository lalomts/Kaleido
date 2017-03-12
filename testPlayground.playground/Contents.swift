//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let view = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 600))
view.backgroundColor = #colorLiteral(red: 0.1603881121, green: 0.1677560508, blue: 0.2133775949, alpha: 1)
PlaygroundPage.current.liveView = view

let base = CALayer()
base.bounds = CGRect(x: 0, y: 0, width: 300, height: 300)
base.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1).cgColor

let mask = CAShapeLayer()
let path = CGMutablePath()
path.move(to: CGPoint(x: 0, y: 0))
path.addLine(to: CGPoint(x: 0, y: base.frame.height))
path.addLine(to: CGPoint(x: base.frame.width, y: base.frame.height))
path.closeSubpath()

mask.path = path
base.mask = mask

let replicator = CAReplicatorLayer()
replicator.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
replicator.position = view.center
replicator.instanceCount = 4
replicator.instanceTransform = CATransform3DMakeRotation(CGFloat(M_PI/2), 0, 0, 1)
replicator.addSublayer(base)

let second = CAReplicatorLayer()
second.frame = CGRect(x: 0, y: 0, width: 600, height: 600)
second.position = view.center
second.instanceCount = 2
second.instanceTransform = CATransform3DMakeScale(-1, 1, 1)
second.addSublayer(replicator)

view.layer.addSublayer(second)

let line = CAShapeLayer()
let linePath = CGMutablePath()

linePath.addEllipse(in: CGRect(x: 5, y: 250, width: 300, height: 120))
linePath.closeSubpath()
line.path = linePath

let rotate = CABasicAnimation(keyPath: "transform.scale.x")
rotate.fromValue = 0
rotate.toValue = M_PI
rotate.repeatCount = HUGE
rotate.duration = 1.0
rotate.autoreverses = true
line.add(rotate, forKey: "transform.scale.x") 

base.addSublayer(line)





