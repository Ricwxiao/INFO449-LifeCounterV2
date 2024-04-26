//
//  ViewController.swift
//  LifeCounter2
//
//  Created by Ricwxiao on 2024/4/25.
//
import UIKit

class PrototypeCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lifeCountLabel: UILabel!
    @IBOutlet weak var lifeDownOneButton: UIButton!
    @IBOutlet weak var lifeUpOneButton: UIButton!
    @IBOutlet weak var lifeDown: UIButton!
    @IBOutlet weak var lifeInput: UITextField!
    @IBOutlet weak var lifeUp: UIButton!
    
    var lifeCountChangeHandler: ((IndexPath) -> Void)?
    var indexPath : IndexPath?
    
}

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var removePlayerButton: UIButton!
    @IBOutlet weak var playerTable: UITableView!
    
    @IBOutlet weak var lostGameLabel: UILabel!
     
    let playerTableData = PlayerTableDataModel([
        (1, 20),
        (2, 20)
    ])
    
    @IBAction func addPlayer(_ sender: Any) {
        playerTableData.addPlayer()
        playerTable.reloadData()
    }
    
    @IBAction func removePlayer(_ sender: Any) {
        playerTableData.removePlayer()
        playerTable.reloadData()
    }
    
    func freezePlayerList() {
        addPlayerButton.isEnabled = false
        removePlayerButton.isEnabled = false
    }
    
    @IBAction func lifeDownOne(_ sender: UIButton) {
        lifeCountHandler(sender.tag, -1)
    }
    
    @IBAction func lifeUpOne(_ sender: UIButton) {
        lifeCountHandler(sender.tag, +1)
    }
    
    func lifeCountHandler(_ tag: Int, _ op: Int) {
        var thisLifeCount = playerTableData.data[tag].1
        playerTableData.data[tag].1 = thisLifeCount + op
        freezePlayerList()
        playerTable.reloadData()
    }
    
    class PlayerTableDataModel : NSObject,UITableViewDataSource,UITableViewDelegate {
        var data : [(Int, Int)]
        var indexPath: IndexPath?
        var lifeDownOne: ((UIButton) -> Void)?
        
        init(_ items : [(Int, Int)]) {
            data = items
        }
        
        func addPlayer() {
            let count = data.count
            if count < 8 {
                data.append((count + 1, 20))
            }
        }
        func removePlayer() {
            let count = data.count
            if count > 2 {
                data.remove(at: count - 1)
            }
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let player = data[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell")! as! PrototypeCell
            cell.nameLabel.text = "Player \(player.0)"
            cell.lifeCountLabel.text = "\(player.1)"
            cell.lifeDownOneButton.tag = indexPath.row
            cell.lifeUpOneButton.tag = indexPath.row
            return cell
        }
        
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            selectedRowIndex = indexPath.row
//            NSLog("Selected row index: %ld", selectedRowIndex ?? -1)
//        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lostGameLabel.isHidden = true
        playerTable.dataSource = playerTableData
        playerTable.delegate = self
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//                view.addGestureRecognizer(tapGesture)
    }
    
//    @objc func dismissKeyboard() {
//        lifeInput.resignFirstResponder()
//    }
    
}
