//
//  PicturesStore.swift
//  mapix
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 01/10/16.
//  Copyright © 2016 OC. All rights reserved.
//

import UIKit

/// A class that provides the images to be presented
class PicturesStore {
    
    private var pictures = [UIImage]()
    
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
        NotificationCenter
            .default
            .post(name: Notification.Name("NewPictureAdded"), object: self)
    }
    
}
