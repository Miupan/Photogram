//
//  HomeViewController.swift
//  Photogram
//
//  Created by 美羽 on 2020/09/02.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var isImageSelected: Bool = false
    
    
    
    @IBOutlet var cameraImageView: UIImageView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
    }
    
    //ViewControllerに写真の値渡しをする&Segueが動作することをViewControllerに通知するメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //SegueのIDを確認して特定のSugueのときのみ動作させる
        if segue.identifier == "toViewController" {
            //遷移先のViewControllerを取得
            let nextView = segue.destination as? ViewController
            //遷移先の変数に値を渡す
            nextView?.ImageValue = self.cameraImageView!.image
            
        }
    }
    
    @IBAction func openAlbum() {
        //カメラロールを使えるかの確認
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            //カメラロールの画像を選択して表示するまでの一連の流れ
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            
            picker.allowsEditing = true
            
            present(picker, animated: true, completion: nil)
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        cameraImageView!.image = info[.editedImage]as?UIImage
        isImageSelected = true
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func editerButton() {
        if isImageSelected == false{
                let alert: UIAlertController = UIAlertController(title: "加工する写真がありません", message: "写真を選択してください", preferredStyle: .alert)
                             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                //ボタンが押された時の動作
                                print("OKボタンが押されました")
                            }
                               )
            )
            present(alert, animated: true,completion: nil)
        }else{
            //画面遷移
            self.performSegue(withIdentifier: "toViewController", sender: self)
        }
    }
}
            
            
//        if cameraImageView!.image == nil {
//            let alert: UIAlertController = UIAlertController(title: "加工する写真がありません", message: "写真を選択してください", preferredStyle: .alert)
//
//
//        } else {
//            //画面遷移実行
//            performSegue(withIdentifier: "toViewController", sender: nil)
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */




