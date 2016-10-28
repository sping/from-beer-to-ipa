//
//  BeerViewController.swift
//  FromBeerToIPA
//
//  Created by David Jupijn on 28/10/2016.
//  Copyright © 2016 Sping BV. All rights reserved.
//

import UIKit
import Alamofire

class BeerViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var textView: UITextView!
  var beer: Beer!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    self.title = beer.name

    let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)

    Alamofire.download(beer.imageURL, to: destination).response { response in
      if response.error == nil, let imagePath = response.destinationURL?.path {
        if let image = UIImage(contentsOfFile: imagePath) {
          print("IMAGE HAS BEEN DOWNLOADED BITCH")
          self.imageView.image = image
          self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(BeerViewController.shareBeer))
        }
      }
    }

    self.textView.text = beer.info


  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func shareBeer() {
    if let image = imageView.image {
      let shareText = "\(beer.name) (\(beer.category)):\n\(beer.info)"
      let viewController = UIActivityViewController(activityItems: [shareText, image], applicationActivities: [])
      present(viewController, animated: true, completion: nil)
    }
  }

}
