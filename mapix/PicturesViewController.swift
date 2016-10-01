//
//  PicturesViewController.swift
//  mapix
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 01/10/16.
//  Copyright © 2016 OC. All rights reserved.
//

import UIKit

class PicturesViewController: UIViewController,
                                UICollectionViewDataSource,
                                UICollectionViewDelegate,
                                UIImagePickerControllerDelegate,
                                UINavigationControllerDelegate {
    
    // MARK: - Model
    
    let store = PicturesStore()

    // MARK: - Outlets
    
    @IBOutlet weak var picturesCollectionView: UICollectionView!

    // MARK: - Actions
    
    @IBAction func addNewPicture(_ sender: UIBarButtonItem) {
        showActionSheet()
    }
    
    // MARK: - ViewController life cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(PicturesViewController.observeNewPictureNotification(_:)),
                         name: Notification.Name(rawValue: "NewPictureAdded"),
                         object: nil)
    }
    
    // MARK: - CollectionView data source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return store.numberOfPictures()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath)
            as! PictureCollectionViewCell
        
        if let image = store.picture(at: indexPath.item) {
            cell.pictureImageView.image = image
        }
        
        return cell
    }
    
    // MARK: - CollectionView delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath),
            let image = (cell as? PictureCollectionViewCell)?.pictureImageView.image
            else { return }
        performSegue(withIdentifier: "ShowPicture", sender: image)
    }
    
    // MARK: - Adding new pictures
    
    func showActionSheet() {
        let actionSheet = UIAlertController(title: nil,
                                            message: "Choose where the new image comes from.",
                                            preferredStyle: .actionSheet)
        let libraryAction = UIAlertAction(title: "Library",
                                          style: .default) { (action) in
                                            self.presentImagePicker(with: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Camera",
                                         style: .default) { (action) in
                                            self.presentImagePicker(with: .camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        actionSheet.addAction(libraryAction)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    func presentImagePicker(with sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker,
                animated: true,
                completion: nil)
    }
    
    // MARK: - UIImagePickerController delegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            store.add(picture: image)
        }
    }
    
    // MARK: - Observer methods
    
    func observeNewPictureNotification(_ notification: Notification?) {
        picturesCollectionView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPicture" {
            guard let image = sender as? UIImage,
                let vc = segue.destination as? PictureViewController
                else {
                return
            }
            vc.image = image
        }
    }
    
}
