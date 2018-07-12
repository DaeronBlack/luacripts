--
-- Created by IntelliJ IDEA.
-- User: Jorn
-- Date: 11-7-2018
-- Time: 20:37
-- To change this template use File | Settings | File Templates.
--

function ENT:Draw()
    self:DrawModel()

    local pos = self:GetPos() + Vector(0, 0, 1) --* math.sin(CurTime() * 2) * 2
    --local PlayersAngle = LocalPlayer():GetAngles()
    local ang = 0--Angle( 0, PlayersAngle.y - 180, 0 )

    --ang:RotateAroundAxis(ang:Right(), -90)
    --ang:RotateAroundAxis(ang:Up(), 90)

    local BankAmount = GetGlobalInt( "BANK_VaultAmount" )

    cam.Start3D2D(pos, ang, 0.6)
    if LocalPlayer().RobberyCooldown and LocalPlayer().RobberyCooldown > CurTime() then
        -- Text , font name, X coor, Y coor, color of text, alignment of X, alignment of Y, width of outline, Color of outline
        draw.SimpleTextOutlined("Robbery Cooldown", "UiBoldBank", 0, -195, BANK_Design_BankVaultCooldownName, 1, 1, 1.5, BANK_Design_BankVaultCooldownBoarderName)
        --draw.SimpleTextOutlined(string.ToMinutesSeconds, "UiSmallerThanBold", 0, -178, BANK_Design_BankVaultCooldown, 1, 1, 1.5, BANK_Design_BankVaultCooldownBoarder)
        draw.SimpleTextOutlined(string.ToMinutesSeconds(math.Round(LocalPlayer().RobberyCooldown - CurTime())), "UiSmallerThanBold", 0, -178, BANK_Design_BankVaultCooldown, 1, 1, 1.5, BANK_Design_BankVaultCooldownBoarder)
    end
    if LocalPlayer().RobberyCountdown and LocalPlayer().RobberyCountdown > CurTime() then
        draw.SimpleTextOutlined("Robbery Countdown", "UiBoldBank", 0, -195, BANK_Design_BankVaultCountdownName, 1, 1, 1.5, BANK_Design_BankVaultCountdownBoarderName)
        --draw.SimpleTextOutlined(string.ToMinutesSeconds, "UiSmallerThanBold", 0, -178, BANK_Design_BankVaultCountdown, 1, 1, 1.5, BANK_Design_BankVaultCountdownBoarder)
        draw.SimpleTextOutlined(string.ToMinutesSeconds(math.Round(LocalPlayer().RobberyCountdown - CurTime())), "UiSmallerThanBold", 0, -178, BANK_Design_BankVaultCountdown, 1, 1, 1.5, BANK_Design_BankVaultCountdownBoarder)
    end
    draw.SimpleTextOutlined("Bank Vault", "UiBoldBank", 0, -160, BANK_Design_BankVaultName, 1, 1, 1.5, BANK_Design_BankVaultNameBoarder)
    draw.SimpleTextOutlined("".. DarkRP.formatMoney(BankAmount), "UiBoldBank", 0, -140, BANK_Design_BankVaultAmount, 1, 1, 1.5, BANK_Design_BankVaultAmountBoarder)
    cam.End3D2D()
end
