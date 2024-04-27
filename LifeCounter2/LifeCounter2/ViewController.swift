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
    @IBOutlet weak var lifeDownButton: UIButton!
    @IBOutlet weak var lifeInput: UITextField!
    @IBOutlet weak var lifeUpButton: UIButton!
    
    var lifeCountChangeHandler: ((IndexPath) -> Void)?
    var indexPath : IndexPath?
    
}

class ViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var removePlayerButton: UIButton!
    @IBOutlet weak var playerTable: UITableView!
    
    @IBOutlet weak var lostGameLabel: UILabel!
     
    let playerTableData = PlayerTableDataModel([
        (1, 5, 20),
        (2, 5, 20)
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
    
    @IBAction func lifeDown(_ sender: UIButton) {
        var byNum = 5
        if let textField = view.viewWithTag(sender.tag) as? UITextField {
            if let text = textField.text {
                byNum = Int(text) ?? 0
                textField.text = "\(5)"
            }
        }
        lifeCountHandler(sender.tag, -byNum)
    }
    
    @IBAction func lifeUp(_ sender: UIButton) {
        var byNum = 5
        if let textField = view.viewWithTag(sender.tag) as? UITextField {
            if let text = textField.text {
                byNum = Int(text) ?? 0
                textField.text = "\(5)"
            }
        }
        lifeCountHandler(sender.tag, byNum)
    }
    
    func lifeCountHandler(_ tag: Int, _ op: Int) {
        playerTableData.data[tag].2 += op
        freezePlayerList()
        playerTable.reloadData()
        checkLost(playerTableData.data[tag])
    }
    
    func checkLost(_ player: (Int, Int, Int)) {
        if (player.2 <= 0) {
            lostGameLabel.text = "Player \(player.0) has lost the game!"
            lostGameLabel.isHidden = false
        }
    }
    
    class PlayerTableDataModel : NSObject,UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate {
        var data : [(Int, Int, Int)]
        var indexPath: IndexPath?
        var lifeDownOne: ((UIButton) -> Void)?
        
        init(_ items : [(Int, Int, Int)]) {
            data = items
        }
        
        func addPlayer() {
            let count = data.count
            if count < 8 {
                data.append((count + 1, 5, 20))
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
            let id = indexPath.row
            let player = data[id]
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell")! as! PrototypeCell
            cell.nameLabel.text = "Player \(player.0)"
            cell.lifeCountLabel.text = "\(player.2)"
            cell.lifeDownOneButton.tag = id
            cell.lifeUpOneButton.tag = id
            cell.lifeInput.tag = id
            cell.lifeInput.delegate = self
            cell.lifeInput.text = "\(player.1)"
            cell.lifeInput.keyboardType = .numberPad
            cell.lifeDownButton.tag = id
            cell.lifeUpButton.tag = id
            return cell
        }
        
//        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            let tag = textField.tag
//            data[tag].1 = Int(textField.text ?? "\(5)")!
//            return true
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lostGameLabel.isHidden = true
        playerTable.dataSource = playerTableData
        playerTable.delegate = self
    }
}
