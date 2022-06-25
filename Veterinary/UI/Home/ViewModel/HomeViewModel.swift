//
//  HomeViewModel.swift
//  Veterinary
//
//  Created by Apple on 25/06/22.
//

import Foundation

class HomeViewModel {
    //MARK:- Var(s)
    var arrPets: GenericViewModel<[Pet]?> = GenericViewModel(nil)
    var configurationSettings: GenericViewModel<Settings?> = GenericViewModel(nil)
    var serverError: GenericViewModel<String?> = GenericViewModel(nil)
}

extension HomeViewModel {
    func isInWorkingHours() -> Bool{
        
        let workingHours = configurationSettings.value?.workHours ?? ""
        
        let currentDate = Date().localDate()
        let arrAvailbleTime = workingHours.components(separatedBy: " ").filter({$0.contains(":")})
        let initialTime = arrAvailbleTime.first
        let initialHour: Int = Int(initialTime?.components(separatedBy: ":").first ?? "0") ?? 0
        let initialMin: Int = Int(initialTime?.components(separatedBy: ":").last ?? "0") ?? 0
        
        let endTime = arrAvailbleTime.last
        let endHour: Int = Int(endTime?.components(separatedBy: ":").first ?? "0") ?? 0
        let endMin = Int(endTime?.components(separatedBy: ":").last ?? "0") ?? 0

        
        if let initialDate = currentDate.setTime(hour: initialHour, min: initialMin), let endDate = currentDate.setTime(hour: endHour, min: endMin){
            return currentDate.isBetween(initialDate, and: endDate)
        }
        
        return false
    }
}

//MARK:- Rest API(s)
extension HomeViewModel {
    
    //Getting Pet List
    func callWebServiceForGetPetList() {
        SharedApp.shared.showLoader()
        APIManager.shared.callService(endPoint: .getPets) {[weak self] (response: PetResponseModel) in
            SharedApp.shared.hideLoader()
            DispatchQueue.main.async { [weak self] in
                self?.arrPets.value = response.pets
            }
        } fail: {[weak self] msg in
            DispatchQueue.main.async { [weak self] in
                self?.serverError.value = msg
            }
        }
        
    }
    
    //Getting Configuration
    func callWebServiceForGetConfiguration() {
        SharedApp.shared.showLoader()
        APIManager.shared.callService(endPoint: .getConfiguration) {[weak self] (response: Configuration) in
            SharedApp.shared.hideLoader()
            DispatchQueue.main.async { [weak self] in
                self?.configurationSettings.value = response.settings
            }
        } fail: {[weak self] msg in
            DispatchQueue.main.async { [weak self] in
                self?.serverError.value = msg
            }
        }
        
    }
}
