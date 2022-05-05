//
//  ViewController.swift
//  CoreDataExample
//
//  Created by Nathaniel Whittington on 2/18/22.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var arr = [Person]()

    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var schoolField: UITextField!
    @IBOutlet weak var hobbyField: UITextField!
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }

    @IBAction func saveButton(_ sender: UIButton) {
        
        let pName = nameField.text ?? ""
        let pLocation = locationField.text ?? ""
        let pHobby = hobbyField.text ?? ""
        let pSchool = schoolField.text ?? ""
        
        if pName.count <= 0 || pLocation.count <= 0 || pHobby.count <= 0 || pSchool.count <= 0 {
            return
        }
        
        
        
        let todoDefaults = Todo(context: appDelegate.persistentContainer.viewContext)
        todoDefaults.hobby = "Fishing"
        todoDefaults.school = "Jackson"
        
        let todo = Todo(context: appDelegate.persistentContainer.viewContext)
        todo.hobby = pHobby
        todo.school = pSchool
        
        
        let person = Person(context: appDelegate.persistentContainer.viewContext)
        person.name = pName
        person.location = pLocation
        person.todos = NSSet(objects: todoDefaults, todo)
        
        
        self.appDelegate.saveContext()
        fetch()
        
        
        
       
       
    }
    
    
    func fetch(){
        
        let fetch = NSFetchRequest<Person>(entityName: "Person")
        
        do {
            arr  = try appDelegate.persistentContainer.viewContext.fetch(fetch)
            tblView.reloadData()
        } catch  {
            

        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let person = arr[indexPath.row]
        let name = person.name
        let todos = person.todos
        var display = ""
        
        for atodo in todos!{
            
            let td = atodo as! Todo
            display = " | " + (td.hobby ?? "N/A") + " | " + (td.school ?? "N/A")
        }
        
        cell?.textLabel?.text = (name ?? "N/A") + display
        return cell ?? UITableViewCell()
    }
    
    
}

