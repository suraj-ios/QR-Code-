//
//  ViewController.swift
//  ApplePayDemo
//
//  Created by IDEAQU on 28/06/21.
//  Copyright © 2021 IDEAQU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var qrCodeImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Get define string to encode
        let myString = "https://link.clintrialreferapp.com/?ibi=com%2Eios%2Eclintrialreferapp&isi=1475066830&apn=com%2Eclintrialrefer%2Eapp&link=https%3A%2F%2Fweb%2Eclintrialreferapp%2Ecom%3FtId%3D21030018%26appId%3D4"
        // Get data from the string
        let data = myString.data(using: String.Encoding.ascii)
        // Get a QR CIFilter
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return }
        // Input the data
        qrFilter.setValue(data, forKey: "inputMessage")
        // Get the output image
        guard let qrImage = qrFilter.outputImage else { return }
        // Scale the image
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledQrImage = qrImage.transformed(by: transform)
        // Invert the colors
        guard let colorInvertFilter = CIFilter(name: "CIColorInvert") else { return }
        colorInvertFilter.setValue(scaledQrImage, forKey: "inputImage")
        guard let outputInvertedImage = colorInvertFilter.outputImage else { return }
        // Replace the black with transparency
        guard let maskToAlphaFilter = CIFilter(name: "CIMaskToAlpha") else { return }
        maskToAlphaFilter.setValue(outputInvertedImage, forKey: "inputImage")
        guard let outputCIImage = maskToAlphaFilter.outputImage else { return }
        // Do some processing to get the UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else { return }
        let processedImage = UIImage(cgImage: cgImage)
        
        self.qrCodeImageView.image = processedImage
        
    }


}

