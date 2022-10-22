//
//  PersonalManga+CoreDataProperties.swift
//  MangaChecks
//
//  Created by Sarah Madalena on 21/10/22.
//
//

import Foundation
import CoreData


extension PersonalManga {
    //método da extensao
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonalManga> {
        return NSFetchRequest<PersonalManga>(entityName: "PersonalManga")
    }

    @NSManaged public var title: String?

}

extension PersonalManga : Identifiable {

}
