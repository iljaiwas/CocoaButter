CocoaButter is aimed to become a dependency manager for Xcode projects written in Objective-C. It is heavily inspired by the [CocoaSeeds](https://github.com/devxoul/CocoaSeeds) project.

#Motivation

- I'm not a ruby programmer, nor do I want to become one just for the sake of fixing my build system. 
- I want to reduce the number of dependencies of my project's build chain (ruby, gem, pod specs, additional subprojects, etc.).
- I'm aware that such a simple system doesn't fit everyone's needs. If you have more complex needs, please look somewhere [else](https://cocoapods.org).

#Project status

This project needs help, it hasn't even reached proof-of-concept stage. I spent my self-imposed time budget on this project and need to start working on other tasks. Main blocker is this issue:


#Concept

You create an JSON file listing your GitHub dependencies in the directory containing your .xcodeproj file. This file could look like this:

    [
        {
            "repo" : "swisspol/GCDWebServer", 
            "revision" : "3.2.7", "includeFilter" : "GCDWebServer/*/*.{h,m}"
        },
        {
            "repo" : "appsquickly/Typhoon",
            "revision" : "3.3.3",
            "includeFilter": "{Source/{Configuration,Definition,Factory,TypeConversion,ios}/**/*.{h,m},Source/{Configuration,Definition,Factory,TypeConversion,ios}/*.{h,m}}"
       }
    ]

Run the `CocoaButter`command and it will download the specified source files and put references to them right in your Xcode project file.


#Requirements

Right now the project uses [CocoaSeeds](https://github.com/devxoul/CocoaSeeds) to source files from the [XcodeEditor](https://github.com/appsquickly/XcodeEditor). The goal is of course to become self-hosted at some point.
 
