//
//  CustomImageView.swift
//  Veterinary
//
//  Created by Apple on 25/06/22.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImage: UIImageView {
    

    var imageURL: URL?

    let activityIndicator = UIActivityIndicatorView()

    func loadImageWithUrl(_ strUrl: String) {
        guard let url: URL = URL(string: strUrl) else {return}
        // setup activityIndicator...
        activityIndicator.color = .darkGray

        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        imageURL = url

        image = nil
        activityIndicator.startAnimating()

        // retrieves image if already available in cache
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {

            self.image = imageFromCache
            activityIndicator.stopAnimating()
            return
        }

        // image does not available in cache.. so retrieving it from url...
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in

            if error != nil {
                print(error as Any)
                DispatchQueue.main.async(execute: {[weak self] in
                    self?.activityIndicator.stopAnimating()
                })
                return
            }

            DispatchQueue.main.async(execute: {[weak self] in

                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {

                    if self?.imageURL == url {
                        self?.image = imageToCache
                    }

                    imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
                self?.activityIndicator.stopAnimating()
            })
        }).resume()
    }
}
