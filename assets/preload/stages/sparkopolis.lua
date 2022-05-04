
local u = false;
local r = 0;
local health = 0;
local ofs = 30;
local followchars = true;
local del = 0;
local del2 = 0;

local angleshit = 1;
local anglevar = 1;




function onUpdate()
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
            setProperty('defaultCamZoom',0.8)
        else

            setProperty('defaultCamZoom',1.0)
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
    
end
