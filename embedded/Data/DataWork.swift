//
//  DataWork.swift
//  embedded
//
//  Created by Pavel Ivanov on 12/3/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataWork {
    class func createData(newUser: User) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        guard let userEntity = NSEntityDescription.entity(forEntityName: "Users", in: context) else { return }
        
        let user = NSManagedObject(entity: userEntity, insertInto: context)
        
        user.setValue(newUser.id, forKey: "id")
        user.setValue(newUser.first_name, forKey: "first_name")
        user.setValue(newUser.last_name, forKey: "last_name")
        user.setValue(newUser.email, forKey: "email")
       
        //------
//        guard let imageString = newUser.avatar else { return }
//        Alamofire.request(imageString).responseImage { response in
//            //debugPrint(response)
//
//            print(response.request ?? " ")
//            print(response.response ?? " ")
//            debugPrint(response.result)
//
//            if let image = response.result.value {
//                print("image downloaded: \(image)")
//                let imageData = image.pngData()
//                user.setValue(imageData, forKey: "avatar")
//            }
//        }
        //--------
    
    
        user.setValue(newUser.avatar, forKey: "avatar")
        
        do {
            try context.save()
            print("Save \(newUser.first_name!) \(newUser.last_name!)")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
  class func fetchAllData() -> [User] {
        
        var arr = [User]()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequst = NSFetchRequest<NSManagedObject>(entityName: "Users")
        
        do {
            let nsUsers = try context.fetch(fetchRequst)
            let users = self.converFromNsToUser(nsUsers: nsUsers)
            arr = users
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
        return arr
    }
    
    class func deleteUser(userId:Int) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequst = NSFetchRequest<NSManagedObject>(entityName: "Users")
        fetchRequst.predicate = NSPredicate(format: "id = %@", String(userId))
        
        do {
            let result = try context.fetch(fetchRequst)
            
            if result.count > 0 {
                
                let objToDelete = result[0]
                context.delete(objToDelete)
                print("delete user \(String(describing: objToDelete.value(forKey: "last_name")))")
                
                do {
                   try context.save()
                } catch let error as NSError {
                    print("Could not delete. \(error), \(error.userInfo)")
                }
                
            } else {
                print("Not found user for delete")
            }
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    class func checkConsistUser(userId:Int) -> Bool {
                
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequst = NSFetchRequest<NSManagedObject>(entityName: "Users")
        
        fetchRequst.predicate = NSPredicate(format: "id = %@", String(userId))
        
        do {
            let result = try context.fetch(fetchRequst)
            
            if result.count > 0 {
                return true
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return false
        
    }
    
  class func converFromNsToUser(nsUsers: [NSManagedObject]) -> [User] {
        
    var users: [User] = []
        for item in nsUsers {
            
            var user = User()
            user.id = item.value(forKey: "id") as! Int?
            user.first_name = item.value(forKey: "first_name") as! String?
            user.last_name = item.value(forKey: "last_name") as! String?
            user.email = item.value(forKey: "email") as! String?
            //------------------------
            //get image from core data
            //let image = item.value(forKey:"avatar") as! NSData
            //fetchedImage.append(UIImage(data: image)!)
            
            //condert nsdata to string
            //user.avatar = String(data: image as Data, encoding: .utf8)
            //---------
            user.avatar = item.value(forKey: "avatar") as! String?
            
            users.append(user)
        }
    
    return users
        
    }
    
}

//extension String {
//    func toImage() -> UIImage? {
//        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
//            return UIImage(data: data)
//        }
//        return nil
//    }
//}
