//
//  ViewController.swift
//  room_manage
//
//  Created by VISHESH MISTRY on 21/02/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import UIKit

class ViewController: baseviewcontroller {

    @IBOutlet weak var back: UIImageView!
    @IBOutlet var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "login")
        self.present(vc!, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sgn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StudentSignup") as! StudentSignup
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func login(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "login")
        self.present(vc!, animated: true, completion: nil)
    }
}

