local displayPrettyUI
do
	local borderImage = {
		[1] = "155cbea943a.png",
		[2] = "155cbe99c72.png",
		[3] = "155cbe9bc9b.png",
		[4] = "155cbe97a3f.png"
	}

	displayPrettyUI = function(x, y, w, h, playerName, _cache)
		_cache = _cache or playerCache[playerName]

		-- Default behavior
		if interfaceBackground[w] and interfaceBackground[w][h] then
			_cache.totalInterfaceImages = _cache.totalInterfaceImages + 1
			_cache.interfaceImages[_cache.totalInterfaceImages] = addImage(
				interfaceBackground[w][h], imageTargets.interfaceBackground, x, y, playerName)
			return
		end

		-- Debug/development behavior, avoidable
		local interfaceId = textAreaId.interface + _cache.totalInterfaceTextareas
		addTextArea(interfaceId + 0, '', playerName, x, y, w, h, 0x141312, 0x141312, 1, true)
		addTextArea(interfaceId + 1, '', playerName, x + 1, y + 1, w - 2, h - 2, 0x7C482C, 0x7C482C,
			1, true)
		addTextArea(interfaceId + 2, '', playerName, x + 4, y + 4, w - 8, h - 8, 0x152D30, 0x141312,
			1, true)
		_cache.totalInterfaceTextareas = _cache.totalInterfaceTextareas + 3

		x = x - 6
		y = y - 6
		w = w - 14
		h = h - 16

		local totalInterfaceImages = _cache.totalInterfaceImages
		local interfaceImages = _cache.interfaceImages

		for b = 1, 4 do
			interfaceImages[totalInterfaceImages + b] = addImage(borderImage[b],
				imageTargets.interfaceTextAreaBackground, x + (b % 2)*w, y + (b < 3 and 0 or 1)*h,
				playerName)
		end
		_cache.totalInterfaceImages = totalInterfaceImages + 4
	end
end

local removePrettyUI = function(playerName, _cache)
	_cache = _cache or playerCache[playerName]

	-- Images
	local interfaceImages = _cache.interfaceImages
	for i = 1, _cache.totalInterfaceImages do
		removeImage(interfaceImages[i])
	end
	_cache.interfaceImages = { }
	_cache.totalInterfaceImages = 0

	-- TextAreas
	local interfaceId = textAreaId.interface
	for t = 1, _cache.totalInterfaceTextareas do
		removeTextArea(interfaceId + interfaceImages[t], playerName)
	end
	_cache.totalInterfaceTextareas = 0
end