//: Playground - noun: a place where people can play

import UIKit
import AVFoundation
import PlaygroundSupport


let view = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 400))
view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
PlaygroundPage.current.liveView = view

let main = UIView()
main.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
main.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

let kaleido = KaleidoLayer(referenceLayer: main.layer)

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

//:1st Kaleido Element
let elm1 = UIView(frame: CGRect(x: -20, y: -20 , width: 60, height: 15))
elm1.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.8274509804, blue: 0.2509803922, alpha: 1)
elm1.transform = CGAffineTransform(rotationAngle: CGFloat(160  * M_PI/180))

UIView.animate(withDuration: 12, delay: 6, options: [.repeat, .curveEaseOut], animations: {
  elm1.frame.origin = CGPoint(x: 45, y: 120)
}, completion: nil)

//: 2nd Element
let elm2 = UIView(frame: CGRect(x: 50, y: 120, width: 70, height: 25))
elm2.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.1254901961, blue: 0.2901960784, alpha: 1)

UIView.animate(withDuration: 8, delay: 3.2, options:  [.repeat, .curveEaseInOut], animations: {
  elm2.frame.origin = CGPoint(x: -45, y: -25)
  elm2.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI * 9 ))
}, completion: nil)

//: 3rd Element
let elm3 = UIView(frame: CGRect(x: 38, y: 38, width: 25, height: 25))
elm3.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.8431372549, blue: 0.07058823529, alpha: 1)

let an1 = CABasicAnimation(keyPath: "transform")
an1.fromValue = CATransform3DMakeScale(0, 0, 0)
an1.toValue = CATransform3DMakeScale(6, 3, 1)

let an2 = CABasicAnimation(keyPath: "transform.rotation.z")
an2.fromValue = CATransform3DIdentity
an2.toValue = CATransform3DMakeRotation(CGFloat(M_PI/5), 0, 0, 1)

let gp2 = CAAnimationGroup()
gp2.animations = [an1, an2]
gp2.duration = 9 
gp2.autoreverses = true
gp2.repeatCount = HUGE
gp2.fillMode = kCAFillModeForwards
gp2.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
elm3.layer.add(gp2, forKey: "grow and rotate")

//4th element 
let elm4 = UIView(frame: CGRect(x: 10, y: 110, width: 80, height: 35))
elm4.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)

UIView.animate(withDuration: 15, delay: 2, options:  [.repeat, .curveEaseOut], animations: {
  elm4.frame.origin.y = -100
  elm4.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
}, completion: nil)

//5th element
let elm5 = UIView(frame: CGRect(x: -80, y: 20, width: 40, height: 65))
elm5.backgroundColor = #colorLiteral(red: 0.1761738379, green: 0.1761738379, blue: 0.1761738379, alpha: 1)

UIView.animate(withDuration: 12, delay: 1, options:  [.repeat,.autoreverse], animations: {
  elm5.frame.origin =
    CGPoint(x: 100, y: 56)
}, completion: nil)

let an3 = CABasicAnimation(keyPath: "transform.rotation.z")
an3.fromValue = CATransform3DIdentity
an3.toValue = CATransform3DMakeRotation(CGFloat(M_PI*2), 0, 0, 1)
an3.duration = 10
an3.autoreverses = true
an3.repeatCount = HUGE
elm5.layer.add(an3, forKey: "rotation")

//6th element
let elm6 = UIView(frame: CGRect(x: 70, y: 0, width: 70, height: 70))
  elm6.backgroundColor = #colorLiteral(red: 0.2234301561, green: 0.5110359363, blue: 0.9686274529, alpha: 1)

UIView.animate(withDuration: 15, delay: 5, options:  [.repeat, .autoreverse], animations: {
  
  elm6.transform = CGAffineTransform(translationX: -70, y: 50)
  
}, completion: nil)

main.addSubview(elm6)
main.addSubview(elm3)
main.addSubview(elm5)
main.addSubview(elm2)
main.addSubview(elm4)
main.addSubview(elm1)

// Mark: - Player
var player: AVAudioPlayer?

guard let songURL = Bundle.main.url(forResource: "fractal", withExtension: "mp3") else {
  fatalError("audio file is not in bundle.")
}
do {
  
  player = try AVAudioPlayer(contentsOf: songURL)
  guard let player = player else { fatalError("Failed to load player") }
  player.play()
  
  player.isMeteringEnabled = true
  player.prepareToPlay()
  player.play()
  
  Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (_) in
    
    player.updateMeters()
    let logPeak = player.peakPower(forChannel: 0)
    let logAverage = player.averagePower(forChannel: 0)
          
    let linearPeak = pow(10.0, logPeak/20.0)
    let linearAverage = pow(10.0, logAverage/20.0)
          
          
    if linearPeak >= 0.55 {
      elm4.backgroundColor = UIColor(hue: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), saturation: 0.7, brightness: 0.7, alpha: 1.0)
      elm3.backgroundColor = UIColor(hue: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), saturation: 0.7, brightness: 0.7, alpha: 1.0)
      elm6.backgroundColor = UIColor(hue: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), saturation: 0.7, brightness: 0.7, alpha: 1.0)
          }
        })
  
} catch {
  fatalError("Could not play file")
}



