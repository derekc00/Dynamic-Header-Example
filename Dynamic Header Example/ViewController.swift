//
//  ViewController.swift
//  Dynamic Header Example
//
//  Created by Derek Chang on 8/5/20.
//  Copyright © 2020 Derek Chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    
    var statusBarFrame: CGRect!
    var statusBarView: UIView!
    var offset: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //header view begins under the navigation bar
        scrollView.contentInsetAdjustmentBehavior = .never
        
        //set the navigation bar to a transparent background
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
       
        scrollView.delegate = self
        
        //get height of status bar
        if #available(iOS 13.0, *) {
            statusBarFrame = UIApplication.shared.windows[0].windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            // Fallback on earlier versions
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        
        //set status bar with white text
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black

        
        statusBarView = UIView(frame: statusBarFrame)
        statusBarView.isOpaque = false
        statusBarView.backgroundColor = .clear
        view.addSubview(statusBarView)
    }

    //called everytime the scrollView scrolls
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        //Mark the end of the offset
        let targetHeight = headerView.bounds.height - (navigationController?.navigationBar.bounds.height)! - statusBarFrame.height
        
        //calculate how much has been scrolled relative to the targetHeight
        offset = scrollView.contentOffset.y / targetHeight
        
//        print(String(describing: targetHeight), String(describing: offset))
        
        //cap offset to 1 to conform to UIColor alpha parameter
        if offset > 1 {offset = 1}
        
        if offset > 0.5 {
            self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        } else {
            self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        }
        
        
        let clearToWhite = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
        let whiteToBlack = UIColor(hue: 1, saturation: 0, brightness: 1-offset, alpha: 1 )
        self.navigationController?.navigationBar.tintColor = whiteToBlack
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : whiteToBlack]
        
        self.navigationController?.navigationBar.backgroundColor = clearToWhite
        
        statusBarView!.backgroundColor = clearToWhite
    }
    
    
}

