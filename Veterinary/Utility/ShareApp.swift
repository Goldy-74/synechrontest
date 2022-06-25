//
//  ShareApp.swift
//  Veterinary
//
//  Created by Apple on 25/06/22.
//

import Foundation
import UIKit

extension NSObject {
    class var className: String {
        return "\(self)"
    }
}

enum StoryBoard: String {
    case Main
    
    var storyboard: UIStoryboard{
        return UIStoryboard(name: self.rawValue, bundle: .main)
    }
}

class SharedApp{
    
    static let shared = SharedApp()
    
    private init() {}
    
    //Getting View Controllers
    func loadViewController<T: UIViewController>(storyBoard: StoryBoard) -> T?{
        let vc: T = storyBoard.storyboard.instantiateViewController(identifier: T.className) as! T
        return vc
    }
    
    //Show Loader
    func showLoader(){
        if let keyWindow = UIApplication.shared.windows.first{
            LoadingOverlay.shared.showOverlay(view: keyWindow)
        }
    }
    
    func hideLoader(){
        LoadingOverlay.shared.hideOverlayView()
    }
}
