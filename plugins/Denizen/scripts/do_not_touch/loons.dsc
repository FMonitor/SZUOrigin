balloons:
    type: world
    debug: false
    events:
        on player enters red_balloon:
        - execute as_op warps
        - playsound <player> custom sound:custom.sound.open_dialogue volume:1
        on player enters green_balloon:
        - execute as_op warps
        - playsound <player> custom sound:custom.sound.open_dialogue volume:1
        on player enters blue_balloon:
        - execute as_op warps
        - playsound <player> custom sound:custom.sound.open_dialogue volume:1
        on player enters yellow_balloon:
        - execute as_op warps
        - playsound <player> custom sound:custom.sound.open_dialogue volume:1