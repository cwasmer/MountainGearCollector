//
//  ViewController.swift
//  MountainGearCollection
//
//  Created by Christian Wasmer on 05/03/2017.
//  Copyright © 2017 Christian Wasmer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tavleView: UITableView!
    
    var gears : [Gear] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tavleView.dataSource = self
        tavleView.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            gears = try context.fetch(Gear.fetchRequest())
            tavleView.reloadData()
        } catch {}
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gears.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let gear = gears[indexPath.row]
        cell.textLabel?.text = gear.title
        cell.imageView?.image = UIImage(data: gear.image! as Data)
        return cell
    }
}


