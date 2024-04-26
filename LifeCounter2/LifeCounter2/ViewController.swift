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
    @IBOutlet weak var lifeDownByOne: UIButton!
    @IBOutlet weak var lifeUpByOne: UIButton!
    @IBOutlet weak var lifeDownByX: UIButton!
    @IBOutlet weak var lifeInput: UITextField!
    @IBOutlet weak var lifeUpByX: UIButton!
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
    
//    @IBAction func lifeDownByOne(_ sender: Any) {
//        guard let selectedRow = playerTableData.selectedRowIndex else {
//            return
//        }
//        if playerTableData.data.indices.contains(selectedRow) {
//            var selectedPlayer = playerTableData.data[selectedRow]
//            selectedPlayer.1 -= 1
//            playerTableData.data[selectedRow] = selectedPlayer
//            playerTable.reloadData()
//        }
//    }
    
    
    class PlayerTableDataModel : NSObject,UITableViewDataSource,UITableViewDelegate {
        var data : [(Int, Int)]
        var selectedRowIndex: Int?
        
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
        
        func handleLifeDownByOne() {
            data[selectedRowIndex!].1 -= 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let player = data[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell")! as! PrototypeCell
            cell.nameLabel.text = "Player \(player.0)"
            cell.lifeCountLabel.text = "\(player.1)"
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectedRowIndex = indexPath.row
            NSLog("Selected row index: %ld", selectedRowIndex ?? -1)
        }

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
