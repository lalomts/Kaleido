import Foundation
import UIKit

/// A layer that masks and applys several transforms to a layer, and turns it into a square kaleidoscopic view.
public class KaleidoLayer: CAReplicatorLayer {
  
  public init(referenceLayer: CALayer) {
    
    let size = referenceLayer.frame.size
    
    let mask = CAShapeLayer()
    let trianglePath = CGMutablePath()
    trianglePath.move(to: CGPoint(x: 0, y: 0))
    trianglePath.addLine(to: CGPoint(x: 0, y: size.height))
    trianglePath.addLine(to: CGPoint(x: size.width, y: size.height))
    trianglePath.closeSubpath()
    
    mask.path = trianglePath
    referenceLayer.mask = mask

    let fan = CAReplicatorLayer()
    fan.frame = CGRect(x: size.width / 2, y: size.height / 2, width: size.width, height: size.height)
    fan.instanceCount = 4
    fan.instanceTransform = CATransform3DMakeRotation(CGFloat(M_PI/2), 0, 0, 1)
    fan.addSublayer(referenceLayer)
    
    super.init()
    self.frame = CGRect(x: 0, y: 0, width: size.width * 2, height: size.height * 2)
    self.instanceCount = 2
    self.instanceTransform = CATransform3DMakeScale(-1, 1, 1)
    self.addSublayer(fan)

  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
