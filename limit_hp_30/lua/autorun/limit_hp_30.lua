hook.Add("PlayerSpawn", "LimitHP30", function(ply)
    timer.Simple(0, function()
        if not IsValid(ply) then return end

        ply:SetMaxHealth(30)
        ply:SetHealth(30)
        ply:SetMaxArmor(30)
    end)
end)

