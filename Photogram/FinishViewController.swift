//
//  FinishViewController.swift
//  Photogram
//
//  Created by 美羽 on 2020/09/02.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

class FinishImageViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    @IBOutlet var finishImageView:UIImageView!
    //ViewControllerから写真の値渡し
    var finishimageValue: UIImage!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        finishImageView?.image = finishimageValue
    }
    
    @IBAction func savePhoto() {
        UIImageWriteToSavedPhotosAlbum(finishImageView.image!, nil, nil, nil)
        
    }
    
    @IBAction func snsPhoto() {
        //シェアの時に一緒に投稿されるコメント
        let shareText = "写真加工したよ〜"
        //シェアの時に投稿される写真
        let shareImage = finishImageView.image!
        //投稿する写真とコメントの準備
        let activityItems:[Any] = [shareText,shareImage]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        let excludedActivityTypes = [UIActivity.ActivityType.postToWeibo, .saveToCameraRoll, .print]
        activityViewController.excludedActivityTypes = excludedActivityTypes
        //iPadで表示するためのコード
        activityViewController.popoverPresentationController?.sourceView = view
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 200, y: 1000, width: 30, height: 20)
        
        present(activityViewController, animated: true, completion: nil )
        
        
    }
    @IBAction func homeButton() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


