//
//  YakPenViewController.swift
//  YikYak
//
//  Created by Greg Hughes on 1/3/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit

class YakPenViewController: UIViewController {

    
    @IBOutlet weak var upVoteButton: UIButton!
    @IBOutlet weak var downVoteButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var yak: Yak? {
        didSet{
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func updateViews(){
        
        guard let yak = yak else { return }
        titleLabel.text = yak.title
        textLabel.text = yak.text
        upVoteButton.setTitle("Up Vote: \(yak.upVote)", for: .normal)
        downVoteButton.setTitle("Down Vote: \(yak.downVote)", for: .normal)
    }
    
    
    @IBAction func upVoteButtonTapped(_ sender: Any) {
        guard let yak = yak else { return }
        yak.upVote += 1
        updateViews()
    }
    
    @IBAction func downVoteButtonTapped(_ sender: Any) {
        guard let yak = yak else { return }
        yak.downVote -= 1
        updateViews()
    }
    
}
