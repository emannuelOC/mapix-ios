//
//  PicturesStore.swift
//  mapix
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 01/10/16.
//  Copyright © 2016 OC. All rights reserved.
//

import UIKit
import CoreData

/// A class that provides the images to be presented
class PicturesStore {
    
    private var pictures = [UIImage]()
    
    private var context: NSManagedObjectContext?
    
    /** 
     Initializes a PictureStore object with a 
     given NSManagedObjectContext.
     */
    init(context: NSManagedObjectContext? = nil) {
        if context != nil {
            self.context = context
            loadImages()
        }
    }
    
    private func loadImages() {
        if let context = context {
            let pics = Picture.retrieve(at: context)
            for p in pics {
                let path = p.filePath ?? ""
                if let image = retrieveImageFile(with: path) {
                    pictures.append(image)
                }
            }
        }
    }
    
    /**
     Returns the number of pictures.
     */
    func numberOfPictures() -> Int {
        return pictures.count
    }
    
    /**
     Returns the image at a given index.
     
     The method will return nil if the `index` 
     is invalid (less than 0 or greater than or
     equal to the number of pictures.
     
     - parameter index: The index for the picture
     to be returned.
     
     - returns: The picture (`UIImage`) at the `index`.
     */
    func picture(at index: Int) -> UIImage? {
        if index < 0 || index >= pictures.count {
            return nil
        }
        return pictures[index]
    }
    
    /**
     Adds a picture to the store.
     
     - parameter picture: The image to be added.
     */
    func add(picture: UIImage) {
        pictures.append(picture)
        save(picture: picture)
        NotificationCenter
            .default
            .post(name: Notification.Name("NewPictureAdded"), object: self)
    }
    
    private func save(picture: UIImage) {
        if let moc = context {
            let pictureEntity = Picture.createNew(at: moc)
            pictureEntity?.title = ""
            pictureEntity?.filePath = persistFile(for: picture)
            do {
                try moc.save()
            } catch {} // TODO: handle error
        }
    }
    
    private func persistFile(for image: UIImage) -> String {
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                       .userDomainMask,
                                                       true)[0]
        let fileName = "\(Date().timeIntervalSince1970)"
                            .replacingOccurrences(of: ".",
                                                  with: "_")
        let imagePath = path.appending("/\(fileName)")
        do {
            try imageData?.write(to: URL(fileURLWithPath: imagePath))
        } catch {} // TODO: handle errors
        return fileName
    }
    
    private func retrieveImageFile(with name: String) -> UIImage? {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                       .userDomainMask,
                                                       true)[0]
        let fileName = path.appending("/\(name)")
        return UIImage(contentsOfFile: fileName)
    }
}
