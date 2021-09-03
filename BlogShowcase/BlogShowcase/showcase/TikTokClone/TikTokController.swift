//
//  TikTokController.swift
//  BlogShowcase
//
//  Created by kwanghyun won on 2021/01/14.
//  Copyright © 2021 wonkwh. All rights reserved.
//

import UIKit
import Nuke
import AVKit

final class TikTokController: UIViewController {
    let mediaUrls = [
        URL(string: "https://mimtok-dsp.s3.ap-northeast-2.amazonaws.com/20210108165757399_android_32445_20210108_165625_9405031.mp4")!,
        URL(string: "https://mimtok-dsp.s3.ap-northeast-2.amazonaws.com/20210112160600558_android_32463_20210112_160517_2597817.mp4")!,
        URL(string: "https://mimtok-dsp.s3.ap-northeast-2.amazonaws.com/20201228185221372_android_18841_20201228_185145_1298999.mp4")!,
        URL(string: "https://mimtok-dsp.s3.ap-northeast-2.amazonaws.com/20201231123458813_android_18831_20201231_123441_4759226.mp4")!,
        URL(string: "https://mimtok-dsp.s3.ap-northeast-2.amazonaws.com/20201229112844988_android_18842_20201229_112810_8023170.mp4")!,
        URL(string: "https://mimtok-dsp.s3.ap-northeast-2.amazonaws.com/20201216230400899_android_18811_20201216_230324_624399.mp4")!,
        URL(string: "https://mimtok-dsp.s3.ap-northeast-2.amazonaws.com/20210111155009597_android_18801_20210111_154946_5402258.mp4")!,
        URL(string: "https://mimtok-dsp.s3.ap-northeast-2.amazonaws.com/20201231011545612_android_19928_20201231_011447_6816809.mp4")!,
        URL(string: "https://mimtok-dsp.s3.ap-northeast-2.amazonaws.com/20201228185131544_android_18841_20201228_185104_8844923.mp4")!,
        URL(string: "https://mimtok-dsp.s3.ap-northeast-2.amazonaws.com/20201224185508703_android_18799_20201224_185341_2793370.mp4")!,
        URL(string: "https://mimtok-dsp.s3.ap-northeast-2.amazonaws.com/20210107171248857_32445_IOS_20210107171224_or.mp4")!,
        URL(string: "https://mimtok-dsp.s3.ap-northeast-2.amazonaws.com/2021011015583349_android_32532_20210110_155745_4513305.mp4")!,
        URL(string: "https://mimtok-dsp.s3.ap-northeast-2.amazonaws.com/20210104012538514_android_27660_20210104_012506_0825867.mp4")!,
        URL(string: "https://mimtok-dsp.s3.ap-northeast-2.amazonaws.com/20210103001509214_android_29174_20210103_001359_9512661.mp4")!,
        URL(string: "https://mimtok-dsp.s3.ap-northeast-2.amazonaws.com/20210106224715412_android_32438_20210106_224559_6206602.mp4")!,
        URL(string: "https://mimtok-dsp.s3.ap-northeast-2.amazonaws.com/20210108150359469_android_32446_20210108_150333_5442340.mp4")!,
        URL(string: "https://mimtok-dsp.s3.ap-northeast-2.amazonaws.com/20201230170001474_android_18849_20201230_165914_1539736.mp4")!,
        URL(string: "https://mimtok-dsp.s3.ap-northeast-2.amazonaws.com/20210101195542850_android_26581_20210101_195423_0536987.mp4")!,
        URL(string: "https://mimtok-dsp.s3.ap-northeast-2.amazonaws.com/20210108164832749_android_26425_20210108_164529_7546254.mp4")!
    ]
    
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.dataSource = self
        view.prefetchDataSource = self
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        view.isPagingEnabled = true
        view.rowHeight = UIScreen.main.bounds.height
        view.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        return view
    }()
    
    let preheater = ImagePreheater()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        TemporaryVideoStorage.shared.removeAll()
        ImageDecoders.MP4.register()

        
        tableView.fillSuperview()
        
        tableView.register(VideoTableCell.self, forCellReuseIdentifier: "VideoTableCell")
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.reloadData()
    }
}

extension TikTokController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaUrls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableCell", for: indexPath) as? VideoTableCell else {
            return UITableViewCell()
        }
        cell.setVideo(with: mediaUrls[indexPath.row])
        print("cellForRowAt: \(indexPath.row))")
        return cell
    }
}

extension TikTokController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let urls = indexPaths.map { mediaUrls[$0.row] }
        preheater.startPreheating(with: urls)
        print("prefetchItemsAt: \(stringForIndexPaths(indexPaths))")
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        let urls = indexPaths.map { mediaUrls[$0.row] }
        preheater.stopPreheating(with: urls)
            print("cancelPrefetchingForItemsAt: \(stringForIndexPaths(indexPaths))")
    }
    
    func stringForIndexPaths(_ indexPaths: [IndexPath]) -> String {
        guard indexPaths.count > 0 else {
            return "[]"
        }
        let items = indexPaths
            .map { return "\(($0 as NSIndexPath).item)" }
            .joined(separator: " ")
        return "[\(items)]"
    }
}



