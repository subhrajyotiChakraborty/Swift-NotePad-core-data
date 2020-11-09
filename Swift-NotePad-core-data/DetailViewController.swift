//
//  DetailViewController.swift
//  Swift-NotePad-core-data
//
//  Created by Subhrajyoti Chakraborty on 10/11/20.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var noteTitle: UILabel!
    @IBOutlet var noteDetail: UITextView!
    
    var noteData: Notes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTitle.text = noteData.title
        noteDetail.text = noteData.body
    }

    @IBAction func goBackHandler(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
