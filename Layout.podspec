Pod::Spec.new do |s|
  s.name = "Layout"
  s.version = "0.1"
  s.summary = " "
  s.description  = <<-DESC
    Readable layout constraints.
  DESC
  s.homepage = "git@github.com:noremac/Layout.git"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Cameron Pulsford" => "cpulsfor@me.com" }
  s.ios.deployment_target = "11.0"
  s.source = { :git => "git@github.com:noremac/Layout.git.git", :tag => s.version.to_s }
  s.source_files = "Sources/**/*"
  s.frameworks = "UIKit"
end
