//
//  PicturesViewController.swift
//  mapix
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 01/10/16.
//  Copyright © 2016 OC. All rights reserved.
//

import UIKit

class PicturesViewController: UIViewController, UICollectionViewDataSource {
    
    // MARK: - Model
    
    let store = PicturesStore()

    // MARK: - Outlets
    
    @IBOutlet weak var picturesCollectionView: UICollectionView!

    // MARK: - Actions
    
    @IBAction func addNewPicture(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - CollectionView data source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.numberOfPictures()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath)
            as! PictureCollectionViewCell
        
        if let image = store.picture(at: indexPath.item) {
            cell.pictureImageView.image = image
        }
        
        return cell
    }
    
    
    
}
