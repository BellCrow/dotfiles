require("core/init")

if os.getenv("PC_PROFILE") == "PERSONAL" then
    require("personal/init")
end

if os.getenv("PC_PROFILE") == "WORK" then
    require("work/init")
end
