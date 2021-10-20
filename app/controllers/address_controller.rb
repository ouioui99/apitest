class AddressController < ApplicationController

  def show
    #URLに入れるためにUriライブラリのencode_www_formメソッドを使用し文字列を変換している
    params = URI.encode_www_form({zipcode:"2270066"})

    #変換したものをAPIを叩けるURLに挿入し、URIオブジェクトに変更している
    uri = URI.parse("http://zipcloud.ibsnet.co.jp/api/search?#{params}")

    #上のURIオブジェクトのリクエストパラメータ（クエリ文字列）をインスタンス変数に格納
    @query = uri.query

    
    response = Net::HTTP.start(uri.host, uri.port) do |h|

      # 接続時に待つ最大秒数を設定
      h.open_timeout = 5

      # 読み込み一回でブロックして良い最大秒数を設定
      h.read_timeout = 10

      #ここでAPiを叩いている
      h.get(uri.request_uri)
    end

    # 例外処理
    begin

      # 成功した場合
      case response
      when Net::HTTPSuccess
         # JSON形式のresponseのbody要素を、hashに変換
        @result = JSON.parse(response.body)
        @zipcode = @result["results"][0]["zipcode"]
        @address1 = @result["results"][0]["address1"]
        @address2 = @result["results"][0]["address2"]
        @address3 = @result["results"][0]["address3"]
      
      #別のURLに飛ばされてしまった時のエラーメッセージ
      when Net::HTTPRedirection
        @massage = "Redirection: code=#{response.code} message=#{response.message}"

      #その他のエラーメッセージ
      else
        @message = "HTTP ERROR: code=#{response.code} message=#{response.message}"
      end
      # エラー時処理
    rescue IOError => e
      @message = "e.message"
    rescue TimeoutError => e
      @message = "e.message"
    rescue JSON::ParserError => e
      @message = "e.message"
    rescue => e
      @message = "e.message"

    end
  end
end
