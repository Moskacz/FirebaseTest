//
//  ViewController.swift
//  FirebaseTest
//
//  Created by Michal Moskala on 17.03.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    private lazy var questionsRef: DatabaseReference = {
        return Database.database().reference().child("questions")
    }()
    
    private lazy var answersRef: DatabaseReference = {
        return Database.database().reference().child("answers")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJSONs()
    }
    
    private func fetchJSONs() {
        questionsRef.observe(.value) { (snap) in
            print(snap)
        }
        
        answersRef.observe(.value) { (snap) in
            print(snap)
        }
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "answer", message: "answer", preferredStyle: .alert)
        alert.addTextField { (_) in }
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            self.save(answer: alert.textFields?.first?.text)
        }
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func save(answer: String?) {
        guard let text = answer else { return }
        answersRef.childByAutoId().setValue(text)
    }
}

