package com.gurutest.commands.User;

import java.util.HashMap;

public class validateTokenCommand extends UserCommands{
    @Override
    public Object execute(HashMap<String, Object> map) throws Exception {
        return getService().validateToken((String) map.get("verificationToken"));
    }
}