//
//  StringPickerView.swift
//  ZYPickerView
//
//  Created by 杨志远 on 2018/1/5.
//  Copyright © 2018年 BaQiWL. All rights reserved.
//

import UIKit

struct AssociatedData {
    var key: String
    var valueArray: [String]?
    init (key: String, valueArray: [String]? = nil) {
        self.key = key
        self.valueArray = valueArray
    }
    
    func valueArrayFor(key : String) -> [String]? {
        return self.valueArray
    }
}

class StringPickerView: ZYPickerView {
//    typealias AssociatedRowDataType = [[String: [String]?]]
    typealias AssociatedRowDataType = [[AssociatedData]]

    enum PickerDataSourceType {
        case singleRowData(_ : [String],defaultIndex: Int?)
        case multiRowData(_ : [[String]],defaultIndexs: [Int]?)
        case associatedRowData(_ : AssociatedRowDataType,defaultIndexs: [Int]?)
    }
    
    lazy var isSingleRowData = false
    lazy var isMultiRowData  = false
    lazy var isAssociatedRowData = false
    
    var firstKey = ""

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
    //MARK: Show
    static func show(dataSource : PickerDataSourceType,doneAction : @escaping DoneAction) {
        let frame = UIScreen.main.bounds
        switch dataSource {
        case .singleRowData(let single,let index):
            let stringPickerView = StringPickerView(frame: frame)
            stringPickerView.show(singleRowData: single, default: index, doneAction: doneAction)
        case .multiRowData(let multi,let indexs) :
            let stringPickerView = StringPickerView(frame: frame)
            stringPickerView.show(mutliRowData: multi, default: indexs, doneAction: doneAction)
        case .associatedRowData(let associated,let indexs):
            let stringPickerView = StringPickerView(frame: frame)
            stringPickerView.show(associatedRowData: associated, default: indexs, doneAction: doneAction)
        }

    }
    //MARK: 单列
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
    //MARK: 多列
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
    //MARK: 多关联
    func show(associatedRowData:AssociatedRowDataType,default index : [Int]? ,doneAction : @escaping DoneAction) {
        assert(!associatedRowData.isEmpty, "数组为空")
        let hasDefaultIndex : Bool = index != nil
        if hasDefaultIndex {
            assert(associatedRowData.count == index!.count,"默认的indexs与associatedRowData数组的总个数不一致")
        }
        self.associatedRowData = associatedRowData
        self.doneAction = doneAction
        var key = ""
        self.selectedValue = hasDefaultIndex ?
            index!.enumerated().map({ (component,i) -> PickerIndexPath in
//                assert(associatedRowData[component].count > i, "默认值导致数组越界")
                self.picker.selectRow(i, inComponent: component, animated: true)
                
                if component == 0 {
                    return PickerIndexPath(component: component, row: i, value: "")
                }
                return PickerIndexPath(component: 0, row: 0, value: "")
            })
            :
            associatedRowData.enumerated().map({ (arg) -> PickerIndexPath in
                let (component, valueArray) = arg
                if component == 0 {
                    key = valueArray[0].key
                    firstKey = key
                }else{
                    guard let values = valueArray.first(where: {$0.key == key}) else{
                        return PickerIndexPath(component: component, row: 0, value: "")
                    }
                    if values.valueArray != nil && values.valueArray!.count >= 1 {
                        key = values.valueArray![0]
                    }else{
                        key = ""
                    }
                }
                return PickerIndexPath(component: component, row: 0, value: key)

            })
        
    }
    //MARK:完成按钮点击事件
    override func rightButtonClicked() {
        self.hide()
        if doneAction != nil {
            doneAction!(selectedValue)            
        }
    }

}
//MARK: UIPickerViewDataSource,UIPickerViewDelegate
extension StringPickerView : UIPickerViewDataSource,UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if isSingleRowData {
            return 1
        }else if isMultiRowData {
            return multiRowData.count
        }else if isAssociatedRowData{
            return associatedRowData.count
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
                return associatedRowData[component].count
            }else {
                let key = self.selectedValue[component-1].value
                let array = associatedRowData[component]
                guard let rowData = array.first(where: { $0.key == key}) else {
                    return 0
                }
                if rowData.valueArray != nil {
                    return rowData.valueArray!.count
                }
                return 0
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
            return titleFor(row, in: component)
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
            if component == 0 {
                firstKey = associatedRowData[component][row].key
                selectedValue[component].value = firstKey
            }else{
                let preKey = selectedValue[component-1].value
                let array = associatedRowData[component]
                guard let rowData = array.first(where: { $0.key == preKey}) else {
                    return
                }
                if rowData.valueArray != nil  && rowData.valueArray!.count > row {
                    self.selectedValue[component].row = row
                    self.selectedValue[component].component = component
                    self.selectedValue[component].value = rowData.valueArray![row]
                }else{
                    return
                }
            }
            for i in ((component+1)..<associatedRowData.count) {
                let array = associatedRowData[i]
                let key = self.selectedValue[i-1].value
                guard let rowData = array.first(where: { $0.key == key}) else {
                    break
                }
                if rowData.valueArray != nil  && rowData.valueArray!.count > 0 {
                    self.selectedValue[i].row = 0
                    self.selectedValue[i].component = i
                    self.selectedValue[i].value = rowData.valueArray![0]
                }else{
                    break
                }
            }
            
            if component < associatedRowData.count - 1 {
                var com = component
                repeat {
                    com = com + 1
                    self.picker.selectRow(0, inComponent: com, animated: true)
                    self.picker.reloadComponent(com)
                    
                }while com < associatedRowData.count - 1
            }
        }
    }
    
    fileprivate func titleFor(_ row : Int,in component:Int) -> String {
        // 第一组 选择的值
        var key = firstKey
        if component == 0 {
            key = associatedRowData[0][row].key
            return key
        }else{
            let preKey = self.selectedValue[component-1].value
            let array = associatedRowData[component]
            guard let rowData = array.first(where: { $0.key == preKey}) else {
                return "111"
            }
            if rowData.valueArray != nil  && rowData.valueArray!.count > row {
                return rowData.valueArray![row]
            }else{
                return "222"
            }
        }
    }
    
}
