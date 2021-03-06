local function checkType(value)
	return not(value >= 0 and value ~= 1 and value ~= 135 and value ~= 411 and value ~= 415 and value ~= 424 and (value <= 160 or value >= 192) and value ~= 439 and value ~= 440 and value ~= 468 and value ~= 469 and (value < 474 or value > 485) and value ~= 501 and value ~= 518 and value ~= 519 and value ~= 520 and value ~= 524 and value ~= 525 and value ~= 536 and value ~= 543 and value ~= 549 and value ~= 576 and value ~= 581 and value ~= 582 and value <= 595)
end

function onSay(cid, words, param, channel)
	if(param == '') then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Command param required.")
		return true
	end

	local t, pid = string.explode(param, ","), cid
	if(t[2]) then
		pid = getPlayerByNameWildcard(t[2])
		if(not pid or (isPlayerGhost(pid) and getPlayerGhostAccess(pid) > getPlayerGhostAccess(cid))) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Player " .. t[2] .. " not found.")
			return true
		end
	end

	local period, tmp = -1, tonumber(t[3])
	if(t[3] and tmp) then
		period = tmp
	end

	if(not isNumeric(t[1])) then
		if(getMonsterInfo(t[1])) then
			doSetMonsterOutfit(pid, t[1], period)
		else
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Such outfit does not exist.")
		end

		return true
	end

	t[1] = tonumber(t[1])
	if(not checkType(t[1])) then
		local item = getItemInfo(t[1])
		if(item) then
			doSetItemOutfit(pid, t[1], period)
			return true
		end

		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Such outfit does not exist.")
		return true
	end

	local tmp = getCreatureOutfit(pid)
	tmp.lookType = t[1]

	if(t[3]) then
		t[3] = tonumber(t[3])
		if(checkType(t[3])) then
			tmp.lookMount = t[3]
		end
	end

	doCreatureChangeOutfit(pid, tmp)
	return true
end
