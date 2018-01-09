//
//  DatePickerView.swift
//  ZYPickerView
//
//  Created by 杨志远 on 2018/1/5.
//  Copyright © 2018年 BaQiWL. All rights reserved.
//

import UIKit

class DatePickerView: ZYPickerView {
    typealias DateDoneAction = (Date) -> Void
    
    var dateDoneAction : DateDoneAction!
    private lazy var picker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return picker
    }()
    
    convenience init(frame: CGRect,mode:UIDatePickerMode,minDate:Date?,maxDate:Date?,doneAction : DateDoneAction) {
        self.init(frame: frame)
    }
    
    static func show(mode:UIDatePickerMode,minDate:Date? = nil,maxDate:Date? = nil,doneAction : @escaping DateDoneAction) {
        let pickerView = DatePickerView(frame: UIScreen.main.bounds, mode: mode, minDate: minDate, maxDate: maxDate, doneAction: doneAction)
        pickerView.picker.minimumDate = minDate
        pickerView.picker.maximumDate = maxDate
        pickerView.picker.datePickerMode = mode
        pickerView.dateDoneAction = doneAction
        pickerView.show()
    }
    
    override var inputView: UIView? {
        get {
            return self.picker
        }
    }
    
    override func rightButtonClicked() {
        self.hide()
        if dateDoneAction != nil {
            dateDoneAction!(self.picker.date)
        }
    }
}


