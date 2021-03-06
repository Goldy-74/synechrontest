//
//  Loader.swift
//  Veterinary
//
//  Created by Apple on 25/06/22.
//

import Foundation
import UIKit
public class LoadingOverlay {

    var overlayView : UIView!
    var activityIndicator : UIActivityIndicatorView!

    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }

    init(){
        self.overlayView = UIView()
        self.activityIndicator = UIActivityIndicatorView()

        overlayView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        overlayView.backgroundColor = .clear
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        overlayView.layer.zPosition = 1

        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.color = .gray
        overlayView.addSubview(activityIndicator)
    }

    public func showOverlay(view: UIView) {
        DispatchQueue.main.async {[weak self] in
            if let overlayView = self?.overlayView{
                overlayView.center = view.center
                view.addSubview(overlayView)
                self?.activityIndicator.startAnimating()
                view.isUserInteractionEnabled = false
            }
        }
    }

    public func hideOverlayView() {
        DispatchQueue.main.async {[weak self] in
            self?.activityIndicator.stopAnimating()
            self?.overlayView.superview?.isUserInteractionEnabled = true
            self?.overlayView.removeFromSuperview()
            self?.overlayView.isUserInteractionEnabled = true
        }
    }
}
