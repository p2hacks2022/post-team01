//
//  PhotoModel.swift
//  TeddyBear2022
//  
//  Created by テディベア on 2022/12/14
//  
//

import Foundation
import SwiftUI
import FirebaseFirestore

class PhotoModel : ObservableObject{
    @Published var id = UUID()
    @Published var bool = false
    @Published var image1: Data = Data.init()
    @Published var image2: Data = Data.init()
    
    @Published var isNewData = false
    @Published var updateItem : PhotoData!
    
    func writeData(context :NSManagedObjectContext){
//データが新規か編集かで処理を分ける
        if updateItem != nil {
            
            updateItem.bool = bool
            updateItem.image1 = image1
            updateItem.image2 = image2
            
            try! context.save()
            
            updateItem = nil
            isNewData.toggle()
            
            bool = false
            image1 = Data.init()
            image2 = Data.init()
 
            return
        }
//データ新規作成
        let newPhotoData = PhotoData(context: context)

        newPhotoData.id = UUID()
        newPhotoData.bool = bool
        newPhotoData.image1 = image1
        newPhotoData.image2 = image2
        
        do{
            try context.save()
            
            isNewData.toggle()
            
            bool = false
            image1 = Data.init()
            image2 = Data.init()
            
        }
        catch {
            print(error.localizedDescription)
            
        }
    }
//編集の時は既存データを利用する
    func editItem(item: PhotoData){
        updateItem = item
        
        id = item.wrappedId
        bool = item.bool
        image1 = item.wrappedImg1
        image2 = item.wrappedImg2

        isNewData.toggle()
    }
}
