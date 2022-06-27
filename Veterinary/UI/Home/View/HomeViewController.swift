//
//  ViewController.swift
//  Veterinary
//
//  Created by Apple on 25/06/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK:- IBOutlet(s)
    
    @IBOutlet weak var btnChat: UIButton?
    @IBOutlet weak var btnCall: UIButton?
    @IBOutlet weak var lblOfficeHours: UILabel?
    @IBOutlet weak var tblPetList: UITableView?
    
    var viewModel: HomeViewModel?
    
    //MARK:- Life Cycle Method(s)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetUp()
    }
}

//MARK:-  Private Method(s)
extension HomeViewController {
    
    private func initialSetUp(){
        self.addViewModelSubscribers()
        self.callWebServiceForGetConfiguration()
    }
    
    private func addViewModelSubscribers(){
        
        self.viewModel = HomeViewModel()
        
        self.viewModel?.arrPets.bind(listener: { [weak self] pets in
            SharedApp.shared.hideLoader()
            if let arrPets = pets, !arrPets.isEmpty {
                self?.tblPetList?.reloadData()
            }
        })
        
        self.viewModel?.configurationSettings.bind(listener: { [weak self] setting in
            SharedApp.shared.hideLoader()
            if let configSetting = setting{
                
                self?.lblOfficeHours?.text = String(format: MessageConstant.workingHoursPlaceholder.rawValue, "\(configSetting.workHours)")
                
                self?.btnChat?.isHidden = !configSetting.isChatEnabled
                self?.btnCall?.isHidden = !configSetting.isCallEnabled
                
                self?.callWebServiceForGetPetList()
                
            }
        })
    }
}

//MARK:-  Action Method(s)
extension HomeViewController {
    
    @IBAction func btnChatAction(_ sender: UIButton){
        let msg = self.viewModel?.isInWorkingHours() == true ? MessageConstant.withinWorkingHourDesc.rawValue : MessageConstant.notInWorkingHourDesc.rawValue
        self.showAlertWith(msg)
    }
    
    @IBAction func btnCallAction(_ sender: UIButton){
        let msg = self.viewModel?.isInWorkingHours() == true ? MessageConstant.withinWorkingHourDesc.rawValue : MessageConstant.notInWorkingHourDesc.rawValue
        self.showAlertWith(msg)
    }
    
}

//MARK:- UITableView DataSource Method(s)
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.arrPets.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PetCell = tableView.dequeueReusableCell(withIdentifier: PetCell.className, for: indexPath) as! PetCell
        let petData = self.viewModel?.arrPets.value?[indexPath.row]
        cell.data = petData
        return cell
    }
}

//MARK:- UITableView DataSource Method(s)
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let petDetailsVC: PetDetailsVC = SharedApp.shared.loadViewController(storyBoard: .Main){
            petDetailsVC.petData = self.viewModel?.arrPets.value?[indexPath.row]
            self.present(petDetailsVC, animated: true, completion: nil)
        }
    }
}

//MARK:- API Call(s)
extension HomeViewController {
    private func callWebServiceForGetConfiguration(){
        SharedApp.shared.showLoader()
        self.viewModel?.callWebServiceForGetConfiguration()
    }
    
    private func callWebServiceForGetPetList(){
        SharedApp.shared.showLoader()
        self.viewModel?.callWebServiceForGetPetList()
    }
}

