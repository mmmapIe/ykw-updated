local function require(module)
	local file = debug.getinfo(1).source
	local directory = file:sub(2,#file-12)
	-- TODO: _FILEDIRECTORY
	return getfenv().require(directory .. module)
end
local tweenObj = require("tween")
local tweens = {}

function tween(obj,properties,time,style)
    table.insert(tweens,tweenObj.new(time,obj,properties,style))
end
function numLerp(a,b,c)
    return a+(b-a)*c
end

dad:changeCharacter("sonic-forced") -- cache sonic-forced
dad:changeCharacter("sonic-mad") -- cache sonic-mad
dad:changeCharacter('sonic')

local camshit = {zoom = getVar("defaultCamZoom")} -- work around for tweening camera zoom
local defaultZoom = getVar("defaultCamZoom");

local charSteps = {
    {step=844,char='sonic-mad'},
    {step=880,char='sonic'},
    {step=1152,char='sonic-mad'},
    {step=1408,char='sonic-forced'},
    {step=1664,char='sonic-mad'},
}
local zoomed=false;

function stepHit(step)
    local setChar='';
	for i = 1, #charSteps do
		local v= charSteps[i]
		local step = v.step;
		local char = v.char;
		if(curStep<step)then
			break;
		end
		setChar=char;
	end

    if(dad.curCharacter~=setChar and setChar~='')then
        print(setChar)
        dad:changeCharacter(setChar)
    end

    if(step>=1664 and step<1920 and not zoomed)then
        zoomed=true;
        tween(camshit,{zoom=1.6},1.5,"inOutQuad")
    end
    if(step>=1920 and zoomed)then
        zoomed=false;
        tween(camshit,{zoom=defaultZoom},1.5,"inOutQuad")
    end
end

function update(elapsed)


    for i = #tweens,1,-1 do
        if(tweens[i]:update(elapsed))then
            table.remove(tweens,i)
        end
	end
    setVar("defaultCamZoom",camshit.zoom)
end