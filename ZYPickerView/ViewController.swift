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

//        AddressPickerView.showAddress { (indexPath) in
//            print(indexPath)
//        }
        
       
        AddressPickerView.showAddress { (indexPath) in
            print(indexPath)
        }
        
//        DatePickerView.show(mode: .date) { (date) in
//            print(date)
//        }
//        DatePickerView.show(mode: .time, minDate: minDate, maxDate: maxDate) { (date) in
//            print(date)
//        }
        /*
         ,
         // 第三列数据 (valueArray)
         [   AssociatedData(key: "陆地", valueArray: ["公交车", "小轿车", "自行车","火车"]),
         AssociatedData(key: "空中", valueArray: ["飞机"]),
         AssociatedData(key: "水上", valueArray: ["轮船"]),
         AssociatedData(key: "健康食品", valueArray: ["蔬菜", "水果"]),
         AssociatedData(key: "垃圾食品", valueArray: ["辣条", "不健康小吃"]),
         AssociatedData(key: "益智游戏", valueArray: ["消消乐", "消灭星星"]),
         AssociatedData(key: "角色游戏", valueArray: ["lol", "cf"])
         ]
         
         */
        
        let path = Bundle.main.path(forResource: "Language", ofType: "plist")
        let languageData = NSArray(contentsOfFile: path!)
        
        
        
        
        let associatedData: [[AssociatedData]] = [
            // 第一列数据 (key)
            [   AssociatedData(key: "Swift"),
                AssociatedData(key: "OC"),
                AssociatedData(key: "Java"),
                AssociatedData(key: "HTML")
            ],
            // 第二列数据 (valueArray)
            [    AssociatedData(key: "Swift", valueArray: ["Xcode"]),
                 AssociatedData(key: "OC", valueArray: ["健康食品", "垃圾食品"]),
                 AssociatedData(key: "游戏", valueArray: ["益智游戏", "角色游戏"]),
            ],
            [   AssociatedData(key: "陆地", valueArray: ["公交车", "小轿车", "自行车","火车"]),
                AssociatedData(key: "空中", valueArray: ["飞机"]),
                AssociatedData(key: "水上", valueArray: ["轮船"]),
                AssociatedData(key: "健康食品", valueArray: ["蔬菜", "水果"]),
                AssociatedData(key: "垃圾食品", valueArray: ["辣条", "不健康小吃"]),
                AssociatedData(key: "益智游戏", valueArray: ["消消乐", "消灭星星"]),
                AssociatedData(key: "角色游戏", valueArray: ["lol", "cf"])
            ]            
        ]
//     StringPickerView.show(dataSource: .associatedRowData(associatedData, defaultIndexs: nil)) { (indexPath) in
//                print(indexPath)
//            }
        }
//
    


    
    
    
}

