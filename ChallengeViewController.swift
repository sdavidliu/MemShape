//
//  ChallengeViewController.swift
//  MemShape
//
//  Created by David Liu on 2/3/18.
//  Copyright © 2018 Davidapps. All rights reserved.
//

import UIKit
import SendGrid

class ChallengeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var textView: UITextView!
    private var SG_API_KEY = "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"
    private var name = ""
    private var emailAddress = ""
    private var highScore = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        textView.text = defaults.string(forKey: "emailList") ?? ""

        textView.layer.cornerRadius = 5.0
        textView.delegate = self
        
        name = defaults.string(forKey: "name") ?? ""
        emailAddress = defaults.string(forKey: "email") ?? ""
        highScore = String(defaults.integer(forKey: "highScore"))
    }

    @IBAction func doneAction(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        defaults.set(textView.text, forKey: "emailList")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func challengeAction(_ sender: UIButton) {
        
        if (name == "") {
            let alert = UIAlertController(title: "Error", message: "Please fill out your name in Settings", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if (emailAddress == "") {
            let alert = UIAlertController(title: "Error", message: "Please fill out your email in Settings", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if (textView.text == "") {
            let alert = UIAlertController(title: "Error", message: "Please fill out at least one email", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let emails = textView.text.split(separator: ",")
        var emailsList = [Address]()
        for e in emails {
            emailsList.append(Address(email: String(e)))
        }
        
        let session = Session()
        session.authentication = Authentication.apiKey(SG_API_KEY)
        // Send a basic example
        let personalization = Personalization(to: emailsList)
        let htmlText = Content(contentType: ContentType.htmlText, value: "<h2><span style=\"color: #4b67a1;\">You have a challenge from " + name + "!</span></h2> <p>&nbsp;</p> <p>" + name + " challenged you to the game of MemShape! Memorize the pattern of the shapes and try to get the high score!</p> <h1 style=\"text-align: center;\">" + name + "'s High Score: " + highScore + "</h1> <p>Open up the app and beat their high score. Or you can download it on the Apple App Store through this link: <a href=\"https://itunes.apple.com/us/app/anteatermaps/id1274238050?mt=8\">https://itunes.apple.com/us/app/anteatermaps/id1274238050?mt=8</a>.</p> <p>Don't forget to challenge other friends and give us a five star rating on the App Store!</p> <p>&nbsp;</p> <p>From,</p> <p>MemShape</p>")
        let email = Email(
            personalizations: [personalization],
            from: Address(email: emailAddress),
            content: [htmlText],
            subject: "MemShape Challenge"
        )
        do {
            try session.send(request: email)
        } catch {
            print(error)
            let alert = UIAlertController(title: "Error", message: "Something went wrong with the email", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let alert = UIAlertController(title: "Success", message: "Challenge was successfully sent", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        print("Sent email")
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

}
