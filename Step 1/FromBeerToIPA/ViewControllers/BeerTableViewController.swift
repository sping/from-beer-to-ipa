//
//  ViewController.swift
//  FromBeerToIPA
//
//  Created by David Jupijn on 28/10/2016.
//  Copyright © 2016 Sping BV. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BeerTableViewController: UITableViewController {

  var beers: [Beer] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.title = "Beers"
    getBeers()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  private func getBeers() {
    let parameters = ["key": beerApiKey, "abv": "5", "p": "1", "hasLabels": "Y", "withBreweries": "Y", "isOrganic": "Y"]
    Alamofire.request("\(beerApi)/beers", parameters: parameters).validate().responseJSON { response in
      switch response.result {
      case .success:
        if let value = response.result.value {
          //          print("Validation Successful\n\(value)")
          self.beers = AppUtils.createBeers(fromJSON: JSON(value))
          self.tableView.reloadData()
        }
      case .failure(let error):
        print(error)
      }
    }
  }


  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    let viewController = segue.destination as! BeerViewController
    let beer = beers[self.tableView.indexPathForSelectedRow!.row]
    viewController.beer = beer
  }


  // MARK: UITableView Delegate and DataSource

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Tapped row: \(indexPath.row)")
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "BeerCell")
    let beer = beers[indexPath.row]
    cell?.textLabel?.text = beer.name
    cell?.detailTextLabel?.text = beer.category

    return cell!
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return beers.count
  }
}

