//
//  StringPickerView.swift
//  ZYPickerView
//
//  Created by 杨志远 on 2018/1/5.
//  Copyright © 2018年 BaQiWL. All rights reserved.
//

import UIKit


class StringPickerView: ZYPickerView {
    typealias AssociatedRowDataType = [[String: [String]?]]

    enum PickerDataSourceType {
        case singleRowData(_ : [String],defaultIndex: Int?)
        case multiRowData(_ : [[String]],defaultIndexs: [Int]?)
        case associatedRowData(_ : AssociatedRowDataType,defaultIndexs: [Int]?)
    }
    
    lazy var isSingleRowData = false
    lazy var isMultiRowData  = false
    lazy var isAssociatedRowData = false

//    lazy var isAssociatedTwoRowData = false
//    lazy var isAssociatedThreeRowData = false

    var singleRowData   : [String]! {
        didSet {
            isSingleRowData = true
            self.picker.reloadAllComponents()
        }
    }
    var multiRowData    : [[String]]! {
        didSet {
            isMultiRowData = true
            self.picker.reloadAllComponents()
        }
    }
//    var associatedTwoRowData : AssociatedTwoRowDataType! {
//        didSet {
//            isAssociatedTwoRowData = true
//            self.picker.reloadAllComponents()
//        }
//    }
    var associatedRowData : AssociatedRowDataType! {
        didSet {
            isAssociatedRowData = true
            self.picker.reloadAllComponents()
        }
    }
    
    var selectedValue : [PickerIndexPath] = [PickerIndexPath(component: 0,row: 0, value: "")]
    
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

    convenience init(frame: CGRect,singleRowData:[String],default index : Int? = nil,doneAction : @escaping DoneAction) {
        self.init(frame: frame)
        show(singleRowData: singleRowData, default: index, doneAction: doneAction)
    }
    convenience init(frame: CGRect,multiRowData:[[String]],default indexs : [Int]? = nil,doneAction : @escaping DoneAction) {
        self.init(frame: frame)
        show(mutliRowData: multiRowData, default: indexs, doneAction: doneAction)
    }
    
    convenience init(frame: CGRect,associatedRowData:AssociatedRowDataType,default indexs : [Int]? = nil,doneAction : @escaping DoneAction) {
        self.init(frame: frame)
        show(associatedRowData: associatedRowData, default: indexs,doneAction: doneAction)
    }
//    convenience init(frame: CGRect,associatedRowData:Array<Dictionary<String,Array<Dictionary<String,String?>>>>,default indexs : [Int]? = nil,doneAction : @escaping DoneAction) {
//        self.init(frame: frame)
//        show(associatedRowData: associatedRowData, default: indexs,doneAction: doneAction)
//    }
    
    static func show(dataSource : PickerDataSourceType,doneAction : @escaping DoneAction) {
        let frame = UIScreen.main.bounds
        switch dataSource {
        case .singleRowData(let single,let index):
            _ = StringPickerView(frame: frame, singleRowData: single, default: index, doneAction: doneAction)
//            stringPickerView.show(singleRowData: single, default: index, doneAction: doneAction)
        case .multiRowData(let multi,let indexs) :
            _ = StringPickerView(frame: frame, multiRowData: multi, default: indexs, doneAction: doneAction)
//            stringPickerView.show(mutliRowData: multi, default: indexs, doneAction: doneAction)
        case .associatedRowData(let associated,let indexs):
        
            assert(!associated.isEmpty, "associated dataSource为空")
            _ = StringPickerView(frame: frame, associatedRowData: associated, default: indexs, doneAction: doneAction)
        }

    }
    
    func show(singleRowData:[String],default index : Int? = nil,doneAction : @escaping DoneAction) {
        assert(!singleRowData.isEmpty, "数组为空")
        let hasDefaultIndex : Bool = index != nil
        if hasDefaultIndex {
            assert(singleRowData.count > index!,"默认的index超出了dataSource数组的总个数")
        }
        self.doneAction = doneAction
        self.singleRowData = singleRowData
        self.selectedValue = hasDefaultIndex ?
            [PickerIndexPath(component: 0,row: index!,value: singleRowData[index!])]
            :
            [PickerIndexPath(component: 0, row: 0, value: singleRowData[0])]
        self.picker.selectRow(index ?? 0, inComponent: 0, animated: true)
    }
    
    func show(mutliRowData:[[String]],default index : [Int]? ,doneAction : @escaping DoneAction) {
        assert(!mutliRowData.isEmpty, "数组为空")
        let hasDefaultIndex : Bool = index != nil
        
        if hasDefaultIndex {
            assert(mutliRowData.count == index!.count,"默认的indexs与mutliRowData数组的总个数不一致")
        }
        self.multiRowData = mutliRowData
        self.doneAction = doneAction
        self.selectedValue = hasDefaultIndex ?
            index!.enumerated().map({ (component,i) -> PickerIndexPath in
                assert(multiRowData[component].count > i, "默认值导致数组越界")
                self.picker.selectRow(i, inComponent: component, animated: true)
                return  PickerIndexPath( component: component,row: i,value: multiRowData[component][i])
            })
            :
            multiRowData.enumerated().map({ (arg) -> PickerIndexPath in
                let (component, dataArray) = arg
                return PickerIndexPath(component: component, row: 0, value: dataArray[0])
            })
        
    }
    
    func show(associatedRowData : Array<String>...) {
        
    }
    
    func show(associatedRowData:AssociatedRowDataType,default index : [Int]? ,doneAction : @escaping DoneAction) {
        assert(!associatedRowData.isEmpty, "数组为空")
        let hasDefaultIndex : Bool = index != nil
        if hasDefaultIndex {
            assert(associatedRowData.count == index!.count,"默认的indexs与associatedRowData数组的总个数不一致")
        }
        self.associatedRowData = associatedRowData
        self.doneAction = doneAction

        self.selectedValue = hasDefaultIndex ?
            index!.enumerated().map({ (component,i) -> PickerIndexPath in
                assert(associatedRowData[component].count > i, "默认值导致数组越界")
                self.picker.selectRow(i, inComponent: component, animated: true)
                if component == 0 {
                    return PickerIndexPath(component: component, row: i, value: "")
                }
                return PickerIndexPath(component: 0, row: 0, value: "")
            })
            :
            associatedRowData.enumerated().map({ (arg) -> PickerIndexPath in
                let (component, dicArray) = arg
                guard let values = dicArray.values.first else{
                    return PickerIndexPath(component: component, row: 0, value: "")
                }
                guard let value = values else {
                    return PickerIndexPath(component: component, row: 0, value: "")
                }
                return PickerIndexPath(component: component, row: 0, value: value[0])
            })
    }
    
    override func rightButtonClicked() {
        self.hide()
        if doneAction != nil {
            doneAction!(selectedValue)            
        }
    }

}

extension StringPickerView : UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if isSingleRowData {
            return 1
        }else if isMultiRowData {
            return multiRowData.count
        }else if isAssociatedRowData{
            
            return 2
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if isSingleRowData {
            return singleRowData.count
        }else if isMultiRowData{
            return multiRowData.count
        }else if isAssociatedRowData {
            if component == 0 {
                return associatedRowData.count
            }else if component == 1 {
                let row = self.selectedValue[component-1].row
                
                guard let values = associatedRowData[row].values.first else{
                    return 0
                }
                guard let value = values else {
                    return 0
                }
                print(value)
                return value.count
            }
            
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if isSingleRowData {
            if singleRowData.count > row {
                return singleRowData[row]
            }else{
                return nil
            }
        }else if isMultiRowData{
            if multiRowData.count > component && multiRowData[component].count > row{
                return multiRowData[component][row]
            }else{
                print("rowData.count 少于等于 component")
                return nil
            }
        }else if isAssociatedRowData{
            //TODO:关联数据
            print(selectedValue[component].value)
            return "1"
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue[component].component = component
        selectedValue[component].row = row
        
        if isSingleRowData {
            selectedValue[component].value = singleRowData[row]
        }else if isMultiRowData{
            selectedValue[component].value = multiRowData[component][row]
        }else if isAssociatedRowData {
            //TODO:关联的数据类型
            selectedValue[component].value = "1"
            if component < 1 {
                self.picker.reloadComponent(1)
                self.picker.selectRow(0, inComponent: component + 1, animated: true)
            }
        }
        
    }
    
}
