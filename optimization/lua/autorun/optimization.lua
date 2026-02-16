if SERVER then
    hook.Add("CreateEntityRagdoll", "AutoRemoveAnyRagdoll", function(owner, rag)
        if IsValid(rag) then
            rag:Fire("Kill", "", 60)
        end
     end)   
    hook.Add("Initialize", "servercvars4343", function()
    	RunConsoleCommand("mp_decals", "8192")
    end)
end

if CLIENT then
    local function ApplyOptimization()
        RunConsoleCommand("gmod_mcore_test", "1")
        RunConsoleCommand("mat_queue_mode", "-1")
        RunConsoleCommand("r_threaded_particles", "1")
        RunConsoleCommand("studio_queue_mode", "1")
        RunConsoleCommand("cl_threaded_bone_setup", "1")
        RunConsoleCommand("r_queued_ropes", "1")
        RunConsoleCommand("mat_bloomscale", "0")
        RunConsoleCommand("mat_bloom_scalefactor_scalar", "0")
        RunConsoleCommand("r_decals", "8192")
        RunConsoleCommand("r_drawmodeldecals", "1")
        RunConsoleCommand("mp_decals", "8192")
    end

    hook.Add("InitPostEntity", "client_optimization", function()
        if not timer.Exists("decalremover") then
            timer.Create("decalremover", 200, 0, function()
                RunConsoleCommand("r_cleardecals")
            end)
        end

        ApplyOptimization()
    end)

    hook.Add("InitPostEntity", "gc_tweak", function()
        collectgarbage("setpause", 200)
        collectgarbage("setstepmul", 30)
    end)

	timer.Create("lua_heap_print", 5, 0, function()
	    local kb = collectgarbage("count")
	    MsgC(Color(0, 255, 0), string.format("[Lua Heap] %.2f MB\n", kb / 1024))
	end)
end
