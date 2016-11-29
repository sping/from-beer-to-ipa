//
//  BeerService.swift
//  FromBeerToIPA
//
//  Created by Sebastiaan Seegers on 29-11-16.
//  Copyright © 2016 Sping BV. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AlamofireImage

class BeerService {

  static func getBeers(completionHandler: @escaping (_ beers: [Beer]?) -> Void) {
    let parameters = ["key": beerApiKey, "abv": "5", "p": "1", "hasLabels": "Y", "withBreweries": "Y", "isOrganic": "Y"]
    Alamofire.request("\(beerApi)/beers", parameters: parameters).validate().responseJSON { response in
      switch response.result {
      case .success:
        if let value = response.result.value {
          let beers: [Beer] = AppUtils.createBeers(fromJSON: JSON(value))
          completionHandler(beers)
        }
      case .failure(let error):
        print(error)
        completionHandler(nil)
      }
    }
  }

  static func getBeerImage(beer: Beer, completionHandler: @escaping (_ image: UIImage?) -> Void) {
    Alamofire.request(beer.imageURL).responseImage(completionHandler: { response in
      debugPrint(response)

      if let image = response.result.value {
        completionHandler(image)
      } else {
        completionHandler(nil)
      }
    })
  }
}
