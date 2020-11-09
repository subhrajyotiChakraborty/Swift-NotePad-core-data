//
//  ViewController.swift
//  Swift-NotePad-core-data
//
//  Created by Subhrajyoti Chakraborty on 06/11/20.
//

import UIKit

class ViewController: UITableViewController {
    
    var notesArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        return cell
    }


}

