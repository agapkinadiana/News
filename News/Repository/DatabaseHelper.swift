//
//  DatabaseHelper.swift
//  News
//
//  Created by Diana Agapkina on 10/30/20.
//

import Foundation
import  UIKit
import CoreData

class DataBaseHelper {
    static let shareInstance = DataBaseHelper()

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: dbName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveCurrentFeed(item: NewsItem) {
        let bgContext = persistentContainer.newBackgroundContext()
        let feed = News(context: bgContext)
        feed.title = item.title
        feed.details = item.details
        feed.imageURL = item.imageURL
        
        do {
            try bgContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveAllFeeds(items: [NewsItem]) {
        deleteAllData()
        for item in items {
            saveCurrentFeed(item: item)
        }
    }
    
    func deleteAllData() {
        let bgContext = persistentContainer.newBackgroundContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: dbName)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try bgContext.execute(batchDeleteRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Fetch all feeds in Core Data
    func fetchSavedFeed() -> [NewsItem]? {
        let bgContext = persistentContainer.newBackgroundContext()
        var rssFeeds = [NewsItem]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: dbName)
        do {
            let feeds = try bgContext.fetch(fetchRequest) as! [News]
            for feed in feeds {
                guard let title = feed.title,
                      let details = feed.details,
                      let url = feed.imageURL
                    else { return rssFeeds }
                rssFeeds.append(NewsItem(title: title, imageURL: url, details: details))
            }
        } catch {
            print(error.localizedDescription)
        }
        return rssFeeds
    }
}
