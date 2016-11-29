//
//  ViewController.swift
//  FromBeerToIPA
//
//  Created by David Jupijn on 28/10/2016.
//  Copyright © 2016 Sping BV. All rights reserved.
//

import UIKit
import RevealingSplashView
import TableFlip

class BeerTableViewController: UITableViewController {

  var beers: [Beer] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.title = "Beers"
    self.tableView.backgroundColor = .white

    BeerService.getBeers(completionHandler: { beerResponse in
      if beerResponse != nil {
        self.beers = beerResponse!
        self.tableView.reloadData()
        self.tableView.animateCells(animation: TableViewAnimation.Cell.left(duration: 0.8))
      } else {
        print("Error receiving beers")
      }
    })

    //Initialize a revealing Splash with with the iconImage, the initial size and the background color
    let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "BeerIcon")!,iconInitialSize: CGSize(width: 70, height: 70), backgroundColor: UIColor(red:1, green:1, blue:1, alpha:1.0))
    revealingSplashView.backgroundColor = .white

    //Adds the revealing splash view as a sub view
    self.navigationController?.view.addSubview(revealingSplashView)

    //Starts animation
    revealingSplashView.startAnimation(){
      print("Completed")
    }
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

