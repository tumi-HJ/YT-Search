//
//  JSONConverter.swift
//  CombineSample
//
//  Created by cmStudent on 2022/07/11.
//

import Foundation

class Fetcher {

    enum FetchError: Error {
        case clientError(Error)
        case networkError
        case statusError
    }
    /// GETで特別な設定のない通常のJSON取得処理ならばこちらを呼ぶ
    /// 処理の結果、成功か失敗かはここではわからないのでhandler側で対応する
    ///
    /// - Parameters:
    ///   - url: 取得したいJSONのURL。パラメータは付与された状態で渡すこと
    ///   - session: 指定がない場合はnil。
    ///   - handler: データを取得後の処理
    static func fetch(from url: URL, session: URLSession? = nil, handler: @escaping (Result<Data, Error>) -> ()) {

        // リクエストを作成してfetch(from:session:handler:)に投げる
        let request = URLRequest(url: url)
        self.fetch(from: request, session: session, handler: handler)

    }


    /// URLRequestの指定がある場合（POST送信など）はこちらを呼ぶ
    /// 処理の結果、失敗かどうかはResultで判定する
    ///
    /// - Parameters:
    ///   - request: 設定済みのrequest
    ///   - session: 指定がない場合はnil。
    ///   - handler: データ取得後の処理
    static func fetch(from request: URLRequest, session: URLSession? = nil, handler: @escaping (Result<Data, Error>) -> ()) {
        let session = (session == nil) ? URLSession(configuration: .default) : session!

        // わかりやすくdata,response,errorに型を書いていますが、型は省略できます
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            // errorはクライアント側のエラー
            if let error = error {
                handler(.failure(FetchError.clientError(error)))
                return
            }
            // 通信の結果データが取得できない、あるいはHTTPURLResponseが取得できていない場合は処理終了
            guard let data = data,
                  let response = response as? HTTPURLResponse else {
                      handler(.failure(FetchError.networkError))
                      return
                  }

            // レスポンスのステータスが200番台以外（正常以外）は処理終了
            if !(200...299).contains(response.statusCode) {
                print("ステータスコードが正常ではありません： \(response.statusCode)")
                handler(.failure(FetchError.statusError))
            }
            // 成功
            handler(.success(data))
        }
        task.resume()
    }
}
