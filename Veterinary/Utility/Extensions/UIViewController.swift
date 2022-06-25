//
//  UIViewController.swift
//  Veterinary
//
//  Created by Apple on 25/06/22.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlertWith(_ msg: String){
        let alert = UIAlertController(title: "Alert!", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
