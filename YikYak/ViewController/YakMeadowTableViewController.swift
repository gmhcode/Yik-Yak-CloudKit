//
//  YakMeadowTableViewController.swift
//  YikYak
//
//  Created by Greg Hughes on 1/3/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit

class YakMeadowTableViewController: UITableViewController {

    
    
    
    
    fileprivate func reloadData() {
        YakController.shared.herdAllYaks { (_) in
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }

    
    @IBAction func refreshControlPulled(_ sender: Any) {
        reloadData()
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        
        reloadData()
        
    }
    
    @IBAction func composeButtonTapped(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Birth Yak", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Get Yakky🤤"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Don't yik your name"
        }
        
        let yakAction = UIAlertAction(title: "Yak Away", style: .default) { (_) in
            
            guard let text = alertController.textFields?.first?.text,
                let title = alertController.textFields?[1].text else {return}
            
            YakController.shared.birthYoungYak(text: text, title: title, completion: { (yak) in
                if yak != nil {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
        }
        
        let yikAction = UIAlertAction(title: "yik", style: .destructive, handler: nil)
        
        alertController.addAction(yakAction)
        alertController.addAction(yikAction)
        self.present(alertController, animated: true)
    }
    
   


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return YakController.shared.yaks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "yakCell", for: indexPath)

         let yak = YakController.shared.yaks[indexPath.row]
        
        cell.textLabel?.text = yak.text
        cell.detailTextLabel?.text = yak.title

        return cell
    }
    

   

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let yak = YakController.shared.yaks[indexPath.row]
            YakController.shared.delete(yak: yak) { (success) in
                if success{
                    DispatchQueue.main.async {
                        YakController.shared.yaks.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                }
            }
        }
    }
 


    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "toYakPen"{
            guard let destinationVC = segue.destination as? YakPenViewController,
            let index = tableView.indexPathForSelectedRow else {return}
            let yak = YakController.shared.yaks[index.row]
            destinationVC.yak = yak
        }
        
    }
 

}
