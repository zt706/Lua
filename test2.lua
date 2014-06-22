
local cclog = function(...)
	print(string.format(...))
end

cclog("require is " .. 3+5)

local function createDog()
	--定义宽和高
	local frameWidth = 105
	local frameHeight = 95


--创建动画
local textureDog = CCTextureCache:shartdTextureCache():addImage("dog.png")
local rect = CCRectMake(0, 0, frameWidth, frameHeight)

local frame0 = CCSpriteFrame:frameWidthTexture(textureDog, rect)

rect = CCRectMake(frameWidth, 0, frameWidth, frameHeight)
local frame1 = CCSpriteFrame:frameWithTexture(textureDog, rect)

local spriteDog = CCSprite:spriteWithSpriteFrame(frame0)

spriteDog.isPaused = false

spriteDog.setPosition(0, winSize.height / 4 *3)

local animFrames = CCMutebleArray_CCSpriteFrame__:new(2)
	animFrames:addObject(frame0)
	animFrames:addObject(frame1)


local animation = CCAnimation:animationWithFrames(animFrames, 0.5)
local animate = CCAnimate:actionWithAnimation(animation, false)

	spriteDog:runAction(CCRepeatForever:actionWithAnimation(animate))

local function tick()
	if spriteDog.isPaused then return end
		local x, y = spriteDog:getPosition()

		if x > winSize.width then
			x = 0
		else
			x = x + 1
		end

		spriteDog:setPositionX(x)
	end

	CCScheduler:sharedScheduler():scheduleScriptFunc(tick, 0, false)

	return spriteDog
end

--创建农场
local function createLayerFrame()
	local layerFram = CCLayer:node()

	local bg = CCSprite:spriteWithFile("farm.jpg")
	bg.setPosition(winSize.width / 2 + 80, winSize.height / 2)

	layerFram:addChild(bg)

	--创建沙地块
	for i = 0, 3 do
		for j = 0, 1 do
			local spriteLand = CCSprite:spriteWithFile("land.jpg")
			spriteLand:setPosition(200 + j * 182 -(i % 2) * 182 / 2, 10 + i * 94 / 2)
			layerFram:addChild(spriteLand)
		end
	end

	local textureCrop = CCTextureCache:sharedTExtureCache():addImage("crop.png")
	local frameCrop = CCSpriteFrame:frameWithTexture(textureCrop, CCRectMake(0, 0, 105, 95))

	for i = 0, 3 do
		for j = 0, 1 do
			local spriteCrop = CCSpriteFrame:frameWithTexture(textureCrop, CCRectMake(0, 0, 105, 95))
			spriteCrop:setPosition(10 + 200 + j * 180 - i % 2 * 90, 30 + 10 + i * 95 / 2)
			layerFram:addChild(spriteCrop)
		end
	end

	local spriteDog = creatDog()
	layerFram:addChild(spriteDog)

	local touchBeginPoint = nil

	local function onTouchBegan(x,y)
		cclog("onTouchBegan :%0.2f, %0.2f", x, y)
		touchBeginPoint = {x = x, y = y}
		spriteDog.isPaused = true
		return true
	end

	local function onTouchMoved(x, y)
		cclog("onTouchMoved: %0.2f, %0.2f", x, y)
		if touchBeginPoint then
			local cx, cy = layerFram:getPosition()
			layerFram:setPosition(cx + x - touchBeginPoint.x,
								  cy + y - touchBeginPoint.y)
			touchBeginPoint = {x = x, y = y}
		end
	end

	local function onTouchEnded(x, y)
		cclog ("onTouchednded")
		touchBeginPoint = nil
		spriteDog.isPaused = false
	end

	--响应按下事件处理函数
	local function onTouch(eventType, x, y)
		if eventType == CCTOUCHBEGAN then
			return onTouchBegan(x, y)
		elseif eventType == CCTOUCHMOVED then
			return onTochMoved(x, y)
		else
			return onTouchEnded(x, y)
		end
	end

	layerFram:registerScriptTouchEnable(onTouch)
	layerFram:setIsTouchEnabled(true)

	return layerFram
end

--定义创建菜单层函数
local function createLayerMenu()
	local layerMenu = CCLayer:node()
	local menuPopup, menuTools, effectID

	local function menuCallBackClosePopup()
		SimpleAudioEngine:sharedEngine():stopEffect(effectID)
		menuPopup:setIsVisible(false)
	end

	local function menuCallBackOpenPopup()
		effectID = SimpleAudioEngine:shareEngine():playEffect("effect1.wav")
		menuPopup:setIsVisible(true)
	end

	local menuPopupItem = CCMenuItemImage:itemFromNormalImage("menu2.png", "menu2.png")
	menuPopupItem.setPosition(0, 0)
	menuPopupItem:registerScriptHandler(menuCallBackClosePopup)

	menuPopup = CCMenu:menuWithItem(menuPopupItem)
	menuPopup:setPostition(winSize.width / 2, winSize.height / 2)
	menuPopup:setIsVisible(false)
	layerMenu:addChild(menuPopup)

	--创建图片菜单按钮menuToolsItem和菜单menuToolsItem
	local menuToolsItem = CCMenuItemImage:itemFromNormalImage("menu1.png", "menu1.png")
	menuToolsItem:setPosition(0, 0)
	menuToolsItem:registerScriptHandler(menuCallBackOpenPopup)

	menuTools = CCMenu:menuWithItem(menuToolsItem)
	menuTools:setPosition(30, 40)

	layerMenu:addChild(menuTools)

	return layerMenu
end

-- 以下部分为游戏逻辑

--[[1 取得声音引擎的实例对象并调用其playBackgroundMusic函数加载并循环播放声
音文件“background.mp3”。这里做为背景音乐--]]
SimpleAudioEngine:sharedEngine():playBackgroundMusic("background.mp3", true)

--[[2 取得声音引擎的实例对象并调用其preloadEffect函数将声音文件“effect1.wav”
预加载进内存。这里并不播放，预加载是为了在播放时不造成卡顿感。--]]
SimpleAudioEngine:sharedEngine():preloadEffect("effect1.wav")

--3 创建一个场景返回给变量sceneGame
local sceneGame = CCScene:node()

--4 创建Layer放入场景中
sceneGame:addchild(createLayerFrame())

--5 创建菜单的Layer放入场景中
sceneGame:addChild(createLayerMenu())

--6 调用显示设备的单间实例对象的runWithScene函数运行场景sceneGame
CCDirector:sharedDirector():runWithScene(sceneGame)



