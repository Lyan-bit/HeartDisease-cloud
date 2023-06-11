//
//  ClassificationViewModel.swift
//  Classification
//
//  Created by Lyan Alwakeel on 06/03/2023.
//

import Foundation
import Darwin
import Combine
import SwiftUI
import CoreLocation



func instanceFromJSON(typeName: String, json: String) -> AnyObject?
{ let jdata = json.data(using: .utf8)!
let decoder = JSONDecoder()
if typeName == "String"
{ let x = try? decoder.decode(String.self, from: jdata)
return x as AnyObject
}
return nil
}


class HeartDiseaseViewModel : ObservableObject {
    static var instance : HeartDiseaseViewModel? = nil
    var cdb : FirebaseDB = FirebaseDB.getInstance()
    private var modelParser : ModelParser? = ModelParser(modelFileInfo: ModelFile.modelInfo)
    //var fileSystem : FileAccessor = FileAccessor()

    static func getInstance() -> HeartDiseaseViewModel {
        if instance == nil
         { instance = HeartDiseaseViewModel()
           }
        return instance! }
                              
    init() {
        // init
    }
          
    @Published var currentHeartDisease : HeartDiseaseVO? = HeartDiseaseVO.defaultHeartDiseaseVO()
    @Published var currentHeartDiseases : [HeartDiseaseVO] = [HeartDiseaseVO]()

        func createHeartDisease(x : HeartDiseaseVO) {
            if let obj = getHeartDiseaseByPK(val: x.id)
            { cdb.persistHeartDisease(x: obj) }
            else {
            let item : HeartDisease = createByPKHeartDisease(key: x.id)
              item.id = x.getId()
              item.age = x.getAge()
              item.sex = x.getSex()
              item.cp = x.getCp()
              item.trestbps = x.getTrestbps()
              item.chol = x.getChol()
              item.fbs = x.getFbs()
              item.restecg = x.getRestecg()
              item.thalach = x.getThalach()
              item.exang = x.getExang()
              item.oldpeak = x.getOldpeak()
              item.slope = x.getSlope()
              item.ca = x.getCa()
              item.thal = x.getThal()
              item.outcome = x.getOutcome()
            cdb.persistHeartDisease(x: item)
            }
            currentHeartDisease = x
    }
            
    func cancelCreateHeartDisease() {
        //cancel function
    }
    
    func deleteHeartDisease(id : String) {
        if let obj = getHeartDiseaseByPK(val: id)
        { cdb.deleteHeartDisease(x: obj) }
    }
        
    func cancelDeleteHeartDisease() {
        //cancel function
    }
    
    func cancelEditHeartDisease() {
        //cancel function
    }

        func cancelSearchHeartDiseaseByAge() {
    //cancel function
            
        }
    
    func listHeartDisease() -> [HeartDiseaseVO] {
        currentHeartDiseases = [HeartDiseaseVO]()
        let list : [HeartDisease] = HeartDiseaseAllInstances
        for (_,x) in list.enumerated()
        { currentHeartDiseases.append(HeartDiseaseVO(x: x)) }
        return currentHeartDiseases
    }
            
    func loadHeartDisease() {
        let res : [HeartDiseaseVO] = listHeartDisease()
        
        for (_,x) in res.enumerated() {
            let obj = createByPKHeartDisease(key: x.id)
            obj.id = x.getId()
        obj.age = x.getAge()
        obj.sex = x.getSex()
        obj.cp = x.getCp()
        obj.trestbps = x.getTrestbps()
        obj.chol = x.getChol()
        obj.fbs = x.getFbs()
        obj.restecg = x.getRestecg()
        obj.thalach = x.getThalach()
        obj.exang = x.getExang()
        obj.oldpeak = x.getOldpeak()
        obj.slope = x.getSlope()
        obj.ca = x.getCa()
        obj.thal = x.getThal()
        obj.outcome = x.getOutcome()
            }
         currentHeartDisease = res.first
         currentHeartDiseases = res
    }
        
    func stringListHeartDisease() -> [String] {
        var res : [String] = [String]()
        for (_,obj) in currentHeartDiseases.enumerated()
        { res.append(obj.toString()) }
        return res
    }
            
    func searchByHeartDiseaseid(val : String) -> [HeartDiseaseVO] {
        var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
        let list : [HeartDisease] = HeartDiseaseAllInstances
        for (_,x) in list.enumerated() {
            if (x.id == val) {
                resultList.append(HeartDiseaseVO(x: x))
            }
        }
      return resultList
    }
    
    func searchByHeartDiseaseage(val : Int) -> [HeartDiseaseVO] {
        var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
        let list : [HeartDisease] = HeartDiseaseAllInstances
        for (_,x) in list.enumerated() {
            if (x.age == val) {
                resultList.append(HeartDiseaseVO(x: x))
            }
        }
      return resultList
    }
    
    func searchByHeartDiseasesex(val : Int) -> [HeartDiseaseVO] {
        var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
        let list : [HeartDisease] = HeartDiseaseAllInstances
        for (_,x) in list.enumerated() {
            if (x.sex == val) {
                resultList.append(HeartDiseaseVO(x: x))
            }
        }
      return resultList
    }
    
    func searchByHeartDiseasecp(val : Int) -> [HeartDiseaseVO] {
        var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
        let list : [HeartDisease] = HeartDiseaseAllInstances
        for (_,x) in list.enumerated() {
            if (x.cp == val) {
                resultList.append(HeartDiseaseVO(x: x))
            }
        }
      return resultList
    }
    
    func searchByHeartDiseasetrestbps(val : Int) -> [HeartDiseaseVO] {
        var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
        let list : [HeartDisease] = HeartDiseaseAllInstances
        for (_,x) in list.enumerated() {
            if (x.trestbps == val) {
                resultList.append(HeartDiseaseVO(x: x))
            }
        }
      return resultList
    }
    
    func searchByHeartDiseasechol(val : Int) -> [HeartDiseaseVO] {
        var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
        let list : [HeartDisease] = HeartDiseaseAllInstances
        for (_,x) in list.enumerated() {
            if (x.chol == val) {
                resultList.append(HeartDiseaseVO(x: x))
            }
        }
      return resultList
    }
    
    func searchByHeartDiseasefbs(val : Int) -> [HeartDiseaseVO] {
        var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
        let list : [HeartDisease] = HeartDiseaseAllInstances
        for (_,x) in list.enumerated() {
            if (x.fbs == val) {
                resultList.append(HeartDiseaseVO(x: x))
            }
        }
      return resultList
    }
    
    func searchByHeartDiseaserestecg(val : Int) -> [HeartDiseaseVO] {
        var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
        let list : [HeartDisease] = HeartDiseaseAllInstances
        for (_,x) in list.enumerated() {
            if (x.restecg == val) {
                resultList.append(HeartDiseaseVO(x: x))
            }
        }
      return resultList
    }
    
    func searchByHeartDiseasethalach(val : Int) -> [HeartDiseaseVO] {
        var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
        let list : [HeartDisease] = HeartDiseaseAllInstances
        for (_,x) in list.enumerated() {
            if (x.thalach == val) {
                resultList.append(HeartDiseaseVO(x: x))
            }
        }
      return resultList
    }
    
    func searchByHeartDiseaseexang(val : Int) -> [HeartDiseaseVO] {
        var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
        let list : [HeartDisease] = HeartDiseaseAllInstances
        for (_,x) in list.enumerated() {
            if (x.exang == val) {
                resultList.append(HeartDiseaseVO(x: x))
            }
        }
      return resultList
    }
    
    func searchByHeartDiseaseoldpeak(val : Int) -> [HeartDiseaseVO] {
        var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
        let list : [HeartDisease] = HeartDiseaseAllInstances
        for (_,x) in list.enumerated() {
            if (x.oldpeak == val) {
                resultList.append(HeartDiseaseVO(x: x))
            }
        }
      return resultList
    }
    
    func searchByHeartDiseaseslope(val : Int) -> [HeartDiseaseVO] {
        var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
        let list : [HeartDisease] = HeartDiseaseAllInstances
        for (_,x) in list.enumerated() {
            if (x.slope == val) {
                resultList.append(HeartDiseaseVO(x: x))
            }
        }
      return resultList
    }
    
    func searchByHeartDiseaseca(val : Int) -> [HeartDiseaseVO] {
        var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
        let list : [HeartDisease] = HeartDiseaseAllInstances
        for (_,x) in list.enumerated() {
            if (x.ca == val) {
                resultList.append(HeartDiseaseVO(x: x))
            }
        }
      return resultList
    }
    
    func searchByHeartDiseasethal(val : Int) -> [HeartDiseaseVO] {
        var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
        let list : [HeartDisease] = HeartDiseaseAllInstances
        for (_,x) in list.enumerated() {
            if (x.thal == val) {
                resultList.append(HeartDiseaseVO(x: x))
            }
        }
      return resultList
    }
    
    func searchByHeartDiseaseoutcome(val : String) -> [HeartDiseaseVO] {
        var resultList: [HeartDiseaseVO] = [HeartDiseaseVO]()
        let list : [HeartDisease] = HeartDiseaseAllInstances
        for (_,x) in list.enumerated() {
            if (x.outcome == val) {
                resultList.append(HeartDiseaseVO(x: x))
            }
        }
      return resultList
    }
    
        
    func getHeartDiseaseByPK(val: String) -> HeartDisease?
        { return HeartDisease.heartDiseaseIndex[val] }
            
    func retrieveHeartDisease(val: String) -> HeartDisease?
            { return HeartDisease.heartDiseaseIndex[val] }
            
    func allHeartDiseaseids() -> [String] {
            var res : [String] = [String]()
            for (_,item) in currentHeartDiseases.enumerated()
            { res.append(item.id + "") }
            return res
    }
            
    func setSelectedHeartDisease(x : HeartDiseaseVO)
        { currentHeartDisease = x }
            
    func setSelectedHeartDisease(i : Int) {
        if i < currentHeartDiseases.count
        { currentHeartDisease = currentHeartDiseases[i] }
    }
            
    func getSelectedHeartDisease() -> HeartDiseaseVO?
        { return currentHeartDisease }
            
    func persistHeartDisease(x : HeartDisease) {
        let vo : HeartDiseaseVO = HeartDiseaseVO(x: x)
        cdb.persistHeartDisease(x: x)
        currentHeartDisease = vo
    }
        
    func editHeartDisease(x : HeartDiseaseVO) {
        if let obj = getHeartDiseaseByPK(val: x.id) {
         obj.id = x.getId()
         obj.age = x.getAge()
         obj.sex = x.getSex()
         obj.cp = x.getCp()
         obj.trestbps = x.getTrestbps()
         obj.chol = x.getChol()
         obj.fbs = x.getFbs()
         obj.restecg = x.getRestecg()
         obj.thalach = x.getThalach()
         obj.exang = x.getExang()
         obj.oldpeak = x.getOldpeak()
         obj.slope = x.getSlope()
         obj.ca = x.getCa()
         obj.thal = x.getThal()
         obj.outcome = x.getOutcome()
        cdb.persistHeartDisease(x: obj)
        }
        currentHeartDisease = x
    }
            
    }

