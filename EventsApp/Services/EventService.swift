//
//  EventService.swift
//  EventsApp
//
//  Created by seunghwan.yoo on 2020/06/01.
//  Copyright © 2020 seunghwan.yoo. All rights reserved.
//

import UIKit
import CoreData

protocol EventServiceProtocol {
    func perform(_ action: EventService.EventAction, data: EventService.EventInputData)
    func getEvent(_ id: NSManagedObjectID) -> Event?
    func getEvents() -> [Event]
}
final class EventService: EventServiceProtocol {
   
    struct EventInputData {
        let name: String
        let date: Date
        let image: UIImage
    }
    
    enum EventAction {
        case add
        case update(Event)
    }
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManage: CoreDataManager =  .shared) {
        self.coreDataManager = coreDataManage
    }
    
    func perform(_ action: EventAction, data: EventInputData) {
        var event: Event
        switch action {
        case .add:
            event = Event(context: coreDataManager.moc)
        case .update(let eventToUpdate):
            event = eventToUpdate
        }
        event.setValue(data.name, forKey: "name")
        
        let resizeImage = data.image.sameAspectRatio(newHeight: 250)
        let imageData = resizeImage.jpegData(compressionQuality: 0.5)
        event.setValue(imageData, forKey: "image")
        event.setValue(data.date, forKey: "date")
        
        coreDataManager.save()
    }
    
    func getEvent(_ id: NSManagedObjectID) -> Event? {
        return coreDataManager.get(id)
    }
    
    func getEvents() -> [Event] {
        return coreDataManager.getAll()
    }
}
