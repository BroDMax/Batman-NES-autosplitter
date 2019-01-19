state("fceux")
{
    short Reset1:       0x3B1388, 0x003B;
    int Reset2:         0x3B1388, 0x0049;
    byte Level:         0x3B1388, 0x0088;
    byte Label:         0x3B1388, 0x000A;
    sbyte BossHP:       0x3B1388, 0x05E0;
    sbyte BossHP2:      0x3B1388, 0x05E1;
    sbyte BossMachine:  0x3B1388, 0x05E3;
    byte EndStage:      0x3B1388, 0x0613;
}

state("nestopia")
{
    short Reset1:       "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xA3;
    int Reset2:         "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xB1;
    byte Level:         "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xF0;
    byte Label:         "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x72;
    sbyte BossHP:       "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x648;
    sbyte BossHP2:      "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x649;
    sbyte BossMachine:  "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x64B;
    byte EndStage:      "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x67B;
}

state("mednafen")
{
    short Reset1:       "mednafen.exe", 0xBE1D1B;
    int Reset2:         "mednafen.exe", 0xBE1D29;
    byte Level:         "mednafen.exe", 0xBE1D68;
    byte Label:         "mednafen.exe", 0xBE1CEA;
    sbyte BossHP:       "mednafen.exe", 0xBE22C0;
    sbyte BossHP2:      "mednafen.exe", 0xBE22C1;
    sbyte BossMachine:  "mednafen.exe", 0xBE22C3;
    byte EndStage:      "mednafen.exe", 0xBE22F3;
}

startup
{
    settings.Add("lvl11", false, "Level 1-1");
    settings.Add("lvl12", false, "Level 1-2");
    settings.Add("lvl13", true, "Level 1-3");
    settings.Add("lvl21", false, "Level 2-1");
    settings.Add("lvl22", false, "Level 2-2");
    settings.Add("lvl23", false, "Level 2-3");
    settings.Add("lvl24", true, "Level 2-4");
    settings.Add("lvl31", false, "Level 3-1");
    settings.Add("lvl32", false, "Level 3-2");
    settings.Add("lvl33", false, "Level 3-3");
    settings.Add("lvl34", true, "Level 3-4");
    settings.Add("lvl41", false, "Level 4-1");
    settings.Add("lvl42", false, "Level 4-2");
    settings.Add("lvl43", false, "Level 4-3");
    settings.Add("lvl44", true, "Level 4-4");
    settings.Add("lvl51", false, "Level 5-1");
    settings.Add("lvl52", false, "Level 5-2");
    settings.Add("lvl53", true, "Level 5-3");
}

reset
{
    return (current.Reset1 == 0) && (current.Reset2 == 0);
}

split
{
    if (settings["lvl11"] && current.Level == 0 && old.EndStage == 0x12 && current.EndStage == 0x02) return true;
    if (settings["lvl12"] && current.Level == 2 && old.EndStage == 0x12 && current.EndStage == 0x02) return true;
    if (settings["lvl13"] && current.Level == 4 && old.BossHP >= 0 && current.BossHP < 0) return true;
    
    if (settings["lvl21"] && current.Level == 6 && old.EndStage == 0x12 && current.EndStage == 0x02) return true;
    if (settings["lvl22"] && current.Level == 8 && old.EndStage == 0x12 && current.EndStage == 0x02) return true;
    if (settings["lvl23"] && current.Level == 10 && old.EndStage == 0x12 && current.EndStage == 0x02) return true;
    if (settings["lvl24"] && current.Level == 12 && old.BossMachine >= 0 && current.BossMachine < 0) return true;
    
    if (settings["lvl31"] && current.Level == 14 && old.EndStage == 0x12 && current.EndStage == 0x02) return true;
    if (settings["lvl32"] && current.Level == 16 && old.EndStage == 0x12 && current.EndStage == 0x02) return true;
    if (settings["lvl33"] && current.Level == 18 && old.EndStage == 0x12 && current.NewEndStage == 0x02) return true;
    if (settings["lvl34"] && current.Level == 20 && old.BossHP >= 0 && current.BossHP < 0) return true;
    
    if (settings["lvl41"] && current.Level == 22 && old.EndStage == 0x12 && current.EndStage == 0x02) return true;
    if (settings["lvl42"] && current.Level == 24 && old.EndStage == 0x12 && current.EndStage == 0x02) return true;
    if (settings["lvl43"] && current.Level == 26 && old.EndStage == 0x12 && current.EndStage == 0x02) return true;
    if (settings["lvl44"] && current.Level == 28 &&
        (((old.BossHP > 0x40) && (old.BossHP2 >= 0 && current.BossHP2 < 0)) ||
        ((old.BossHP2 > 0x40) && (old.BossHP >= 0 && current.BossHP < 0))))
        return true;
        
    if (settings["lvl51"] && current.Level == 30 && old.EndStage == 0x12 && current.EndStage == 0x02) return true;
    if (settings["lvl52"] && current.Level == 32 && old.BossHP >= 0 && current.BossHP < 0) return true;
    if (settings["lvl53"] && current.Level == 34 && old.EndStage == 0x12 && current.EndStage == 0x02) return true;
}

start
{
    return (current.Level == 0) && (old.Label == 0) && (current.Label == 1);
}