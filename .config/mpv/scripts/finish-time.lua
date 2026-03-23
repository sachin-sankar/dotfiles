local mp = require("mp")

local function update_finish_time()
	local remaining = mp.get_property_number("time-remaining")
	local pos = mp.get_property_osd("time-pos")
	local duration = mp.get_property_osd("duration")
	local percent = mp.get_property_number("percent-pos")

	if not remaining or not pos then
		return
	end

	local finish = os.time() + math.floor(remaining)
	local h = tonumber(os.date("%I", finish))
	local min = os.date("%M", finish)
	local ampm = os.date("%p", finish)

	mp.set_property(
		"options/osd-status-msg",
		string.format(
			"%s / %s (%d%%) — Ends at %d:%s %s",
			pos,
			duration or "?",
			math.floor(percent or 0),
			h,
			min,
			ampm
		)
	)
end

mp.observe_property("time-remaining", "number", update_finish_time)
