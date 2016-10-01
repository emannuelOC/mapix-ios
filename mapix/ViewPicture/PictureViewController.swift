//
//  PictureViewController.swift
//  mapix
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 01/10/16.
//  Copyright © 2016 OC. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {
    
    // MARK: - Model
    
    var image: UIImage?

    // MARK: - Outlets
    
    @IBOutlet weak var pictureImageView: UIImageView!

    // MARK: - Actions
    
    @IBAction func shareImage(_ sender: UIBarButtonItem) {
        if let image = image {
            let activityController = UIActivityViewController(activityItems: [image],
                                                              applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
        }
    }

    // MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = image {
            pictureImageView.image = image
        }
    }
}
