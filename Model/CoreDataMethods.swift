//
//  CoreDataMethods.swift
//  MangaChecks
//
//  Created by Sarah Madalena on 22/10/22.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared: CoreDataStack = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MangaChecks")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    func fetchMangaEntity() -> [PersonalManga] {
        do {
            let mangaRequest = PersonalManga.fetchRequest() as NSFetchRequest<PersonalManga>
            return try context.fetch(mangaRequest)
        } catch {
            print("Error while fetching Mangas.")
            print(error)
            return []
        }
    }
    
    func createMangaEntity(mangaData: MangasData) -> PersonalManga {
        let newMangaEntity = PersonalManga(context: context)
        //        newAnimeEntity.malID = Int64(animeData.malId!)
        //        newAnimeEntity.malRating = animeData.score!
        //        newAnimeEntity.animeImage = animeData.images?.jpg?.imageUrl
        //        newAnimeEntity.detailText = animeData.synopsis
        newMangaEntity.title = mangaData.title
        
        return newMangaEntity
    }
    
    func printAllMangaEntity() {
        let mangas = fetchMangaEntity()
        if !mangas.isEmpty {
            for manga in mangas {
                print("title: \(manga.title ?? "error")")
            }
        } else {
            print("Something wrong, your coredata are empty")
        }
    }
}
