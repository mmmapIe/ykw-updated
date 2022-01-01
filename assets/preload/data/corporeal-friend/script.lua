function onUpdate(elapsed)
    songPos = getSongPosition()
    local currentBeat = (songPos/5000)(curBpm/60)
    doTweenY('dadFloatY', 'dad', defaultOpponentY+(math.sin(songPos0*003)*300)+100, 0.1, 'sineIn')
    end