if SERVER then
    hook.Add("PlayerSpawn", "LimitHP30", function(ply)
        timer.Simple(0, function()
            if not IsValid(ply) then return end

            ply:SetMaxHealth(30)
            ply:SetHealth(30)
            ply:SetMaxArmor(30)
        end)
    end)

    hook.Add("InitPostEntity", "aconsolepart", function()
        RunConsoleCommand("mp_falldamage", "1")
    end)

    hook.Add("ScalePlayerDamage", "OneShotHeadshot", function(ply, hitgroup, dmginfo)
        if hitgroup == HITGROUP_HEAD then
            ply:SetHealth(0)
        end
    end)

    hook.Add("ScaleNPCDamage", "OneShotHeadshotNPC", function(npc, hitgroup, dmginfo)
        if hitgroup == HITGROUP_HEAD then
            npc:SetHealth(0)
        end
    end)

    hook.Add("CreateEntityRagdoll", "nocollision", function(ent, ragdoll)
        if IsValid(ent) and ragdoll:IsValid() then
            ragdoll:SetCollisionGroup(COLLISION_GROUP_WEAPON)
        end
    end)

    hook.Add("CreateEntityRagdoll", "AutoRemoveAnyRagdoll", function(owner, rag)
        if IsValid(rag) then
            rag:Fire("Ignite", "10", 590)
            rag:Fire("Kill", "", 600)
        end
     end)   
    hook.Add("Initialize", "servercvars4343", function()
        RunConsoleCommand("mp_decals", "8192")
    end)

end


if CLIENT then

    local function ApplyOptimization()
        RunConsoleCommand("gmod_mcore_test", "1")
        RunConsoleCommand("mat_queue_mode", "2")
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
            timer.Create("decalremover", 600, 0, function()
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

    hook.Add("HUDDrawPickupHistory", "DisablePickupHistory", function()
        return false
    end)

    hook.Add("InitPostEntity", "aconsolepart", function()
        RunConsoleCommand("cl_showhints", "0")
        RunConsoleCommand("hud_deathnotice_time", "0")
    end)

    hook.Add("HUDDrawTargetID", "HidePlayerInfo", function()
        return false
    end)

    local hide = {
        ["CHudHealth"] = true,
        ["CHudBattery"] = true,
        ["CHudAmmo"] = true,
        ["CHudSecondaryAmmo"] = true,
        ["CHudCrosshair"] = true
    }

    hook.Add("HUDShouldDraw", "HideHUD", function( name )
        if ( hide[ name ] ) then
            return false
        end
    end)

    local tab = {}
    tab["$pp_colour_addr"] = -0.01
    tab["$pp_colour_addg"] = -0.01
    tab["$pp_colour_addb"] = 0.04

    tab["$pp_colour_brightness"] = -0.07
    tab["$pp_colour_contrast"]   = 0.60
    tab["$pp_colour_colour"]     = 0.65

    tab["$pp_colour_mulr"] = -0.04
    tab["$pp_colour_mulg"] = -0.04
    tab["$pp_colour_mulb"] = 0.48

    hook.Add("RenderScreenspaceEffects", "HorrorPostFX", function()
        DrawColorModify(tab)
        DrawBloom(
            0.1,
            1,
            9, 9,
            1, 1,
            1, 1, 1
        )  
    end)
end
