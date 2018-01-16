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
    
    
    @IBAction func singleShow(_ sender: UIButton) {
        StringPickerView.show(dataSource: .singleRowData(["男","女","其他"], defaultIndex: nil)) { (indexPath) in
            print(indexPath)
        }
    }
    
    @IBAction func multiShow(_ sender: UIButton) {
        StringPickerView.show(dataSource: .multiRowData([["1","2","3"],["4","5","6"],["7","8","9"]], defaultIndexs:nil)) { (indexPath) in
            print(indexPath)
        }
    }
    
    @IBAction func doubleAssociatedShow(_ sender: UIButton) {
        let associatedData: [[AssociatedData]] = [
            // 第一列数据 (key)
            [   AssociatedData(key: "swift"),
                AssociatedData(key: "objectivec"),
                AssociatedData(key: "html"),
                AssociatedData(key: "java")
            ],
            // 第二列数据 (valueArray)
            [    AssociatedData(key: "swift", valueArray: ["xcode"]),
                 AssociatedData(key: "objectivec", valueArray: ["xcode"]),
                 AssociatedData(key: "html", valueArray: ["vs", "monokai-sublime","foundation","dark","atelier-dune-dark","googlecode","color-brewer","atelier-dune-light"]),
                 
                 AssociatedData(key: "java", valueArray: ["androidstudio", "vs","pojoaque","googlecode"])
            ]
        ]
        
        StringPickerView.show(dataSource: .associatedRowData(associatedData, defaultIndexs: nil)) { (indexPath) in
            print(indexPath)
        }
    //end
    }
    
    @IBAction func thirdAssociatedShow(_ sender: UIButton) {
        let associatedData: [[AssociatedData]] = [
            // 第一列数据 (key)
            [   AssociatedData(key: "宇宙"),
                AssociatedData(key: "交通工具")
            ],
            // 第二列数据 (valueArray)
            [    AssociatedData(key: "宇宙", valueArray: ["太阳系","银河系"]),
                 AssociatedData(key: "交通工具", valueArray: ["海", "陆","空"])
            ],
            [   AssociatedData(key: "太阳系", valueArray: ["地球", "月球", "太阳","火星"]),
                AssociatedData(key: "银河系", valueArray: ["半人马座α星","巴纳德星","伍尔夫359星","勃兰得2147星"]),
                AssociatedData(key: "海", valueArray: ["轮船","潜艇"]),
                AssociatedData(key: "陆", valueArray: ["汽车", "小黄车","膜拜","火车"]),
                AssociatedData(key: "空", valueArray: ["飞机", "热气球"])
            ]
        ]
        StringPickerView.show(dataSource: .associatedRowData(associatedData, defaultIndexs: nil)) { (indexPath) in
            print(indexPath)
        }
    //end
    }
    
    @IBAction func dateShow(_ sender: UIButton) {
        DatePickerView.show(mode: .date) { (date) in
            print(date)
        }
    //end
    }
    
    @IBAction func addressShow(_ sender: UIButton) {
        AddressPickerView.showAddress { (indexPath) in
            print(indexPath)
        }
    //end
    }
    


//end
}

