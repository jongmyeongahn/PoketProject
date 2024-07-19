//
//  CoreData.swift
//  PoketProject
//
//  Created by arthur on 7/19/24.
//

import UIKit
//import CoreData
//
//class CoreData {
//
//    private let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
//    
// 
//    
//    // AdamCoreData 에서 데이터 Read.
//    func readAllData() {
//        do {   // fetch는 데이터 접근하는데 도움을 주는 역활
//            let phoneBooks = try self.container.viewContext.fetch(PhoneBook.fetchRequest())
//                            
//            for phoneBook in phoneBooks as [NSManagedObject]{ // 프로퍼티 접근을 위해 타입캐스팅함[NSMang..]
//                if let name = phoneBook.value(forKey: PhoneBook.Key.name) as? String,
//                   let phoneNumber = phoneBook.value(forKey: PhoneBook.Key.phoneNumber) as? String {
//                    print("name: \(name), phoneNumber: \(phoneNumber)")
//                }
//            }
//        } catch {
//            print("데이터 읽기 실패")
//        }
//    }
//    // AdamCoreData 에서 테이터 Upate.
//    func updateData(currentName: String, updateName: String) {
//        
//        let fetchRequest = PhoneBook.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "name == %@", currentName)
//        
//        do {
//            let result = try self.container.viewContext.fetch(fetchRequest)
//            
//            for data in result as [NSManagedObject] {
//                //data 중 name 의 값을 updateName 으로 update 한다.
//                data.setValue(updateName, forKey: PhoneBook.Key.name)
//            }
//            
//            
//            try self.container.viewContext.save()
//            print("데이터 수정 성공")
//            
//        } catch {
//            print("데이터 수정 실패")
//        }
//        
//    }
//    
//    //AdamCoreData 에서 Delete.
//    func deleteDate(name: String) {
//        let fetchRequest = PhoneBook.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
//        
//        do {
//            let result = try self.container.viewContext.fetch(fetchRequest)
//            
//            for data in result as [NSManagedObject] {
//                self.container.viewContext.delete(data)
//            }
//            
//            try self.container.viewContext.save()
//            
//            print("데이터 삭제 완료")
//            
//        } catch {
//            print("데이터 삭제 실패")
//        }
//    }
//     
//}
