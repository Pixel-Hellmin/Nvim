function build()
    print("hello from build function")
    for dir in io.popen([[dir /b /ad]]):lines()
    do
        print(dir)
        if dir == "build.bat" then
            print("build.bat dir exists")
        end
    end
end