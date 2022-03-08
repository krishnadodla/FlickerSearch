//
//  File.swift
//  FlickerSearch
//
//  Created by kdodla on 3/7/22.
//

import UIKit
import Foundation
import Kingfisher

class ImageSearchViewModel {
    var filteredTableData = [Items]()
    
    //Return number of rows
    func numberOfRows() -> Int {
        return filteredTableData.count
    }
    
    // Cell for row method
    func imageCell(searchController: UISearchController, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ConstantStrings.imageCell, for: indexPath) as? ImageTableViewCell, filteredTableData.count > 0 {
            cell.configure(with: filteredTableData[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    //Show image details
    func showDetailsPage(from viewController: UIViewController, indexpath: IndexPath){
        if let vc = UIStoryboard.init(name: ConstantStrings.storyBoardName, bundle: Bundle.main).instantiateViewController(withIdentifier: ConstantStrings.detilsVC) as? ImageDetailsViewController {
            vc.imageModel = filteredTableData[indexpath.row]
            vc.viewModel = self
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //Calculate image width x height
    func setImageSize(imageView: UIImageView, completionBlock: @escaping(String) -> ()) {
        if let image = imageView.image {
            let heightInPoints = image.size.height
            let heightInPixels = heightInPoints * image.scale
            
            let widthInPoints = image.size.width
            let widthInPixels = widthInPoints * image.scale
            
            completionBlock("\(widthInPixels)x\(heightInPixels)")
        }
    }
    
    //API call to fetch the images from Flicker
    @objc func fetchTheResults(searchText: String = "", completionBlock: @escaping() -> Void)  {
        //remove existing results
        filteredTableData.removeAll(keepingCapacity: false)
        
        //Load from API
        NetworkUtil().fetchImages(for: searchText, completionHandler: {[weak self] images in
            if let imageResults = images.items {
                self?.filteredTableData = imageResults
                completionBlock()
            }
        })
    }
}
