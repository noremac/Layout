Pod::Spec.new do |s|
  s.name = "Layout"
  s.version = "1.0"
  s.summary = "Readable layout constraints."
  s.description  = <<-DESC
    Readable layout constraints.
  DESC
  s.homepage = "git@github.com:noremac/Layout.git"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Cameron Pulsford" => "cpulsfor@me.com" }
  s.ios.deployment_target = "11.0"
  s.source = { :git => "https://github.com/noremac/Layout.git", :tag => s.version.to_s }
  s.source_files = "Sources/**/*.swift"
  s.frameworks = "UIKit"
  s.swift_version = "5.0"
end
