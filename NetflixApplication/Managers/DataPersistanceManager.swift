//
//  DataPersistanceManager.swift
//  NetflixApplication
//
//  Created by pritam on 2024-01-13.
//

import Foundation
import UIKit
import CoreData

class DataPersistanceManager {
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToGetData
        case failedToSuccessfullySaveData
    }
    
    static let shared  = DataPersistanceManager()
    
    func downloadTitleWith(model: Title, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = TitleItem(context: context)
        
        item.original_title = model.original_title
        item.id = Int64(model.id)
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_Type
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count)
        item.vote_average = model.vote_average
        
        
        do {
            try context.save()
            completion(.success(()))
        }catch {
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    
    // when function is called we expect an array of title items
    func fetchingTitlesFromDatabase(completion: @escaping (Result<[TitleItem], Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        //Asking context manager for request to get the TitleItem data from database
        let request: NSFetchRequest<TitleItem>
        
        request = TitleItem.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
        }catch {
            completion(.failure(DatabaseError.failedToGetData))
        }
        
    }
    
    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, Error>)-> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        // Database maanager for deleting defined model
        context.delete(model)
        do {
            try context.save()
            completion(.success(()))
        }catch {
            completion(.failure(DatabaseError.failedToSuccessfullySaveData))
        }
        
        
    }
    
    
}
