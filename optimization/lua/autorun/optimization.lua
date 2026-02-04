hook.Add("CreateEntityRagdoll", "AutoRemoveAnyRagdoll", function(owner, rag)
    if IsValid(rag) then
        rag:Fire("Kill", "", 60)
    end
end)


timer.Create("decalremover", 30, 0, function()
    RunConsoleCommand("r_cleardecals")
end)

