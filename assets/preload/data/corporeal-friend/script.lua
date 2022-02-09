function onUpdate(elapsed)
	if curStep == 20 then
		started = true
	end
songPos = getSongPosition()
local currentBeat = (songPos/5000)*(curBpm/60)
doTweenY('opponentmove', 'dad', 100 - 400*math.sin((currentBeat+12*12)*math.pi), 2)
doTweenX('whisper1', 'whisper1.scale', 0 - 50*math.sin((currentBeat+1*0.1)*math.pi), 6)
doTweenY('whisper2', 'whisper2.scale', 0 - 31*math.sin((currentBeat+1*1)*math.pi), 6)
end
