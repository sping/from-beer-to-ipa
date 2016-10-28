//
//  AppUtils.swift
//  FromBeerToIPA
//
//  Created by David Jupijn on 28/10/2016.
//  Copyright © 2016 Sping BV. All rights reserved.
//

import UIKit
import SwiftyJSON

class AppUtils: NSObject {

  static func createBeers(fromJSON json: JSON) -> [Beer] {
    let beerArray = json["data"].arrayValue
    var beers: [Beer] = []
    for beer in beerArray {
      beers.append(Beer(fromJSON: beer))
    }
    return beers
  }
}
