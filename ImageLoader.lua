ImageLoader = class()

function ImageLoader:init(x)
    -- you can accept and set parameters here
    self.x = x
end

function ImageLoader:LoadImages()
    imageStatus='Ready' --tells draw it's ok to draw the scene (will be turned off if we have to download images)
    output.clear()
    --pass through Codea name of image and internet url
    --not in Codea, will be downloaded and saved
    
    img = {}
    
    for var=0,23,1 do
        img[var] = self:LoadImage('Project:gyrobot'..var..'-a','http://raw.githubusercontent.com/interactivenyc/CodeaJoystick/master/gyrobot'..var..'-a.png')
    end
    
    if imageStatus=='Ready' then self:imageLoadingDone() end
end

--downloads images one by one
function ImageLoader:LoadImage(fileName,url)
    self:log("url:"..url)
    local i=readImage(fileName)
    if i~=nil then return i end
    --not found, we need to download, add to queue (ie table)
    if imageTable==nil then
        imageTable={}
    end
    imageTable[#imageTable+1]={name=fileName,url=url}
    self:log('Queueing fileName: ',fileName)
    imageStatus='Loading'
    --if the first one, go ahead and download
    if #imageTable==1 then
        http.request(imageTable[1].url,self:ImageDownloaded())
        self:log('loading',imageTable[1].url)
    end
end

--saves downloaded images
function ImageLoader:ImageDownloaded(img)
    self:log(imageTable[1].name,'loaded')
    saveImage(imageTable[1].name,img)  --save
    table.remove(imageTable,1)
    --load next one if we have any more to do
    if #imageTable>0 then
        http.request(imageTable[1].url,self:ImageDownloaded())
        self:log('loading',imageTable[1].name)
    else
        LoadImages()
    end
end

function ImageLoader:imageLoadingDone()
    self:log("imageLoadingDone")
end

function ImageLoader:draw()
    -- Codea does not automatically call this method
end

function ImageLoader:touched(touch)
    -- Codea does not automatically call this method
end
function ImageLoader:log(msg)
    if msg then
        print("[ImageLoader] "..msg)
    end
    
end


