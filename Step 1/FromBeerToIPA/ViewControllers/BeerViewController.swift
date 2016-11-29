//
//  BeerViewController.swift
//  FromBeerToIPA
//
//  Created by David Jupijn on 28/10/2016.
//  Copyright © 2016 Sping BV. All rights reserved.
//

import UIKit

class BeerViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var textView: UITextView!
  var beer: Beer!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    self.title = beer.name

    BeerService.getBeerImage(beer: beer, completionHandler: { beerImage in
      if beerImage != nil {
        self.imageView.image = beerImage!
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(BeerViewController.shareBeer))
      } else {
        print("Error getting beer image :(")
      }
    })

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
