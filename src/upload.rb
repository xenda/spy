require 'rubygems'; require 'net/http/post/multipart'; require 'hash_improvement'

class Upload
  
  def self.send(key,filename)
    url = URI.parse("http://www.imageshack.us/upload_api.php")
    res = ""
    File.open(filename) do |image|
      req = Net::HTTP::Post::Multipart.new url.path,
        "fileupload" => UploadIO.new(image, "image/png", filename)
      res = Net::HTTP.start(url.host, url.port) do |http|
        http.request(req)
      end
    end
  
    if res && xml = res.body
      hash = Hash.from_xml(xml)
      raise hash['error'][0]["content"] if hash['error']
      url = hash['links'][0]["image_link"]
      return url
    else
      return nil
    end
  end
end