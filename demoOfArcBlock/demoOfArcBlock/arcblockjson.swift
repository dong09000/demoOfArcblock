//
//  arcblockjson.swift
//  demoOfArcBlock
//
//  Created by 董月峰 on 2024/12/19.
//

import Foundation


struct ArcblockJson: Codable {
    let countAll: Int
    let total: Int
    let data: [Article]
}

// 有脏数据，里面的内容其实也是这个
struct Meta: Codable {
    let unpublishedChanges: Int
//    let explicitSlug: Bool
}

// 对应整个JSON数据的主结构体
struct Article: Codable {
    let latestCommenters: [String]
    let meta: Meta
    let id: String
    let slug: String
    let title: String
    let author: String
    let cover: String
    let excerpt: String
    let boardId: String
    let createdAt: String
    let updatedAt: String
    let commentCount: Int
    let type: String
    let status: String
    let publishTime: String
    let labels: [String]
    let locale: String
}
