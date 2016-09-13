//
//  ViewController.swift
//  渐变色（圆形）
//
//  Created by xqzh on 16/9/13.
//  Copyright © 2016年 xqzh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let cricle = DRCricleGradientView(frame: CGRectMake((self.view.bounds.width - 100) / 2.0, (self.view.bounds.height - 100) / 2.0, 100, 100))
    self.view.addSubview(cricle)
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

