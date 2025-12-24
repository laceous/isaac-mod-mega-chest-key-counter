local mod = RegisterMod('Mega Chest Key Counter', 1)
local game = Game()

mod.font = Font()
mod.font:Load('font/upheavalmini.fnt') -- font/luaminioutlined.fnt
mod.kcolor = KColor(1,1,1,1) -- white

-- MC_POST_PICKUP_RENDER has weird water reflection behavior
-- it's also harder to read in the mirror world
function mod:onRender()
  for _, v in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_MEGACHEST, -1, false, false)) do
    if v.FrameCount > 0 and v.SubType > 0 then -- ChestSubType.CHEST_OPENED
      local pos = Isaac.WorldToScreen(v.Position)
      local txt = tostring(v.SubType)
      
      if game:GetRoom():IsMirrorWorld() then
        local wtrp320x280 = Isaac.WorldToRenderPosition(Vector(320, 280)) -- center pos normal room, WorldToRenderPosition makes this work in large rooms too
        mod.font:DrawString(txt, wtrp320x280.X*2 - pos.X - mod.font:GetStringWidth(txt)/2, pos.Y, mod.kcolor, 0, true)
      else
        mod.font:DrawString(txt, pos.X - mod.font:GetStringWidth(txt)/2, pos.Y, mod.kcolor, 0, true)
      end
    end
  end
end

mod:AddPriorityCallback(ModCallbacks.MC_POST_RENDER, CallbackPriority.EARLY, mod.onRender) -- display under mcm