require 'net/http'
require 'uri'

class Main
    def run()
        files = Dir['_posts/zmediumtomarkdown/*.md']
        files.each do |file|
            id = file.split("-").last.split(".").first

            lines = File.readlines(file)
            newLines = []

            ch_url = "https://zhgchg.li/posts/#{id}/"
            ch_url_exists = url_exists(ch_url)
            ch_text = "[本文中文版本](#{ch_url}){:target=\"_blank\"}\r\n"

            lines.each do |line|
                if line.include? "延伸閱讀" or line.include? "本文同步發表於" or line.include? "Like Z Realm" or line.include? "有任何問題及指教歡迎與我聯絡。" or line.include? "converted from Medium by [ZMediumToMarkdown]"
                    
                    newLines.append("\r\n\r\n===")
                    if ch_url_exists
                        newLines.append("\r\n\r\n#{ch_text}")
                    end
                    newLines.append("\r\n\r\n===\r\n\r\nThis article was first published in Traditional Chinese on Medium ➡️ [**View Here**](https://medium.com/p/#{id}){:target=\"_blank\"}\r\n")

                    break
                end
                newLines.append(line)
            end

            File.open(file, 'w') { |f| f.write(newLines.join) }

            puts "#{file} Optimze Done!"
        end

        puts "Optimze Markdown Footer Success!"
    end

    def url_exists(url)
        uri = URI.parse(url)
        request = Net::HTTP.new(uri.host, uri.port)
        request.use_ssl = (uri.scheme == 'https')
        
        path = uri.path.empty? ? '/' : uri.path
        response = request.request_head(path)
        
        response.code.to_i != 404
    end
end

main = Main.new()
main.run()
