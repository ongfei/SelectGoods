

Pod::Spec.new do |s|

  s.name         = "SelectGoods"
  s.version      = "1.0"
  s.summary      = "商品类型选择"

 

  s.homepage     = "http://github.com/ongfei/SelectGoods"

  s.license      = “ONG”

  s.author             = { "ongfei" => "ong_fei@163.com" }

  s.platform     = :ios, "7.0"

  s.source       = { :git => "http://github.com/ongfei/SelectGoods.git", :tag => "1.0" }


  s.source_files  = ‘SelectGoods/SelectGoods/**/*.{h,m}’


 
   s.resources = ‘SelectGoods/SelectGoods/*.png’



   s.requires_arc = true

end