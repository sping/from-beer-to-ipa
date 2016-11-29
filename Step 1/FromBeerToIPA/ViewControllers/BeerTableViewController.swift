//
//  ViewController.swift
//  FromBeerToIPA
//
//  Created by David Jupijn on 28/10/2016.
//  Copyright © 2016 Sping BV. All rights reserved.
//

import UIKit

class BeerTableViewController: UITableViewController {

  var beers: [Beer] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.title = "Beers"
    BeerService.getBeers(completionHandler: { beerResponse in
      if beerResponse != nil {
        self.beers = beerResponse!
        self.tableView.reloadData()
      } else {
        print("Error getting beers")
      }
    })
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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

