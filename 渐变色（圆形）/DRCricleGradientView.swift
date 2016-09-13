//
//  DRCricleGradientView.swift
//  渐变色（圆形）
//
//  Created by xqzh on 16/9/13.
//  Copyright © 2016年 xqzh. All rights reserved.
//

import UIKit

class DRCricleGradientView: UIView {
  
  private var backgroundLayer:CAShapeLayer!
  private var gradientLayer1:CAGradientLayer!
  private var gradientLayer2:CAGradientLayer!
  private var colors:NSMutableArray!
  
  // 圆环宽度
  var width:CGFloat {
    didSet {
      backgroundLayer.lineWidth = width
    }
  }
  
  override init(frame: CGRect) {
    width = 5
    super.init(frame: frame)
    
    backgroundLayer = CAShapeLayer()
    gradientLayer1  =  CAGradientLayer()
    gradientLayer2  =  CAGradientLayer()
    
    // 添加渐变的颜色组合
    colors = NSMutableArray()
    var hue = 0
    for _ in 0...360 {
      if hue > 360 {
        break
      }
      let color:UIColor
      color = UIColor(hue: 1.0 * CGFloat(hue) / 360.0, saturation: 1.0, brightness: 1.0, alpha: 1.0)
      colors.addObject(color.CGColor)
      hue += 5
    }
    
    self.layer.addSublayer(circleShape())
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  func circleShape() -> CALayer {
    // 画圆
    let arcCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    let radius:CGFloat = self.bounds.width / 2.0 - 5
    let circlePath = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: CGFloat(M_PI), endAngle: CGFloat(-M_PI), clockwise: false)
    
    backgroundLayer.path = circlePath.CGPath;
    backgroundLayer.strokeColor = UIColor.lightGrayColor().CGColor
    backgroundLayer.fillColor = UIColor.clearColor().CGColor
    backgroundLayer.lineWidth = width
    
    // 方形光谱
    let gradientLayer = CALayer()
    gradientLayer1.frame = CGRectMake(0, CGRectGetMidY(self.bounds) - radius - 5, self.bounds.width/2, self.bounds.width);
    gradientLayer1.colors = colors as [AnyObject]
    //gradientLayer1.locations = [0.5,0.9,1]
    gradientLayer1.startPoint = CGPointMake(0.5, 1.0)
    gradientLayer1.endPoint = CGPointMake(0.5, 0.0)
    gradientLayer.addSublayer(gradientLayer1)
    //gradientLayer2.locations = [0.1,0.5,1]
    gradientLayer2.frame = CGRectMake(self.bounds.width/2, CGRectGetMidY(self.bounds) - radius - 5, self.bounds.width/2, self.bounds.width);
    gradientLayer2.colors = colors as [AnyObject]
    gradientLayer2.startPoint = CGPointMake(0.5, 0.0)
    gradientLayer2.endPoint = CGPointMake(0.5, 1.0)
    gradientLayer.addSublayer(gradientLayer2)
    
    // 截取渐变层
    gradientLayer.mask = backgroundLayer //用progressLayer来截取渐变层
    
    // 光谱动画
    let colorArray = NSMutableArray(array: colors)
    let lastColor = colorArray.lastObject!
    colorArray.removeLastObject()
    
    
    colorArray.insertObject(lastColor, atIndex: 0)
    
    let shiftedColors = NSArray(array: colorArray)
    gradientLayer1.colors = shiftedColors as [AnyObject]
    gradientLayer2.colors = shiftedColors as [AnyObject]
    let animation = CABasicAnimation(keyPath: "gavin_colors")
    animation.toValue = shiftedColors
    animation.duration = 0.02
    animation.fillMode = kCAFillModeForwards
    animation.delegate = self
    gradientLayer1.addAnimation(animation, forKey: "gavin_animateGradient")
    
//    let animation1 = CABasicAnimation(keyPath: "gavin_colors_1")
//    animation1.toValue = shiftedColors
//    animation1.duration = 0.02
//    animation1.fillMode = kCAFillModeBoth
//    animation1.delegate = self
//    gradientLayer2.addAnimation(animation1, forKey: "gavin_animateGradient_1")
    
    
    return gradientLayer
  }
  
}

var i:CGFloat = 0.0
extension DRCricleGradientView {
  
  override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
    // 颜色调整
    let colorArray = NSMutableArray(array: gradientLayer1.colors!)
    let lastColor = colorArray.lastObject!
    colorArray.removeLastObject()
    colorArray.insertObject(lastColor, atIndex: 0)
    let shiftedColors = NSArray(array: colorArray)
    
    gradientLayer1.colors = shiftedColors as [AnyObject]
    gradientLayer2.colors = shiftedColors as [AnyObject]
    
    // 动画
    let animation = CABasicAnimation(keyPath: "gavin_colors")
    animation.toValue = shiftedColors
    animation.duration = 0.02
    animation.fillMode = kCAFillModeForwards
    animation.delegate = self
    gradientLayer1.addAnimation(animation, forKey: "gavin_animateGradient")
    
    
//    let animation1 = CABasicAnimation(keyPath: "gavin_colors_1")
//    animation1.toValue = shiftedColors
//    animation1.duration = 0.02
//    animation1.fillMode = kCAFillModeBoth
//    animation1.delegate = self
//    gradientLayer2.addAnimation(animation1, forKey: "gavin_animateGradient_1")
    
    // 增加 进度模式
//    let maskLayer = CALayer()
//    maskLayer.frame = CGRectMake(0.0, 0.0, 0.0, 2.0)
//    maskLayer.backgroundColor = UIColor.blackColor().CGColor
//    gradientLayer1.mask = maskLayer
//    gradientLayer2.mask = maskLayer
//    
//    var maskRect = maskLayer.frame
//    maskRect.size.width = CGRectGetWidth(self.bounds) * i
//    maskLayer.frame = maskRect
    
//    i += 0.01
  }
}

