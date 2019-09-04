//
//  ViewController.swift
//  保存模型
//
//  Created by Kay on 2019/8/13.
//  Copyright © 2019 tong. All rights reserved.
//

///参考简书文章：https://www.jianshu.com/p/4876e94862e2
///Swift Codable 和 NSCoding协议，以及归档，JSON编码

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

      
    }
    ///NSCoding 归档
    @IBAction func codingWithEncodable(_ sender: Any) {
        let fm = FileManager.default
        do {
            let docsurl = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let personFile = docsurl.appendingPathComponent("person.txt")
            
            let person = Person(firstName: "/", lastName: "2", age: 20)
            // 将上面的person使用 NSKeyedArchiver 进行存储
            // 先转换为 NSData 类型
            // 如果使用 NSSecureCoding 协议， 则requiringSecureCoing则需要使用true
            // 如果使用 NSCoding 协议， 则requiringSecureCoing为false
            let personData = try NSKeyedArchiver.archivedData(withRootObject: person, requiringSecureCoding: true)
            // 使用 write(to:) 方法写入文件
            // 哪些数据类型可以使用 write(to:) 方法，下面会介绍
            try personData.write(to: personFile)
            
        }catch{
            print("----失败----")
        }
    }
    ///NSCoding 解档
    @IBAction func codingWithDecodable(_ sender: Any) {
        let fm = FileManager.default
        do {
            let docsurl = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let personFile = docsurl.appendingPathComponent("person.txt")
            // 将 personFile 路径下文件的内容读取为 NSData 格式
            let personData = try NSData(contentsOf: personFile)
            // 然后进行解档
            // 注意这里的ofClass是 Person.self
            // 如果存入的数据是 [Person]数组，则这里相对应的则是 [Person].self
//            let personObj = try NSKeyedUnarchiver.unarchivedObject(ofClasses: Person.self, from: personData)!
            
        }catch{
            
        }
 
    }
    ///Codable 归档
    @IBAction func codableWithEncodable(_ sender: Any) {
//        do {
//            let docsurl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//            let filePath = docsurl.appendingPathComponent("student.txt")
//            let student = Student(name: "123", age: 12)
//            let encodeStudent = try PropertyListEncoder().encode(student) // 编码
//            //写入到该文件
//            try encodeStudent.write(to: filePath)
//        }catch{
//            print("----失败----")
//        }
        do {
            let docsurl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let filePath = docsurl.appendingPathComponent("student.txt")
    
            var param :[String:Any] = ["name":"扣哦呵呵"]
            param["courses"] = [["name":"qq"],["name":"oo"]]
            let data = try? JSONSerialization.data(withJSONObject:param, options: [])
            let website = try JSONDecoder().decode(Website.self, from: data!)
            let encodeStudent = try PropertyListEncoder().encode(website) // 编码
            //写入到该文件
            try encodeStudent.write(to: filePath)
        }catch{
            print("----失败----")
        }
        
    }
    ///Codable 解档
    @IBAction func codableWithDecodable(_ sender: Any) {
        do {
            let docsurl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let filePath = docsurl.appendingPathComponent("student.txt")
            let contents  = try Data(contentsOf: filePath)
            let decodedStudent = try PropertyListDecoder().decode(Website.self, from: contents)
            print("\(decodedStudent) ++++++++\(decodedStudent.courses[0].name)")
        } catch  {
            print("----失败----")
        }
    }
}

