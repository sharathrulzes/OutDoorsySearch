//
//  ListViewController.swift
//  OutDoorsySearch
//
//  Created by Sharat on 2/26/21.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var listView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.tableFooterView = UIView(frame: .zero)
        listView.estimatedRowHeight = 111
        listView.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
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

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ListTableCell else {
            return UITableViewCell()
        }
        cell.tag = indexPath.row
        cell.titleLabel.text = "Hello World!"
        return cell
    }
}
