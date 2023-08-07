Pod::Spec.new do |spec|

  spec.name         = "MatrixFlow"
  spec.version      = "0.0.1"
  spec.summary      = "A CocoaPods library for swift-driven matrix multiplications"
  spec.swift_versions    = '5.0'
  
  spec.description  = <<-DESC
  MatrixFlow helps you perform multiplication/additions and more on MLMultiarray matrices
                   DESC

  spec.homepage     = "https://github.com/jadechoghari/MatrixFlow.git"
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "Jade Choghari" => "chogharijade@gmail.com" }
  spec.social_media_url   = "https://twitter.com/jadechoghari"

  spec.ios.deployment_target = "11.0"


  spec.source       = { :git => "https://github.com/jadechoghari/MatrixFlow.git", :tag => "#{spec.version}" }
  spec.source_files  = "MatrixFlow/**/*.{swift,h,m}"

end
