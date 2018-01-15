//
//  AddressPickerView.swift
//  ZYPickerView
//
//  Created by 杨志远 on 2018/1/15.
//  Copyright © 2018年 BaQiWL. All rights reserved.
//

import UIKit

struct Province {
    var name : String
}
struct City {
    var name : String
}
struct Area {
    var name : String
}


class AddressPickerView: ZYPickerView {
    
    var dataSource : Array<Dictionary<String,Any>>! {
        didSet {
            fetchProvince()
        }
    }
    lazy var provinceArray : [String] = []
    lazy var cityArray  : [String] = []
    lazy var areaArray : [String] = []
    
    var selectedProvince : Int = 0
    var selectedCity : Int = 0
    var selectedArea : Int = 0
    //MARK:Show
    static func showAddress(doneAction : @escaping DoneAction) {
        let addressPickerView = AddressPickerView(frame: UIScreen.main.bounds)
        
        addressPickerView.doneAction = doneAction
        addressPickerView.loadPlist()
        addressPickerView.fetch(provinceIndex: addressPickerView.selectedProvince, cityIndex: addressPickerView.selectedCity, areaIndex: addressPickerView.selectedArea)
        
        addressPickerView.picker.reloadAllComponents()
    }
    
    fileprivate lazy var picker : UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return picker
    }()
    override var inputView: UIView? {
        get {
            return self.picker
        }
    }
    
    //MARK:完成按钮点击事件
    override func rightButtonClicked() {
        self.hide()
        if doneAction != nil {
            selectedValue = [
                PickerIndexPath(component: 0, row: selectedProvince, value: provinceArray[selectedProvince]),
                PickerIndexPath(component: 1, row: selectedCity, value: cityArray[selectedCity]),
                PickerIndexPath(component: 2, row: selectedArea, value: areaArray[selectedArea])]
            doneAction!(selectedValue)
        }
    }
    
    func loadPlist() {
        let path = Bundle.main.path(forResource: "city", ofType: "plist")
        let array = NSArray(contentsOfFile: path!) as! Array<Dictionary<String,Any>>
        dataSource = array
    }
    
    func fetch(provinceIndex : Int = 0,cityIndex : Int = 0,areaIndex : Int = 0) {
        fetchCity(use: provinceIndex)
        fetchArea(use: provinceIndex, cityIndex: cityIndex)
    }
    
    func fetchProvince() {
        var temp = [String]()
        for provinceD in dataSource {
            for key in provinceD.keys {
                temp.append(key)
            }
        }
        provinceArray = temp
    }
    
    func fetchCity(use provinceIndex : Int) {
        let cityDic = dataSource[provinceIndex][provinceArray[provinceIndex]] as! Dictionary<String,Dictionary<String,Any>>
        var temp = [String]()
        for cityValue in cityDic.values {
            for key in cityValue.keys {
                temp.append(key)
            }
        }
        cityArray = temp
    }
    
    func fetchArea(use provinceIndex: Int,cityIndex: Int) {
        let cityDic = dataSource[provinceIndex][provinceArray[provinceIndex]] as! Dictionary<String,Dictionary<String,Any>>
        let areaDic = Array(cityDic.values)[cityIndex]
        let array = areaDic[cityArray[cityIndex]]
        areaArray = array as! [String]
    }
    
    func reloadPicker(_ row: Int,in component: Int) {
        self.picker.reloadComponent(component)
        self.picker.selectRow(row, inComponent: component, animated: true)
    }
    
    
//end
}

//MARK: UIPickerViewDataSource,UIPickerViewDelegate
extension AddressPickerView : UIPickerViewDataSource,UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return provinceArray.count
        case 1:
            return cityArray.count
        case 2:
            return areaArray.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return provinceArray[row]
        case 1:
            return cityArray[row]
        case 2:
            return areaArray[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            selectedProvince = row
            
            fetchCity(use: selectedProvince)
            fetchArea(use: selectedProvince, cityIndex: 0)
            
            picker.reloadComponent(1)
            picker.selectRow(0, inComponent: 1, animated: true)
            picker.reloadComponent(2)
            picker.selectRow(0, inComponent: 2, animated: true)
            
        }else if component == 1 {
            selectedCity = row
            fetchArea(use: selectedProvince, cityIndex: selectedCity)
            picker.reloadComponent(2)
            picker.selectRow(0, inComponent: 2, animated: true)
        }else{
            selectedArea = row
        }
//        selectedValue[component].component = component
//        selectedValue[component].row = row
//        
    }
    
//end
}


