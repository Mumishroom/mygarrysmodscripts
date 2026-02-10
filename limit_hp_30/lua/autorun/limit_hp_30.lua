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

    hook.Add("EntityFireBullets", "NoBulletForce", function(ent, data)
        data.Force = 0.01
        return true
    end)

end


if CLIENT then
    hook.Add("HUDDrawPickupHistory", "DisablePickupHistory", function()
        return false
    end)

    hook.Add("InitPostEntity", "aconsolepart", function()
        RunConsoleCommand("cl_showhints", "0")
        RunConsoleCommand("hud_deathnotice_time", "0")
    end)

    hook.Add( "HUDDrawTargetID", "HidePlayerInfo", function()
        return false
    end)

    local hide = {
        ["CHudHealth"] = true,
        ["CHudBattery"] = true,
        ["CHudAmmo"] = true,
        ["CHudSecondaryAmmo"] = true,
        ["CHudCrosshair"] = true
    }

    hook.Add( "HUDShouldDraw", "HideHUD", function( name )
        if ( hide[ name ] ) then
            return false
        end
    end )

    hook.Add("CalcView", "FuckTFASprintFOV", function(ply, pos, ang, fov)
        return {
            origin = pos,
            angles = ang,
            fov = GetConVar("fov_desired"):GetInt()
        }
    end)
end
