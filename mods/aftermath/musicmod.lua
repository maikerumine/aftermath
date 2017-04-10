math.randomseed(3)
sound_playing = 0

minetest.register_globalstep(function(time)
		local time = minetest.env:get_timeofday()
		--minetest.chat_send_all(time .. " " .. sound_playing)

		if sound_playing == 0 then
		sound_playing = time
		end

		if sound_playing > 1 and time < 0.2 then
		sound_playing = 0.2
		end
	
		if time > sound_playing then

			if time > 0.8 or time < 0.2 then
			sound_playing = time + 0.2
			minetest.sound_play("mm_dark")
			return true
			end	

				sound_playing = time + 0.2
				minetest.sound_play("mm_light")
				return true
		end
end)
