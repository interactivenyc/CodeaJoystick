

function initImageLoader()
    log("init")
    LoadImages()
    sprite()
end

function LoadImages()
    imageStatus='Ready' --tells draw it's ok to draw the scene (will be turned off if we have to download images)
    output.clear()
    --pass through Codea name of image and internet url
    --not in Codea, will be downloaded and saved
    
    img = {}
    
    for var=0,23,1 do
        img[var] = LoadImage('Project:gyrobot'..var..'-a','https://raw.githubusercontent.com/interactivenyc/CodeaJoystick/master/gyrobot'..var..'-a.png')
        --img[var] = LoadImage('Project:gyrobot'..var..'-b','https://raw.githubusercontent.com/interactivenyc/CodeaJoystick/master/gyrobot'..var..'-b.png')
    end
    
    img2 = {}
    
    for var2=0,23,1 do
        img2[var2] = LoadImage('Project:gyrobot'..var2..'-b','https://raw.githubusercontent.com/interactivenyc/CodeaJoystick/master/gyrobot'..var2..'-b.png')
    end
    
    
    if imageStatus=='Ready' then AllImagesDownloaded() end
end

--downloads images one by one
function LoadImage(fileName,url)
    print("url:"..url)
    local i=readImage(fileName)
    if i~=nil then return i end
    --not found, we need to download, add to queue (ie table)
    if imageTable==nil then
        imageTable={}
    end
    imageTable[#imageTable+1]={name=fileName,url=url}
    print('Queueing fileName: ',fileName)
    imageStatus='Loading'
    --if the first one, go ahead and download
    if #imageTable==1 then
        http.request(imageTable[1].url,ImageDownloaded)
        print('loading',imageTable[1].url)
    end
end

--saves downloaded images
function ImageDownloaded(img)
    print(imageTable[1].name,'loaded')
    saveImage(imageTable[1].name,img)  --save
    table.remove(imageTable,1)
    --load next one if we have any more to do
    if #imageTable>0 then
        http.request(imageTable[1].url,ImageDownloaded)
        print('loading',imageTable[1].name)
    else
        LoadImages()
    end
end

function AllImagesDownloaded()
    output.clear()
    print("AllImagesDownloaded");
end

