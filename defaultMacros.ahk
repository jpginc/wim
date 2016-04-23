escGoesToNormalMode := new MacroClass("insert", "Escape")
escGoesToNormalMode.setPostMacroMode("normal")

iGoesToInsertMode := new MacroClass("normal", "i")
iGoesToInsertMode.setPostMacroMode("insert")


globalDefaultMacros := []
globalDefaultMacros.Insert(escGoesToNormalMode)