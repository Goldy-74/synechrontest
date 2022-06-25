//
//  PetDetailsVC.swift
//  Veterinary
//
//  Created by Apple on 25/06/22.
//

import UIKit
import WebKit

class PetDetailsVC: UIViewController {

    //MARK:- IBOutlet(s)
    @IBOutlet weak var webView: WKWebView?
    
    //MARK:- Var(s)
    var petData: Pet?
    
    //MARK:- Life Cycle Method(s)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadContentInWebView()
    }
}

//MARK: - Private Method(s)
extension PetDetailsVC {
    private func loadContentInWebView(){
        guard let petData = petData, let contentURL = URL(string: petData.contentURL) else {
            return
        }
        let request = URLRequest(url: contentURL)
        self.webView?.load(request)
    }
}

//MARK: - Action Method(s)
extension PetDetailsVC {
    @IBAction func btnCloseAction(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}
