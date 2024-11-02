local mp = require 'mp'

-- 定义一个函数，用于检查字幕轨道并在使用“弹幕”时应用 60fps 滤镜
local function check_and_apply_60fps()
    local track_list_count = mp.get_property_number("track-list/count", 0)
    local danmaku_in_use = false
    local track_list_count_cached = track_list_count

    -- 遍历所有轨道
    for i = 0, track_list_count_cached - 1 do
        local track_type = mp.get_property(string.format("track-list/%d/type", i))
        local track_title = mp.get_property(string.format("track-list/%d/title", i)) or ""
        local external_filename = mp.get_property(string.format("track-list/%d/external-filename", i)) or ""
        local track_selected = mp.get_property(string.format("track-list/%d/selected", i))

        -- 检查是否为字幕轨道，且标题或外部文件名中包含“danmaku”，并且该轨道被选中
        if track_type == "sub" 
           and (track_title:lower():find("danmaku") or external_filename:lower():find("danmaku")) 
           and track_selected == "yes" then
            danmaku_in_use = true
            break
        end
    end
    
    if danmaku_in_use then
        local vf_list = mp.get_property_native("vf")
        local filter_exists = false
        for _, filter in ipairs(vf_list) do
            if filter['name'] == 'fps' and filter['label'] == '@60fps' then
                filter_exists = true
                break
            end
        end
        if not filter_exists then
            -- 添加名为 @60fps 的视频滤镜，设置帧率为 60fps，且不显示 OSD
            mp.command("no-osd vf add @60fps:fps=fps=60")
        end
    else
        -- 如果不使用“弹幕”字幕，移除名为 @60fps 的视频滤镜
        mp.command("no-osd vf remove @60fps")
    end
end

local function debounce(func, timeout)
    local timer = nil
    return function(...)
        if timer then
            timer:kill()
        end
        local args = {...}
        timer = mp.add_timeout(timeout, function()
            func(unpack(args))
        end)
    end
end

mp.register_event("file-loaded", check_and_apply_60fps)

-- 监听当前字幕轨道的变化，当字幕轨道发生变化时重新调用 check_and_apply_60fps 函数
mp.observe_property("current-tracks/sub", "string", debounce(function() 
    check_and_apply_60fps() 
end, 0.5))

-- 监听当前次字幕轨道的变化，当次字幕轨道发生变化时重新调用 check_and_apply_60fps 函数
mp.observe_property("current-tracks/sub2", "string", debounce(function() 
    check_and_apply_60fps() 
end, 0.5))
