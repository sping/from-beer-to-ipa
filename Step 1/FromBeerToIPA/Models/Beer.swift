//
//  Beer.swift
//  FromBeerToIPA
//
//  Created by David Jupijn on 28/10/2016.
//  Copyright © 2016 Sping BV. All rights reserved.
//

import UIKit
import SwiftyJSON

class Beer: NSObject {
  var id = ""
  var name = ""
  var info = ""
  var category = ""
  var imageURL = ""

  convenience init(fromJSON json: JSON) {
    self.init()
    let dict = json.dictionaryValue
    self.id = dict["id"]!.stringValue
    self.name = dict["name"]!.stringValue
    if let info = dict["description"]?.stringValue {
      self.info = info
    }
    self.category = dict["style"]!["category"]["name"].stringValue
    if let labels = dict["labels"] {
      print("beer has image: \(self.name)")
      self.imageURL = labels["medium"].stringValue
    }
  }
}
