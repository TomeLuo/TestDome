//
//  Model.swift
//  保存模型
//
//  Created by Kay on 2019/8/13.
//  Copyright © 2019 tong. All rights reserved.
//

import UIKit

//
class Person: NSObject, NSCoding {
    
    var firstName: String
    var lastName: String
    var age: Int
    
     /// 如果定义一个实例Person，打印结果将是这里定义的描述字符串
     var descirption: String {
        return "\(self.firstName) \(self.lastName) \(age)"
    }
    
    init(firstName: String,lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    // 实现NSCoding 协议的方法
    func encode(with aCoder: NSCoder) {
        // 如果Person 还有一个父类，假设Human也采用了NSCoding协议
        // 则必须先调用父类的 super
        // 这里不需要
        aCoder.encode(self.firstName, forKey: "first")
        aCoder.encode(self.lastName, forKey: "last")
        aCoder.encode(self.age, forKey: "age")
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 同上，如果存在父类采用NSCoding协议，则也需要先调用父类的构造器
        
        // 注意这里返回的是 NSString 类型
        self.firstName = aDecoder.decodeObject(of: NSString.self, forKey: "first")! as String
        self.lastName = aDecoder.decodeObject(of: NSString.self, forKey: "last")! as String
        // 对于Int类型
        self.age = aDecoder.decodeInteger(forKey: "age")
    }
}


// 不需要写 encode(with:) 和 init(coder:) 的协议方法
// 因为协议扩展 extension Codable 中提供了默认实现

class Student: NSObject,Codable {
    
    var name : String
    var age : Int
    
    
    init(name: String,age:Int) {
        self.name = name
        self.age = age
     
    }
 
}


struct Website: Codable {
    let name: String
//    let description: String
    let courses: [Course] // 可以进行组合
    
    struct Course: Codable {
//        let id: Int
        let name: String
//        let link: String
//        let imageUrl: String
//        let number_of_lessons: Int
    }
}

