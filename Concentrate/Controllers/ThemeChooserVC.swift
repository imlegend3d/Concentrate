//
//  ThemeChooserVC.swift
//  Concentrate
//
//  Created by David on 2019-09-05.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

class ThemeChooserVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISplitViewControllerDelegate{
   
    @IBOutlet weak var themeChooserTV: UITableView!
    
    let emojiThemes = Emoji()
    
    var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        themeChooserTV.delegate = self
        themeChooserTV.dataSource = self
        
        setUpViews()
    }
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    func setUpViews(){
        
        view.backgroundColor = UIColor.lightGray
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiThemes.themes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "theme", for: indexPath)
        
        cell.textLabel?.text = emojiThemes.themes[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        
        performSegue(withIdentifier: "themeToGame", sender: tableView.cellForRow(at: indexPath))
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let selectedIndex = selectedIndex else {return }
        
        if segue.identifier == "themeToGame", selectedIndex <= emojiThemes.themes.count, selectedIndex >= 0 {
            
            if let concentrationVC = segue.destination as? ConcentrationVC {
                concentrationVC.selectedNumber = selectedIndex
                concentrationVC.theme = emojiThemes.selectEmojis(index: selectedIndex)
            }
        }
    }
}
