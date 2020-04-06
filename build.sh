#!/bin/sh
echo ---- clear ----
rm -rf ./dist
mkdir ./dist
xcodebuild clean -project boringssl-ios.xcodeproj -target boringssl-ios
echo ---- build ----
#
echo ---- building x32 x64 ----
xcodebuild build -sdk iphonesimulator13.2 -arch i386 -project boringssl-ios.xcodeproj -target boringssl-ios -configuration Release
cp -rf build/Release-iphonesimulator/boringssl_ios.framework/boringssl_ios build/Release-iphonesimulator/boringssl_ios.framework/boringssl_ios_x32
xcodebuild build -sdk iphonesimulator13.2 -arch x86_64 -project boringssl-ios.xcodeproj -target boringssl-ios -configuration Release
cp -rf build/Release-iphonesimulator/boringssl_ios.framework/boringssl_ios build/Release-iphonesimulator/boringssl_ios.framework/boringssl_ios_x64
lipo -create build/Release-iphonesimulator/boringssl_ios.framework/boringssl_ios_x32 build/Release-iphonesimulator/boringssl_ios.framework/boringssl_ios_x64 -output build/Release-iphonesimulator/boringssl_ios.framework/boringssl_ios
rm -rf build/Release-iphonesimulator/boringssl_ios.framework/boringssl_ios_x32
rm -rf build/Release-iphonesimulator/boringssl_ios.framework/boringssl_ios_x64
#
echo ---- building armv7s arm64 ----
xcodebuild build -sdk iphoneos13.2 -arch armv7s -project boringssl-ios.xcodeproj -target boringssl-ios -configuration Release
cp -rf build/Release-iphoneos/boringssl_ios.framework/boringssl_ios build/Release-iphoneos/boringssl_ios.framework/boringssl_ios_x32
xcodebuild build -sdk iphoneos13.2 -arch arm64 -project boringssl-ios.xcodeproj -target boringssl-ios -configuration Release
cp -rf build/Release-iphoneos/boringssl_ios.framework/boringssl_ios build/Release-iphoneos/boringssl_ios.framework/boringssl_ios_x64
lipo -create build/Release-iphoneos/boringssl_ios.framework/boringssl_ios_x32 build/Release-iphoneos/boringssl_ios.framework/boringssl_ios_x64 -output build/Release-iphoneos/boringssl_ios.framework/boringssl_ios
rm -rf build/Release-iphoneos/boringssl_ios.framework/boringssl_ios_x32
rm -rf build/Release-iphoneos/boringssl_ios.framework/boringssl_ios_x64
#
cp -rf build/Release-iphoneos/boringssl_ios.framework dist/boringssl_ios.framework
lipo -create build/Release-iphoneos/boringssl_ios.framework/boringssl_ios build/Release-iphonesimulator/boringssl_ios.framework/boringssl_ios -output dist/boringssl_ios.framework/boringssl_ios
echo ---- info ----
lipo -info dist/boringssl_ios.framework/boringssl_ios
