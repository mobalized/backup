local config = {
	heal = true,
	save = true,
	effect = false,
	addMoney = true
}

function onAdvance(player, skill, oldLevel, newLevel)
	if skill ~= SKILL_LEVEL or newLevel <= oldLevel then
		return true
	end

	if config.effect then
		player:getPosition():sendMagicEffect(math.random(CONST_ME_FIREWORK_YELLOW, CONST_ME_FIREWORK_BLUE))
		player:say('LEVEL UP!', TALKTYPE_MONSTER_SAY)
	end

	if config.heal then
		player:addHealth(player:getMaxHealth())
	end

	if config.addMoney then
		local amount = 2000
		local multiplier = 1

		if newLevel >= 50 and newLevel < 100 then
			multiplier = 2
		elseif newLevel >= 100 and newLevel < 150 then
			multiplier = 4
		elseif newLevel >= 150 then
			multiplier = 8
		end

		player:setBankBalance(player:getBankBalance() + (amount * multiplier))
	end

	if config.save then
		player:save()
	end

	return true
end

