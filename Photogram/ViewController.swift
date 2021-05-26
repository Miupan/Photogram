//
//  ViewController.swift
//  Photogram
//
//  Created by 美羽 on 2020/09/02.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //画像加工するもとの写真
    var originalImage: UIImage!
    //画像加工するフィルターの宣言
    var filter:CIFilter!
    
    @IBOutlet var ReceivedImageView: UIImageView!
    //HomeViewControllerから写真の値渡し
    var ImageValue: UIImage!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ReceivedImageView.image =  ImageValue
        originalImage = ReceivedImageView.image
    }
    
    //FinishViewControllerへの値渡し
    //segueが動作することをViewControllerに通知するメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segueのIDを確認して特定のSegueのときにのみ動作
        if segue.identifier == "toFinishImageViewController" {
            //遷移先のViewControllerを取得
            let finish = segue.destination as? FinishImageViewController
            //遷移先の変数に値を渡す
            finish?.finishimageValue = self.ReceivedImageView.image
        }
    }
    
    
    //人物フィルターメソッド
    @IBAction func personFilter() {
        filter = CIFilter(name: "CIColorControls")!
        //彩度
        filter.setValue(1.5, forKey: "inputSaturation")
        //明度
        filter.setValue(0.3, forKey: "inputBrightness")
        //コントラスト
        filter.setValue(1.5, forKey: "inputContrast")
        
        self.editimage()
        
    }
    //景色フィルターメソッド
    @IBAction func viewFilter() {
        filter = CIFilter(name: "CIColorPolynomial")!
        filter.setValue(CIVector(x: 0, y: 0, z: 0, w: 0.4), forKey: "inputRedCoefficients")
        filter.setValue(CIVector(x: 0, y: 0, z: 0.5, w: 0.8), forKey: "inputGreenCoefficients")
        filter.setValue(CIVector(x: 0, y: 0, z: 0.5, w: 1), forKey: "inputBlueCoefficients")
        filter.setValue(CIVector(x: 0, y: 1, z: 1, w: 1), forKey: "inputAlphaCoefficients")
        self.editimage()
    }
    //料理フィルターメソッド
    @IBAction func foodFilter() {
        filter = CIFilter(name: "CIColorControls")!
        //彩度
        filter.setValue(2, forKey: "inputSaturation")
        //明度
        filter.setValue(0.3, forKey: "inputBrightness")
        //コントラスト
        filter.setValue(1.6, forKey: "inputContrast")
        self.editimage()
        
    }
    //イラスト風フィルターメソッド
    @IBAction func artFilter() {
        filter = CIFilter(name: "CIColorPosterize")
        self.editimage()
        
    }
    //モノクロフィルターメソッド
    @IBAction func monoFilter() {
        filter = CIFilter(name: "CIPhotoEffectMono")!
        self.editimage()
    }
    
    //レトロなフィルターメソッド
    @IBAction func retroFilter() {
        filter = CIFilter(name: "CIPhotoEffectInstant")!
        self.editimage()
    }
    
    //完成画面に送る遷移するボタン
    @IBAction func finishButton(){
        //FinishViewControllerへ画面遷移実行
        performSegue(withIdentifier: "toFinishImageViewController", sender: nil)
        
    }
    //戻るボタン
    @IBAction func backButton() {
        self.dismiss(animated: true, completion: nil)
    }
    //編集のメソッド
    func editimage() {
        let filterImage: CIImage = CIImage(image: originalImage!)!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        ReceivedImageView.image = UIImage(cgImage: cgImage!)
    }




}
