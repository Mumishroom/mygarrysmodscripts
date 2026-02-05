hook.Add("CreateEntityRagdoll", "AutoRemoveAnyRagdoll", function(owner, rag)
    if IsValid(rag) then
        rag:Fire("Kill", "", 60)
    end
end)


timer.Create("decalremover", 30, 0, function()
    RunConsoleCommand("r_cleardecals")
end)

local function ApplyOptimization()
    RunConsoleCommand("gmod_mcore_test", "1")
    RunConsoleCommand("mat_queue_mode", "-1")
    RunConsoleCommand("r_threaded_particles", "1")
    RunConsoleCommand("studio_queue_mode", "1")
    RunConsoleCommand("cl_threaded_bone_setup", "1")
    RunConsoleCommand("r_queued_ropes", "1")
end

hook.Add("InitPostEntity", "run_console_commands", function()
    ApplyOptimization()
    hook.Remove("OnEntityCreated", "WidgetInit")
end)
