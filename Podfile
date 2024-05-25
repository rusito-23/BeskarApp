platform :ios, '16.0'
workspace 'BeskarWorkspace'

target 'Beskar' do
    project 'Beskar/Beskar.xcodeproj'
    use_frameworks!

    pod 'Realm', '10.18.0'
    pod 'RealmSwift', '10.18.0'
    pod 'TinyConstraints'
    pod 'SwiftyBeaver'
    pod 'Swinject'
    pod 'CombineDataSources'
    pod 'IQKeyboardManagerSwift'
    pod 'Eureka'
    pod 'Loaf'
    pod 'CombineCocoa'
end

target 'BeskarTests' do
    project 'Beskar/Beskar.xcodeproj'
    use_frameworks!

    pod 'Realm', '10.18.0'
    pod 'RealmSwift', '10.18.0'
    pod 'Swinject'
    pod 'Quick'
    pod 'Nimble'
end

target 'BeskarKit' do
    project 'BeskarKit/BeskarKit.xcodeproj'
    use_frameworks!

    pod 'Realm', '10.18.0'
    pod 'RealmSwift', '10.18.0'
    pod 'SwiftyBeaver'
end

target 'BeskarUI' do
    project 'BeskarUI/BeskarUI.xcodeproj'
    use_frameworks!

    pod 'TinyConstraints'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "16.0"
    end
  end
end
