//
//  StudentTableViewController.swift
//  StudentPut
//
//  Created by Bradley GIlmore on 4/12/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import UIKit

class StudentTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var nameTextField: UITextField!
    
    //MARK: - IBActions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else { return }
        StudentController.post(studentWithName: name) { (success) in
            guard success else { return }
            DispatchQueue.main.async {
                self.nameTextField.text = ""
                self.nameTextField.resignFirstResponder()
                self.fetchStudents()
            }
        }
    }
    
    //MARK: - Internal Properties
    
    var students = [Student]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Private methods
    private func fetchStudents() {
        StudentController.fetchStudents { (students) in
            self.students = students
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStudents()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)

        let student = students[indexPath.row]
        cell.textLabel?.text = student.name
        
        return cell
    }
}
