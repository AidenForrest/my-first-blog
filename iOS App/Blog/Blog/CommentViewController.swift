//
//  CommentViewController.swift
//  Blog
//
//  Created by Aiden Forrest on 13/07/2022.
//

import UIKit

class CommentViewController: UIViewController {

    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var segments: UISegmentedControl!
    
    // Global var for telling which post to load comments for
    struct vars {
        static var post = 1
    }
    
    // Loads comments when segment is selected
    @IBAction func `switch`(_ sender: Any) {
        let index = segments.selectedSegmentIndex
        // Gets comments again as global variable would not work?
        guard let url = URL(string: "http://aidenma182.pythonanywhere.com/post/" + String(vars.post) + "/comment/api") else{return}
        let task = URLSession.shared.dataTask(with: url) { [self]
            data, response, error in
            
            let decoder = JSONDecoder()
            
            if let data = data {
                do {
                    let posts = try decoder.decode([Comment].self, from: data)
                    if posts.count != 0 {
                        // Post for loop update
                        var count = 0
                        for post in posts {
                            if count == index {
                                DispatchQueue.main.async { [self] in
                                    author.text = post.author
                                    body.text = post.text
                                  }
                            }
                            count += 1
                        }
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

        // Loads comments for the first time and creates segments accordingly
        guard let url = URL(string: "http://aidenma182.pythonanywhere.com/post/" + String(vars.post) + "/comment/api") else{return}
        let task = URLSession.shared.dataTask(with: url) { [self]
            data, response, error in
            
            let decoder = JSONDecoder()
            
            if let data = data {
                do {
                    let posts = try decoder.decode([Comment].self, from: data)
                    DispatchQueue.main.async {
                        self.segments.removeAllSegments()
                    }
                    if posts.count != 0 {
                        var count = 0
                        for comment in posts {
                            if comment.approved_comment {
                                DispatchQueue.main.async { [self] in
                                    self.segments.insertSegment(withTitle: comment.author, at: count, animated: true)
                                    print(count) // prints 1,2 and 3 however the title of all the segments is 'Comment 3'?
                                    segments.selectedSegmentIndex = 0
                                    author.text = comment.author
                                    body.text = comment.text
                                }
                            }
                            count += 1
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
