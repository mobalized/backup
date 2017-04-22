-- ordered as in creaturescripts.xml
local events = {
	'TutorialCockroach',
	'ElementalSpheresOverlords',
	'BigfootBurdenVersperoth',
	'BigfootBurdenWarzone',
	'BigfootBurdenWeeper',
	'BigfootBurdenWiggler',
	'SvargrondArenaKill',
	'NewFrontierShardOfCorruption',
	'NewFrontierTirecz',
	'ServiceOfYalaharDiseasedTrio',
	'ServiceOfYalaharAzerus',
	'ServiceOfYalaharQuaraLeaders',
	'InquisitionBosses',
	'InquisitionUngreez',
	'KillingInTheNameOfKills',
	'MastersVoiceServants',
	'SecretServiceBlackKnight',
	'ThievesGuildNomad',
	'WotELizardMagistratus',
	'WotELizardNoble',
	'WotEKeeper',
	'WotEBosses',
	'WotEZalamon',
	'PlayerDeath',
	'AdvanceSave',
	'AdvanceRookgaard',
	'PythiusTheRotten',
	'DropLoot'
}

local function onMovementRemoveProtection(cid, oldPosition, time)
	local player = Player(cid)
	if not player then
		return true
	end

	local playerPosition = player:getPosition()
	if (playerPosition.x ~= oldPosition.x or playerPosition.y ~= oldPosition.y or playerPosition.z ~= oldPosition.z) or player:getTarget() then
		player:setStorageValue(Storage.combatProtectionStorage, 0)
		return true
	end

	addEvent(onMovementRemoveProtection, 1000, cid, oldPosition, time - 1)
end

function onLogin(player)
	player:setStorageValue(12540, 6) --sea serpents access
	player:setStorageValue(12350, 1) -- wote questline
	player:setStorageValue(12351, 3) --mission 1
	player:setStorageValue(12352, 3) --mission 2
	player:setStorageValue(12353, 3) --mission 3
	player:setStorageValue(12354, 3) --mission 4
	player:setStorageValue(12355, 3) --mission 5
	player:setStorageValue(12356, 4) --mission 6
	player:setStorageValue(12357, 6) --mission 7
	player:setStorageValue(12358, 2) --8
	player:setStorageValue(12359, 2) --9
	player:setStorageValue(12360, 6) --10
	player:setStorageValue(12361, 2) --11
	player:setStorageValue(12362, 1) --12
	player:setStorageValue(12700, 1) --shattered isles
	player:setStorageValue(12701, 3) --shattered isles
	player:setStorageValue(12702, 2) --shattered isles
	player:setStorageValue(12703, 1) --shattered isles
	player:setStorageValue(12704, 3) --shattered isles
	player:setStorageValue(12705, 5) --shattered isles
	player:setStorageValue(12706, 1) --shattered isles
	player:setStorageValue(12707, 1) --shattered isles
	player:setStorageValue(12710, 4) --shattered isles
	player:setStorageValue(100157, 1) --killing in the name of
	player:setStorageValue(2500, 100) --killing in the name of
	player:setStorageValue(12130, 1) --new frontier
	player:setStorageValue(12131, 3) --new frontier
	player:setStorageValue(12132, 6) --new frontier
	player:setStorageValue(12133, 3) --new frontier
	player:setStorageValue(12134, 2) --new frontier
	player:setStorageValue(12135, 7) --new frontier
	player:setStorageValue(12136, 3) --new frontier
	player:setStorageValue(12137, 3) --new frontier
	player:setStorageValue(12138, 2) --new frontier
	player:setStorageValue(12139, 3) --new frontier
	player:setStorageValue(12140, 1) --new frontier
	player:setStorageValue(12141, 12) --new frontier
	player:setStorageValue(12240, 5) --service of yalahar
	player:setStorageValue(12241, 6) --service of yalahar
	player:setStorageValue(12242, 8) --service of yalahar
	player:setStorageValue(12243, 6) --service of yalahar
	player:setStorageValue(12244, 6) --service of yalahar
	player:setStorageValue(12245, 8) --service of yalahar
	player:setStorageValue(12246, 5) --service of yalahar
	player:setStorageValue(12247, 5) --service of yalahar
	player:setStorageValue(12248, 4) --service of yalahar
	player:setStorageValue(12249, 2) --service of yalahar
	player:setStorageValue(12250, 5) --service of yalahar
	
	
	

	local loginStr = 'Welcome to ' .. configManager.getString(configKeys.SERVER_NAME) .. '!'
	if player:getLastLoginSaved() <= 0 then
		loginStr = loginStr .. ' Please choose your outfit.'
		player:sendTutorial(1)
	else
		if loginStr ~= '' then
			player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
		end

		loginStr = string.format('Your last visit was on %s.', os.date('%a %b %d %X %Y', player:getLastLoginSaved()))
	end
	player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)

	local playerId = player:getId()

	-- Stamina
	nextUseStaminaTime[playerId] = 0

	-- Promotion
	local vocation = player:getVocation()
	local promotion = vocation:getPromotion()
	if player:isPremium() then
		local value = player:getStorageValue(Storage.Promotion)
		if not promotion and value ~= 1 then
			player:setStorageValue(Storage.Promotion, 1)
		elseif value == 1 then
			player:setVocation(promotion)
		end
	elseif not promotion then
		player:setVocation(vocation:getDemotion())
	end

	-- Events
	for i = 1, #events do
		player:registerEvent(events[i])
	end

	if player:getStorageValue(Storage.combatProtectionStorage) <= os.time() then
		player:setStorageValue(Storage.combatProtectionStorage, os.time() + 10)
		onMovementRemoveProtection(playerId, player:getPosition(), 10)
	end
	return true
end
