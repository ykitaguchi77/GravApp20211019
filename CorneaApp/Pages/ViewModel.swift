//
//  ViewModel.swift
//  CorneaApp
//
//  Created by Yoshiyuki Kitaguchi on 2021/11/04.
//

import SwiftUI
import CoreData

class ViewModel : ObservableObject{
    @Published var content = ""
    @Published var newdate = Date()
    @Published var newid = ""
    @Published var newhospitals = ""
    @Published var newdisease = ""
    @Published var newfreedisease = ""
    
    @Published var isNewData = false
    @Published var updateItem : Item!

    func writeData(context : NSManagedObjectContext ){
        
        if updateItem != nil{
            updateItem.newdate = newdate
            updateItem.newid = newid
            updateItem.newhospitals = newhospitals
            updateItem.newdisease = newdisease
            updateItem.newfreedisease = newfreedisease
            updateItem.content = content
            try! context.save()
            
            updateItem = nil
            isNewData.toggle()
            content = ""
            newdate = Date()
            return
        }
        
        let newItem = Item(context: context)
        newItem.newdate = newdate
        newItem.newid = newid
        newItem.newhospitals = newid
        newItem.newdisease = newdisease
        newItem.newfreedisease = newfreedisease
        newItem.content = content
        
        do{
            try context.save()
            isNewData.toggle()
            content = ""
            newdate = Date()
        }
        catch{
            print(error.localizedDescription)
        }
    }

    func EditItem(item:Item){
        updateItem = item
        
        newdate = item.newdate!
        content = item.content!
        isNewData.toggle()
    }
    }
