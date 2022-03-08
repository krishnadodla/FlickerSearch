//
//  ImageSearchTableTableViewController.swift
//  FlickerSearch
//
//  Created by kdodla on 3/7/22.
//

import UIKit

class ImageSearchTableViewController: UITableViewController {
    var imageSearchViewModel = ImageSearchViewModel()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup UI elements
        setupUI()
        
        //Load initial Data
//        loadDefaultData()
    }
    
    func setupUI() {
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.obscuresBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        
        // Reload the table
        tableView.reloadData()
    }
}

extension ImageSearchTableViewController {
    func loadDefaultData() {
        imageSearchViewModel.fetchTheResults(searchText: "", completionBlock: {
            //Refresh UI to display latest results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}

extension ImageSearchTableViewController {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageSearchViewModel.numberOfRows()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return imageSearchViewModel.imageCell(searchController: resultSearchController, tableView: tableView, indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        resultSearchController.isActive = false
        tableView.deselectRow(at: indexPath, animated: true)
        imageSearchViewModel.showDetailsPage(from: self, indexpath: indexPath)
    }
}

extension ImageSearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //Cancel the action
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.loadSearchResults), object: nil)
        
        //Perform teh search
        self.perform(#selector(self.loadSearchResults), with: nil, afterDelay: 2.0)
    }
    
    @objc func loadSearchResults() {
        //Fetch the latest results based on user input
        guard let searchString = resultSearchController.searchBar.text, searchString.count > 1 else {
//            loadDefaultData()
            return
        }
        
        imageSearchViewModel.fetchTheResults(searchText: searchString) {
            //Refresh UI to display latest results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
