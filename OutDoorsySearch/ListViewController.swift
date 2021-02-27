//
//  ListViewController.swift
//  OutDoorsySearch
//
//  Created by Sharat on 2/26/21.
//

import UIKit

class ListViewController: UIViewController {
    let defaultRowHeight: CGFloat = 81.0
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var listView: UITableView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var noResultsLabel: UILabel!
    var outDoorsy: [Outdoorsy]?
    var outDoorsyRespone: OutdoorsyResponse?
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.tableFooterView = UIView(frame: .zero)
        listView.estimatedRowHeight = defaultRowHeight
        listView.rowHeight = UITableView.automaticDimension
        self.activityView.startAnimating()
        DispatchQueue.main.async {
            self.getOutDoorsDetails([:])
        }
        // Do any additional setup after loading the view.
    }
    func getOutDoorsDetails(_ params: [String: Any]) {
        APIHandler.getOutDoorsyDetails(params) { (reponse, error) in
            self.activityView.stopAnimating()
            guard let responseobj = reponse else{
                return
            }
            guard let obj = responseobj.data else {
                return
            }
            self.outDoorsyRespone = responseobj
            self.outDoorsy = obj
            self.noResultsLabel.isHidden = self.outDoorsy?.count ?? 0 > 0
            self.listView.reloadData()
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outDoorsyRespone?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ListTableCell else {
            return UITableViewCell()
        }
        cell.tag = indexPath.row
        cell.updateListCell(outDoorsyRespone)
        return cell
    }
}

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let params = ["keywords": searchText]
        self.getOutDoorsDetails(params as [String : Any])
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}


