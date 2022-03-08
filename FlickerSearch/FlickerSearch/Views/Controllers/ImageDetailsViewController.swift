//
//  ImageDetailsViewController.swift
//  FlickerSearch
//
//  Created by kdodla on 3/7/22.
//

import UIKit
import Kingfisher
import WebKit

class ImageDetailsViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageSizeLabel: UILabel!
    @IBOutlet var imageTitle: UILabel!
    @IBOutlet var descriptionWebview: WKWebView!
    @IBOutlet var contentView: UIView!
    
    var imageModel: Items?
    var viewModel: ImageSearchViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        //setup UI
        descriptionWebview.navigationDelegate = self
        setupUI()
    }
    
    func setupUI() {
        let share = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(shareButtonAction))
        navigationItem.rightBarButtonItems = [share]
        
        guard let item = imageModel else {
            self.imageView.image = UIImage(named: ImageName.placeholderCvsImage)
            self.imageTitle.text = ConstantStrings.placeholderTitle.uppercased()
            return
        }
        if let urlString = item.media?.mediaLink, let url = URL(string: urlString) {
            self.imageView.kf.setImage(with: url, placeholder: UIImage(named: ImageName.placeholderCvsImage), options: nil) { [weak self] result in
                switch result {
                case .success(_):
                    self?.setImageSize()
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
        } else {
            self.imageView.image = UIImage(named: ImageName.placeholderCvsImage)
        }
        
        if let title = item.title, title.count > 1 {
            self.imageTitle.text = title
        } else {
            self.imageTitle.text = ConstantStrings.placeholderTitle.uppercased()
        }
        
        if let description = item.description {
            descriptionWebview.loadHTMLString(ConstantStrings.headerString + description, baseURL: nil)
        }
    }
    
    @IBAction func shareButtonAction() {
        guard let img = self.imageView.image else {
            return
        }
        let activityViewController = UIActivityViewController(activityItems: [img], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func setImageSize() {
        viewModel?.setImageSize(imageView: self.imageView, completionBlock: { size in
            self.imageSizeLabel.text = size
        })
    }
}

extension ImageDetailsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.navigationType == WKNavigationType.linkActivated {
                decisionHandler(WKNavigationActionPolicy.cancel)
                return
            }
            decisionHandler(WKNavigationActionPolicy.allow)
     }
}
