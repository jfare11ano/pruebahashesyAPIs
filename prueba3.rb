require 'uri'
require 'net/http'
require 'json'
require 'pp'

def request(url, api_key = "K6j0PyEOPtrGodgBdrx5qr6Detq9L7d7Ffoi02pQ")
   url = URI("#{url}&api_key=#{api_key}")
   http = Net::HTTP.new(url.host, url.port)
   http.use_ssl = true
   request = Net::HTTP::Get.new(url)
   request["cache-control"] = 'no-cache'
   request["Postman-Token"] = '2178e596-b98d-4395-bfa7-e0ac0e2df059'
   response = http.request(request)
   JSON.parse(response.read_body)
end

datos = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10")

def build_a_web_page(data,hash)

texto = []
texto.push("<html>")
texto.push("<head>")
texto.push("</head>")
texto.push("<body>")
texto.push("<p>#{hash}</p>")
texto.push("</body>")
texto.push("</html>")

## pp data['photos'][0]['img_src']
## data hash, fotos es un array 26 fotos


file = File.open('index.html', "w")
file.puts texto

end

def count_photos(data)
## pp data['photos'][0]['camera']['name']
camera = []
data['photos'].count.times do |i|
    camera[i]= data['photos'][i]['camera']['name']
end
camuniq = camera.uniq
cantidad = Array.new(camuniq.count)
camuniq.count.times do |i|
    cantidad[i]=0
    camera.count.times do |j|
        if camera[j]==camuniq[i]
            cantidad[i]=cantidad[i]+1
        end
    end
end
pp camuniq.zip(cantidad).to_h
end

#count_photos(datos)
build_a_web_page(datos,count_photos(datos))