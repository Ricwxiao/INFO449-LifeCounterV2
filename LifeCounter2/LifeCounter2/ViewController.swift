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
    
    
    class PlayerTableDataModel : NSObject,UITableViewDataSource {
        
        var data : [(Int, Int)]
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
            return cell
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lostGameLabel.isHidden = true
        playerTable.dataSource = playerTableData
        playerTable.delegate = self
    }
    
}
