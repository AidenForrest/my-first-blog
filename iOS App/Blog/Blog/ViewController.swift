//
//  ViewController.swift
//  Blog
//
//  Created by Aiden Forrest on 13/07/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segments: UISegmentedControl!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var created: UILabel!
    @IBOutlet weak var updated: UILabel!
    let defaults = UserDefaults.standard
    
    
    @IBAction func `switch`(_ sender: Any, forEvent event: UIEvent) {
        let index = segments.selectedSegmentIndex
        guard let url = URL(string: "http://aidenma182.pythonanywhere.com/post/api") else{return}
        let task = URLSession.shared.dataTask(with: url) { [self]
            data, response, error in
            
            let decoder = JSONDecoder()
            
            if let data = data {
                do {
                    let posts = try decoder.decode([Post].self, from: data)
                    for var i in 0...posts.count - 1 {
                        if i == index {
                            DispatchQueue.main.async {
                                postTitle.text = posts[i - 1].title
                                body.text = posts[i - 1].text
                                created.text = posts[i - 1].created_date
                                updated.text = posts[i - 1].published_date
                            }
                        }
                        i+=1
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let url = URL(string: "http://aidenma182.pythonanywhere.com/post/api") else{return}
        let task = URLSession.shared.dataTask(with: url) { [self]
            data, response, error in
            
            let decoder = JSONDecoder()
            
            if let data = data {
                do {
                    let posts = try decoder.decode([Post].self, from: data)
                    DispatchQueue.main.async {
                        self.segments.removeAllSegments()
                    }
                    for var i in 0...posts.count - 1 {
                        DispatchQueue.main.async {
                            self.segments.insertSegment(withTitle: "Post " + String(i), at: i, animated: true)
                            segments.selectedSegmentIndex = 0
                            postTitle.text = posts[0].title
                            body.text = posts[0].text
                            created.text = posts[0].created_date
                            updated.text = posts[0].published_date
                        }
                        i+=1
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
}


