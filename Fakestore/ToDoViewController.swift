//
//  ToDoViewController.swift
//  Fakestore
//
//  Created by Apple on 02/09/22.
//

import UIKit

//var todosList: [String] = []

class ToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var toDoTable: UITableView!
    
    var toDoList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        toDoTable.delegate = self
        toDoTable.dataSource = self
        
        let name = Notification.Name("reloadToDo")
        NotificationCenter.default.addObserver(self, selector: #selector(reloadToDo), name: name, object: nil)
        
        let value = UserDefaults.standard.stringArray(forKey: "ToDoList") ?? []
        toDoList = value
        
    }
    
    @objc func reloadToDo(){
        let value = UserDefaults.standard.stringArray(forKey: "ToDoList") ?? []
        toDoList = value
        
        toDoTable.reloadData()
    }
    
    @IBAction func addAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddToDoVc")
        
        self.present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  UITableViewCell()
        cell.textLabel?.text = toDoList[indexPath.row]
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
