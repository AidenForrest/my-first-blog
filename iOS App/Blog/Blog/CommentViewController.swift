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
                        for var i in 0...posts.count - 1 {
                            if i == index {
                                DispatchQueue.main.async { [self] in
                                    author.text = posts[i - 1].author
                                    body.text = posts[i - 1].text
                                }
                            }
                            i+=1
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
                        for var i in 0...posts.count - 1 {
                            if posts[i].approved_comment != false {
                                DispatchQueue.main.async { [self] in
                                    self.segments.insertSegment(withTitle: "Comment " + String(i), at: i, animated: true)
                                    segments.selectedSegmentIndex = 0
                                    author.text = posts[0].author
                                    body.text = posts[0].text
                                }
                            }
                            i+=1
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
