//
//  ViewController.swift
//  Swift-NotePad-core-data
//
//  Created by Subhrajyoti Chakraborty on 06/11/20.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var notesArray = [Notes]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNotesHandler))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        loadNotes()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        cell.textLabel?.text = notesArray[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetail", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(notesArray[indexPath.row])
            notesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
            
            saveNote()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            vc.noteData = notesArray[indexPath.row]
        }
    }
    
    @objc func addNotesHandler() {
        let ac = UIAlertController(title: "Add Note", message: nil, preferredStyle: .alert)
        ac.addTextField { (alertTitleTextField) in
            alertTitleTextField.placeholder = "Title"
        }
        
        ac.addTextField { (alertDetailTextField) in
            alertDetailTextField.placeholder = "Description"
        }
        
        let submitAction = UIAlertAction(title: "Add Note", style: .default) { [weak self, weak ac] _ in
            guard let noteTitle = ac?.textFields?[0].text else { return }
            guard let noteDescription = ac?.textFields?[1].text else { return }
            self?.submitAction(title: noteTitle, body: noteDescription)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submitAction(title: String, body: String) {
        let newNote = Notes(context: context)
        newNote.title = title
        newNote.body = body
        
        notesArray.append(newNote)
        
        saveNote()
    }
    
    func saveNote() {
        do {
            try context.save()
        } catch {
            print("Error while saving the note \(error.localizedDescription)")
        }
        
        tableView.reloadData()
    }
    
    func loadNotes() {
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        
        do {
            notesArray = try context.fetch(request)
            print("notes count => ", notesArray.count)
        } catch {
            print("Error while fetching the notes data \(error.localizedDescription)")
        }
        
        tableView.reloadData()
    }
    
    
}

