local menu_gunshoppolitie = {name="Magazin de Arme LSPD",css={top="75px"}}

local function ch_armament1(player,choice) -- aici este armura bagata
  local user_id = vRP.getUserId(player)
  local rank = vRP.getFactionRank(user_id)
  local new_weight = vRP.getInventoryWeight(user_id)+0.3*1
  if (rank == "Gradul Pt Armament1")then
		vRPclient.giveWeapons(player,{{
			["WEAPON_FLASHLIGHT"] = {ammo=1},
			["WEAPON_NIGHTSTICK"] = {ammo=1},
			["WEAPON_STUNGUN"] = {ammo=1},
			["WEAPON_COMBATPISTOL"] = {ammo=250}
    }})
    if new_weight <= vRP.getInventoryMaxWeight(user_id) then
      vRP.giveInventoryItem(user_id,"armura",1,true)
    else
      vRPclient.notify(player,{"Nu ai destul ~r~loc ~w~in ~r~inventar~w~, pentru a lua ~b~armura"})
    end
  end
end


local function ch_armament2(player,choice) -- aici nu este armura bagata
  local user_id = vRP.getUserId(player)
  local rank = vRP.getFactionRank(user_id)
  if (rank == "Gradul Pt Armament2")then
		vRPclient.giveWeapons(player,{{
			["WEAPON_FLASHLIGHT"] = {ammo=1},
			["WEAPON_NIGHTSTICK"] = {ammo=1},
			["WEAPON_STUNGUN"] = {ammo=1},
			["WEAPON_COMBATPISTOL"] = {ammo=250},
      ["WEAPON_PUMPSHOTGUN"] = {ammo=250}
    }})
  end
end


menu_gunshoppolitie["1. Armament 1"] = {ch_armament1,"I-ati armamentul din dotarea unui Grad Pe care Doresti"}
menu_gunshoppolitie["2. Armament 2"] = {ch_armament2,"I-ati armamentul din dotarea unui Grad Pe care Doresti"}



local function gunshoppolitie_enter(source,area)
  local user_id = vRP.getUserId(source)
  local faction = vRP.getUserFaction(user_id)
  if user_id ~= nil  then
    if (faction == "Politia Romana") then
    vRP.openMenu(source,menu_gunshoppolitie)
    vRPclient.notify(source,{"Tocmai ai <span style='color:green'>deschis ~w~Meniul ~b~Armamentul ~w~Politiei Romane"})
  else
    vRPclient.notify(source,{"Nu faci ~r~parte ~w~din ~r~Politia Romana"})
    end
  end
end















local function menu_leave(source,area)
  vRP.closeMenu(source)
end







local function build_client_points(source)

  -- PC

  vRP.setArea(source,"vRP:gunshoppolitie",x,y,z,2.7,2.7,gunshoppolitie_enter,menu_leave)
end








  -- build police points
  AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
    if first_spawn then
      build_client_points(source)
    end
  end)
