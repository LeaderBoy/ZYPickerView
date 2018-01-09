//
//  ViewController.swift
//  ZYPickerView
//
//  Created by 杨志远 on 2017/12/29.
//  Copyright © 2017年 BaQiWL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
//        StringPickerView.show(dataSource: .singleRowData(["7","8","9"], defaultIndex: nil)) { (indexPath) in
//            print(indexPath)
//        }
        
        
//        StringPickerView.show(dataSource: .singleRowData(["7","8","9"], defaultIndex: 2)) { (indexPath) in
//            print(indexPath)
//        }
        
//        StringPickerView.show(dataSource: .multiRowData([["1","2","3"],["4","5","6"],["7","8","9"]], defaultIndexs:nil)) { (indexPath) in
//            print(indexPath)
//        }
        
//        StringPickerView.show(dataSource: .multiRowData([["1","2","3"],["4","5","6"],["7","8","9"]], defaultIndexs: [0,1,2])) { (indexPath) in
//            print(indexPath)
//        }

        
//        DatePickerView.show(mode: .time) { (date) in
//            print(date)
//        }
//        DatePickerView.show(mode: .time, minDate: minDate, maxDate: maxDate) { (date) in
//            print(date)
//        }
        
        
        let path = Bundle.main.path(forResource: "Language", ofType: "plist")
        let languageData = NSArray(contentsOfFile: path!)
        
        let a = ["a":["1":["q","w","er"],"2":["q","w","er"],"3":["q","w","er"]]]
        let b = ["a":["1":["q","w","er"],"2":["q","w","er"],"3":["q","w","er"]]]
 StringPickerView.show(dataSource: .associatedRowData(languageData as! StringPickerView.AssociatedRowDataType, defaultIndexs: nil)) { (indexPath) in
            print(indexPath)
        }
    }
    
    


    
    
    
}

